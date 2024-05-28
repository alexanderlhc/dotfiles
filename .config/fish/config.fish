if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -U fish_greeting

abbr -a 'v' 'nvim'
abbr -a 'vf' 'nvim $(fzf)'
abbr -a 'rate-upate-mirror' 'rate-mirrors --allow-root --disable-comments --protocol https arch  | sudo tee /etc/pacman.d/mirrorlist'
# abbr -a 'docker stop all' 'docker stop (docker ps -aq)'

# vi like
# complete suggestion
bind \cy accept-autosuggestion

mcfly init fish | source

zoxide init fish | source

fish_add_path ~/.local/bin

# pnpm
set -gx PNPM_HOME "/home/alexander/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end