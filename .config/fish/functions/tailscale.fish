function tailscale --description 'tailscale, plus a `toggle` subcommand'
    if test "$argv[1]" != toggle
        command tailscale $argv
        return
    end
    set -l state (command tailscale status --json 2>/dev/null | jq -r .BackendState)
    if test "$state" = Running
        command tailscale down
        or return
        echo "Tailscale: off"
    else
        command tailscale up
        or return
        echo "Tailscale: on"
    end
end
