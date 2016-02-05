export EDITOR='vim'
export VISUAL='vim'

if [[ -n $SSH_CONNECTION ]]; then
  # remote stuff only
else
  # local stuff only
  export VISUAL='atom'

  export HOMEBREW_CASK_OPTS="--appdir=/Applications"

  export DOCKER_HOST="tcp://192.168.1.23:4243"
fi

export HISTFILE="${HOME}/.zsh_history"

# node npm
export PATH=${PATH}:/usr/local/share/npm/bin

# go
export PATH=${PATH}:/usr/local/opt/go/libexec/bin

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
