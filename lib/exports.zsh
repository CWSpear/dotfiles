if [[ -n $SSH_CONNECTION ]]; then
  # remote stuff only
else
  # local stuff only
  export DOCKER_TLS_VERIFY="1"
  export DOCKER_HOST="tcp://192.168.99.100:2376"
  export DOCKER_CERT_PATH="${HOME}/.docker/machine/machines/ua"
  export DOCKER_MACHINE_NAME="ua"

  export HOMEBREW_CASK_OPTS="--appdir=/Applications"
fi

export EDITOR='vim'

export HISTFILE="${HOME}/.zsh_history"

# node npm
export PATH=${PATH}:/usr/local/share/npm/bin

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
export PATH="$PATH:$HOME/.bin"

# global composer
export PATH="$PATH:$HOME/.composer/vendor/bin"

# Added by the Heroku Toolbelt
export PATH="$PATH:/usr/local/heroku/bin"

# Xcode
export PATH=${PATH}:/Development/android-sdk-macosx/platform-tools:/Development/android-sdk-macosx/tools:/usr/local/share/npm/bin:/Development/android-ndk-macosx:/usr/local/share/python

# Add RVM to PATH for scripting
export PATH="$PATH:$HOME/.rvm/bin"

export MANPATH="/usr/local/man:$MANPATH"

# Homestead vagrantfile directory
export HOMESTEAD_VM_DIR=$HOME/Sites/homestead

# remove duplicates
PATH=$(echo "$PATH" | awk -v RS=':' -v ORS=":" '!a[$1]++{if (NR > 1) printf ORS; printf $a[$1]}')
