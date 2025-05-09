#!/bin/sh

# Nerd Font icons
ICON_DATE=""         # nf-fa-calendar
ICON_CLOCK=""        # nf-fa-clock-o
ICON_BATTERY=""      # nf-fa-battery
ICON_UPDATES=""      # nf-fa-download
ICON_VPN=""
ICON_CLIP=""         # nf-fa-file_text
ICON_CPU=""         # fa-microchip
ICON_MEM=""         # fa-line-chart
ICON_VOLUME=""       # nf-fa-volume-up
ICON_BRIGHTNESS=""   # nf-fa-sun-o

# Date and Time
date_line="$ICON_DATE $(date '+%Y-%m-%d')"
time_line="$ICON_CLOCK $(date '+%H:%M:%S')"

# Battery
battery_line="$ICON_BATTERY $(acpi -b | cut -d' ' -f4-)"

# VPN
vpn_status=$(nordvpn status | grep 'Status' | awk '{print $2}')
vpn_icon=""
[ "$vpn_status" = "Disconnected" ] && vpn_icon=""
vpn_line="$ICON_VPN $vpn_icon"

# Updates
updates_line="$ICON_UPDATES $(pacman -Qu | wc -l)"

# Clipboard
wl_clipboard="$ICON_CLIP $(wl-paste | tr -cd '\11\12\15\40-\176' | head -c 8)..."

# Memory usage
memory_usage="$ICON_MEM $(free | awk '/Mem:/ {printf "%.1f%%", $3/$2 * 100.0}')"

# CPU usage
cpu_idle=$(top -bn1 | grep "Cpu(s)" | sed 's/.*, *\([0-9.]*\)%* id.*/\1/')
cpu_usage=$(awk "BEGIN {printf \"%.1f%%\", 100 - $cpu_idle}")
cpu_line="$ICON_CPU $cpu_usage"

# Volume
# Volume using pactl (PipeWire-compatible)
volume_level=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | head -n1)
volume_muted=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')

if [ "$volume_muted" = "yes" ]; then
    volume_line="$ICON_VOLUME Mute"
else
    volume_line="$ICON_VOLUME $volume_level"
fi

# Brightness
brightness_raw=$(brightnessctl get)
brightness_max=$(brightnessctl max)
brightness_percent=$(awk "BEGIN {printf \"%d%%\", ($brightness_raw / $brightness_max) * 100}")
brightness_line="$ICON_BRIGHTNESS $brightness_percent"

# Final output
echo "[ $wl_clipboard | $date_line | $time_line | $battery_line | $vpn_line | $memory_usage | $cpu_line | $volume_line | $brightness_line | $updates_line ]"

