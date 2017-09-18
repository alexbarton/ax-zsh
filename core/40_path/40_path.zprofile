# AX-ZSH: Alex' Modular ZSH Configuration
# 40_path.zprofile: Setup PATH environment

# Set default PATH
if [[ -x /usr/libexec/path_helper ]]; then
	eval "$(/usr/libexec/path_helper)"
else
	PATH="/usr/sbin:/usr/bin:/sbin:/bin"
fi
typeset -Ux PATH

# Prepend additional search paths
for d (
	/Developer/usr/bin
	/usr/ucb
	/usr/pkg/bin
	/usr/local/bin
	/usr/local/sbin
	/opt/*/bin(NOn)
	/opt/*/sbin(NOn)
	~/.gem/ruby/*/bin(NOn)
	~/.local/bin
	~/bin
	~/sbin
	~/Applications
); do
	[ -d "$d" ] && path=("$d" $path)
done

# Append additional search paths
for d (
	/usr/X11/bin
	/usr/local/games
	/usr/games
); do
	[ -d "$d" ] && path=($path "$d")
done

# Set default MANPATH
MANPATH="$(manpath -q)" 2>/dev/null
if [[ $? -ne 0 ]]; then
	MANPATH="/usr/share/man"
	for d (/usr/local/share/man /opt/*/man(N)); do
		[ -d "$d" ] && manpath=($manpath "$d")
	done
fi
typeset -Ux MANPATH
