# START=`ruby -e 'puts Time.now.to_f'`

# mission critical vars
export ZDOTDIR="${HOME}/.dotfiles"
export LIBDIR="${ZDOTDIR}/lib"

# allow my custom modules to be used
fpath=(
  ${LIBDIR}/modules/prompt
  ${fpath}
)

# only source it is it exists (i.e. probably only local)
# [[ -e ~/.phpbrew/bashrc ]] && source ~/.phpbrew/bashrc
# [[ -e ~/.nvm/nvm.sh ]] && source ~/.nvm/nvm.sh

# start up prezto
source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"

source "${LIBDIR}/exports.zsh"
source "${LIBDIR}/functions.zsh"
source "${LIBDIR}/aliases.zsh"
# source "${LIBDIR}/autocompletes.zsh"
source "${LIBDIR}/settings.zsh"

# END=`ruby -e 'puts Time.now.to_f'`
# echo "Time to load: $((END-START))"
