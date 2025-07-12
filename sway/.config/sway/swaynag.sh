#!/usr/bin/sh
exec swaynag \
      --font 'JetBrainsMono Nerd Font 12' \
	  -t warning \
	  -m 'You pressed the exit shortcut. Do you really want to exit Sway? This will end your Wayland session.' \
	  -b 'Yes exit sway' 'pkill swaybg; pkill mako; pkill wlsunset; pkill rocketbar; swaymsg exit;' \
	  --background $2 \
	  --text $1 \
	  --button-background $2 \
	  --button-text $1 \
	  --border $2 \
	  --border-bottom $1


