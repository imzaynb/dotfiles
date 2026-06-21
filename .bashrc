# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac



#########################
# History configuration #
#########################
HISTCONTROL=ignoreboth # don't put duplicate lines or lines starting with space in the history.
shopt -s histappend    # append to the history file, don't overwrite it
HISTSIZE=1000          # set history size 
HISTFILESIZE=2000      # set history file size



########################
# Window configuration #
########################
shopt -s checkwinsize  # check and update values of LINES and COLUMNS after each command

shopt -s globstar      # "**" used in a pathname will match all files zero or more directories+subdirs



#######################
# Other configuration #
#######################
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)" # make less more friendly for non-text input files, see lesspipe(1)



##############
# Completion #
##############
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



###################
# Prompt settings #
###################
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

force_color_prompt=yes # force colored prompt
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

######################
# Other colorization #
######################
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01' # colored GCC warnings and errors
