#!/bin/bash

move_h() {
  hyprctl dispatch scroller:setmode row
  hyprctl dispatch scroller:movewindow $1
  hyprctl dispatch scroller:alignwindow c &
  hyprctl dispatch scroller:alignwindow m
}

move_v() {
  hyprctl dispatch scroller:setmode col
  hyprctl dispatch scroller:movewindow $1
  hyprctl dispatch scroller:alignwindow m &
  hyprctl dispatch scroller:alignwindow c
}

case "$1" in
  left) move_h l;;
  right) move_h r;;
  up) move_v u;;
  down) move_v d;;
esac

flag="$1"
