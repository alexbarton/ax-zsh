# AX-ZSH: Alex' Modular ZSH Configuration
# correction.zshrc: Setup correction

setopt correct_all

# Ignore completion functions starting with an "_", never offer them as a
# correction!
CORRECT_IGNORE='_*'

# Ignore dot files, don't offer them as a correction.
CORRECT_IGNORE_FILE='.*'

SPROMPT="$ZSH_NAME: Correct \"$fg[yellow]%R$reset_color\" to \"$fg[green]%r$reset_color\" [$fg_bold[white]nyae$reset_color]? "

