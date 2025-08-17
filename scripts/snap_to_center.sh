#!/bin/bash

# Move the window to the center of the screen
sleep 0.02
hyprctl dispatch scroller:alignwindow c &
hyprctl dispatch scroller:alignwindow m
