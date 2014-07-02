# temporary things?
if [[ -n $SSH_CONNECTION ]]; then
  # remote stuff only
else
  # local stuff only
  export DOCKER_HOST=tcp://192.168.59.103:2375
fi

# start antigen

source $HOME/.antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle command-not-found

# Fish-like bundles
antigen bundle zsh-users/fizsh
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search
# antigen bundle tarruda/zsh-autosuggestions

# Load the theme.
antigen theme https://gist.github.com/CWSpear/f48efd4474ce1bdedf9d.git cwspear

# Tell antigen that you're done.
antigen apply

# end antigen

# cool helper functions
mkcd () {
    mkdir -p "$@" && cd "$@"
}

# phpv () {
#     vagrant ssh -c "cd /vagrant && php $@"
# }

# history-substring-search config
# bind UP and DOWN arrow keys
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)


# autosuggestions config
# Enable autosuggestions automatically
# zle-line-init() {
#     zle autosuggest-start
# }
# zle -N zle-line-init
# bindkey '^f' vi-forward-blank-word
# bindkey '^T' autosuggest-toggle

# User configuration

if [[ -n $SSH_CONNECTION ]]; then
  # remote stuff only
  export EDITOR='vim'
else
  # local stuff only
  export EDITOR='subl'
  [[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh
fi

# Exports

# node npm
export PATH=/usr/local/share/npm/bin

# homebrew
export PATH=${PATH}:/usr/local/bin
export PATH=${PATH}:/usr/local/sbin

# ruby gems
export PATH=${PATH}:/usr/local/opt/ruby/bin

# the rest
export PATH=${PATH}:/usr/bin
export PATH=${PATH}:/bin
export PATH=${PATH}:/usr/sbin
export PATH=${PATH}:/sbin

# my scripts!
export PATH="$PATH:/Users/cameron/.bin"  

export PATH

# Added by the Heroku Toolbelt
export PATH="$PATH:/usr/local/heroku/bin"

# Xcode
export PATH=${PATH}:/Development/android-sdk-macosx/platform-tools:/Development/android-sdk-macosx/tools:/usr/local/share/npm/bin:/Development/android-ndk-macosx:/usr/local/share/python/

export MANPATH="/usr/local/man:$MANPATH"

###-begin-npm-completion-###
#
# npm command completion script
#
# Installation: npm completion >> ~/.bashrc  (or ~/.zshrc)
# Or, maybe: npm completion > /usr/local/etc/bash_completion.d/npm
#

COMP_WORDBREAKS=${COMP_WORDBREAKS/=/}
COMP_WORDBREAKS=${COMP_WORDBREAKS/@/}
export COMP_WORDBREAKS

if type complete &>/dev/null; then
  _npm_completion () {
    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$COMP_CWORD" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           npm completion -- "${COMP_WORDS[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
  }
  complete -F _npm_completion npm
elif type compdef &>/dev/null; then
  _npm_completion() {
    si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 npm completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef _npm_completion npm
elif type compctl &>/dev/null; then
  _npm_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       npm completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _npm_completion npm
fi
###-end-npm-completion-###
