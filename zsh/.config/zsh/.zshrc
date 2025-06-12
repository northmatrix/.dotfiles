# Initialize sway wm from when tty1 launched
[[ $(tty) == /dev/tty1 ]] && exec sway

# Set tty color
if [ "$TERM" = "linux" ]; then
  # Standard colors
  echo -en '\e]P015161e'  # black
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

# Auto Completion
autoload -Uz compinit
compinit -i
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zcache

# Prompt
if [[ $(tty) == /dev/tty* || -n $TMUX ]]; then
	PROMPT="%F{white}%n%F{blue}%m%F{white}@%F{yellow}%~%F{white} %# "
else
    eval "$(starship init zsh)"
fi


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

# Ls
alias ls="exa --group-directories-first --sort=filename"
alias la="ls -A"
alias ll="ls -l"
alias lla="ll -A"
alias lt="ls --tree --level=1"
alias llt="lt -l"

# Grep
alias grep="grep --color=auto"

# Nicities
alias c="clear"
alias .="cd ."
alias ..="cd .."
alias ...="cd ../.."

# File Operations
alias mkdir="mkdir -pv"
alias rm="rm -i"
alias cp="cp -iv"
alias mv="mv -iv"
