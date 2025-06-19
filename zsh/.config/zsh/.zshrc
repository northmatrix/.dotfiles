autoload -Uz compinit promptinit add-zsh-hook
compinit -d "$XDG_CACHE_HOME/zsh/.zcompdump"
promptinit

zstyle ':completion:*' menu select

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[home]="${terminfo[khome]}"
key[end]="${terminfo[kend]}"
key[insert]="${terminfo[kich1]}"
key[backspace]="${terminfo[kbs]}"
key[delete]="${terminfo[kdch1]}"
key[up]="${terminfo[kcuu1]}"
key[down]="${terminfo[kcud1]}"
key[left]="${terminfo[kcub1]}"
key[right]="${terminfo[kcuf1]}"
key[pageup]="${terminfo[kpp]}"
key[pagedown]="${terminfo[knp]}"
key[shift-tab]="${terminfo[kcbt]}"

bindkey -v
# setup key accordingly
[[ -n "${key[home]}"      ]] && bindkey -- "${key[home]}"       beginning-of-line
[[ -n "${key[end]}"       ]] && bindkey -- "${key[end]}"        end-of-line
[[ -n "${key[insert]}"    ]] && bindkey -- "${key[insert]}"     overwrite-mode
[[ -n "${key[backspace]}" ]] && bindkey -- "${key[backspace]}"  backward-delete-char
[[ -n "${key[delete]}"    ]] && bindkey -- "${key[delete]}"     delete-char
[[ -n "${key[up]}"        ]] && bindkey -- "${key[up]}"         up-line-or-history
[[ -n "${key[down]}"      ]] && bindkey -- "${key[down]}"       down-line-or-history
[[ -n "${key[left]}"      ]] && bindkey -- "${key[left]}"       backward-char
[[ -n "${key[right]}"     ]] && bindkey -- "${key[right]}"      forward-char
[[ -n "${key[pageup]}"    ]] && bindkey -- "${key[pageup]}"     beginning-of-buffer-or-history
[[ -n "${key[pagedown]}"  ]] && bindkey -- "${key[pagedown]}"   end-of-buffer-or-history
[[ -n "${key[shift-tab]}" ]] && bindkey -- "${key[shift-tab]}"  reverse-menu-complete

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

[[ $(tty) = /dev/tty1 ]] && exec sway

# # Define the theme
# prompt_mytheme_setup() {
#     PROMPT='%B%F{white}%n%f%b@%F{blue}%m%f %F{yellow}%~%f %(?.%F{green}.%F{red})%% %f'
# }
#
# # Add the theme to promptsys
# prompt_themes+=( mytheme )

# Function to check if sudo timeout is active
sudo_active() {
  sudo -n true 2>/dev/null
}

# Define the theme with dynamic username color based on sudo status
prompt_mytheme_setup() {
  # Check sudo status and set username color accordingly
  if sudo_active; then
    local user_color='%B%F{red}'
  else
    local user_color='%B%F{white}'
  fi

  PROMPT="${user_color}%n%f%b@%F{blue}%m%f %F{yellow}%~%f %(?.%F{green}.%F{red})%% %f"
}

# Add the theme to promptsys
prompt_themes+=( mytheme )

# Make prompt update dynamically before each command
precmd_functions+=(prompt_mytheme_setup)

eval "$(zoxide init zsh)"


umask 0077
export SUDO_PROMPT=$'\e[31m[sudo]\e[0m Password for %u: '

# better alts
alias cd="z"
alias ls="eza"
alias ll="eza -l"
alias la="eza -A"
alias lt="eza -T --level=1" 
alias grep="rg"
alias cat="bat --theme=tokyonight -pP"

# shortcuts
alias p="sudo pacman"
alias SS="sudo systemctl"
alias sv="sudo vim"
alias sa="eval $(ssh-agent -s) ssh-add ~/.local/share/ssh/github_ed25519"
alias v="vim"
alias visudo="sudo visudo"
alias g="git"
alias ka="killall"
alias nf="touch"
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
