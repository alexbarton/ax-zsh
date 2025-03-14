# AX-ZSH: Alex' Modular ZSH Configuration
# bashcompletion.zsh: load bash(1) completion scripts into ZSH.

scripts=(/etc/bash_completion.d/*(N))

# Check if bash completion script are available
if [[ -z "$scripts" ]]; then
	unset scripts
	return 1
fi

autoload -U bashcompinit
bashcompinit

for script ($scripts); do
	source "$script"
done
unset script scripts

return 0
