#!/bin/bash

LAYOUT=$(hyprctl getoption general:layout | head -n 1 | awk '{print $NF}')
echo $LAYOUT
right() {
    if [ "$LAYOUT" = "scrolling" ]; then
        hyprctl -- dispatch layoutmsg move +col
    elif [ "$LAYOUT" = "master" ]; then
        hyprctl dispatch movefocus r
    fi
}

left() {
    if [ "$LAYOUT" = "scrolling" ]; then
        hyprctl -- dispatch layoutmsg move -col
    elif [ "$LAYOUT" = "master" ]; then
        hyprctl dispatch movefocus l
    fi
}
move_right() {
    if [ "$LAYOUT" = "scrolling" ]; then
        hyprctl -- dispatch layoutmsg swapcol r
    elif [ "$LAYOUT" = "master" ]; then
        hyprctl dispatch movewindow r
    fi
}

move_left() {
    if [ "$LAYOUT" = "scrolling" ]; then
        hyprctl -- dispatch layoutmsg swapcol l
    elif [ "$LAYOUT" = "master" ]; then
        hyprctl dispatch movewindow l
    fi
}

move_up() {
    if [ "$LAYOUT" = "scrolling" ]; then
        # hyprctl -- dispatch layoutmsg movewindowto u
        echo "scrolling"
    elif [ "$LAYOUT" = "master" ]; then
        hyprctl dispatch movewindow u
    fi
}

move_down() {
    if [ "$LAYOUT" = "scrolling" ]; then
        hyprctl -- dispatch layoutmsg movewindowto d
    elif [ "$LAYOUT" = "master" ]; then
        hyprctl dispatch movewindow d
    fi
}


case "$1" in
    mvup) move_up ;;
    mvdown) move_down ;;
    mvright) move_right ;;
    mvleft) move_left ;;
    left) left ;;
    right) right ;;
esac
