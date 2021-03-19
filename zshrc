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
# don't share history across multiple zsh sessions
setopt no_share_history
unsetopt share_history
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

# nix's autojump
source_it /run/current-system/sw/share/zsh/site-functions/autojump.zsh

if command -v direnv >/dev/null ; then
    eval "$(direnv hook zsh)"
fi


## Common

source $HOME/.profile.d/common/common.sh


## Prompt

source $HOME/.profile.d/git/git-prompt.sh
setopt prompt_subst
autoload -Uz promptinit && promptinit

PROMPT='%F{$date_colour}%D{%y-%m-%f} %D{%r}|%F{$host_colour}%n@%M%f%F{237}:%f%F{22}%~%f%F{172}$(__git_ps1 " (%s)")%f %F{237}$%f '
# No right prompt, please
RPS1=""
RPROMPT=""


## Source any local overrides

if [[ -d "$HOME/.profile.d/local" ]]; then
    for P in $HOME/.profile.d/local/* ; do
        # echo $P
        source $P
    done
fi


## Stuff that needs to go last

autoload -Uz compinit && compinit
