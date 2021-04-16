# cool helper functions
function mkcd() {
  mkdir -p "$@" && cd "$@"
}

# Git Clone Directory -- clone a repo and CD into that dir!
function gcd(){
  git clone $1 && cd $(basename $1)
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
  if ! type "fd" > /dev/null 2>&1; then
    echo No fd, falling back to find
    wild=\'\*$1\*\'
    sh -c "find . -iname $wild"
    echo No fd, fell back to find
  else
    fd "$@"
  fi
}

function find.contents() {
  if ! type "rg" > /dev/null 2>&1; then
    echo No rg, falling back to grep
    grep -Ril "$1" .
    echo No rg, fell back to grep
  else
    rg "$@" .
  fi
}

# Use Mac OSX Preview to open a man page in a more handsome format
function manp() {
  man -t $1 | open -f -a /Applications/Preview.app
}

function dexec() {
  docker exec -it "$1" bash
}


function docker-rmrf {
  # add protection from running this when connected to a docker-machine other than goomba
  # MACHINE=`docker-machine active 2> /dev/null`
  MACHINE=$DOCKER_MACHINE_NAME

  if [[ $MACHINE != 'wario' && $MACHINE != '' ]]; then
    echo "[ERR] Will not run command while connected to [$MACHINE]"
  else
    if [[ !  -z  `docker container ls -a -q`  ]]; then
      docker container rm -vf `docker container ls -a -q` && echo 'All containers removed\n'
    else
      echo 'No containers to remove\n'
    fi

    if [[ !  -z  `docker volume ls -q`  ]]; then
      docker volume rm -f `docker volume ls -q` && echo 'All volumes removed\n'
    else
      echo 'No volumes to remove\n'
    fi

    if [[ !  -z  `docker network ls -q`  ]]; then
      docker network prune -f && echo 'All networks removed\n'
    else
      echo 'No networks to remove\n'
    fi

    # just to be sure
    docker system prune -f
    killall docker-compose
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


function mcp() {
  for file in "$@"
  do
    scp "$file" lakitu.local:/Volumes/Ice/Movies
  done
}
