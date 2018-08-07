# AX-ZSH: Alex' Modular ZSH Configuration
# go.zprofile: Setup Go environment.

# Make sure that "go(1)" is installed
(( $+commands[go] )) || return

# Try to detect existing GOPATH directory ...
if [[ -z "$GOPATH" ]]; then
	for gopath in $HOME/.go $HOME/go; do
		if [[ -d "$gopath" ]]; then
			GOPATH="$gopath"
			break
		fi
	done
	unset gopath
fi

# Make sure a GOPATH directory exists:
if [[ -z "$GOPATH" ]]; then
	GOPATH="$HOME/.go"
	mkdir -p "$GOPATH"
fi

path+=("$GOPATH/bin")
export GOPATH
