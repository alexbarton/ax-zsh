AX-ZSH: Alex' Modular ZSH Configuration
=======================================


Configuration
-------------

AX-ZSH can be configured using settings in a `$HOME/.zshenv` file.

The following configuration variables are supported:

* `AXZSH_PLUGIN_D`: Optional directory for additional plugins.
* `axzsh_default_plugins`: Array of default plugins, that will be loaded in
  addition to the core plugins. You can reset this array to disable(!) loading
  of these default plugins. Currently these plugins are loaded by default:
   * byebye
   * completion
   * correction
   * history
   * ls
   * prompt
   * ssh
   * std_aliases
   * std_env
* `axzsh_plugins`: Optional array of addiutional (non-core and non-default)
  plugins to load.

Example for a `$HOME/.zshenv` file:

```
# Add additinal custom plugin search path
export AXZSH_PLUGIN_D="/opt/ax-zsh-plugins"

# Disable all default plugins
typedef -U axzsh_default_plugins
axzsh_default_plugins=()

# Add additional plugins
typedef -U axzsh_plugins
axzsh_plugins=(
	editor_select
	homebrew
)
```

Note: it should *not* be necessary to disable the default plugins! The above
is an example only!


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
