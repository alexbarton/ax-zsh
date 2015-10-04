# AX-ZSH: Alex' Modular ZSH Configuration
# powerline-shell.zshrc: "powerline-shell" integration.

[[ "$TERM" = "linux" ]] && return

if [[ -z "$POWERLINE_SHELL" ]]; then
	for p (
		"$HOME/powerline-shell.py"
		"$HOME/.powerline-shell.py"
	); do
		[[ -r "$p" ]] || continue
		POWERLINE_SHELL="$p"
		break
	done
	unset p
fi
if [[ ! -r "$POWERLINE_SHELL" ]]; then
	echo "Powerline shell extension not found/readable!"
	return
fi

function powerline_precmd() {
	PS1="$(
		$POWERLINE_SHELL \
			--shell zsh \
			--mode ${POWERLINE_SHELL_MODE:-"compatible"} \
			--colorize-hostname \
			--cwd-mode ${POWERLINE_SHELL_CWD_MODE:-"fancy"} \
			--cwd-max-depth ${POWERLINE_SHELL_CWD_DEPTH:-4} \
			$? 2>/dev/null
	)"
}

# Make sure "powerline_precmd" isn't installed already
for s in "${precmd_functions[@]}"; do
	[[ "$s" = "powerline_precmd" ]] && return
done

precmd_functions+=(powerline_precmd)
