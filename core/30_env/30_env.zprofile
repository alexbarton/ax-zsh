# AX-ZSH: Alex' Modular ZSH Configuration
# 30_env.zprofile: Setup environment

# Setup XDG cache directory
if [[ -z "$XDG_CACHE_HOME" ]]; then
	XDG_CACHE_HOME="$LOCAL_HOME/.cache"
	mkdir -p "$XDG_CACHE_HOME"
	chmod 0700 "$XDG_CACHE_HOME"
fi
export XDG_CACHE_HOME

# Setup XDG runtime directory
if [[ -z "$XDG_RUNTIME_DIR" ]]; then
	XDG_RUNTIME_DIR="${TMPDIR:-/tmp/${UID}-runtime-dir}"
	mkdir -p "$XDG_RUNTIME_DIR"
	chmod 0700 "$XDG_RUNTIME_DIR"
fi
export XDG_RUNTIME_DIR

# Setup ZSH cache directory
if [[ -z "$ZSH_CACHE_DIR" ]]; then
	ZSH_CACHE_DIR="$XDG_CACHE_HOME/zsh"
	mkdir -p "$ZSH_CACHE_DIR"
	chmod 0700 "$ZSH_CACHE_DIR"
fi
export ZSH_CACHE_DIR
