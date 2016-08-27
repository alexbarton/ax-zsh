# AX-ZSH: Alex' Modular ZSH Configuration
# 30_env.zprofile: Setup environment

# Setup XDG cache directory
[[ -z "$XDG_CACHE_HOME" ]] && XDG_CACHE_HOME="$LOCAL_HOME/.cache"
export XDG_CACHE_HOME
mkdir -p "$XDG_CACHE_HOME"

# Setup XDG runtime directory
[[ -z "$XDG_RUNTIME_DIR" ]] && XDG_RUNTIME_DIR="${TMPDIR:-/tmp/${UID}-runtime-dir}"
export XDG_RUNTIME_DIR
mkdir -p "$XDG_CACHE_HOME"

# Setup ZSH cache directory
[[ -z "$ZSH_CACHE_DIR" ]] && ZSH_CACHE_DIR="$XDG_CACHE_HOME/zsh"
export ZSH_CACHE_DIR
mkdir -p "$ZSH_CACHE_DIR"
