AX-ZSH: Alex' Modular ZSH Configuration
=======================================

AX-ZSH is a modular configuration system for the Z shell (ZSH).
It provides sane defaults and is extendable by plugins.


Installation
------------

To install AX-ZSH, either download a source archive or use Git to clone it.
Afterwards use the `install.sh` script inside of the source directory to set
up the `~/.axzsh` directory.

When using Git it is best to directly clone the AX-ZSH repository into the
`~/.axzsh` directory and call `install.sh` from this location.

Clone repository from _GitHub_ (https://github.com/alexbarton/ax-zsh):

    $ git clone https://github.com/alexbarton/ax-zsh.git ~/.axzsh

Then run the installer script:

    $ ~/.axzsh/install.sh

The `install.sh` script creates symbolic links for `~/.zprofile`, `~/.zshrc`,
`~/.zlogin`, and `~/.zlogout` (don't worry, already existing files are backed
up).

Now close and restart all your running ZSH session to activate AX-ZSH.

To update AX-ZSH run `axzshctl upgrade`.


AX-ZSH & Local ZSH Configuration
--------------------------------

Plugins are loaded when they are linked into the `$AXZSH/active_plugins/`
directory; see the _Customization_ section below for how to activate them.

Don't modify `~/.zprofile`, `~/.zshrc`, `~/.zlogin`, or `~/.zlogout`! These
are links to "AX-ZSH"-private files that can become overwritten when updating.

You can use the following files for local ZSH configuration:

1. AX-ZSH doesn't use `~/.zshenv` in any way. So you can use this file for your
   own purposes (for example, to set up some environment variables that AX-ZSH
   relies on).

2. AX-ZSH reads the optional files `~/.zprofile.local`, `~/.zshrc.local`,
   `~/.zlogin.local`, and `~/.zlogout.local` after its own core initialization
   files when present.


Customization
-------------

Use the `axzshctl` tool to enable, disable, and reset plugins. AXZSH
initializes an alias which points to the actual location in `~/.axzsh/bin/`.

See `axzshctl --help` for details.

You can link custom plugins stored in arbitrary directories using `axzshctl`
by specifying the complete path name. Or you can place additional plugins into
the `~/.axzsh/custom_plugins` folder which is searched by the `axzshctl` tool
by default.

In addition you can set the `AXZSH_PLUGIN_D` variable (and `ZSH_CUSTOM` like
"OhMyZsh") to specify additional plugin search directories.


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
* `XDG_RUNTIME_DIR`
* `XDG_CACHE_HOME`
* `ZSH_CACHE_DIR`
