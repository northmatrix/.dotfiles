#!/bin/bash

echo "Installing  Tmux, Neovim, Zsh, Oh-My-Zsh, p10k-theme"
sudo pacman -S tmux neovim zsh 
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
