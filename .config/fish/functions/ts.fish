function ts --description 'Toggle Tailscale up/down'
    set -l state (tailscale status --json 2>/dev/null | jq -r .BackendState)
    if test "$state" = Running
        tailscale down
        or return
        echo "Tailscale: off"
    else
        tailscale up
        or return
        echo "Tailscale: on"
    end
end
