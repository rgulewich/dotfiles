OS=$(uname)

## Common

# Make the shell pick up on window size changes
shopt -s checkwinsize

RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"

[ -e $HOME/.profile.d/git-completion.bash ] && source $HOME/.profile.d/git-completion.bash

## Mac
if [[ $OS == "Darwin" ]] ; then
    alias ls="ls -G"
    export PATH="$HOME/bin:$PATH:/usr/local/Cellar/node/0.2.3/bin"
    export MANPATH="$MANPATH:/usr/local/Cellar/node/0.2.3/share/man"
    export PS1="\e[0;32m\]\u@\h:\w\$ \e[0m"
fi

## Solaris
if [[ $OS == "SunOS" ]] ; then
    alias ls="ls --color"
    export TERM=xterm-color
    PS1="$RED\u@\h:\w$YELLOW"'$(__git_ps1 " (%s)")'" $RED\$\e[0m "
fi

## Common

alias jsonpp='python -mjson.tool'

# Resty
[ -e $HOME/.profile.d/resty ] && source $HOME/.profile.d/resty

# Use autojump if it's installed:
[ -e /etc/profile.d/autojump.bash ] && source /etc/profile.d/autojump.bash

