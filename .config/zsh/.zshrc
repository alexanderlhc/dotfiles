setopt histignorealldups
HISTFILE=~/.local/share/zsh-histfile
HISTSIZE=1000
SAVEHIST=1000
setopt extendedglob nomatch notify
unsetopt autocd beep
bindkey -v

autoload -Uz compinit
compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"

source ~/.config/zsh/.zfuncs

source ~/.config/aliases
path+=('/home/alexander/.local/bin')
path+=('/var/lib/snapd/snap/bin')
export PATH

# managed through aur
# fixes delete key
bindkey "^[[3~" delete-char
source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
source /usr/share/zsh/plugins/zsh-system-clipboard/zsh-system-clipboard.zsh

eval "$(starship init zsh)"
source /usr/share/nvm/init-nvm.sh

# cht.sh
#curl https://cheat.sh/:zsh > ~/.zsh.d/_cht
fpath=(~/.zsh.d/ $fpath)

# direnv
if [ $(command -v direnv) ]; then
  eval "$(direnv hook zsh)"
fi
load-local-conf() {
     # check file exists, is regular file and is readable:
     if [[ -f .aliases && -r .aliases ]]; then
       source .aliases
     fi
}
autoload -U add-zsh-hook chpwd load-local-conf

### Randomized prompt
#colorscript random

# https://gist.github.com/kevinoid/189a0168ef4ceae76ed669cd696eaa37
if [ -t 0 ]; then
	# Set GPG_TTY so gpg-agent knows where to prompt.  See gpg-agent(1)
	export GPG_TTY="$(tty)"
	# Set PINENTRY_USER_DATA so pinentry-auto knows to present a text UI.
	export PINENTRY_USER_DATA=USE_TTY=1
fi

# nnn cd to working directory on exit
# https://github.com/jarun/nnn/wiki/Basic-use-cases#configure-cd-on-quit
nnn_cd()                                                                                                   
{
    if ! [ -z "$NNN_PIPE" ]; then
        printf "%s\0" "0c${PWD}" > "${NNN_PIPE}" !&
    fi  
}

trap nnn_cd EXIT

# pnpm
export PNPM_HOME="/home/alexander/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end
