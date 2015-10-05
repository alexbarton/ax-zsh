# AX-ZSH: Alex' Modular ZSH Configuration
# git.zshrc: Setup Git

# Make sure that "git(1)" is installed
(( $+commands[git] )) || return

git_parse_dirty() {
	local flags
	flags=(
		'--porcelain'
		'--ignore-submodules=dirty'
		#'--untracked-files=no'
	)
	[[ -n "$(git status $flags 2>/dev/null | tail -n1)" ]] \
		&& echo "$ZSH_THEME_VCS_PROMPT_DIRTY" \
		|| echo "$ZSH_THEME_VCS_PROMPT_CLEAN"
}

git_current_branch() {
	local ref=$(git symbolic-ref --quiet HEAD 2>/dev/null)
	local ret=$?
	if [[ $ret != 0 ]]; then
		[[ $ret == 128 ]] && return		# No Git repository
		ref=$(git rev-parse --short HEAD 2>/dev/null) || return
	fi
	echo "${ref#refs/heads/}"
}

git_prompt_ahead() {
	[[ -n "$(git rev-list "@{upstream}..HEAD" 2>/dev/null)" ]] \
		&& echo "$ZSH_THEME_VCS_PROMPT_AHEAD"
}

git_prompt_behind() {
	[[ -n "$(git rev-list HEAD..@{upstream} 2>/dev/null)" ]] \
		&& echo "$ZSH_THEME_VCS_PROMPT_BEHIND"
}

git_prompt() {
	ref=$(git symbolic-ref HEAD 2>/dev/null) || return 1
	echo "${ref#refs/heads/}$(git_parse_dirty)$(git_prompt_ahead)$(git_prompt_behind)"
	return 0
}

ax_vcs_prompt_functions=($ax_vcs_prompt_functions git_prompt)

alias ga="git add"
alias gc="git commit"
alias gd="git diff"
alias gdc="git diff --cached"
alias gst="git status --short --branch --untracked"
