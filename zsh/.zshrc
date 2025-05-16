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

# Sway startup script
[[ $(tty) == /dev/tty1 ]] && exec sway
export PATH=/opt/nvim-linux-x86_64/bin:$PATH

# Init 
PROMPT='%F{white}%n@%F{green}%m%f:%F{red}%~%f$ '
eval "$(zoxide init zsh)"

#Aliases
alias ls="eza"
alias alarm="sudo rtcwake -m mem -s 28800 && mpv ./Music/Fallout/07. Guy Mitchell - Heartaches By The Number.flac3"
