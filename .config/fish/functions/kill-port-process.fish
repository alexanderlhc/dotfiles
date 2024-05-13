function kill-port-process --argument port
    set pid (lsof -ti tcp:$port)
    if test -n "$pid"
        kill $pid
        echo "Killed process on port $port with PID $pid"
    else
        echo "No process found on port $port"
    end
end
