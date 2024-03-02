if status is-interactive
    # Commands to run in interactive sessions can go here
end

abbr -a 'v' 'nvim'
abbr -a 'rate-upate-mirror' 'rate-mirrors --allow-root --disable-comments --protocol https arch  | sudo tee /etc/pacman.d/mirrorlist'
# abbr -a 'docker stop all' 'docker stop (docker ps -aq)'

zoxide init fish | source
