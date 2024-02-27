function dotconfig
  if test $argv[1] = "lazy"
    lazygit --git-dir=$HOME/.dotfiles/ --work-tree=$HOME
    return
  end
  /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $argv
end
