export PATH="$(yarn global bin):$PATH"

export EDITOR='nvim'
export VISUAL='nvim'
export READER='zathura'
export TERMINAL='alacritty'
export BROWSER='firefox'
export COLORTERM='truecolor'
export _JAVA_AWT_WM_NONREPARENTING=1
export CHROME_EXECUTABLE=/usr/bin/chromium

#-----
# XDG
export XDG_DATA_HOME=~/.local/share
export XDG_CONFIG_HOME=~/.config
export XDG_STATE_HOME=~/.local/state
export XDG_CACHE_HOME=~/.cache
# XDG compliance
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history
export NVM_DIR="$XDG_DATA_HOME"/nvm
export PASSWORD_STORE_DIR="$XDG_DATA_HOME"/pass
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
# .zshenv to .config/zsh
#environment variable in */etc/zsh/zshenv*:
#export ZDOTDIR="$HOME"/.config/zsh
