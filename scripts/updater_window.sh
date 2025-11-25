#!/bin/bash


kitty --title "update" -e bash -c "figlet \"Updater\" && paru -Syu --noconfirm" &&
kitty --title "update" -e bash -c "figlet \"Flatpak Updater\" && sudo flatpak update && echo done"
