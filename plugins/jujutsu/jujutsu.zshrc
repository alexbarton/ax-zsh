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

alias ja="jj abandon"
alias jb="jj bookmark"
alias jba="jj bookmark advance"
alias jbc="jj bookmark create"
alias jbd="jj bookmark delete"
alias jbf="jj bookmark forget"
alias jbl="jj bookmark list"
alias jbm="jj bookmark move"
alias jbr="jj bookmark rename"
alias jbs="jj bookmark set"
alias jbt="jj bookmark track"
alias jbu="jj bookmark untrack"
alias jc="jj commit"
alias jcmsg="jj commit --message"
alias jd="jj diff"
alias jdesc="jj desc"
alias je="jj edit"
alias jf="jj git fetch"
alias jfa="jj git fetch --all-remotes"
alias jla="jj log -r 'all()'"
alias jlo="jj log"
alias jlon="jj log --limit \$((LINES/4))"
alias jmsg="jj describe --message"
alias jn="jj new"
alias jnm="jj new --message"
alias jnt="jj new 'trunk()'"
alias jp="jj git push"
alias jr="jj git remote"
alias jrb="jj rebase"
alias jrbm="jj rebase --onto 'trunk()'"
alias jrs="jj restore"
alias jsh="jj show"
alias jsp="jj split"
alias jsq="jj squash"
alias jst="jj status"

# Check for and enable command completion:
if ! type _jj &>/dev/null && ! type _clap_dynamic_completer_jj &>/dev/null; then
	# No completion function found so far.
	source <(COMPLETE=zsh jj)
fi
