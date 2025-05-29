#!/bin/bash

# Example: checks if tun0 or any VPN interface is up
if ip a | grep -q "nordlynx"; then
    echo "󰖂 VPN ON"
else
    echo "󰖃 VPN OFF"
fi
