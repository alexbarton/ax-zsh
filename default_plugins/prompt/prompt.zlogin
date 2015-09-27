# AX-ZSH: Alex' Modular ZSH Configuration
# prompt.zlogin: Setup default prompts

# Default prompt
PS1="$(ax_logname_prompt_yn)$(ax_hostname_prompt_yn)%B%2~%b "'$(ax_vcs_prompt)'"%{$fg_no_bold[green]%}%B\$%b%{$reset_color%} "

# Prompt on right side
RPS1="%(?..%{$fg_no_bold[red]%}%? ↵%{$reset_color%})"
