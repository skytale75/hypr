#!/usr/bin/env bash

function handle {
  if [[ ${1:0:8} == "scroller" ]]; then
    if [[ ${1:10:11} == "overview, 0" ]]; then
        hyprctl notify -1 3000 "rgb(ff1ea3)" "Normal mode!"
    elif [[ ${1:10:11} == "overview, 1" ]]; then
        hyprctl notify -1 3000 "rgb(ff1ea3)" "Overview mode!"
    elif [[ ${1:10:9} == "mode, row" ]]; then
        hyprctl notify -1 3000 "rgb(ff1ea3)" "Row mode!"
    elif [[ ${1:10:12} == "mode, column" ]]; then
        hyprctl notify -1 3000 "rgb(ff1ea3)" "Column mode!"
    elif [[ ${1:10:11} == "admitwindow" ]]; then
        hyprctl notify -1 3000 "rgb(ff1ea3)" "Admit Window!"
    elif [[ ${1:10:11} == "expelwindow" ]]; then
        hyprctl notify -1 3000 "rgb(ff1ea3)" "Expel Window!"
    fi
  fi
}

socat - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do handle "$line"; done
