#!/usr/bin/bash
echo "Northmatrix automatic dotfiles installer"
# Install necessary packages
pacman -Syu zsh vim stow
# ======= Top Level ========
cp  ~/.dotfiles/etc/issue /etc/issue
cp  ~/.dotfiles/etc/login.defs /etc/login.defs
cp  ~/.dotfiles/etc/sudoers /etc/sudoers
cp  ~/.dotfiles/etc/environmnet /etc/environment
# ======== Zsh ===========
cp  ~/.dotfiles/etc/zsh/zshenv /etc/zsh/zshenv
# ========= Systemd ============
cp  ~/.dotfiles/etc/systemd/resolved.conf /etc/systemd/resolved.conf
cp  ~/.dotfiles/etc/systemd/network/20-ethernet.network /etc/systemd/network/20-ethernet.network
cp  ~/.dotfiles/etc/systemd/system/vtrgb.service /etc/systemd/system/vtrgb.service
# ========== Color Theme
cp  ~/.dotfiles/etc/vtrgb/tokyo.hex /etc/vtrgb/tokyo.hex
# ========== Binaries 
cp ~/.dotfiles/usr/local/bin/sway-launch /usr/local/bin/sway-launch 
# User setup
useradd -mG wheel northmatrix
chsh -s /usr/bin/zsh northmatrix
cp -r ~/.dotfiles /home/northmatrix/
chown -R northmatrix:northmatrix /home/northmatrix/.dotfiles
