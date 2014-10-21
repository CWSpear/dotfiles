# temporary things?
if [[ -n $SSH_CONNECTION ]]; then
  # remote stuff only
else
  # local stuff only
  export DOCKER_HOST=tcp://192.168.59.103:2375

  # phpbrew's only going to be on local box
  export PHPBREW_SET_PROMPT=1
  source ~/.phpbrew/bashrc
fi

# start antigen

source $HOME/.antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle ant
antigen bundle autojump
antigen bundle battery
antigen bundle bower
antigen bundle brew
antigen bundle command-not-found
antigen bundle compleat
antigen bundle composer
antigen bundle dirpersist
antigen bundle docker
antigen bundle gem
antigen bundle git
antigen bundle laravel4
antigen bundle npm
antigen bundle osx
antigen bundle ruby
antigen bundle sublime
antigen bundle supervisor
antigen bundle textmate
antigen bundle vagrant
antigen bundle web-search

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
function mkcd() {
  mkdir -p "$@" && cd "$@"
}

function vgdo() {
  eval "vagrant ssh -c \"cd /vagrant && $@\""
}
alias vudo=vgdo

# "mario" user do
function mudo() {
  PWD=`pwd`
  eval "ssh mario.local \"cd $PWD && $@\""
}

# do a Matrix movie effect of falling characters
function matrix() {
  echo -e "\e[1;40m" ; clear ; while :; do echo $LINES $COLUMNS $(( $RANDOM % $COLUMNS)) $(( $RANDOM % 72 )) ;sleep 0.05; done|gawk '{ letters="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@#$%^&*()"; c=$4; letter=substr(letters,c,1);a[$3]=0;for (x in a) {o=a[x];a[x]=a[x]+1; printf "\033[%s;%sH\033[2;32m%s",o,x,letter; printf "\033[%s;%sH\033[1;37m%s\033[0;0H",a[x],x,letter;if (a[x] >= $1) { a[x]=0; } }}'
}

function matrix2() {
  echo -e "\e[1;40m" ; clear ; characters=$( jot -c 94 33 | tr -d '\n' ) ; while :; do echo $LINES $COLUMNS $(( $RANDOM % $COLUMNS)) $(( $RANDOM % 72 )) $characters ;sleep 0.05; done|gawk '{ letters=$5; c=$4; letter=substr(letters,c,1);a[$3]=0;for (x in a) {o=a[x];a[x]=a[x]+1; printf "\033[%s;%sH\033[2;32m%s",o,x,letter; printf "\033[%s;%sH\033[1;37m%s\033[0;0H",a[x],x,letter;if (a[x] >= $1) { a[x]=0; } }}'
}

function matrix3() {
  echo -e "\e[1;40m" ; clear ; while :; do echo $LINES $COLUMNS $(( $RANDOM % $COLUMNS)) $( printf "\U$(( $RANDOM % 500 ))" ) ;sleep 0.05; done|gawk '{c=$4; letter=$4;a[$3]=0;for (x in a) {o=a[x];a[x]=a[x]+1; printf "\033[%s;%sH\033[2;32m%s",o,x,letter; printf "\033[%s;%sH\033[1;37m%s\033[0;0H",a[x],x,letter;if (a[x] >= $1) { a[x]=0; } }}'
}

function find.name() {
  wild=\'\*$1\*\'
  sh -c "find . -iname $wild"
}

function find.contents() {
  grep -Ril "$1" .
}

# Use Mac OSX Preview to open a man page in a more handsome format
function manp() {
  man -t $1 | open -f -a /Applications/Preview.app
}

# nifty aliases
alias ccat="pygmentize -g"

alias lessc='less -R' # Lets color escape sequences carry through to less
alias morec='more -R'
alias lesscolor='less -R'
alias morecolor='more -R'

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


if [[ -n $SSH_CONNECTION ]]; then
  # remote stuff only
else
  # local stuff only
  phpbrew switch "php-5.4.33"
fi
