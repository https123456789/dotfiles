#!/bin/sh

current_dir=$(kitten @ ls | jq '.[].tabs.[].windows.[] | select(.is_active) | .foreground_processes.[0].cwd' -r)
kitten @ launch --cwd "$current_dir"
