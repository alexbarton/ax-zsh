# AX-ZSH: Alex' Modular ZSH Configuration
# 50_prompt.zshrc: Setup default prompts

# Some dummy functions (used by some OhMyZsh themes, for example) ...
git_prompt_info(){ true; }
git_prompt_status(){ true; }
rvm_prompt_info(){ true; }

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

if axzsh_is_utf_terminal; then
	clean="✔"; dirty="✘"; ahead="→"; behind="←"
else
	clean="+"; dirty="x"; ahead=">"; behind="<"
fi

ZSH_THEME_VCS_PROMPT_PREFIX_SPACING="("
ZSH_THEME_VCS_PROMPT_PREFIX="%{$fg_no_bold[yellow]%}"
ZSH_THEME_VCS_PROMPT_SUFFIX="%{$fg[default]%}"
ZSH_THEME_VCS_PROMPT_SUFFIX_SPACING=")"

ZSH_THEME_VCS_PROMPT_CLEAN=" %{$fg_no_bold[green]%}$clean%{$fg[default]%}"
ZSH_THEME_VCS_PROMPT_DIRTY=" %{$fg_no_bold[red]%}$dirty%{$fg[default]%}"
ZSH_THEME_VCS_PROMPT_AHEAD="%{$fg_no_bold[cyan]%}$ahead%{$fg[default]%}"
ZSH_THEME_VCS_PROMPT_BEHIND="%{$fg_no_bold[blue]%}$behind%{$fg[default]%}"

unset clean dirty ahead behind

function ax_vcs_prompt() {
	local func
	local p
	for func ($ax_vcs_prompt_functions); do
		p=$( $func ) || continue
		echo "${ZSH_THEME_VCS_PROMPT_PREFIX_SPACING}${p}${ZSH_THEME_VCS_PROMPT_SUFFIX_SPACING}"
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
