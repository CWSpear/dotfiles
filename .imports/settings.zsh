# history-substring-search config
# bind UP and DOWN arrow keys
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
