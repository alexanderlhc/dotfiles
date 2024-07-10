function docker
  switch $argv[1]
    case 'stop'
      if test "$argv[2]" = 'all'
        echo "docker stop (docker ps -aq)"
        command docker stop (docker ps -aq)
      else
        command docker $argv
      end
    case 'no-containers-restart'
      echo "docker stop (docker ps -aq)"
      command docker stop (docker ps -aq)
    case '*'
      command docker $argv
  end
end

# Completions added in completion/docker.fish:
