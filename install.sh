#!/usr/bin/bash
echo "Northmatrix automatic dotfiles installer"

# Ensure running with sudo
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root using sudo."
    exit 1
fi

# Install necessary packages
pacman -Syu zsh vim stow

# Get the home directory of the original user who invoked sudo
USER_HOME=$(eval echo ~$SUDO_USER)

# ======= Top Level ========
cp  $USER_HOME/.dotfiles/etc/issue /etc/issue
chown root:root /etc/issue

cp  $USER_HOME/.dotfiles/etc/login.defs /etc/login.defs
chown root:root /etc/login.defs

cp  $USER_HOME/.dotfiles/etc/sudoers /etc/sudoers
chown root:root /etc/sudoers

cp  $USER_HOME/.dotfiles/etc/environment /etc/environment
chown root:root /etc/environment

# ======== Zsh ===========
cp  $USER_HOME/.dotfiles/etc/zsh/zshenv /etc/zsh/zshenv
chown root:root /etc/zsh/zshenv

# ========= Systemd ============
cp  $USER_HOME/.dotfiles/etc/systemd/resolved.conf /etc/systemd/resolved.conf
chown root:root /etc/systemd/resolved.conf

cp  $USER_HOME/.dotfiles/etc/systemd/network/20-ethernet.network /etc/systemd/network/20-ethernet.network
chown root:root /etc/systemd/network/20-ethernet.network

cp  $USER_HOME/.dotfiles/etc/systemd/system/vtrgb.service /etc/systemd/system/vtrgb.service
chown root:root /etc/systemd/system/vtrgb.service

# ========== Color Theme
mkdir -p /etc/vtrgb/
cp  $USER_HOME/.dotfiles/etc/vtrgb/tokyo.hex /etc/vtrgb/tokyo.hex
chown root:root /etc/vtrgb/tokyo.hex

# ========== Binaries 
cp $USER_HOME/.dotfiles/usr/local/bin/sway-launch /usr/local/bin/sway-launch
chown root:root /usr/local/bin/sway-launch

# User setup
chsh -s /usr/bin/zsh $SUDO_USER

# Start zsh for the user to ensure they get the right environment
stow zsh
sudo -u $SUDO_USER zsh

# Lets link systemd dns resolv.conf
sudo ln -sf /run/systemd/resolve/stub-resolv.confg /etc/resolv.conf

