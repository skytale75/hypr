#!/bin/bash

function yes() {
    hyprctl keyword input:follow_mouse 1
}

function no() {
    hyprctl keyword input:follow_mouse 0
}

case "$1" in
    yes) yes ;;
    no) no ;;
esac

