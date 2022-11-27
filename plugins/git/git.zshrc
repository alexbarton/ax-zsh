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

git_prompt_info() {
	local ref=$(git symbolic-ref HEAD 2>/dev/null) || return 1
	[[ -n "$ref" ]] || return 1
	echo "${ZSH_THEME_VCS_PROMPT_PREFIX}${ref#refs/heads/}${ZSH_THEME_VCS_PROMPT_SUFFIX}"
}
git_prompt_status() {
	local ref=$(git symbolic-ref HEAD 2>/dev/null) || return 1
	[[ -n "$ref" ]] || return 1
	echo "$(git_parse_dirty)$(git_prompt_ahead)$(git_prompt_behind)"
}

git_prompt() {
	local prompt=$(git_prompt_info)
	[[ -n "$prompt" ]] || return 1
	echo "$prompt$(git_prompt_status)"
	return 0
}

# OhMyZsh compatibility functions
alias parse_git_dirty=git_parse_dirty

axzsh_vcs_prompt_functions=($axzsh_vcs_prompt_functions git_prompt)

alias fix="gd --name-only | uniq | xargs $EDITOR"
alias g="git"
alias ga="g add"
alias gapa="ga --patch"
alias gc="g commit --verbose"
alias gc!="gc --amend"
alias gca="gc --all"
alias gcam="gca --message"
alias gcmsg="gc --message"
alias gcn="gc --no-edit"
alias gcn!="gcn --amend"
alias gco="g checkout"
alias gd="g diff"
alias gdca="gd --cached"
alias gdcw="gdca --word-diff"
alias gdw="gd --word-diff"
alias gf="g fetch"
alias gfa="gf --all --prune"
alias gfo="gf origin"
alias gl="g pull"
alias glo="g log --oneline --decorate"
alias gp="g push"
alias gr="g remote"
alias grb="g rebase"
alias grbi="grb --interactive"
alias gsb="gss --branch"
alias gsh="g show"
alias gss="gst --short"
alias gst="g status"
alias gsta="g stash"
alias gstl="gsta list"
alias gstp="gsta pop"
