if [ -z "$PS1" ]; then
   return
fi

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
    export PATH="$HOME/bin:$PATH:/usr/local/node/bin"
    export MANPATH="$MANPATH:/usr/local/node/share/man"
    # For gist:
    export GITHUB_USER="wayfaringrob"
    [ -e "$HOME/.priv/github_token" ] && export GITHUB_TOKEN=$(cat $HOME/.priv/github_token)
    PSCOLOR=$GREEN
fi

## Solaris
if [[ $OS == "SunOS" ]] ; then
    alias ls="ls --color=auto"
    export TERM=xterm-color
    export PAGER=less
    export PATH="$PATH:/opt/local/gcc34/bin"
    zone=$(zonename)
    if [ $zone == "global" ]; then
        PSCOLOR=$RED
    else
        PSCOLOR=$BLUE
    fi
fi

## Common

PS1="$PSCOLOR\u@\h:\w$YELLOW"'$(__git_ps1 " (%s)")'" $PSCOLOR\$\e[0m "
alias less='less -R'

# Resty
[ -e $HOME/.profile.d/resty/resty ] && source $HOME/.profile.d/resty/resty

# Use autojump if it's installed:
[ -e /etc/profile.d/autojump.bash ] && source /etc/profile.d/autojump.bash

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

# Source any local overrides

for P in $HOME/.profile.d/local/* ; do
    echo $P
    source $P
done

