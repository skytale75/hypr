#!/bin/bash

# Move the window to the center of the screen

my_window() {
  hyprctl dispatch scroller:setwidth "$1"
  hyprctl dispatch scroller:setheight "$1"
  hyprctl dispatch scroller:alignwindow c &
  hyprctl dispatch scroller:alignwindow m
}


case "$1" in 
  default) my_window 3;;
  full) my_window 4;;
esac

flag "$1"
