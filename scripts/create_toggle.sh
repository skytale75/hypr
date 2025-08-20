#!/bin/bash

run_special() {
  local grep_pattern="$1"
  local launch_command="$2"
  local workspace_name="$3"

  if ! hyprctl clients | grep -q "$grep_pattern"; then
    eval "$launch_command" &&
    sleep 1 # Wait a bit for the window to open
  else
    hyprctl dispatch togglespecialworkspace "$workspace_name"
  fi
}

case "$1" in
  -music)
    run_special "title: mpdClient" "ghostty --title='mpdClient' -e ncmpcpp --host localhost" "mpdClient"
    ;;
  -notes)
    run_special "title: notes" "ghostty --title='notes' -e nvim /home/mike/notes/index.norg" "notes"
    ;;
  -email)
    run_special "class: org.gnome.Evolution" "evolution" "email"
    ;;
  -files)
    run_special "title: yazi" "ghostty --title='yazi' -e yazi" "my_yazi"
    ;;
  *)
    # This part runs if no match is found
    echo "Usage: $0 {-music|-notes|-email|-files}"
    exit 1
    ;;
esac

: <<'END_COMMENT'
mpd_player() {
  if ! hyprctl clients | grep -q "title: mpdClient"; then
    ghostty --title="mpdClient" -e ncmpcpp --host localhost &
    sleep 1 # Wait a bit for the window to open
  else
    hyprctl dispatch togglespecialworkspace mpdClient
  fi

}

norg_notes() {
  if ! hyprctl clients | grep -q "title: notes"; then
    ghostty --title="notes" -e nvim /home/mike/notes/index.norg &
    sleep 1 # Wait a bit for the window to open
  else
    hyprctl dispatch togglespecialworkspace notes
  fi

}

my_email() {
  if ! hyprctl clients | grep -q "class: org.gnome.Evolution"; then
    evolution &
    sleep 1 # Wait a bit for the window to open
  else
    hyprctl dispatch togglespecialworkspace email
  fi
}

my_files() {
  if ! hyprctl clients | grep -q "title: yazi"; then
    ghostty --title="yazi" -e yazi &
    sleep 1 # Wait a bit for the window to open
  else
    hyprctl dispatch togglespecialworkspace my_yazi
  fi
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
END_COMMENT
