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
        makoctl mode -a layouts
        notify-send -r 12345 "$SUBMAP" "$(cat $HOME/.config/hypr/listeners/$SUBMAP)"
    elif [ "$SUBMAP" == "default" ]; then
        makoctl mode -r layouts
        notify-send -r 12345 "$SUBMAP"
        sleep 3
        makoctl dismiss
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
