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

# managed through aur
source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh

eval "$(starship init zsh)"
