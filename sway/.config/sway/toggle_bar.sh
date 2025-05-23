#!/bin/sh
current=$(swaymsg -t get_bar_config bar-0 | grep '"mode":' | cut -d '"' -f4)
if [ "$current" = "dock" ]; then
  swaymsg bar bar-0 mode hide
else
  swaymsg bar bar-0 mode dock
fi


