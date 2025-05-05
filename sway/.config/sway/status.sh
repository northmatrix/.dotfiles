#!/bin/sh

GREEN="\033[32m"
RESET="\033[0m"

# Show date and time
date_line="Date: $(date '+%Y-%m-%d %H:%M:%S')"

# Show battery status
battery_line="Battery: $(acpi -b | cut -d' ' -f4-)"

# Show VPN status (using nordvpn)
vpn_line="VPN: $(nordvpn status | grep 'Status' | awk '{print $2}')"

# Show CPU usage
cpu_line="CPU: $(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}')"

# Show number of updates available (for Arch-based systems)
updates_line="Updates: $(pacman -Qu | wc -l)"

wl_clipboard="Clip: $(wl-paste | tr -cd '\11\12\15\40-\176' | head -c 8)..." 

# Combine all lines
echo  "[ $wl_clipboard ] [ $date_line ] [ $battery_line ] [ $vpn_line ] [ $cpu_line ] [ $updates_line ]"
