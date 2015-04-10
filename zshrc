# START=`ruby -e 'puts Time.now.to_f'`

# start up prezto
export ZDOTDIR="${HOME}/.dotfiles"
source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"

# set up IMPORTDIR and include all our customizations
export IMPORTDIR="${ZDOTDIR}/.imports"

source "${IMPORTDIR}/exports.zsh"
source "${IMPORTDIR}/functions.zsh"
source "${IMPORTDIR}/aliases.zsh"
source "${IMPORTDIR}/autocompletes.zsh"
source "${IMPORTDIR}/settings.zsh"

# start autojump
# [[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

# END=`ruby -e 'puts Time.now.to_f'`
# echo "Time to load: $((END-START))"
