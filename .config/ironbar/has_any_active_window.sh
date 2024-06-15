#! /bin/bash

HAS_ACTIVE=$(hyprctl activewindow -j | jq 'has("title")')

if "$HAS_ACTIVE"; then
    exit 0
fi

exit 1
