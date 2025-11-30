#!/bin/bash

pkill -f listeners &&
killall mako &&
/home/mike/.config/hypr/listeners/submap_listen.sh &
