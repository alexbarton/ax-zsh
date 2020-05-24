# AX-ZSH: Alex' Modular ZSH Configuration
# travis.zshrc: Setup autocompletion for travis(1).

# Make sure that "travis(1)" is installed
(( $+commands[travis] )) || return

# Does the user-local completion file exist?
[[ -r "$HOME/.travis/travis.sh" ]] && source "$HOME/.travis/travis.sh"
return 0
