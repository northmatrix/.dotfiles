# Initialize sway wm from when tty1 launched
[[ $(tty) == /dev/tty1 ]] && exec sway

# Set tty color
if [ "$TERM" = "linux" ]; then
  # Standard colors
  #echo -en '\e]P015161e'  # black
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

#XDG_CONFIG_HOME   DEFAULT=@{HOME}/.config
#XDG_CACHE_HOME    DEFAULT=@{HOME}/.cache
#XDG_DATA_HOME     DEFAULT=@{HOME}/.local/share
#XDG_STATE_HOME    DEFAULT=@{HOME}/.local/state
#XDG_DATA_DIRS     DEFAULT=/usr/local/share:/usr/share
#XDG_CONFIG_DIRS   DEFAULT=/etc/xdg
#CARGO_HOME             DEFAULT=${XDG_DATA_HOME}/cargo
#RUSTUP_HOME            DEFAULT=${XDG_DATA_HOME}/rustup
#GOPATH                 DEFAULT=${XDG_DATA_HOME}/go
#NPM_CONFIG_INIT_MODULE DEFAULT=${XDG_CONFIG_HOME}/npm/config/npm-init.js
#NPM_CONFIG_CACHE       DEFAULT=${XDG_CACHE_HOME}/npm
#NPM_CONFIG_TMP         DEFAULT=${XDG_RUNTIME_DIR}/npm
#ZDOTDIR                DEFAULT=${XDG_CONFIG_HOME}/zsh
#TMUX_CONF              DEFAULT=${XDG_CONFIG_HOME}/tmux/tmux.conf
#HISTFILE               DEFAULT=${XDG_STATE_HOME}/zsh/history
export BAT_THEME=tokyonight
export SUDO_PROMPT=$'\e[31m[sudo]\e[0m Password for %u: '
#export FZF_DEFAULT_OPTS="--no-border --style=minimal "



# Paths
add_paths() {
  for d in "$@"; do
    [[ -d "$d" && ! "$PATH" =~ (^|:)$d(:|$) ]] && PATH="$PATH:$d"
  done
}

add_paths $CARGO_HOME/bin 

# Setting Default mask
umask 0077

# Setting History settings 
HISTSIZE=1000
SAVEHIST=1000

#  Options
setopt autocd extendedglob nomatch notify 

# Load zsh-completions if available


# Auto Completion
# autoload -Uz compinit 
# compinit -i
# zstyle ':completion:*' use-cache on
# zstyle ':completion:*' cache-path ~/.zcache

# Auto Completion
# autoload -Uz compinit 
# compinit -i
#
# # Cache settings (XDG-compliant)
# zstyle ':completion:*' use-cache on
# zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompcache"
#
# # Colored completion menus
# zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# zstyle ':completion:*' menu select
# zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
#

# Auto Completion
autoload -Uz compinit
compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"
autoload -U colors && colors

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME"/zsh/zcompcache
zstyle ':completion:*' frecent yes

# Colored completion menus (explicit colors)
  zstyle ':completion:*' list-colors \
    'di=1;34' \
    'fi=0' \
    'ln=1;36' \
    'ex=1;32'

 # Enable colors in completion lists
#zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Alternative: More comprehensive coloring
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}%d%f'
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}%d(errors: %e) !%f'
zstyle ':completion:*:messages' format ' %F{purple}%d%f'
zstyle ':completion:*:warnings' format ' %F{red}no matches found%f'

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Additional enhancements
zstyle ':completion:*' group-name ''
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' squeeze-slashes true

if [[ -f "${XDG_DATA_HOME}/zsh/zsh-completions/zsh-completions.zsh" ]]; then
    source "${XDG_DATA_HOME}/zsh/zsh-completions/zsh-completions.zsh"
fi

if [[ -f "${XDG_DATA_HOME}/zsh/zsh-autocompletions/zsh-autocompletions.zsh" ]]; then
    source "${XDG_DATA_HOME}/zsh/zsh-autocompletions/zsh-autocompletions.zsh"
fi



# Prompt
if [[ $(tty) == /dev/tty* || -n $TMUX ]]; then
	PROMPT="%F{white}%n%F{blue}%m%F{white}@%F{yellow}%~%F{white} %# "
else
    eval "$(starship init zsh)"
    #PROMPT="%B%F{white}%n%f%b%F{blue}%m%F{white}@%B%F{yellow}%~%f%b%F{white} %# "
fi

# Initialize zoxide
#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(zoxide init zsh)"

# Key Binds
bindkey -v
bindkey '^?' backward-delete-char
bindkey '^R' history-incremental-search-backward
autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search

# Load zsh-syntax-highlighting
if [[ -f "${XDG_DATA_HOME}/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
    source "${XDG_DATA_HOME}/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

if [[ -f "${XDG_DATA_HOME}/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
    source "${XDG_DATA_HOME}/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

# Ls
alias ls="eza --color=auto" 
alias l="ls"
alias la="ls -A"
alias ll="ls -l"
alias lla="ll -A"
alias lt="ls --tree --level=1"
alias llt="lt -l"
alias llta="llt -a"

# Grep
alias grep="grep --color=auto"

# Cat
alias cat="bat -p --pager never"

# Nicities
alias c="clear"
alias cd="z"
alias .="cd ."
alias ..="cd .."
alias ...="cd ../.."
alias v="nvim"

# File Operations
alias mkdir="mkdir -pv"
alias rm="rm -i"
alias cp="cp -iv"
alias mv="mv -iv"

pacman_original() {
    sudo tar -xOf /var/cache/pacman/pkg/"$1"-*.pkg.tar.zst "$2"
}

