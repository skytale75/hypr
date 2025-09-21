#!/bin/bash

run_special() {
    local grep_pattern="$1"
    local launch_command="$2"
    local workspace_name="$3"

    hyprctl dispatch focusmonitor "HDMI-A-1"
    if ! hyprctl clients | grep -q "$grep_pattern"; then
        eval "$launch_command" &&
        hyprctl dispatch movetoworkspace special:"$workspace_name" &&
        sleep 1 # Wait a bit for the window to open
    else
        hyprctl dispatch togglespecialworkspace "$workspace_name" &&
        hyprctl dispatch centerwindow
    fi
}

case "$1" in
    -music)
        run_special "title: mpdClient" "ghostty --title='mpdClient' -e ncmpcpp --host localhost" "mpdClient"
        ;;
    -gg_serv)
        run_special "class: live_server" "google-chrome-stable --class=live_server" "live_server"
        ;;
    -notes)
        run_special "title: notes" "ghostty --title='notes' -e nvim /home/mike/vimwiki/index.wiki" "notes"
        ;;
    -email)
        run_special "class: org.gnome.Evolution" "evolution" "email"
        ;;
    -files)
        run_special "title: yazi" "ghostty --title='yazi' -e yazi" "my_yazi"
        ;;
    -copy)
        run_special "class: com.github.hluk.copyq" "copyq toggle || copyq" "my_copy"
        ;;
    -term_util)
        run_special "title: term_util" "ghostty --title='term_util' -e tmux new -s UTILITY || tmux attach -t UTILITY" "term_util"
        ;;
    *)
        # This part runs if no match is found
        echo "Usage: $0 {-music|-notes|-email|-files}"
        exit 1
        ;;
esac
