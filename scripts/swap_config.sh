#!/bin/bash

HYPR_CONFIG_DIR="$HOME/.config/hypr"
SCRIPTS="$HOME/.config/hypr/scripts"
PROJECT="project.conf"
MAIN="main.conf"
CURRENT_CONFIG="hyprland.conf"
FILE_CONTENTS=$(cat $SCRIPTS/current_config.txt)

if [ "$FILE_CONTENTS" = "$PROJECT" ]; then
    cp "$HYPR_CONFIG_DIR/$CURRENT_CONFIG" "$HYPR_CONFIG_DIR/$PROJECT"
    cp "$HYPR_CONFIG_DIR/$MAIN" "$HYPR_CONFIG_DIR/$CURRENT_CONFIG"
    echo "Switched to $MAIN"
    echo "main.conf" > $SCRIPTS/current_config.txt
elif [ "$FILE_CONTENTS" = "$MAIN" ]; then
    cp "$HYPR_CONFIG_DIR/$CURRENT_CONFIG" "$HYPR_CONFIG_DIR/$MAIN"
    cp "$HYPR_CONFIG_DIR/$PROJECT" "$HYPR_CONFIG_DIR/$CURRENT_CONFIG"
    echo "Switched to $PROJECT"
    echo "$PROJECT" > $SCRIPTS/current_config.txt
fi

hyprctl reload # Reload Hyprland to apply changes
