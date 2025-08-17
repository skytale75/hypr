#!/bin/bash
COLUMNS=34
export COLUMNS
center_text() {
  local text="$*"
  local columns=$(tput cols)
  local text_length=${#text}
  local indent=$(( (columns - text_length) / 2 ))

  printf "%${indent}s%s\n" " " "$text"
}

center_input_prompt() {
  local prompt_text="$1"  # The prompt string to display
  local var_name="$2"     # The name of the variable to store the input

  # Get terminal width
  local columns=34

  # Calculate padding
  local prompt_length=${#prompt_text}
    # local padding=$(( ((columns - prompt_length)) / 2 ))
    local padding=50

  # Print the centered prompt and read input
  printf "%*s%s" $padding "" "$prompt_text"
  read $var_name
}

center_text ""
center_text ""
center_text "Exit Hyprland? (Y/N)"
center_input_prompt ""

if [[ $REPLY =~ ^[Yy]$ ]]; then
  center_text "Exiting hyprland..." &&
  sleep 1
  hyprctl dispatch exit
else
  exit 0
fi
