#!/usr/bin/bash
echo "Northmatrix automatic dotfiles installer"

# Install necessary packages
pacman -Syu zsh vim stow

# ======= Top Level ========

cp  ~/.dotfiles/etc/issue /etc/issue
chown root:root /etc/issue

cp  ~/.dotfiles/etc/login.defs /etc/login.defs
chown root:root /etc/login.defs

cp  ~/.dotfiles/etc/sudoers /etc/sudoers
chown root:root /etc/sudoers

cp  ~/.dotfiles/etc/environmnet /etc/environment
chown root:root /etc/environment

# ======== Zsh ===========

cp  ~/.dotfiles/etc/zsh/zshenv /etc/zsh/zshenv
chown root:root /etc/zsh/zshenv

# ========= Systemd ============

cp  ~/.dotfiles/etc/systemd/resolved.conf /etc/systemd/resolved.conf
chown root:root /etc/systemd/resolved.conf

cp  ~/.dotfiles/etc/systemd/network/20-ethernet.network /etc/systemd/network/20-ethernet.network
chown root:root /etc/systemd/network/20-ethernet.network

cp  ~/.dotfiles/etc/systemd/system/vtrgb.service /etc/systemd/system/vtrgb.service
chown root:root /etc/systemd/system/vtrgb.service

# ========== Color Theme

mkdir -p /etc/vtrgb/
cp  ~/.dotfiles/etc/vtrgb/tokyo.hex /etc/vtrgb/tokyo.hex
sudo chown root:root /etc/vtrgb/tokyo.hex

# ========== Binaries 

cp ~/.dotfiles/usr/local/bin/sway-launch /usr/local/bin/sway-launch 
chown root:root /usr/local/bin/sway-launch

# User setup

chsh -s /usr/bin/zsh
zsh
