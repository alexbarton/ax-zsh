# AX-ZSH: Alex' Modular ZSH Configuration
# 50_prompt.zshrc: Setup default prompts

# Logname ("user name")

(( $UID == 0 )) \
	&& ZSH_THEME_LOGNAME_PROMPT_PREFIX="%{$fg_no_bold[red]%}" \
	|| ZSH_THEME_LOGNAME_PROMPT_PREFIX=""
ZSH_THEME_LOGNAME_PROMPT_SUFFIX="%{$reset_color%}@"

function ax_logname_prompt_root() {
	(( $UID == 0 )) || return 1
	echo "$LOGNAME"
	return 0
}

ax_logname_prompt_functions=($ax_logname_prompt_functions ax_logname_prompt_root)

function ax_logname_prompt() {
	local func
	local p
	for func ($ax_logname_prompt_functions); do
		p=$( $func ) || continue
		echo "${ZSH_THEME_LOGNAME_PROMPT_PREFIX}${p}${ZSH_THEME_LOGNAME_PROMPT_SUFFIX}"
		return
	done
}

# Hostname

ZSH_THEME_HOSTNAME_PROMPT_PREFIX=""
ZSH_THEME_HOSTNAME_PROMPT_SUFFIX="%{$reset_color%}:"

function ax_hostname_prompt_root() {
	(( $UID == 0 )) || return 1
	echo "$SHORT_HOST"
	return 0
}

ax_hostname_prompt_functions=($ax_hostname_prompt_functions ax_hostname_prompt_root)

function ax_hostname_prompt() {
	local func
	local p
	for func ($ax_hostname_prompt_functions); do
		p=$( $func ) || continue
		echo "${ZSH_THEME_HOSTNAME_PROMPT_PREFIX}${p}${ZSH_THEME_HOSTNAME_PROMPT_SUFFIX}"
		return
	done
}

# VCS

ZSH_THEME_VCS_PROMPT_PREFIX="(%{$fg_no_bold[yellow]%}"
ZSH_THEME_VCS_PROMPT_SUFFIX="%{$reset_color%}) "

ZSH_THEME_VCS_PROMPT_CLEAN="%{$fg_no_bold[green]%}✔"
ZSH_THEME_VCS_PROMPT_DIRTY="%{$fg_no_bold[red]%}✘"
ZSH_THEME_VCS_PROMPT_AHEAD="%{$fg_no_bold[cyan]%}→"
ZSH_THEME_VCS_PROMPT_BEHIND="%{$fg_no_bold[blue]%}←"

function ax_vcs_prompt() {
	local func
	local p
	for func ($ax_vcs_prompt_functions); do
		p=$( $func ) || continue
		echo "${ZSH_THEME_VCS_PROMPT_PREFIX}${p}${ZSH_THEME_VCS_PROMPT_SUFFIX}"
		return
	done
}

# Options and defaults

setopt PROMPT_SUBST

export PS1 RPS1
