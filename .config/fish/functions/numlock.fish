function numlock --description 'Toggle Num Lock (real key press via ydotool)'
    ydotool key 69:1 69:0
    or return
    sleep 0.3
    set -l ledfile /sys/class/leds/*numlock*/brightness
    if set -q ledfile[1]
        if test (cat $ledfile[1]) = 1
            echo "Num Lock: on"
        else
            echo "Num Lock: off"
        end
    end
end
