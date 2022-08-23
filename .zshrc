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

# cht.sh
#curl https://cheat.sh/:zsh > ~/.zsh.d/_cht
fpath=(~/.zsh.d/ $fpath)

### Randomized prompt
colorscript random

# https://gist.github.com/kevinoid/189a0168ef4ceae76ed669cd696eaa37
if [ -t 0 ]; then
	# Set GPG_TTY so gpg-agent knows where to prompt.  See gpg-agent(1)
	export GPG_TTY="$(tty)"
	# Set PINENTRY_USER_DATA so pinentry-auto knows to present a text UI.
	export PINENTRY_USER_DATA=USE_TTY=1
fi
