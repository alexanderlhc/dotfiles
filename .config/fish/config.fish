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
abbr -a fabric fabric-ai

# vi like
fish_vi_key_bindings
# complete suggestion
bind --mode insert \cY accept-autosuggestion

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

# Android SDK
set -gx ANDROID_HOME "$HOME/Android/Sdk"
fish_add_path $ANDROID_HOME/emulator
fish_add_path $ANDROID_HOME/platform-tools
fish_add_path $ANDROID_HOME/cmdline-tools/latest/bin
direnv hook fish | source

# World of Warcraft (Bottles: Bnet-GE-Proton) — used by KeyBinds' `npm run addon:install`
set -gx WOW_ADDONS_DIR "$HOME/.var/app/com.usebottles.bottles/data/bottles/bottles/Bnet-GE-Proton/drive_c/Program Files (x86)/World of Warcraft/_retail_/Interface/AddOns"
