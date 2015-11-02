# AX-ZSH: Alex' Modular ZSH Configuration
# 50_prompt.zshrc: Setup default prompts

# Logname ("user name")

ZSH_THEME_LOGNAME_PROMPT_PREFIX_SPACING=""
if (( $UID == 0 )); then
	ZSH_THEME_LOGNAME_PROMPT_PREFIX="%{$fg_no_bold[red]%}" \
	ZSH_THEME_LOGNAME_PROMPT_SUFFIX="%{$reset_color%}"
else
	ZSH_THEME_LOGNAME_PROMPT_PREFIX=""
	ZSH_THEME_LOGNAME_PROMPT_SUFFIX=""
fi
ZSH_THEME_LOGNAME_PROMPT_SUFFIX_SPACING="@"

function ax_logname_prompt_root() {
	(( $UID == 0 )) || return 1
	return 0
}

function ax_logname_prompt_yn() {
	local func
	for func ($ax_logname_prompt_functions); do
		$func || continue
		echo "${ZSH_THEME_LOGNAME_PROMPT_PREFIX_SPACING}${ZSH_THEME_LOGNAME_PROMPT_PREFIX}${1:-$LOGNAME}${ZSH_THEME_LOGNAME_PROMPT_SUFFIX}${ZSH_THEME_LOGNAME_PROMPT_SUFFIX_SPACING}"
		return
	done
}

ax_logname_prompt_functions=(ax_logname_prompt_root)

# Hostname

ZSH_THEME_HOSTNAME_PROMPT_PREFIX_SPACING=""
ZSH_THEME_HOSTNAME_PROMPT_PREFIX=""
ZSH_THEME_HOSTNAME_PROMPT_SUFFIX=""
ZSH_THEME_HOSTNAME_PROMPT_SUFFIX_SPACING=":"

function ax_hostname_prompt_root() {
	(( $UID == 0 )) || return 1
	return 0
}

function ax_hostname_prompt_yn() {
	local func
	for func ($ax_hostname_prompt_functions); do
		$func || continue
		echo "${ZSH_THEME_HOSTNAME_PROMPT_PREFIX_SPACING}${ZSH_THEME_HOSTNAME_PROMPT_PREFIX}${1:-$SHORT_HOST}${ZSH_THEME_HOSTNAME_PROMPT_SUFFIX}${ZSH_THEME_HOSTNAME_PROMPT_SUFFIX_SPACING}"
		return
	done
}

ax_hostname_prompt_functions=()

# VCS

ZSH_THEME_VCS_PROMPT_PREFIX_SPACING="("
ZSH_THEME_VCS_PROMPT_PREFIX="%{$fg_no_bold[yellow]%}"
ZSH_THEME_VCS_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_VCS_PROMPT_SUFFIX_SPACING=")"

ZSH_THEME_VCS_PROMPT_CLEAN=" %{$fg_no_bold[green]%}✔"
ZSH_THEME_VCS_PROMPT_DIRTY=" %{$fg_no_bold[red]%}✘"
ZSH_THEME_VCS_PROMPT_AHEAD="%{$fg_no_bold[cyan]%}→"
ZSH_THEME_VCS_PROMPT_BEHIND="%{$fg_no_bold[blue]%}←"

function ax_vcs_prompt() {
	local func
	local p
	for func ($ax_vcs_prompt_functions); do
		p=$( $func ) || continue
		echo "${ZSH_THEME_VCS_PROMPT_PREFIX_SPACING}${ZSH_THEME_VCS_PROMPT_PREFIX}${p}${ZSH_THEME_VCS_PROMPT_SUFFIX}${ZSH_THEME_VCS_PROMPT_SUFFIX_SPACING}"
		return
	done
}

ax_vcs_prompt_functions=()

# Prompt

ZSH_THEME_PROMPT="$"
ZSH_THEME_PROMPT_ROOT="#"

ZSH_THEME_PROMPT_PREFIX_SPACING=""
ZSH_THEME_PROMPT_PREFIX=""
ZSH_THEME_PROMPT_ROOT_PREFIX=""
ZSH_THEME_PROMPT_SUFFIX=""
ZSH_THEME_PROMPT_SUFFIX_SPACING=""

function ax_prompt() {
	local p
	(( $UID == 0 )) \
		&& p="${ZSH_THEME_PROMPT_ROOT_PREFIX}${ZSH_THEME_PROMPT_ROOT}" \
		|| p="${ZSH_THEME_PROMPT_PREFIX}${ZSH_THEME_PROMPT}"
	echo "${ZSH_THEME_PROMPT_PREFIX_SPACING}${p}${ZSH_THEME_PROMPT_SUFFIX}${ZSH_THEME_PROMPT_SUFFIX_SPACING}"
}

# Options and defaults

setopt PROMPT_SUBST
