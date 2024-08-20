# nifty aliases
alias ccat="pygmentize -g"

alias lessc='less -R' # Lets color escape sequences carry through to less
alias morec='more -R'
alias lesscolor='less -R'
alias morecolor='more -R'

alias lsa='ls -lah'

# note this overrides dc (desk calculator)
alias dc="docker compose"
alias dcp="docker compose -f docker-compose.yml -f docker-compose.production.yml"
alias dm="docker-machine"
alias drm="docker-rmrf"
alias dcon="docker context use"

alias vudo=vgdo

alias mblt='lt --host "http://tunnel.matchbooklab.com"'
alias cwst='lt --host "http://tunnel.cameronspear.com"'

# fasd shortcuts
alias j="fasd_cd -d"
alias ji="fasd_cd -i"

# unalias things from prezto that conflict!
unalias lt # local tunnel

if type "bat" > /dev/null 2>&1; then
  alias cat='bat --paging=never --style=plain'
fi
