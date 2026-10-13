// Wraps vscode-php-debug to work around Helix 25.07 DAP limitations:
// - template args can't hold objects, so launch args come from .vscode/launch.json
// - Helix sends `terminate`, which the adapter doesn't implement, so it becomes `disconnect`
// - Helix makes any `thread` event the current thread, so a parallel request (heartbeat, cron)
//   steals focus from the stopped one, only a thread event for the stopping thread is sent
// - a session only becomes active in Helix after its first stop, so it can't be terminated
//   before that, a new launch replaces the previous adapter instead
const { spawn } = require('child_process');
const fs = require('fs');
const os = require('os');
const path = require('path');

const pidFile = path.join(os.tmpdir(), `helix-php-debug-${process.getuid()}.pid`);

function stopPrevious() {
  const pid = Number(fs.readFileSync(pidFile, { encoding: 'utf8', flag: 'a+' }));
  if (!pid || pid === process.pid) {
    return;
  }
  try {
    process.kill(pid, 'SIGTERM');
  }
  catch {
    return;
  }
  for (let i = 0; i < 20; i++) {
    try {
      process.kill(pid, 0);
    }
    catch {
      return;
    }
    Atomics.wait(new Int32Array(new SharedArrayBuffer(4)), 0, 0, 100);
  }
}

stopPrevious();
fs.writeFileSync(pidFile, String(process.pid));

const adapter = spawn('node', [
  path.join(process.env.HOME, '.local/share/nvim/mason/packages/php-debug-adapter/extension/out/phpDebug.js'),
], { stdio: ['pipe', 'pipe', 'inherit'] });

function findUp(start, name) {
  for (let dir = start; ; dir = path.dirname(dir)) {
    if (fs.existsSync(path.join(dir, name))) {
      return dir;
    }
    if (dir === path.dirname(dir)) {
      return null;
    }
  }
}

function parseJsonc(text) {
  // drop comments outside strings, trailing commas, and add commas missing between objects
  const json = text
    .replace(/("(?:\\.|[^"\\])*")|\/\/[^\n]*|\/\*[\s\S]*?\*\//g, (match, string) => string ?? '')
    .replace(/,(\s*[}\]])/g, '$1')
    .replace(/}(\s*){/g, '},$1{');
  return JSON.parse(json);
}

function vscodeConfig() {
  const root = findUp(process.cwd(), '.vscode/launch.json');
  if (!root) {
    return null;
  }
  const expand = (value) => value.replace(/\$\{(workspaceRoot|workspaceFolder)\}/g, root);
  const configs = parseJsonc(fs.readFileSync(path.join(root, '.vscode/launch.json'), 'utf8')).configurations
    .filter((config) => config.type === 'php' && config.request === 'launch')
    .map((config) => ({
      ...config,
      pathMappings: Object.fromEntries(
        Object.entries(config.pathMappings ?? {}).map(([remote, local]) => [remote, expand(local)]),
      ),
    }));
  const config = configs.find((c) => Object.values(c.pathMappings).every((local) => fs.existsSync(local))) ?? configs[0];
  if (!config) {
    return null;
  }
  const { name, type, request, ...args } = config;
  return args;
}

function cmsConfig() {
  const src = path.join(process.cwd(), 'src');
  const cms = ['bedrock', 'wordpress', 'drupal'].find((dir) => fs.existsSync(path.join(src, dir)));
  return {
    pathMappings: cms ? { '/var/www/html/': path.join(src, cms) } : {},
    xdebugSettings: { max_children: 500 },
  };
}

function write(stream, message) {
  const body = Buffer.from(JSON.stringify(message));
  stream.write(`Content-Length: ${body.length}\r\n\r\n`);
  stream.write(body);
}

function read(stream, onMessage) {
  let buffer = Buffer.alloc(0);
  stream.on('data', (chunk) => {
    buffer = Buffer.concat([buffer, chunk]);
    for (;;) {
      const headerEnd = buffer.indexOf('\r\n\r\n');
      if (headerEnd === -1) {
        return;
      }
      const length = Number(/Content-Length: (\d+)/i.exec(buffer.subarray(0, headerEnd).toString())[1]);
      const bodyStart = headerEnd + 4;
      if (buffer.length < bodyStart + length) {
        return;
      }
      onMessage(JSON.parse(buffer.subarray(bodyStart, bodyStart + length)));
      buffer = buffer.subarray(bodyStart + length);
    }
  });
}

const terminateRequests = new Set();

read(process.stdin, (message) => {
  if (message.command === 'launch') {
    message.arguments = { ...(vscodeConfig() ?? cmsConfig()), ...message.arguments };
  }
  if (message.command === 'terminate') {
    terminateRequests.add(message.seq);
    message.command = 'disconnect';
    message.arguments = {};
  }
  write(adapter.stdin, message);
});

read(adapter.stdout, (message) => {
  if (message.type === 'event' && message.event === 'thread') {
    return;
  }
  if (message.type === 'event' && message.event === 'stopped') {
    write(process.stdout, {
      seq: message.seq,
      type: 'event',
      event: 'thread',
      body: { reason: 'started', threadId: message.body.threadId },
    });
  }
  if (message.type === 'response' && terminateRequests.has(message.request_seq)) {
    message.command = 'terminate';
  }
  write(process.stdout, message);
});

// the adapter keeps listening on the port after its stdin closes, so never leave it behind
process.stdin.on('end', () => adapter.kill());
for (const signal of ['SIGTERM', 'SIGINT', 'SIGHUP']) {
  process.on(signal, () => adapter.kill());
}
process.on('exit', () => {
  adapter.kill();
  if (fs.readFileSync(pidFile, { encoding: 'utf8', flag: 'a+' }) === String(process.pid)) {
    fs.rmSync(pidFile, { force: true });
  }
});
adapter.on('exit', (code) => process.exit(code ?? 0));
