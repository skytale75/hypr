#!/bin/bash

move_h() {
  hyprctl dispatch scroller:alignwindow m
  hyprctl dispatch scroller:alignwindow c
  hyprctl dispatch scroller:setmode row
  hyprctl dispatch scroller:movefocus $1
  hyprctl dispatch scroller:alignwindow c
  hyprctl dispatch scroller:alignwindow m
}

move_v() {
  hyprctl dispatch scroller:alignwindow m
  hyprctl dispatch scroller:alignwindow c
  hyprctl dispatch scroller:setmode col
  hyprctl dispatch scroller:movefocus $1
  hyprctl dispatch scroller:alignwindow m
  hyprctl dispatch scroller:alignwindow c
}

over() {
  hyprctl dispatch scroller:toggleoverview
  hyprctl dispatch scroller:alignwindow m
  hyprctl dispatch scroller:alignwindow c
}

case "$1" in
  left) move_h l;;
  right) move_h r;;
  up) move_v u;;
  down) move_v d;;
  ov) over;;
esac

flag="$1"
