#!/bin/bash

makoctl mode -a hyprsubmaps
notify-send "$(hyprctl activeworkspace -j | jq -r .name)"
makoctl mode -r hyprsubmaps

