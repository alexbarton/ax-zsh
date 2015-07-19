# AX-ZSH: Alex' Modular ZSH Configuration
# grep.zshrc: Setup grep

# Make sure that "grep(1)" is installed
(( $+commands[grep] )) || return

grep-flag-available() {
	echo | grep "$1" "" >/dev/null 2>&1
}

grep_options=""
vcs_folders="{.bzr,.cvs,.git,.hg,.svn}"

# Color
if grep-flag-available "--color=auto"; then
	grep_options+=" --color=auto"
fi

# Exclude VCS folders
if grep-flag-available "--exclude-dir=.csv"; then
	grep_options+=" --exclude-dir=$vcs_folders"
elif grep-flag-available "--exclude=.csv"; then
	grep_options+=" --exclude=$vcs_folders"
fi

[[ -n "$options" ]] && alias grep="grep${grep_options}"

unfunction grep-flag-available
unset grep_options
unset vcs_folders
