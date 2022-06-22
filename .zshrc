setopt histignorealldups
HISTFILE=~/.local/share/zsh-histfile
HISTSIZE=1000
SAVEHIST=1000
setopt extendedglob nomatch notify
unsetopt autocd beep
bindkey -v

autoload -Uz compinit
compinit

source ~/.config/aliases
path+=('/home/alexander/.local/bin')
path+=('/var/lib/snapd/snap/bin')
export PATH

# managed through aur
# fixes delete key
bindkey "^[[3~" delete-char
source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh

eval "$(starship init zsh)"
source /usr/share/nvm/init-nvm.sh
