
[[ $- != *i* ]] && return
[[ $(tty) = /dev/tty1 ]] && exec sway

autoload -Uz compinit promptinit add-zsh-hook
compinit -d "$XDG_CACHE_HOME/zsh/.zcompdump"
promptinit

zstyle ':completion:*' menu select

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"       beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"        end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"     overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}"  backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"     delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"       backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"      forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"     beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"   end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}"  reverse-menu-complete

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "${key[Up]}"   ]] && bindkey -- "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search



key[Control-Left]="${terminfo[kLFT5]}"
key[Control-Right]="${terminfo[kRIT5]}"

[[ -n "${key[Control-Left]}"  ]] && bindkey -- "${key[Control-Left]}"  backward-word
[[ -n "${key[Control-Right]}" ]] && bindkey -- "${key[Control-Right]}" forward-word



function reset_broken_terminal () {
	printf '%b' '\e[0m\e(B\e)0\017\e[?5l\e7\e[0;0r\e8'
}

add-zsh-hook -Uz precmd reset_broken_terminal


function xterm_title_precmd () {
	print -Pn -- '\e]2;%n@%m %~\a'
	[[ "$TERM" == 'screen'* ]] && print -Pn -- '\e_\005{2}%n\005{-}@\005{5}%m\005{-} \005{+b 4}%~\005{-}\e\\'
}

function xterm_title_preexec () {
	print -Pn -- '\e]2;%n@%m %~ %# ' && print -n -- "${(q)1}\a"
	[[ "$TERM" == 'screen'* ]] && { print -Pn -- '\e_\005{2}%n\005{-}@\005{5}%m\005{-} \005{+b 4}%~\005{-} %# ' && print -n -- "${(q)1}\e\\"; }
}

if [[ "$TERM" == (Eterm*|alacritty*|aterm*|foot*|gnome*|konsole*|kterm*|putty*|rxvt*|screen*|wezterm*|tmux*|xterm*) ]]; then
	add-zsh-hook -Uz precmd xterm_title_precmd
	add-zsh-hook -Uz preexec xterm_title_preexec
fi


exit_zsh() { exit }
zle -N exit_zsh
bindkey '^D' exit_zsh

# Function to check if sudo timeout is active
# sudo_active() {
#   sudo -n true 2>/dev/null
# }

# Define the theme with dynamic username color based on sudo status
prompt_mytheme_setup() {
  # Check sudo status and set username color accordingly
  # if sudo_active; then
  #   local user_color='%B%F{red}'
  # else
  #   local user_color='%B%F{white}'
  # fi
  local user_color='%B%F{white}'
  PROMPT="${user_color}%n%f%b@%F{blue}%m%f %F{yellow}%~%f %(?.%F{green}.%F{red})%% %f"
}

# Add the theme to promptsys
prompt_themes+=( mytheme )

# Make prompt update dynamically before each command
precmd_functions+=(prompt_mytheme_setup)

eval "$(zoxide init zsh)"


export SUDO_PROMPT=$'\e[31m[sudo]\e[0m Password for %u: '

# better alts
alias cd="z"
alias ls="eza -g --time-style=long-iso"
alias ll="ls -l"
alias la="ls -A"
#alias grep="rg"
alias cat="bat --theme=tokyonight -pP"

# shortcuts
alias p="sudo pacman"
alias sd="sudo systemctl"
alias sv="sudoedit"
alias sa="eval $(ssh-agent -s) ssh-add ~/.local/share/ssh/github_ed25519"
alias v="vim"
alias g="git"
alias l="ls"
alias c="clear"
alias t="htop"
alias ka="killall"
alias .="cd ."
alias ...="cd ../.."

# saftey
alias mkdir="mkdir -pv"
alias mv="mv -iv"
alias cp="cp -irv"
alias rm="rm -Iv"

#lang shortcuts
alias py="python3"
# History file location
HISTFILE="$XDG_DATA_HOME/zsh/history"

# Number of commands to save in memory during session
HISTSIZE=10000

# Number of commands to save in the history file
SAVEHIST=10000

# History behavior options
setopt APPEND_HISTORY         # Don't overwrite history file; append to it
setopt INC_APPEND_HISTORY     # Save commands as they are typed
setopt SHARE_HISTORY          # Share history across all sessions
setopt HIST_IGNORE_DUPS       # Ignore duplicate commands
setopt HIST_IGNORE_ALL_DUPS   # Delete old duplicates when new command is added
setopt HIST_REDUCE_BLANKS     # Remove superfluous blanks
setopt HIST_VERIFY            # Show command with history expansion before executing


setopt AUTO_CD

export EDITOR=vim
export VISUAL=nvim

# This will set the default prompt to the walters theme
prompt mytheme
