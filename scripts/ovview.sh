#!/bin/bash

#!/usr/bin/env bash

function handle {
  if [[ ${1:0:8} == "scroller" ]]; then
    if [[ ${1:10:11} == "overview, 0" ]]; then
        hyprctl keyword general:border_size 1 
    elif [[ ${1:10:11} == "overview, 1" ]]; then
        hyprctl keyword general:border_size 7
    fi
  fi
}

socat - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do handle "$line"; done
