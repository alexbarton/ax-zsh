# AX-ZSH: Alex' Modular ZSH Configuration
# bash_completion.zshrc: Setup bash(1) completion

# Define some "dummy functions"
_init_completion() { return 0 }

autoload -Uz bashcompinit || return 1
bashcompinit

for dir (
	/etc/bash_completion.d
	/usr/local/etc/bash_completion.d
); do
	# Read in all completion functions ...
	for file ("$dir/"*(N)); do
		# Ignore errors ...
		source "$file" 2>/dev/null
	done
done
unset dir
