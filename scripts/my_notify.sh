#!/bin/bash

standard_notify() {
  hyprctl notify -1 10000 "rgb(ff0000)" "fontsize:35 $1"
}

submap_notify() {
  hyprctl notify -1 10000 "rgb(336386)" "fontsize:35 $1"
}

submap_notify "hello world"
