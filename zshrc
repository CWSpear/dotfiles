# START=`ruby -e 'puts Time.now.to_f'`

# only source it is it exists (i.e. probably only local)
[[ -e ~/.phpbrew/bashrc ]] && source ~/.phpbrew/bashrc
# [[ -e ~/.nvm/nvm.sh ]] && source ~/.nvm/nvm.sh

# start up prezto
export ZDOTDIR="${HOME}/.dotfiles"
source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"

# set up IMPORTDIR and include all our customizations
export IMPORTDIR="${ZDOTDIR}/.imports"
export PLUGINDIR="${ZDOTDIR}/.plugins"

source "${IMPORTDIR}/exports.zsh"
source "${IMPORTDIR}/functions.zsh"
source "${IMPORTDIR}/aliases.zsh"
source "${IMPORTDIR}/autocompletes.zsh"
source "${IMPORTDIR}/settings.zsh"

# END=`ruby -e 'puts Time.now.to_f'`
# echo "Time to load: $((END-START))"
