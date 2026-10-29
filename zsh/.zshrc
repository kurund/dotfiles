alias resgs="mix setup && mix run priv/repo/seeds_scale.exs"
alias resg="mix setup"
alias rung="mix phx.server"
alias vim="nvim"

# export NVIM_THEME="rose-pine"
export NVIM_THEME="catppuccin"

export UV_PREVIEW=1

autoload -Uz compinit && compinit

if [[ "$OSTYPE" == darwin* ]]; then

  export ANDROID_HOME=$HOME/Library/Android/sdk
  export PATH=$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools

  eval "$(starship init zsh)"

  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

  # >>> conda initialize >>>
  # !! Contents within this block are managed by 'conda init' !!
  __conda_setup="$('/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
  if [ $? -eq 0 ]; then
      eval "$__conda_setup"
  else
      if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
          . "/opt/anaconda3/etc/profile.d/conda.sh"
      else
          export PATH="/opt/anaconda3/bin:$PATH"
      fi
  fi
  unset __conda_setup
  # <<< conda initialize <<<

  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
  export PATH="$HOME/.composer/vendor/bin:$PATH"
else
  HISTFILE=~/.histfile
  HISTSIZE=1000
  SAVEHIST=1000
  bindkey -e

  export PNPM_HOME="$HOME/.local/share/pnpm"
  export PATH="$PNPM_HOME/bin:$PATH"

  export ASDF_DATA_DIR="$HOME/.asdf"
  export PATH="$ASDF_DATA_DIR/shims:$HOME/.local/bin:$PATH:$HOME/.cargo/bin:/usr/local/bin"
  [[ -f /etc/ssl/certs/ca-certificates.crt ]] && export NIX_SSL_CERT_FILE="/etc/ssl/certs/ca-certificates.crt"
fi

[[ -f "$HOME/.local/bin/env" ]] && . "$HOME/.local/bin/env"
