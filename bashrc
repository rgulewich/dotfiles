if [ -z "$PS1" ]; then
   return
fi

OS=$(uname)

## Commonly-used functions

function source_it() {
    [[ -e $1 ]] && source $1
}

function add_path() {
    [[ -d $1 ]] && export PATH="$PATH:$1"
}

## Common

# Make the shell pick up on window size changes
shopt -s checkwinsize
# Allow partial completion of names
shopt -s cdspell
# Share bash history between open terminals
shopt -s histappend
export PROMPT_COMMAND="history -a"

source_it $HOME/.profile.d/git-completion.bash

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


## Common

PS1=$'\\[\E[1m\E[38;5;${host_colour}m\\]\\u@\\h\\[\E[m\017\\]\\[\E[1m\E[38;5;237m\\]:\\[\E[m\017\\]\\[\E[1m\E[38;5;22m\\]\\w\\[\E[m\017\\]\\[\E[1m\E[38;5;172m\\]$(__git_ps1 " (%s)") \\[\E[m\017\\]\\[\E[1m\E[38;5;237m\\]$\\[\E[m\017\\] '
alias less='less -R'
alias date-for-date='echo "# Run the following on target machine to set to same date as here." && echo -n "date " && date -u "+%m%d%H%M%Y.%S"'

add_path $HOME/bin

# golang:
export GOPATH=$HOME/src/go
export GO111MODULE=on
add_path $HOME/src/go/bin

# node / nvm:
export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && \. "$NVM_DIR/nvm.sh"
[[ -s "$NVM_DIR/bash_completion" ]] && \. "$NVM_DIR/bash_completion"
add_path /usr/local/node/bin
export MANPATH="$MANPATH:/usr/local/node/share/man"

set -o vi
set completion-ignore-case On


function gup {
  # subshell for `set -e` and `trap`
  (
    # fail immediately if there's a problem
    set -e
    # fetch upstream changes
    git fetch
    BRANCH=$(git describe --contains --all HEAD)
    if [ -z "$(git config branch.$BRANCH.remote)" -o -z "$(git config branch.$BRANCH.merge)" ]
    then
      echo "\"$BRANCH\" is not a tracking branch." >&2
      exit 1
    fi
    # create a temp file for capturing command output
    TEMPFILE="`mktemp -t gup.XXXXXX`"
    trap '{ rm -f "$TEMPFILE"; }' EXIT
    # if we're behind upstream, we need to update
    if git status | grep "# Your branch" > "$TEMPFILE"; then

      # extract tracking branch from message
      UPSTREAM=$(cat "$TEMPFILE" | cut -d "'" -f 2)
      if [ -z "$UPSTREAM" ]
      then
        echo Could not detect upstream branch >&2
        exit 1
      fi

      # stash any uncommitted changes
      git stash | tee "$TEMPFILE"
      [ "${PIPESTATUS[0]}" -eq 0 ] || exit 1

      # take note if anything was stashed
      HAVE_STASH=0
      grep -q "No local changes" "$TEMPFILE" || HAVE_STASH=1

      # rebase our changes on top of upstream, but keep any merges
      git rebase -p "$UPSTREAM"

      # restore any stashed changed
      [ "$HAVE_STASH" -ne 0 ] && git stash pop -q

    fi
  )
}

# Prints the sha of the last git change
gsh ()
{
    local sha;
    sha=$(git show ${1-HEAD} | head -n1 | awk '{print $2}' | xargs echo -n);
    echo -n $sha | pbcopy;
    echo $sha
}

# Highlight text
function hi() {
    perl -pe "s/$1/\e[1;31;43m$&\e[0m/g"
}

# Source any local overrides

if [ -d "$HOME/.profile.d/local" ]; then
    for P in $HOME/.profile.d/local/* ; do
        # echo $P
        source $P
    done
fi
