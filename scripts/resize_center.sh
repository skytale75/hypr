#!/bin/bash

# Resize the active window to 85% of the monitor dimensions
hyprctl dispatch resizeactive exact $1 $2

# Center the newly resized window on the active monitor
hyprctl dispatch centerwindow

