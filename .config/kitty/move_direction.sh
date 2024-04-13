#!/bin/bash

# Get the program running in the currently focus window
process=$(kitten @ ls | \
    jq -r '.[].tabs.[].windows.[] | select(.is_active) | .foreground_processes.[0].cmdline.[0]')

# If the current window is an instance of neovim, we don't want to switch windows and will let
# the neovim plugin decide if a new window should be focused by passing along the keys
if [ "$process" == "nvim" ]; then
    kitten @ send-key "ctrl+$2"
else
    kitten @ focus-window -m neighbor:$1
fi
