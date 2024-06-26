function update-mirrors
    set TMPFILE (mktemp)
    sudo true
    if rate-mirrors --save=$TMPFILE arch --max-delay=43200
        sudo mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist-backup
        sudo mv $TMPFILE /etc/pacman.d/mirrorlist
    end
end

function update-and-upgrade
  update-mirrors
  if test $status -eq 0
    topgrade
  end
end
