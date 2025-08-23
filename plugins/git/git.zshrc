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

alias fix="git diff --name-only | uniq | xargs $EDITOR"
alias g="git"
alias ga="git add"
alias gapa="git add --patch"
alias gc="git commit --verbose"
alias gc!="git commit --verbose --amend"
alias gca="git commit --verbose --all"
alias gcam="git commit --verbose --all --message"
alias gcmsg="git commit --verbose --message"
alias gcn="git commit --verbose --no-edit"
alias gcn!="git commit --verbose --no-edit --amend"
alias gco="git checkout"
alias gd="git diff"
alias gdca="git diff --cached"
alias gdcw="git diff --cached --word-diff"
alias gdw="git diff --word-diff"
alias gf="git fetch"
alias gfa="git fetch --all --prune"
alias gfo="git fetch origin"
alias gl="git pull"
alias glg="git log --stat"
alias glgg="git log --graph"
alias glgga="git log --graph --decorate --all"
alias glgp="git log --stat --patch"
alias glo="git log --oneline --decorate"
alias glog="git log --oneline --decorate --graph"
alias gloga="git log --oneline --decorate --graph --all"
alias glon="git log --oneline --decorate --max-count=\$((LINES*2/3))"
alias gloo="git log --oneline --decorate ORIG_HEAD.."
alias gp="git push"
alias gr="git remote"
alias grb="git rebase"
alias grbi="git rebase --interactive"
alias gsb="git status --short --branch"
alias gsh="git show"
alias gss="git status --short"
alias gst="git status"
alias gsta="git stash push"
alias gstl="git stash list"
alias gstp="git stash pop"
