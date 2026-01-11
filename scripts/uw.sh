#!/bin/bash

function paru_update() {
    figlet \"Updater\" &&
    paru -Syu --noconfirm | tee -i ~/logs/paru.log
}

ghostty --title=update -e bash -c "figlet \"Updater\" && yay -Syu --noconfirm --logfile ~/logs/yay.log" &&
ghostty --title=update -e bash -c "figlet \"Flatpak Updater\" && sudo flatpak update && echo done"
