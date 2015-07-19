# AX-ZSH: Alex' Modular ZSH Configuration
# 50_completion.zshrc: Setup completion

autoload -U compinit

setopt completealiases

zstyle ':completion:*' list-colors ''
zstyle ':completion:*' menu select
zstyle ':completion:*' special-dirs true

# Use caching so that commands like apt and dpkg completions are useable
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path "$ZSH_CACHE_DIR"

# Don't complete uninteresting users
zstyle ':completion:*:*:*:users' ignored-patterns \
	adm amanda amavis apache arpwatch at avahi avahi-autoipd \
	beaglidx bin bind cacti canna clamav colord daapd daemon dbus \
	distcache dnsmasq dovecot dovenull fax fetchmail firebird \
	ftp games gdm gkrellmd gnats gopher hacluster haldaemon halt \
	hsqldb ident irc junkbust kdm ldap libuuid libvirt-qemu list \
	logcheck lp mail mailman mailnull man messagebus mldonkey mysql \
	nagios named netdump news nfsnobody nobody nscd ntp nut nx \
	obsrun oident openvpn operator pcap polkitd postfix postgres \
	postgrey privoxy proxy pvm quagga radvd rpc rpcuser rpm rtkit \
	rwhod sbuild scard shutdown squid sshd statd stunnel4 svn sync \
	sys telnetd telnetd-ssl tftp usbmux uucp vcsa www-data wwwrun \
	xfs xrdp zabbix \
	'_*' '*$' 'debian-*' 'Debian-*'

# Ignore completion functions
zstyle ':completion:*:functions' ignored-patterns '_*'

# Save the location of the current completion dump file.
if [[ -z "$ZSH_COMPDUMP" ]]; then
	ZSH_COMPDUMP="$ZSH_CACHE_DIR/zcompdump-${SHORT_HOST}-${ZSH_VERSION}"
fi

# Initialize ZSH completion system
compinit -d "$ZSH_COMPDUMP"
