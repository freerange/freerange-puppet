fpath=(~/.zsh/functions $fpath)

source ~/.zsh/prompt.zsh
source ~/.zsh/misc.zsh
source ~/.zsh/history.zsh

autoload -U ~/.zsh/functions/*(:t)

setopt LOCAL_OPTIONS # allow functions to have local options
setopt LOCAL_TRAPS # allow functions to have local traps

alias g='git'
alias fr='freerange'

cdpath=(~)

setopt autopushd # Use pushd for all directory changing
source ~/.zsh/completion.zsh

alias ls='ls -alh --color'