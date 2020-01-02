if [[ ! -o interactive ]]; then
    return
fi

source $HOME/.profile.d/common/functions.sh


## Shell options, completion

bindkey -v
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fpath=(~/.zsh $fpath)

autoload -Uz compinit && compinit


## Common

source $HOME/.profile.d/common/common.sh


## Prompt

source $HOME/.profile.d/git-prompt.sh
setopt prompt_subst
autoload -Uz promptinit && promptinit

PROMPT='%F{$host_colour}%n@%M%f%F{237}:%f%F{22}%~%f%F{172}$(__git_ps1 " (%s)")%f %F{237}$%f '
