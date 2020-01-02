## Shared functions between bash and zsh

# blue:
host_colour=25

## Mac
if [[ $OS == "Darwin" ]] ; then
    export EDITOR=vim
    # Make things colourful:
    export CLICOLOR=1
    export GREP_OPTIONS='--color=auto'

    # Aliases:
    alias ldd='otool -L'
    alias t='todo.sh'
    # Tell tmux we have 256 colours available
    alias tmux="tmux -2"

    # rvm:
    [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

    # autojump
    source_it /usr/local/etc/profile.d/autojump.sh
    # virtualenv
    #add_path $HOME/Library/Python/2.7/bin
    add_path $HOME/Library/Python/3.7/bin
fi

## Linux
if [[ $OS == "Linux" ]] ; then
    alias ls="ls --color=auto"
    # Solarized doesn't play nicely with the colours that Linux picks:
    export LS_COLORS="di=00;34:ln=00;35:so=00;32:pi=01;33:ex=00;31:bd=00;34"

    # autojump
    source_it /usr/share/autojump/autojump.bash
    # system golang:
    add_path /usr/local/go/bin
    # purple
    host_colour=97
fi

## Aliases

alias less='less -R'
alias date-for-date='echo "# Run the following on target machine to set to same date as here." && echo -n "date " && date -u "+%m%d%H%M%Y.%S"'
alias rgv='rg --iglob "!vendor"'

## Paths

add_path $HOME/bin

# yarn
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# golang
export GOPATH=$HOME/src/go
export GO111MODULE=on
add_path $HOME/src/go/bin

# node / nvm
export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
[[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"
add_path /usr/local/node/bin

# man
export MANPATH="$MANPATH:/usr/local/node/share/man"

