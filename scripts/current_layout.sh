#!/bin/bash

output=$(hyprctl getoption general:layout | head -n 1 | awk '{print $NF}')
if [ "$output" == "scrolling" ]; then
    class="scrolling"
    SEND="scrolling"
elif [ "$output" == "master" ]; then
    class="master"
    SEND="master"
elif [ "$output" == "dwindle" ]; then
    class="dwindle"
    SEND="dwindle"
fi

echo "{\"text\": \"$SEND\", \"class\": \"$class\"}"
pkill -RTMIN+11 waybar
