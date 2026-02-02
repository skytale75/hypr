#!/bin/bash

SUBMAP=$(hyprctl submap) &&
# notify-send "$SUBMAP" "$(cat /home/mike/.config/mango/keymodes/$SUBMAP)" &&
makoctl mode -a layouts
notify-send -r 12345 "$SUBMAP" "$(cat /home/mike/.config/mango/keymodes/$SUBMAP)"


