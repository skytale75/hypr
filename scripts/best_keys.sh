#!/bin/bash

LAYOUT=$(hyprctl getoption general:layout | head -n 1 | awk '{print $NF}')

right() {
    if [ "$LAYOUT" = "scrolling" ]; then
        hyprctl -- dispatch layoutmsg move +col
    else
        hyprctl disptach movefocus r
    fi
}

left() {
    if [ "$LAYOUT" = "scrolling" ]; then
        hyprctl -- dispatch layoutmsg move -col
    else
        hyprctl disptach movefocus l
    fi
}


case "$1" in
    left) left ;;
    right) right ;;
esac
