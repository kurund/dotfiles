# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/kurund/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME/bin:$PATH"

export ASDF_DATA_DIR="$HOME/.asdf"
export PATH="$ASDF_DATA_DIR/shims:$HOME/.local/bin:$PATH:$HOME/.cargo/bin:/usr/local/bin"
[[ -f /etc/ssl/certs/ca-certificates.crt ]] && export NIX_SSL_CERT_FILE="/etc/ssl/certs/ca-certificates.crt"
