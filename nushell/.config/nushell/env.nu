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

# ---------------------------------------------------------------- prompt ---

# starship's init script hard-codes the absolute path to the binary, so it is
# generated per machine rather than committed. Delete the file to rebuild it.
const starship_init = ("~/.cache/nushell/starship.nu" | path expand)

if not ($starship_init | path exists) {
    mkdir ($starship_init | path dirname)
    starship init nu | save -f $starship_init
}
