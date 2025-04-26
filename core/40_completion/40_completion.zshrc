# AX-ZSH: Alex' Modular ZSH Configuration
# 50_completion.zshrc: Setup completion

autoload -Uz compinit

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate

zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' menu select
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' group-name ''
zstyle ':completion:*' squeeze-slashes true

# Messages
zstyle ':completion:*:corrections' format '%B%F{green}-> %d (%e errors):%f%b'
zstyle ':completion:*:descriptions' format '%B%F{cyan}-> %d:%f%b'
zstyle ':completion:*:messages' format '%B%F{yellow}-> %d%f%b'
zstyle ':completion:*:warnings' format '%B%F{red}-> no matches found!%f%b'

# Use caching so that commands like apt and dpkg completions are useable
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$ZSH_CACHE_DIR"

# Manual pages
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.*' insert-sections true

# Don't complete uninteresting users
zstyle ':completion:*:*:*:users' ignored-patterns \
	adm amanda amavis apache arpwatch at avahi backup beaglidx bin bind \
	cacti canna clamav colord daapd daemon davfs2 dbus distcache dnsmasq \
	dovecot dovenull fax fetchmail firebird ftp games gdm geoclue \
	git-daemon gkrellmd gnats gopher hacluster haldaemon halt hsqldb ident \
	irc junkbust kdm ldap libuuid libvirt-qemu list logcheck lp mail \
	mailman mailnull man mariadb messagebus mldonkey mysql nagios named \
	netdata netdump news nfsnobody nobody nscd ntp nut nx obsrun oident \
	openvpn operator pcap polkitd postfix postgres postgrey privoxy proxy \
	pvm quagga radvd redis rpc rpcuser rpm rslsync rtkit rwhod sbuild scard \
	shutdown squid sshd statd stunnel4 svn sync sys tcpdump telnetd \
	telnetd-ssl tftp thelounge tss usbmux uucp uuidd vcsa www-data wwwrun \
	xfs xrdp zabbix \
	'*$' '_*' 'avahi-*' 'cockpit-*' 'cups-*' 'debian-*' 'Debian-*' \
	'fwupd-*' 'gnome-*' 'speech-*' 'systemd-*'

# Ignore completion functions
zstyle ':completion:*:functions' ignored-patterns '_*'

# Show ignore matches, if we really want this
zstyle '*' single-ignored show

# Save the location of the current completion dump file.
if [[ -z "$ZSH_COMPDUMP" ]]; then
	ZSH_COMPDUMP="$ZSH_CACHE_DIR/zcompdump-${SHORT_HOST}-${ZSH_VERSION}"
fi

# Try to add all folders possibly containing completion functions to the fpath
# before calling compinit. See <https://github.com/ohmyzsh/ohmyzsh/issues/4614>
# for a discussion of this topic, for example. It boils down to:
# - We have to call compinit early,
# - but plugins can add completions later, that won't be found ...
# (GENCOMPL_FPATH is used by RobSis/zsh-completion-generator)
[[ -n "$GENCOMPL_FPATH" ]] && fpath+=($GENCOMPL_FPATH)
fpath+=("$AXZSH/active_plugins/"*/completions(N))
fpath+=("$AXZSH/active_plugins/"*/src(N))

# Initialize ZSH completion system
if [[ "$ZSH_DISABLE_COMPFIX" = "true" ]]; then
	compinit -u -d "$ZSH_COMPDUMP"
else
	compinit -d "$ZSH_COMPDUMP"
fi
