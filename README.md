# 🧩 Dotfiles – Sway + Zsh + Foot on Arch Linux

My personal dotfiles for a minimal, tiling window manager setup on Arch Linux using:

- 🌲 [Sway](https://github.com/swaywm/sway)
- 🐚 [Zsh](https://www.zsh.org/)
- 🦶 [Foot](https://codeberg.org/dnkl/foot)

## 📁 Structure

- `sway/` – config + keybinds + scripts
- `zsh/` – `.zshrc`, plugins, aliases
- `foot/` – `foot.ini` appearance + fonts

## ⚙️ Requirements

- Arch Linux  
- Wayland  
- `wl-clipboard`, `grim`, `slurp`, `mako`  
- `zsh`, `foot`, `sway`, `fzf`, `starship`, etc.

## 🚀 Setup

```bash
git clone https://github.com/yourusername/dotfiles ~/.dotfiles
cd ~/.dotfiles
stow sway zsh foot
