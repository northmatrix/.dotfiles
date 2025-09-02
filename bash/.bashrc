# ~/.bashrc - Based on your Zsh configuration

# XDG Base Directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_DATA_DIRS="/usr/local/share:/usr/share"
export XDG_CONFIG_DIRS="/etc/xdg"

# Launch sway on tty1
if [[ "$(tty)" == "/dev/tty1" ]] && command -v sway-launch >/dev/null; then
    exec sway-launch
fi

# History settings
export HISTFILE="${XDG_STATE_HOME}/bash/history"
export HISTSIZE=10000
export HISTCONTROL=ignoredups:erasedups
#shopt -s histappend
#PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

PROMPT_COMMAND='
if [ $? -eq 0 ]; then
    history -a   # Append successful command
else
    history -d $((HISTCMD-1))  # Remove failed command
fi
'

# Language/Tool-specific environment
export QT_QPA_PLATFORMTHEME=qt5ct
export _JAVA_AWT_WM_NONREPARENTING=1
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"
export GOPATH="${XDG_DATA_HOME}/go"
export NPM_CONFIG_INIT_MODULE="${XDG_CONFIG_HOME}/npm/config/npm-init.js"
export NPM_CONFIG_CACHE="${XDG_CACHE_HOME}/npm"
export NPM_CONFIG_TMP="${XDG_RUNTIME_DIR}/npm"
export TMUX_CONF="${XDG_CONFIG_HOME}/tmux/tmux.conf"
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"

# PATH
export PATH="$HOME/.local/share/gem/ruby/3.4.0/bin:$PATH"
export PATH="$CARGO_HOME/bin:$GOPATH/bin:$PATH"

# Aliases
alias grep="grep --color=always"
#alias cat="bat -Pp --theme=OneHalfDark"
#alias ls="eza --time-style=iso --group"
alias ls="ls -l --sort=extension --human-readable --color=auto"
alias la="ls -A"
alias ll="ls -l"
alias lla="ll -A"
alias l="ls"
alias c="clear"
alias v="nvim"
alias q="exit"
alias sv="sudo v"

# Safer defaults
alias mkdir="mkdir -pv"
alias mv="mv -iv"
alias cp="cp -irv"
alias rm="rm -Iv"

# Prompt with Git info
#parse_git_branch() {
#  git branch 2>/dev/null | grep '\*' | sed 's/* //'
#}

#export PS1='[\[\e[97m\]dead@\[\e[94m\]\h \[\e[93m\]\W\[\e[0m\]$(parse_git_branch)]\[\e[92m\]\$\[\e[0m\] '
export PS1='[\[\e[97m\]dead@\[\e[94m\]\h \[\e[93m\]\W\[\e[0m\]]\[\e[92m\]\$\[\e[0m\] '

# Terminal title
case "$TERM" in
  *xterm*|*rxvt*|*alacritty*|*foot*|*tmux*|*screen*|*wezterm*)
    #PROMPT_COMMAND+='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}: ${PWD/#$HOME/~}\007";'
    ;;
esac

# OSC7 for terminal file location tracking
osc7_pwd() {
  printf '\e]7;file://%s%s\e\\' "$HOSTNAME" "${PWD// /%20}"
}
#PROMPT_COMMAND="osc7_pwd; $PROMPT_COMMAND"

if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

if [ -f /usr/share/bash-completion/completions/git ]; then
    . /usr/share/bash-completion/completions/git
fi


set -o vi

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
# Enable programmable completion for history searching with tab
bind '"\t": complete'
bind -m vi-insert -x '"\eh": run-help'

# Enable color in completion
#complete -cf sudo
shopt -s autocd
shopt -s expand_aliases

run-help() { help "$READLINE_LINE" 2>/dev/null || man  "$READLINE_LINE"; }
