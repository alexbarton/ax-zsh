# AX-ZSH: Alex' Modular ZSH Configuration
# 99_cleanup.zlogin: Don't pollute the namespace, remove variables/functions/...

for func (
	axzsh_hostname_prompt_root
	axzsh_hostname_prompt_yn
	axzsh_logname_prompt_root
	axzsh_logname_prompt_yn
	axzsh_prompt
); do
	unfunction $func 2>/dev/null
done

for func ($axzsh_logname_prompt_functions); do
	unfunction $func 2>/dev/null
done
unset axzsh_logname_prompt_functions

for func ($axzsh_hostname_prompt_functions); do
	unfunction $func 2>/dev/null
done
unset axzsh_hostname_prompt_functions

# Try to map OhMyZsh theme Environment ...
[[ -n "$ZSH_THEME_GIT_PROMPT_AHEAD" ]] \
	&& ZSH_THEME_VCS_PROMPT_AHEAD="$ZSH_THEME_GIT_PROMPT_AHEAD"
[[ -n "$ZSH_THEME_GIT_PROMPT_CLEAN" ]] \
	&& ZSH_THEME_VCS_PROMPT_CLEAN="$ZSH_THEME_GIT_PROMPT_CLEAN"
[[ -n "$ZSH_THEME_GIT_PROMPT_DIRTY" ]] \
	&& ZSH_THEME_VCS_PROMPT_DIRTY="$ZSH_THEME_GIT_PROMPT_DIRTY"
[[ -n "$ZSH_THEME_GIT_PROMPT_PREFIX" ]] \
	&& ZSH_THEME_VCS_PROMPT_PREFIX="$ZSH_THEME_GIT_PROMPT_PREFIX"
[[ -n "$ZSH_THEME_GIT_PROMPT_SUFFIX" ]] \
	&& ZSH_THEME_VCS_PROMPT_SUFFIX="$ZSH_THEME_GIT_PROMPT_SUFFIX"
[[ -n "$ZSH_THEME_GIT_PROMPT_UNMERGED" ]] \
	&& ZSH_THEME_VCS_PROMPT_BEHIND="$ZSH_THEME_GIT_PROMPT_UNMERGED"
