#!/bin/bash

SUBMAP=$(hyprctl submap) &&
# notify-send "$SUBMAP" "$(cat /home/mike/.config/mango/keymodes/$SUBMAP)" &&
makoctl mode -a layouts
notify-send -r 12345 "$SUBMAP" "$(cat /home/mike/.config/mango/keymodes/$SUBMAP)"
# makoctl mode -r layouts
# sleep 10 &&
# if [[ $SUBMAP != "default" ]]; then
#     mmsg -d setkeymode,default
#     dunstify -C 12345
# fi
