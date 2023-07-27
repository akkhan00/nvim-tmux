#!/bin/bash

# Get the current active layout
current_layout=$(setxkbmap -query | grep layout | awk '{print $2}')

# Define the layouts to switch between
urdu_layout="pk"
english_layout="us"

# Check the current layout and toggle to the other one
if [ "$current_layout" = "$urdu_layout" ]; then
    setxkbmap -layout "$english_layout"
else
    setxkbmap -layout "$urdu_layout"
fi

