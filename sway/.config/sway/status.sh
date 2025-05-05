#!/bin/sh

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

# Combine all lines
echo "$date_line | $battery_line | $vpn_line | $cpu_line | $updates_line"
