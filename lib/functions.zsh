# cool helper functions
function mkcd() {
  mkdir -p "$@" && cd "$@"
}

function vgdo() {
  eval "vagrant ssh -c \"cd /vagrant && $@\""
}

# Git Clone Directory -- clone a repo and CD into that dir!
function gcd(){
  git clone $1 && cd $(basename $1)
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
  bash ./deploy/$1.sh
}

# Under Armour Schema scripts shortcut
function uas() {
  bash ./schema/$1.sh
}

function ua-test {
  local NAME=$(cat ./package.json | grep "\"name\":" | cut -d':' -f2 | cut -d'"' -f2)
  local CONTAINER="docker-artifacts.ua-ecm.com/$NAME"
  docker build -t $CONTAINER . && ua-ci $@ $CONTAINER
}

function dexec() {
  docker exec -it "$1" bash
}

function ua-build {
    local NAME=$(cat ./package.json | grep "\"name\":" | cut -d':' -f2 | cut -d'"' -f2)
    local CONTAINER="docker-artifacts.ua-ecm.com/${NAME}:latest"
    echo $CONTAINER
    docker rmi $CONTAINER
    docker build --pull -t $CONTAINER .
}

function docker-rmrf {
  # add protection from running this when connected to a docker-machine other than goomba
  MACHINE=`docker-machine active 2> /dev/null`

  if [[ $MACHINE != 'hammer-bro' && $MACHINE != '' ]]; then
    echo "[ERR] Will not run command while connected to [$MACHINE]"
  else
    # LOCAL_PERSIST=`docker ps -qf "name=local-persist"`

    # if [[ !  -z  `docker ps -a -q | grep -v $LOCAL_PERSIST`  ]]; then
      # docker rm -vf `docker ps -a -q | grep -v $LOCAL_PERSIST` && echo 'All containers removed'
      
    if [[ !  -z  `docker ps -a -q`  ]]; then
      docker rm -vf `docker ps -a -q` && echo 'All containers removed'
    else
      echo 'No containers to remove'
    fi

    docker system prune -f
  fi
}

function dnpm() {
  if [ -n "$DNPM_VERSION" ]; then
    local current=`node --version`
    DNPM_VERSION="${current/v/}"
  fi

  echo Running npm $@ with Node $DNPM_VERSION

  docker run -i \
    -v `pwd`:/src \
    -w /src \
    --entrypoint /usr/local/bin/npm \
    node:$version \
      $@
}

function nvm-init {
    export NVM_DIR="$HOME/.nvm"
    . "$(brew --prefix nvm)/nvm.sh"
}

# # Homestead shorcuts
function homestead {
  # run in a subshell so we don't change dirs
  (cd $HOMESTEAD_VM_DIR && vagrant $@)
}

function docker-local-persist {
    docker rm --force local-persist
    docker run -d --restart always \
        -v /run/docker/plugins/:/run/docker/plugins/ \
        -v /data/plugin-data/:/var/lib/docker/plugin-data/ \
        -v /data/:/data/ \
        --name local-persist \
            cwspear/docker-local-persist-volume-plugin
}

# function go {
#     docker run --rm -v /go/bin/:/go/bin/ -v `pwd`:/go/src -w /go/src golang $@
# }

function jira() {
  TICKET=$1
  if [[ $TICKET == '' ]]; then
    TICKET=`git rev-parse --abbrev-ref HEAD | cut -d - -f 1-2`
  fi

  URL="https://underarmour.atlassian.net/browse/$TICKET"

  echo "Opening $URL..."

  open "$URL"
}
