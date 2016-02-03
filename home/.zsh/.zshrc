# START=`ruby -e 'puts Time.now.to_f'`

umask 022

# mission critical vars
export LIBDIR="$HOME/.homesick/repos/dotfiles/lib"

# Load homeshick function and zsh completion.
source $HOME/.homesick/repos/homeshick/homeshick.sh
fpath=($HOME/.homesick/repos/homeshick/completions $fpath)

# allow my custom modules to be used
fpath=(${LIBDIR}/modules/prompt $fpath)

[[ -e $HOME/.zshlocalsetup ]] && source $HOME/.zshlocalsetup
[[ -e $HOME/.zsh/.zshlocalsetup ]] && source $HOME/.zsh/.zshlocalsetup

# only source it is it exists (i.e. probably only local)
# [[ -e ~/.phpbrew/bashrc ]] && source ~/.phpbrew/bashrc
# [[ -e ~/.nvm/nvm.sh ]] && source ~/.nvm/nvm.sh

# for iterm shell integration
[[ -e ~/.iterm2_shell_integration.zsh ]] && source ~/.iterm2_shell_integration.zsh

# start up prezto
source ${ZDOTDIR:-$HOME}/.zprezto/runcoms/zshrc

source "${LIBDIR}/exports.zsh"
source "${LIBDIR}/functions.zsh"
source "${LIBDIR}/aliases.zsh"
# source "${LIBDIR}/autocompletes.zsh"
source "${LIBDIR}/settings.zsh"

[[ -e $HOME/.zshlocal ]] && source $HOME/.zshlocal
[[ -e $HOME/.zsh/.zshlocal ]] && source $HOME/.zsh/.zshlocal

# manually added completions
fpath=(${LIBDIR}/completions $fpath)

# END=`ruby -e 'puts Time.now.to_f'`
# echo "Time to load: $((END-START))"
