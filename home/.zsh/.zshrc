# START=`ruby -e 'puts Time.now.to_f'`

# mission critical vars
export LIBDIR="$HOME/.homesick/repos/dotfiles/lib"

# Load homeshick function and zsh completion.
source $HOME/.homesick/repos/homeshick/homeshick.sh
fpath=($HOME/.homesick/repos/homeshick/completions $fpath)

# allow my custom modules to be used
fpath=(
  ${LIBDIR}/modules/prompt
  ${fpath}
)

# only source it is it exists (i.e. probably only local)
# [[ -e ~/.phpbrew/bashrc ]] && source ~/.phpbrew/bashrc
# [[ -e ~/.nvm/nvm.sh ]] && source ~/.nvm/nvm.sh

# start up prezto
source ${ZDOTDIR:-$HOME}/.zprezto/runcoms/zshrc

source "${LIBDIR}/exports.zsh"
source "${LIBDIR}/functions.zsh"
source "${LIBDIR}/aliases.zsh"
# source "${LIBDIR}/autocompletes.zsh"
source "${LIBDIR}/settings.zsh"

# END=`ruby -e 'puts Time.now.to_f'`
# echo "Time to load: $((END-START))"
