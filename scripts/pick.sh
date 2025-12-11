#!/bin/bash

set -e
set -o pipefail
trap 'echo "Exiting..."; exit 1' SIGINT

function new_file() {
    GET=$(hyprpicker -a -f hex) &&
    if [ $GET != "" ]; then
        echo "$GET" > $HOME/Documents/colors/$1.css
    fi
}

function new_file_rgb() {
    GET=$(hyprpicker -a -f rgb) &&
    MAKE="rgb($GET)"
    if [ "$GET" != "" ]; then
        echo "$MAKE" > $HOME/Documents/colors/$1.css
    fi
}

function add_color() {
    GET=$(hyprpicker -a -f hex) &&
    if [ $GET != "" ]; then
        echo "$GET" >> $HOME/Documents/colors/$1.css
    fi
}

function add_color_rgb() {
    GET=$(hyprpicker -a --format=rgb) &&
    MAKE="rgb($GET)"
    if [ "$GET" != "" ]; then
        echo "$MAKE" >> $HOME/Documents/colors/$1.css
    fi
}

case "$1" in
    -new) new_file "$2" ;;
    -new_rgb) new_file_rgb "$2" ;;
    -add) add_color "$2" ;;
    -add_rgb) add_color_rgb "$2" ;;
esac
