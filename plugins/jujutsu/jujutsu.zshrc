# AX-ZSH: Alex' Modular ZSH Configuration
# jujutsu.zshrc: Setup Jujutsu, a version control system.

# Make sure that "jj(1)" is installed
(( $+commands[jj] )) || return

jj_prompt_info() {
	if axzsh_is_utf_terminal; then
		local empty="∅"; local nodesc="⁉"
	else
		local empty="0"; local nodesc="?"
	fi
	local jj_info=""

	local jj_status=$(LC_ALL=C jj --color=always status 2>/dev/null)
	[[ -n "$jj_status" ]] || return 1

	# Try to get and split the commit ID ...
	declare -a jj_id=($(
		echo $jj_status \
		| sed -En 's/^Working copy *: \x1B\[1m\x1B\[[0-9;]*m([a-z0-9]*)\x1B\[[0-9;]*m([a-z0-9]*).*/\1 \2/p'
	))
	[[ -n "$jj_id" ]] || return 1

	echo $jj_status | grep -E '^Working copy .*\(empty\)' >/dev/null \
		&& jj_info+="%{$fg[yellow]%}${empty}%{$fg[default]%}"
	echo $jj_status | grep -E '^Working copy .*\(no description set\)' >/dev/null \
		&& jj_info+="%{$fg[red]%}${nodesc}%{$fg[default]%}"

	[[ -n "$jj_info" ]] && jj_info=" ${jj_info}"
	echo "${ZSH_THEME_VCS_PROMPT_PREFIX}%{$fg_bold[magenta]%}${jj_id[1]}${FG[008]}${jj_id[2]}%{$reset_color%}${jj_info}${ZSH_THEME_VCS_PROMPT_SUFFIX}"
}

jj_prompt() {
	local prompt=$(jj_prompt_info)
	[[ -n "$prompt" ]] || return 1
	echo "$prompt"
	return 0
}

axzsh_vcs_prompt_functions=($axzsh_vcs_prompt_functions jj_prompt)

alias jd="jj diff"
alias jdesc="jj desc"
alias je="jj edit"
alias jf="jj git fetch"
alias jfa="jj git fetch --all-remotes"
alias jlo="jj log"
alias jn="jj new"
alias jp="jj git push"
alias jr="jj git remote"
alias jrb="jj rebase"
alias jsh="jj show"
alias jst="jj status"
