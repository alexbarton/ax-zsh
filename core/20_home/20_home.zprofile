# AX-ZSH: Alex' Modular ZSH Configuration
# 20_home.zprofile: Setup (local) home directory

[[ -d "/usr/local/home" && ! -d "/usr/local/home/$LOGNAME" ]] \
	&& mkdir -m 700 "/usr/local/home/$LOGNAME" >/dev/null 2>&1

[[ -w "/usr/local/home/$LOGNAME" ]] \
	&& export LOCAL_HOME="/usr/local/home/$LOGNAME" \
	|| export LOCAL_HOME="$HOME"
