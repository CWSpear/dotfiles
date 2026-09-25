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

function auto-dockercontext() {
  BLUE='\033[0;34m'
  GREEN='\033[0;32m'
  NC='\033[0m' # No Color (resets the color)

  if [[ "$MANUAL_DOCKER_CONTEXT_IS_SET" == "1" && "$DOCKER_CONTEXT" != "default" ]]; then
    echo "Docker Context was manually set with ${GREEN}dcon${NC}, staying on ${BLUE}${DOCKER_CONTEXT}${NC}"
    return
  fi

  dockercontext_path=$(find-up .dockercontext | tr -d '[:space:]')

  if [ -n "$dockercontext_path" ]; then
    dockercontext=`cat $dockercontext_path/.dockercontext`
    current_dockercontext=${DOCKER_CONTEXT:-default}
    if [ "$dockercontext" != "$current_dockercontext" ]; then
      echo "Setting docker context based on .dockercontext: ${BLUE}$dockercontext${NC}"
      dcon $dockercontext > /dev/null 2>&1
      unset MANUAL_DOCKER_CONTEXT_IS_SET
    fi
  #elif [ -n "$DOCKER_CONTEXT" ]; then
    #echo "Setting docker context to value in \$DOCKER_CONTEXT: ${BLUE}$DOCKER_CONTEXT${NC}"
    #docker context use $DOCKER_CONTEXT > /dev/null 2>&1
  else
    if [ -n "$DOCKER_CONTEXT" ]; then
      echo "Clearing DOCKER_CONTEXT (using Docker's current context)"
      dcon default > /dev/null 2>&1
      unset MANUAL_DOCKER_CONTEXT_IS_SET
    fi
  fi
}

function dcon() {
  new_context="$1"

  if [[ "$new_context" == "unset" ]]; then
    # unset does the same thing as `default`, except it also attempts to load from `.dockercontext`
    run_auto_load="1"
    new_context="default"
  fi


  if ! docker context ls -q | grep -Fxq "$new_context"; then
    print -P "%F{cyan}${new_context}%f does not exist"
    return
  fi

  unset DOCKER_TLS_VERIFY
  unset DOCKER_HOST
  unset DOCKER_CERT_PATH
  unset DOCKER_MACHINE_NAME

  # docker context use "$1"
  if [[ "$new_context" == "default" ]]; then
    unset DOCKER_CONTEXT
    unset MANUAL_DOCKER_CONTEXT_IS_SET
    if [[ "$run_auto_load" == "1" ]]; then
      auto-dockercontext
    fi
  else
    export DOCKER_CONTEXT="$new_context"
    export MANUAL_DOCKER_CONTEXT_IS_SET="1"
  fi
}

function find-up() {
  path=$(pwd)
  while [[ "$path" != "" && ! -e "$path/$1" ]]; do
    path=${path%/*}
  done
  echo "$path"
}

# allows doing `dcp --context pandora up -d`, rerouting `--context` as a docker flag (instead of a compose flag)
dcp() {
  local docker_args=()
  local compose_files=(-f docker-compose.yml -f docker-compose.production.yml)

  while [[ $# -gt 0 ]]; do
    case "$1" in
      --context|-c)
        docker_args+=("$1" "$2")
        shift 2
        ;;
      --context=*)
        docker_args+=("$1")
        shift
        ;;
      *)
        break
        ;;
    esac
  done

  docker "${docker_args[@]}" compose "${compose_files[@]}" "$@"
}

sshoon() {
  local target="$1"
  echo "Waiting for $target to come back online..."
  until ssh -o ConnectTimeout=2 -o BatchMode=yes "$target" 'exit' 2>/dev/null; do
    printf "."
    sleep 1
  done
  echo -e "\nServer up! Connecting..."
  ssh "$target"
}