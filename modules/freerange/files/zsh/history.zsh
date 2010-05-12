HISTFILE=~/.zhistory
HISTSIZE=100000
SAVEHIST=100000
#setopt appendhistory
setopt share_history
setopt histignoredups
setopt hist_no_store
setopt histreduceblanks

bindkey "\e[A" history-beginning-search-backward
bindkey "\e[B" history-beginning-search-forward