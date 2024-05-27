set DOTFILES $HOME/.local/share/dotfiles/

function dotconfig
  if test $argv[1] = "lazy"
    lazygit --git-dir=$DOTFILES --work-tree=$HOME
    return
  end
  /usr/bin/git --git-dir=$DOTFILES --work-tree=$HOME $argv
end
