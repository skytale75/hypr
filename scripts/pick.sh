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

function add_color() {
    GET=$(hyprpicker -a -f hex) &&
    if [ $GET != "" ]; then
        echo "$GET" >> $HOME/Documents/colors/$1.css
    fi
}

case "$1" in
    -new) new_file "$2" ;;
    -add) add_color "$2" ;;
esac
