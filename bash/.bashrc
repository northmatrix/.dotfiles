#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
# Initialize sway wm from when tty1 launched
[[ $(tty) == /dev/tty1 ]] && exec sway

# Set tty color
if [ "$TERM" = "linux" ]; then
  # Standard colors
  echo -en '\e]P0000000'  # black
  echo -en '\e]P1f7768e'  # red
  echo -en '\e]P29ece6a'  # green
  echo -en '\e]P3e0af68'  # yellow
  echo -en '\e]P47aa2f7'  # blue
  echo -en '\e]P5bb9af7'  # magenta
  echo -en '\e]P67dcfff'  # cyan
  echo -en '\e]P7c0caf5'  # white
  
  # Bright colors
  echo -en '\e]P8414868'  # bright black (gray)
  echo -en '\e]P9f7768e'  # bright red
  echo -en '\e]PA9ece6a'  # bright green
  echo -en '\e]PBe0af68'  # bright yellow
  echo -en '\e]PC7aa2f7'  # bright blue
  echo -en '\e]PDBb9af7'  # bright magenta
  echo -en '\e]PE7dcfff'  # bright cyan
  echo -en '\e]PFa9b1d6'  # bright white
  
  clear
fi

# Set prompt: cyan user, blue hostname, then cwd and $ in default color
export SUDO_PROMPT=$'\e[31m[sudo]\e[0m Password for %u: '

# Set mask
umask 0077

# Enable bash completion
if [ -f /usr/share/bash-completion/bash_completion ]; then
  . /usr/share/bash-completion/bash_completion
fi

# Alias
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Colors
BLUE='\[\e[34m\]'   # Host color
GREEN='\[\e[32m\]'  # Green for success
RED='\[\e[31m\]'    # Red for failure
RESET='\[\e[0m\]'   # Reset color

PS1='\u@'"${BLUE}"'\h'"${RESET}"':\w$(if [[ $? == 0 ]]; then echo "'${GREEN}'\$"; else echo "'${RED}'\$"; fi) '"${RESET}"
