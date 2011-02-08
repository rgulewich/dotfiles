OS=$(uname)

## Common

# Make the shell pick up on window size changes
shopt -s checkwinsize

RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"
BLUE="\[\033[0;34m\]"

[ -e $HOME/.profile.d/git-completion.bash ] && source $HOME/.profile.d/git-completion.bash

## Mac
if [[ $OS == "Darwin" ]] ; then
    alias ls="ls -G"
    export PATH="$HOME/bin:$PATH:/usr/local/Cellar/node/0.2.3/bin"
    export MANPATH="$MANPATH:/usr/local/Cellar/node/0.2.3/share/man"
    export PS1="$GREEN\u@\h:\w \$\e[0m "
    # For gist:
    export GITHUB_USER="wayfaringrob"
    [ -e "$HOME/.priv/github_token" ] && export GITHUB_TOKEN=$(cat $HOME/.priv/github_token)
    PSCOLOR=$GREEN
fi

## Solaris
if [[ $OS == "SunOS" ]] ; then
    alias ls="ls --color"
    export TERM=xterm-color
    export PAGER=less
    zone=$(zonename)
    if [ $zone == "global" ]; then
        PSCOLOR=$RED
    else
        PSCOLOR=$BLUE
    fi
fi

## Common

PS1="$PSCOLOR\u@\h:\w$YELLOW"'$(__git_ps1 " (%s)")'" $PSCOLOR\$\e[0m "
alias jsonpp='python -mjson.tool'
alias less='less -R'

# Resty
[ -e $HOME/.profile.d/resty/resty ] && source $HOME/.profile.d/resty/resty

# Use autojump if it's installed:
[ -e /etc/profile.d/autojump.bash ] && source /etc/profile.d/autojump.bash

