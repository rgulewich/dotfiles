if [[ -z "$PS1" ]]; then
   return
fi

source $HOME/.profile.d/common/functions.sh


## Shell options, completion

# Make the shell pick up on window size changes
shopt -s checkwinsize
# Allow partial completion of names
shopt -s cdspell
# Share bash history between open terminals
shopt -s histappend
set -o vi
export PROMPT_COMMAND="history -a"

set completion-ignore-case On
source_it $HOME/.profile.d/git/git-completion.bash
# nix's autojump
source_it /run/current-system/sw/share/bash-completion/completions/autojump.bash


## Common

source $HOME/.profile.d/common/common.sh


## Prompt

source_it $HOME/.profile.d/git/git-prompt.sh
PS1=$'\\[\E[1m\E[38;5;${host_colour}m\\]\\u@\\h\\[\E[m\017\\]\\[\E[1m\E[38;5;237m\\]:\\[\E[m\017\\]\\[\E[1m\E[38;5;22m\\]\\w\\[\E[m\017\\]\\[\E[1m\E[38;5;172m\\]$(__git_ps1 " (%s)") \\[\E[m\017\\]\\[\E[1m\E[38;5;237m\\]$\\[\E[m\017\\] '


## Functions

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


## Source any local overrides

if [[ -d "$HOME/.profile.d/local" ]]; then
    for P in $HOME/.profile.d/local/* ; do
        # echo $P
        source $P
    done
fi
