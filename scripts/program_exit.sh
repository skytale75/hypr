#!/bin/bash

# Move the window to the center of the screen
hyprctl dispatch killactive 
sleep 0.03
hyprctl dispatch scroller:alignwindow c &
hyprctl dispatch scroller:alignwindow m
