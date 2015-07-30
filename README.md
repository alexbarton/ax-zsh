AX-ZSH: Alex' Modular ZSH Configuration
=======================================

AX-ZSH is a modular configuration system for the Z shell. If provides sane
defaults and is extendable by plugins.


Installation
------------

To install AX-ZSH, call the `install.sh` script inside of the source directory.
This script creates the `~/.axzsh` symbolic link to the source directory and
creates links for `~/.zprofile`, `~/.zshrc`, `~/.zlogin`, and `~/.zlogout`
(don't worry, already existing files are backed up).

Then you have to restart your ZSH session.


Configuration
-------------

Plugins are loaded when they are linked into the `$AXZSH/active_plugins/`
directory.

AX-ZSH doesn't use `~/.zshenv` in any way. So you can use this file for your
own purposes (for example, to set up some environment variables that AX-ZSH
relays on). In addition, AX-ZSH reads the optional files `~/.zprofile.local`,
`~/.zshrc.local`, `~/.zlogin.local`, and `~/.zlogout.local` after its own
core initialization files when present.


Environment Variables
---------------------

Expected to be already set:

* `HOME`
* `LOGNAME`

Validated and/or set up by core plugins:

* `AXZSH`
* `HOST`
* `HOSTNAME` (same as HOST, deprecated)
* `LOCAL_HOME`
* `PS1`
* `SHORT_HOST`
* `TERM`
* `XDG_CACHE_HOME`
* `ZSH_CACHE_DIR`
