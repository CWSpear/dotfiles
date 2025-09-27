# START=`ruby -e 'puts Time.now.to_f'`

umask 022

# mission critical vars
export LIBDIR="$HOME/.homesick/repos/dotfiles/lib"

# Load homeshick function and brew zsh completion.
source $HOME/.homesick/repos/homeshick/homeshick.sh
fpath=(/usr/local/share/zsh/site-functions $fpath)

# allow my custom modules to be used
fpath=(${LIBDIR}/modules/prompt $fpath)

[[ -e $HOME/.zshlocalsetup ]] && echo "you should 'mv ~/.zshlocalsetup ~/.zsh-local.setup.zsh'"
[[ -e $HOME/.zsh/.zshlocalsetup ]] && echo "you should 'mv ~/.zsh/.zshlocalsetup ~/.zsh/.zsh-local.setup.zsh'"
[[ -e $HOME/.local.setup.zsh ]] && echo "you should 'mv ~/.local.setup.zsh ~/.zsh-local.setup.zsh'"
[[ -e $HOME/.zsh/.local.setup.zsh  ]] && echo "you should 'mv ~/.zsh/.local.setup.zsh ~/.zsh/.zsh-local.setup.zsh'"
[[ -e $HOME/.zsh-local.setup.zsh ]] && source $HOME/.zsh-local.setup.zsh
[[ -e $HOME/.zsh/.zsh-local.setup.zsh ]] && source $HOME/.zsh/.zsh-local.setup.zsh

# for iterm shell integration
[[ -e ~/.iterm2_shell_integration.zsh ]] && source ~/.iterm2_shell_integration.zsh

# start up prezto
source ${ZDOTDIR:-$HOME}/.zprezto/runcoms/zshrc

source "${LIBDIR}/exports.zsh"
source "${LIBDIR}/functions.zsh"
source "${LIBDIR}/aliases.zsh"
source "${LIBDIR}/settings.zsh"

[[ -e $HOME/.zshlocal ]] && echo "you should 'mv ~/.zshlocal ~/.zsh-local.zsh'"
[[ -e $HOME/.zsh/.zshlocal ]] && echo "you should 'mv ~/.zsh/.zshlocal ~/.zsh/.zsh-local.zsh'"
[[ -e $HOME/.local.zsh ]] && echo "you should 'mv ~/.local.zsh ~/.zsh-local.zsh'"
[[ -e $HOME/.zsh/.local.zsh  ]] && echo "you should 'mv ~/.zsh/.local.zsh ~/.zsh/.zsh-local.zsh'"
[[ -e $HOME/.zsh-local.zsh ]] && source $HOME/.zsh-local.zsh
[[ -e $HOME/.zsh/.zsh-local.zsh ]] && source $HOME/.zsh/.zsh-local.zsh


# manually added completions
fpath=(${LIBDIR}/completions $fpath)

# END=`ruby -e 'puts Time.now.to_f'`
# echo "Time to load: $((END-START))"

# To customize prompt, run `p10k configure` or edit ~/.zsh/.p10k.zsh.
[[ -f ~/.zsh/.p10k.zsh ]] && source ~/.zsh/.p10k.zsh

if (( $+commands[direnv] )); then
  # Install direnv hook for zsh
  eval "$(direnv hook zsh)"
fi


# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/cwspear/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions

if (( $+commands[starship] )); then
  # starship (replaces zsh thing)
  eval "$(starship init zsh)"
fi
