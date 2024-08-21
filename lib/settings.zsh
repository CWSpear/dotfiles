# history-substring-search config
# bind UP and DOWN arrow keys
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)

# allows me to use "hashtag bookmarks"
setopt INTERACTIVE_COMMENTS

# Setup zsh-autosuggestions
# source "${PLUGINDIR}/zsh-autosuggestions/autosuggestions.zsh"

# # Enable autosuggestions automatically
# zle-line-init() {
#     zle autosuggest-start
# }

# zle -N zle-line-init

# # use ctrl+t to toggle autosuggestions(hopefully this wont be needed as
# # zsh-autosuggestions is designed to be unobtrusive)
# bindkey '^T' autosuggest-toggle

# Keypad
# 0 . Enter
bindkey -s "^[Op" "0"
bindkey -s "^[On" "."
bindkey -s "^[OM" "^M"
# 1 2 3
bindkey -s "^[Oq" "1"
bindkey -s "^[Or" "2"
bindkey -s "^[Os" "3"
# 4 5 6
bindkey -s "^[Ot" "4"
bindkey -s "^[Ou" "5"
bindkey -s "^[Ov" "6"
# 7 8 9
bindkey -s "^[Ow" "7"
bindkey -s "^[Ox" "8"
bindkey -s "^[Oy" "9"
# + -  * /
bindkey -s "^[OQ" "/"
bindkey -s "^[OR" "*"
bindkey -s "^[OS" "-"
bindkey -s "^[Ol" "+"
# END Keypad

autoload -U add-zsh-hook

auto-dockercontext() {
  dockercontext_path=$(find-up .dockercontext | tr -d '[:space:]')

  if [ -n "$dockercontext_path" ]; then
    dockercontext=`cat $dockercontext_path/.dockercontext`
    docker context use $dockercontext
  else
    echo "Reverting to docker context default version"
    docker context use default
  fi
}

add-zsh-hook chpwd auto-dockercontext
auto-dockercontext
