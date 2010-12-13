# Exports
export PATH="$HOME/bin:$PATH:/usr/local/Cellar/node/0.2.3/bin"
export MANPATH="$MANPATH:/usr/local/Cellar/node/0.2.3/share/man"

# Aliases
alias ls="ls -G"

# Resty
source $HOME/.profile.d/resty

# Prompt
export PS1="\e[0;32m\]\u@\h:\w\$ \e[0m"

# Use autojump if it's installed:
[ -e /etc/profile.d/autojump.bash ] && source /etc/profile.d/autojump.bash

