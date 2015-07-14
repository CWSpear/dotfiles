# cool helper functions
function mkcd() {
  mkdir -p "$@" && cd "$@"
}

function vgdo() {
  eval "vagrant ssh -c \"cd /vagrant && $@\""
}

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

# Under Armour Deploy scripts shortcut
function uad() {
  sh ./deploy/$1.sh
}

function docker-nuke {
  docker rm -f $(docker ps -a -q)
  docker rmi -f $(docker images -q)
}

function zupdate() {
  CURDIR=`pwd`
  cd ${ZDOTDIR} 
  git pull 
  git submodule update --init --recursive
  cd $CURDIR
}
