if [[ -n $SSH_CONNECTION ]]; then
  # remote stuff only
  export EDITOR='vim'
else
  # local stuff only
  export EDITOR='subl'

  export DOCKER_HOST=tcp://192.168.59.103:2375

  export HOMEBREW_CASK_OPTS="--appdir=/Applications"
fi

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
export PATH="$PATH:/Users/cameron/.bin"  

# global composer
export PATH="$PATH:/Users/cameron/.composer/vendor/bin"

# Added by the Heroku Toolbelt
export PATH="$PATH:/usr/local/heroku/bin"

# Xcode
export PATH=${PATH}:/Development/android-sdk-macosx/platform-tools:/Development/android-sdk-macosx/tools:/usr/local/share/npm/bin:/Development/android-ndk-macosx:/usr/local/share/python

# Add RVM to PATH for scripting
export PATH="$PATH:$HOME/.rvm/bin"

export MANPATH="/usr/local/man:$MANPATH"

# remove duplicates
PATH=$(echo "$PATH" | awk -v RS=':' -v ORS=":" '!a[$1]++{if (NR > 1) printf ORS; printf $a[$1]}')