# AX-ZSH: Alex' Modular ZSH Configuration
# 40_path.zprofile: Setup PATH environment

# Set default PATH
export PATH="/usr/bin:/bin:/usr/sbin:/sbin"

# Set default MANPATH
export MANPATH="$(manpath)" 2>/dev/null
if [[ $? -ne 0 ]]; then
	MANPATH="/usr/share/man"
	for d (/usr/local/share/man /opt/*/man(N)); do
		[ -d "$d" ] && MANPATH="$MANPATH:$d"
	done
fi

# Prepend additional search paths
for d (/usr/local/bin /usr/local/sbin ~/Applications(N)); do
	[ -d "$d" ] && PATH="$d:$PATH"
done

# Append additional search paths
for d (/opt/*/sbin /opt/*/bin(N)); do
	[ -d "$d" ] && PATH="$PATH:$d"
done

if [[ -x /usr/libexec/path_helper ]]; then
	# Update PATH using "path_helper(1)", when available
	eval "$(/usr/libexec/path_helper)"
fi
