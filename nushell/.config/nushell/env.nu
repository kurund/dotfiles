# env.nu — loaded before config.nu.
#
# Environment only: PATH, exported variables, and the generated completion
# scripts that config.nu sources. Completions are built here because `source`
# in config.nu resolves at parse time, so the files must already exist.

# ---------------------------------------------------------------- PATH -----

# Add each path that exists, skipping duplicates and keeping the listed order.
def --env path-prepend [paths: list<string>] {
    for p in ($paths | reverse) {
        let p = ($p | path expand)
        if ($p | path exists) and ($p not-in $env.PATH) {
            $env.PATH = ($env.PATH | prepend $p)
        }
    }
}

def --env path-append [paths: list<string>] {
    for p in $paths {
        let p = ($p | path expand)
        if ($p | path exists) and ($p not-in $env.PATH) {
            $env.PATH = ($env.PATH | append $p)
        }
    }
}

$env.ASDF_DATA_DIR = ($env.HOME | path join ".asdf")
$env.ANDROID_HOME = ($env.HOME | path join "Library/Android/sdk")

# Listed highest-priority first.
path-prepend [
    ($env.ASDF_DATA_DIR | path join "shims")  # erlang/elixir toolchain wins
    "~/.local/bin"                            # uv & other user-installed bins
    "/opt/homebrew/bin"
    "/opt/homebrew/sbin"
]

path-append [
    "~/.cargo/bin"
    # conda has no nushell hook: this makes the `conda` binary callable, but
    # `conda activate` does not work — use `nu -e` from a conda-aware shell.
    "/opt/anaconda3/condabin"
    "~/.orbstack/bin"
    "~/.antigravity/antigravity/bin"
    ($env.ANDROID_HOME | path join "emulator")
    ($env.ANDROID_HOME | path join "platform-tools")
]

# ------------------------------------------------------------ variables ----

$env.EDITOR = "nvim"
$env.VISUAL = "nvim"

$env.NVIM_THEME = "atomic"
$env.TMUX_THEME = "nord"
$env.UV_PREVIEW = "1"

# ----------------------------------------------------------- completions ---

# Completion scripts for third-party tools are generated once into the cache
# dir and sourced by config.nu. Run `refresh-completions` after upgrading a
# tool to pick up its new flags.
const completion_dir = ("~/.cache/nushell/completions" | path expand)

mkdir $completion_dir

for tool in [[bin, file, generate]; [jj, jj.nu, "jj util completion nushell"]] {
    let out = ($completion_dir | path join $tool.file)
    if not ($out | path exists) {
        if (which $tool.bin | is-not-empty) {
            nu -c $tool.generate | save -f $out
        } else {
            # Stub: keeps `source` in config.nu valid when the tool is missing.
            "" | save -f $out
        }
    }
}
