# Remember to run: `fish_update_completions`

if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -U fish_greeting

set -gx EDITOR nvim

abbr -a v nvim
abbr -a vf 'nvim $(fzf)'
abbr -a rate-upate-mirror 'rate-mirrors --allow-root --disable-comments --protocol https arch  | sudo tee /etc/pacman.d/mirrorlist'
abbr -a cargo_copy 'cargo c 2>&1 | tee /tmp/cargo_output.log | cat; cat /tmp/cargo_output.log | wl-copy'

# vi like
# complete suggestion
bind \cy accept-autosuggestion

mcfly init fish | source

zoxide init fish | source

fish_add_path ~/.local/bin
fish_add_path ~/.cargo/bin
fish_add_path /usr/lib/rustup/bin

# pnpm
set -gx PNPM_HOME "/home/alexander/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
