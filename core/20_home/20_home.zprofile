# AX-ZSH: Alex' Modular ZSH Configuration
# 20_home.zprofile: Setup (local) home directory

[[ -d "/usr/local/home" && ! -d "/usr/local/home/$LOGNAME" ]] \
	&& mkdir -m 700 "/usr/local/home/$LOGNAME" >/dev/null 2>&1

[[ -w "/usr/local/home/$LOGNAME" ]] \
	&& export LOCAL_HOME="/usr/local/home/$LOGNAME" \
	|| export LOCAL_HOME="$HOME"

# Setup XDG cache directory
export XDG_CACHE_HOME="$LOCAL_HOME/.cache"
mkdir -p "$XDG_CACHE_HOME"

# Setup ZSH cache directory
export ZSH_CACHE_DIR="$XDG_CACHE_HOME/zsh"
mkdir -p "$ZSH_CACHE_DIR"

# Update PATH to include directories inside of the $HOME directory
typeset -U path
for dir in ~/bin ~/sbin ~/Applications; do
	[[ -d "$dir" ]] && path[1,0]="$dir"
done
unset dir
