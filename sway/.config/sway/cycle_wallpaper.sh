#!/bin/bash
DIR="$HOME/Pictures/Wallpaper/"
INDEX_FILE="$HOME/.cache/current_wallpaper_index"
mkdir -p "$HOME/.cache"
files=("$DIR"/*)
count=${#files[@]}
idx=0
if [[ -f "$INDEX_FILE" ]]; then
  idx=$(cat "$INDEX_FILE")
  ((idx=(idx+1)%count))
fi
echo "$idx" > "$INDEX_FILE"
swaymsg output "*" bg "${files[$idx]}" fill

