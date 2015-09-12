AX-ZSH: Alex' Modular ZSH Configuration
=======================================

AX-ZSH is a modular configuration system for the Z shell. If provides sane
defaults and is extendable by plugins.


Installation
------------

To install AX-ZSH, either download a source archive or use Git to clone it.
Afterwards use the `install.sh` script inside of the source directory to set
up the `~/.axzsh` directory.

When using Git it is best to directly clone the AX-ZSH repository into the
`~/.axzsh` directory and call `install.sh` from this location:

  $ git clone git://arthur.barton.de/ax-zsh.git ~/.axzsh
  $ ~/.axzsh/install.sh

You can use `cd ~/.axzsh && git pull --ff-only` to upgrade this installation.

The `install.sh` script creates symbolic links for `~/.zprofile`, `~/.zshrc`,
`~/.zlogin`, and `~/.zlogout` (don't worry, already existing files are backed
up).

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
