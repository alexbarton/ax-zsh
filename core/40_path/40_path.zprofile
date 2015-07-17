# AX-ZSH: Alex' Modular ZSH Configuration
# 40_path.zprofile: Setup PATH environment

# Set default PATH
export PATH="/usr/bin:/bin:/usr/sbin:/sbin"

# Prepend additional search paths
for d (/usr/local/bin /usr/local/sbin ~/Applications(N)); do
	[ -d "$d" ] && path=("$d" $path)
done

# Append additional search paths
for d (/opt/*/sbin /opt/*/bin(N)); do
	[ -d "$d" ] && path=($path "$d")
done

# Set default MANPATH
export MANPATH="$(manpath -q)" 2>/dev/null
if [[ $? -ne 0 ]]; then
	MANPATH="/usr/share/man"
	for d (/usr/local/share/man /opt/*/man(N)); do
		[ -d "$d" ] && manpath=($manpath "$d")
	done
fi

if [[ -x /usr/libexec/path_helper ]]; then
	# Update PATH using "path_helper(1)", when available
	eval "$(/usr/libexec/path_helper)"
fi
