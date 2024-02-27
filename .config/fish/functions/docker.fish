function docker
    switch $argv[1]
        case 'stop'
            if test "$argv[2]" = 'all'
                echo "docker stop (docker ps -aq)"
                command docker stop (docker ps -aq)
            else
                command docker $argv
            end
        case '*'
            command docker $argv
    end
end
