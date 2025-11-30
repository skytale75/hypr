#!/bin/sh

submap_notify() {

    STATUS="$HOME/.config/hypr/listeners/submap_id.txt"
    SUBMAP=$(hyprctl submap)
    # makoctl dismiss $STATUS || NID=$(notify-send -p "First notification") && echo $NID > $STATUS
    #
    if [ -s "$STATUS" ]; then
        hyprctl dismissnotify -1 3000000 "rgb(00ff00)" "$SUBMAP submaps are active."
        echo "hello"
        cp /dev/null $STATUS
        makoctl mode -r hyprsubmaps
    elif [ ! -s "$STATUS" ]; then
        NID=$(hyprctl notify -1 3000000 "rgb(0000ff)" "fontsize:18 $SUBMAP submaps are active.") &&
        echo "$NID" > $STATUS
    fi
}

submap_notify_mako() {

    SUBMAP=$(hyprctl submap)
    # makoctl dismiss $STATUS || NID=$(notify-send -p "First notification") && echo $NID > $STATUS
    #
    if [ "$SUBMAP" != "default" ]; then
        # NOTIFICATION_ID=$(notify-send -p -t 0 "This notification will be closed by the script." "Hello there")
        echo "$SUBMAP" > mako_layout.txt
        makoctl mode -a "$SUBMAP"
        NOT_ID=$(notify-send -p -t 0 "$SUBMAP" "$(cat $HOME/.config/hypr/guides/$SUBMAP)") &&
        echo  > $HOME/.config/hypr/listeners/submap_id.txt
    elif [ "$SUBMAP" == "default" ]; then
        CLOSE_ID=$(< ~/.config/hypr/listeners/submap_id.txt)
        makoctl dismiss -n "$CLOSE_ID"
        makoctl mode -r $(< mako_layout.txt)
        # makoctl mode -a "$SUBMAP"
        DEF_ID=$(notify-send -p -t 0 "$SUBMAP" "mode: default")
        sleep 2
        makoctl dismiss -n "$DEF_ID"
    fi
}


handle() {
    case $1 in
            # createworkspace*notes) echo "notes" ;;
            # activespecial*notes) echo "yes" ;;


        submap*)makoctl dismiss && submap_notify_mako ;;
    esac
}

socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done
