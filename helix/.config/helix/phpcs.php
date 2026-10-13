<?php

// phpcs only discovers phpcs.xml from the cwd upwards, phpactor runs it from a fixed cwd
// and its fix-diff runs use a temp copy, so reuse the folder of the last real file
$lastDirFile = sys_get_temp_dir() . '/helix-phpcs-' . getmyuid();
foreach ($argv as $arg) {
  if (!str_starts_with($arg, '--stdin-path=')) {
    continue;
  }
  $dir = dirname(substr($arg, strlen('--stdin-path=')));
  if ($dir === sys_get_temp_dir()) {
    $dir = @file_get_contents($lastDirFile);
  }
  else {
    file_put_contents($lastDirFile, $dir);
  }
  if (!empty($dir)) {
    chdir($dir);
  }
}

require getenv('HOME') . '/.config/composer/vendor/bin/phpcs';
