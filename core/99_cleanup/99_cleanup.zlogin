# AX-ZSH: Alex' Modular ZSH Configuration
# 99_cleanup.zlogin: Don't pollute the namespace, remove variables/functions/...

for func (
	ax_hostname_prompt_root
	ax_hostname_prompt_yn
	ax_logname_prompt_root
	ax_logname_prompt_yn
	ax_prompt
); do
	unfunction $func
done

for func ($ax_logname_prompt_functions); do
	unfunction $func 2>/dev/null
done
unset ax_logname_prompt_functions

for func ($ax_hostname_prompt_functions); do
	unfunction $func 2>/dev/null
done
unset ax_hostname_prompt_functions
