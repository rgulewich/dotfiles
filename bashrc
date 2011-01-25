OS=$(uname)

# Mac
if [[ $OS == "Darwin" ]] ; then
    alias ls="ls -G"
    export PATH="$HOME/bin:$PATH:/usr/local/Cellar/node/0.2.3/bin"
    export MANPATH="$MANPATH:/usr/local/Cellar/node/0.2.3/share/man"
    export PS1="\e[0;32m\]\u@\h:\w\$ \e[0m"
fi
# Solaris
if [[ $OS == "SunOS" ]] ; then
    alias ls="ls --color"
fi

# Common
alias jsonpp='python -mjson.tool'

# Resty
[ -e $HOME/.profile.d/resty ] && source $HOME/.profile.d/resty

# Use autojump if it's installed:
[ -e /etc/profile.d/autojump.bash ] && source /etc/profile.d/autojump.bash

