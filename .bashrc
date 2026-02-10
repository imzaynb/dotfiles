# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
			# We have color support; assume it's compliant with Ecma-48
			# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
			# a case would tend to support setf rather than setaf.)
			color_prompt=yes
    else
			color_prompt=
    fi
fi

COLOR_START='\[\033['
COLOR_END='m\]'
		 COLOR_RESET="${COLOR_START}00${COLOR_END}"
			COLOR_BOLD="${COLOR_START}01${COLOR_END}"
	COLOR_FG_BLACK="${COLOR_START}30${COLOR_END}"
		COLOR_FG_RED="${COLOR_START}31${COLOR_END}"
	COLOR_FG_GREEN="${COLOR_START}32${COLOR_END}"
 COLOR_FG_YELLOW="${COLOR_START}33${COLOR_END}"
	 COLOR_FG_BLUE="${COLOR_START}34${COLOR_END}"
COLOR_FG_MAGENTA="${COLOR_START}35${COLOR_END}"
	 COLOR_FG_CYAN="${COLOR_START}36${COLOR_END}"
	COLOR_FG_WHITE="${COLOR_START}37${COLOR_END}"
	COLOR_BG_BLACK="${COLOR_START}40${COLOR_END}"
		COLOR_BG_RED="${COLOR_START}41${COLOR_END}"
	COLOR_BG_GREEN="${COLOR_START}42${COLOR_END}"
 COLOR_BG_YELLOW="${COLOR_START}43${COLOR_END}"
	 COLOR_BG_BLUE="${COLOR_START}44${COLOR_END}"
COLOR_BG_MAGENTA="${COLOR_START}45${COLOR_END}"
	 COLOR_BG_CYAN="${COLOR_START}46${COLOR_END}"
	COLOR_BG_WHITE="${COLOR_START}47${COLOR_END}"

function build_prompt {
		
		# Handle debian chroot stuff
		PS1="${debian_chroot:+($debian_chroot)}"

		# Print user
		PS1+="${COLOR_BOLD}${COLOR_FG_RED}\u"
		
		# at
		PS1+="${COLOR_RESET} at "

		# Print host name
		PS1+="${COLOR_BOLD}${COLOR_FG_BLUE}\h"
	
		# Print Git information.
		# a couple pieces of git information inspired by https://github.com/bewuethr/dotfiles/blob/main/.myprompt.bash
		GIT_DIR=$(git rev-parse --git-dir 2> /dev/null)
		if [[ $GIT_DIR != "" ]]; then
			GIT_BRANCH=$(git symbolic-ref -q --short HEAD)
		  PS1+="${COLOR_RESET} δ ${COLOR_BOLD}${COLOR_FG_CYAN}$GIT_BRANCH"

			local UNTRACKED_CHANGES=$(git status --porcelain | grep -c '^??')
			if [[ $UNTRACKED_CHANGES -gt 0 ]]; then
				PS1+=" ?$UNTRACKED_CHANGES"
			fi
			local UNSTAGED_CHANGES=$(git status --porcelain | grep -c '^.[MD]')
			if [[ $UNSTAGED_CHANGES -gt 0 ]]; then
				PS1+=" !$UNSTAGED_CHANGES"
			fi
			local STAGED_CHANGES=$(git status --porcelain | grep -c '^[MADRC]')
			if [[ $STAGED_CHANGES -gt 0 ]]; then
				PS1+=" +$STAGED_CHANGES"
			fi
		fi

		# Print the current time and date.
		PS1+="\n${COLOR_FG_GREEN}[\t $(date +"%m-%d-%Y")] "

		# Print working directory
		PS1+="${COLOR_FG_MAGENTA}\w"

		# Print $
		PS1+="${COLOR_RESET}\$ "
}

if [ "$color_prompt" = yes ]; then
		export PROMPT_COMMAND=build_prompt
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Node Version Manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# export PATH="$PATH:/opt/nvim-linux64/bin:/home/zaynb/bin"
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"

alias config='/usr/bin/git --git-dir=/home/zaynb/.dotfiles/ --work-tree=/home/zaynb'

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Podman
export PODMAN_COMPOSE_PROVIDER="/usr/bin/podman-compose"

# Cargo
. "$HOME/.cargo/env"

# Elixir
installs_dir=$HOME/.elixir-install/installs
export PATH=$installs_dir/otp/28.1/bin:$PATH
export PATH=$installs_dir/elixir/1.19.4-otp-28/bin:$PATH

. "$HOME/.config/tmux/tmux-startup.sh"
