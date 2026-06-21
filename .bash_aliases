############################
# Enable colorized ls+grep #
############################
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

##########################
# Dotfiles configuration #
##########################
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

######################
# Helpful ls aliases #
######################
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
