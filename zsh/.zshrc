#eval "$(starship init zsh)"
PROMPT='%F{white}%n%f@%F{215}%m%f:%F{blue}%~%f %# '

eval "$(dircolors -b ~/.dircolors)"

print -Pn "\e]0;%n@%m: %~\a"
#eval "$(zoxide init zsh)"

case $TERM in
  foot|xterm*)
    # List of commands that should update the title
    title_commands=(neovim nvim vim vi emacs nano cmus mpv vlc ssh tmux screen htop top btop less more man git)
    
    # Set title before command runs (only for specific commands)
    preexec() {
      local cmd=${1%% *}  # Get first word of command
      
      # Check if command is in our list
      if (( ${title_commands[(Ie)$cmd]} )); then
        case $cmd in
          neovim|nvim|vim|vi)
            # Show full command with file arguments for editors
            print -Pn "\e]0;$1\a"
            ;;
          *)
            # Just show command name for other programs
            print -Pn "\e]0;$cmd\a"
            ;;
        esac
      fi
    }
    
    # Always set title back to prompt info after command finishes
    precmd() {
      print -Pn "\e]0;%n@%m: %~\a"
    }
    ;;
esac

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob nomatch
bindkey -v
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename '/home/jamie/.zshrc'
autoload -Uz compinit
compinit
# End of lines added by compinstall

# Path setup 
export PATH=$PATH:$HOME/.cargo/bin:$HOME/miniforge3/bin

# Sway startup script
[[ $(tty) == /dev/tty1 ]] && exec sway
export PATH=/opt/nvim-linux-x86_64/bin:$PATH

#Aliases
alias l="ls"
alias ls="ls --color"
alias e="exit"
alias v="nvim"
alias c="clear"
