if [[ ! -o interactive ]]; then
    return
fi

source $HOME/.profile.d/common/functions.sh


## Shell options, completion

bindkey -v
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fpath=(~/.zsh $fpath)

# Command history
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
SAVEHIST=10000
HISTSIZE=10000
# share history across multiple zsh sessions
setopt SHARE_HISTORY
setopt APPEND_HISTORY
# adds commands as they are typed, not at shell exit
setopt INC_APPEND_HISTORY
# expire duplicates first
setopt HIST_EXPIRE_DUPS_FIRST
# do not store duplications
setopt HIST_IGNORE_DUPS
#ignore duplicates when searching
setopt HIST_FIND_NO_DUPS
# removes blank lines from history
setopt HIST_REDUCE_BLANKS

# Enable reverse history search with Ctrl-R
bindkey '^R' history-incremental-search-backward


autoload -Uz compinit && compinit


## Common

source $HOME/.profile.d/common/common.sh


## Prompt

source $HOME/.profile.d/git-prompt.sh
setopt prompt_subst
autoload -Uz promptinit && promptinit

PROMPT='%F{$host_colour}%n@%M%f%F{237}:%f%F{22}%~%f%F{172}$(__git_ps1 " (%s)")%f %F{237}$%f '
