#!/bin/bash

mpd_player() {
  if ! hyprctl clients | grep -q "title: mpdClient"; then
    ghostty --title="mpdClient" -e ncmpcpp --host localhost &
    sleep 1 # Wait a bit for the window to open
  fi

  hyprctl dispatch togglespecialworkspace mpdClient
}

norg_notes() {
  if ! hyprctl clients | grep -q "title: notes"; then
    ghostty --title="notes" -e nvim /home/mike/notes/index.norg &
    sleep 1 # Wait a bit for the window to open
  fi

  hyprctl dispatch togglespecialworkspace notes
}

my_email() {
  if ! hyprctl clients | grep -q "class: org.gnome.Evolution"; then
    evolution &
    sleep 1 # Wait a bit for the window to open
  fi

  hyprctl dispatch togglespecialworkspace email
}

my_files() {
  if ! hyprctl clients | grep -q "title: yazi"; then
    ghostty --title="yazi" -e yazi &
    sleep 1 # Wait a bit for the window to open
  fi

  hyprctl dispatch togglespecialworkspace my_yazi
}

case "$1" in
  -music)
    mpd_player
    ;;
  -notes)
    norg_notes
    ;;
  -email)
    my_email
    ;;
  -files)
    my_files
    ;;
  *)
    # This part runs if no match is found
    echo "Usage: $0 -music"
    exit 1
    ;;
esac
