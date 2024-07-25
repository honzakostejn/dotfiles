#!/bin/bash

logo=(
    icon="􀣺"
    icon.font="SF Pro:Black:16.0"
    icon.color=0xff121219
    icon.padding_left=6
    icon.padding_right=8
    label.drawing=off
    background.color=0xff6EA3FE
    background.border_color=0xff6EA3FE
    # background.height=30
    # background.shadow.drawing=on
    padding_left=3
    # shadow=on
)

sketchybar \
    --add item  logo left \
    --set       logo "${logo[@]}"