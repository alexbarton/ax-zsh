# AX-ZSH: Alex' Modular ZSH Configuration

[AX-ZSH] is a modular configuration system for the Z shell ([ZSH]).
It provides sane defaults and is extendable by plugins.

AX-ZSH integrates well with [Powerlevel10k] and other extensions, even plugins
of [OhMyZsh], see [below](#integration-with-other-projects). And it uses a
*cache* and supports the Powerlevel10k *instant prompt* feature to speed up ZSH
startup times, even when using multiple plugins.

The homepage of [AX-ZSH] can be found at [GitHub]:
<https://github.com/alexbarton/ax-zsh>.

## Installation

Prerequisites:

* [ZSH] – obviously ;-)
* [Git] (optional but recommended!)

Installing AX-ZSH is a two-step process:

1. Clone or copy the source files into the `~/.axzsh` directory,
2. Run the `~/.axzsh/install.sh` script.

The `install.sh` script creates symbolic links for `~/.zprofile`, `~/.zshrc`,
`~/.zlogin`, and `~/.zlogout`. But don't worry, preexisting files are backed
up.

*Note:* The installation is per-user and only changes/installs files into the
home directory of the current user (`~`). AX-ZSH is not meant to be installed
globally for all users on a system at once, and you don't need to become "root"
or any other user with elevated privileges!

### Installation using Git

The preferred method for installing AX-ZSH is using [Git] to clone the
repository directly into the `~/.axzsh` directory and to call the `install.sh`
script from this location:

```sh
git clone https://github.com/alexbarton/ax-zsh.git ~/.axzsh
~/.axzsh/install.sh
```

On Debian, you can fulfil the prerequisites like this:

```sh
apt update && apt install --no-install-recommends \
  ca-certificates git zsh
```

### Installation without Git

*Note:* If you do not use [Git] to install AX-ZSH, you will not be able to
upgrade AX-ZSH itself afterwards with the integrated `axzsh upgrade` command!
Therefore this method is *not recommended* for normal use!

```sh
curl -Lo ax-zsh-master.zip https://github.com/alexbarton/ax-zsh/archive/refs/heads/master.zip
unzip ax-zsh-master.zip
mv ax-zsh-master ~/.axzsh
~/.axzsh/install.sh
```

On Debian, you can fulfil the prerequisites like this:

```sh
apt update && apt install --no-install-recommends \
  ca-certificates curl unzip zsh
```

### Post-Installation Tasks

After installing AX-ZSH, using Git or via an archive file, you should close all
running ZSH sessions and restart them to activate AX-ZSH. And maybe you want to
change your default shell to ZSH if you haven't already?

For example like this:

```sh
# Set new default shell
chsh -s $(command -v zsh)

# Replace running shell with a ZSH login shell
exec $(command -v zsh) -l
```

## Upgrade

When you used [Git] to install AX-ZSH (and/or plugins), you can use the
`axzshctl` command to upgrade AX-ZSH itself and external plugins like this:

```sh
axzshctl upgrade
```

## Usage

AX-ZSH comes with a hopefully sane default configuration and can be extended
using plugins. Different types of plugins are supported:

* Plugins shipped with AX-ZSH.
* Themes shipped with AX-ZSH.
* 3rd-party plugins:
  * installed manually into `$AXZSH/custom_plugins`
  * stand-alone plugins stored on GitHub
  * plugins of OhMyZsh from its GitHub repository
* 3rd-party themes:
  * installed manually into `$AXZSH/custom_themes`
  * some stand-alone themes stored on GitHub

### Configuration of other applications & tools

Some tools, notably remote access tools like ssh(1) and screen-multiplexers
like screen(1) or tmux(1), can be configured to better support AX-ZSH. For
example, AX-ZSH tries to adjust itself for a sane terminal and locale setup,
which in turn requires some information (mostly environment variables) being
available and passed to the ZSH running AX-ZSH on the (target) system.

#### OpenSSH Client

If you are using the OpenSSH client, the following configuration in your
`~/.ssh/config` file is very useful:

```ini
# Some defaults.
# Note: Place this block LAST to not override some other settings, if any, as
# OpenSSH uses the first(!) match it finds!
Host *
    # Pass some environment variables to the remote host to allow the remote
    # system to get a better idea of your used and desired working environment:
    SendEnv COLORTERM LANG LC_* TERM_* TZ

    # Don't hash host names in the ~/.ssh/known_hosts file, so that ZSH
    # compeltion functions can detect helpful host names to complete.
    # Note: This has an "security impact". It is on YOU to check what your
    # security requirements are!
    HashKnownHosts no
```

#### OpenSSH Server

On an OpenSSH server, the following configuration in one of its configuration
files (for example, a good place is in a drop-in configuration file like
`/etc/ssh/sshd_config.d/local.conf`) allows SSH clients to pass some
environment variables to the server:

```init
# Allow SSH client to pass some "safe" environment variables to the server:
AcceptEnv COLORTERM LANG LC_* TERM_* TZ
```

This is required for the SSH client configuration shown above to work.

Don't forget to have `sshd` reload its configuration, for example using
`systemctl reload ssh.service` or `pkill -o -HUP sshd`, or whatever is used on
your operating system.

### Check whether all locally available "useful" plug-ins are activated

Most plugins can be enabled even when the commands they work with aren't
available and won't do any harm. But to keep ZSH startup times low, you should
only enable plugins that are useable on your local system and which you actually
plan to use.

You can use the following command to let AX-ZSH scan the status of all locally
available plugins:

```sh
axzshctl check-plugins
```

It will summarize the status of all enabled plugins, and suggest to enable
plugins which seem to make sense on the system and to disable enabled plugins
that seem not to be supported (for example because of missing dependencies).

### List enabled plugins

Run the following command to list all currently enabled plugins:

```sh
axzshctl list-enabled
```

### Enable plugins

AX-ZSH comes with a sane "core ZSH configuration", but it can show its true
strengths when enabling additional plugins for additional tools and commands
that are available on your system and you want to use.

Different types of plugins are supported (see the introduction to the section
"*usage*" above) which are differentiated by their identifier:

* `<name>`: locally available plugin, either bundled with AX-ZSH itself, or
  installed manually (see below).
* `<repository>/<name>`: stand-alone [GitHub] repository.
* `@ohmyzsh/<name>`: [OhMyZsh] plugin from the OhMyZsh GitHub
  repository (see <https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins>).

You can enable one or more plugins like this:

```sh
axzshctl enable-plugin <identifier> [<identifier> […]]
```

*Hint:* *Tab-completion* works for sub-commands and already locally available
plugin names!

Some examples:

```sh
# Enable some plugins bundled with AX-ZSH:
axzshctl enable-plugin editor_select git ssh_autoadd

# Enable the Powerlevel10k "theme plugin" from GitHub, see
# <https://github.com/romkatv/powerlevel10k>:
axzshctl enable-plugin romkatv/powerlevel10k

# Enable the "fast-syntax-highlighting" plugin from GitHub, see
# <https://github.com/zdharma-continuum/fast-syntax-highlighting>:
axzshctl enable-plugin zdharma-continuum/fast-syntax-highlighting

# Enable the Git and tmux plugins of OhMyZsh:
axzshctl enable-plugin @ohmyzsh/git @ohmyzsh/tmux
```

#### Custom local plugins

You can link custom plugins stored in arbitrary directories using `axzshctl`
by specifying the complete path name. Or you can place additional plugins into
the `$AXZSH/custom_plugins` folder which is searched by the `axzshctl` tool
by default.

In addition you can set the `AXZSH_PLUGIN_D` variable (and `ZSH_CUSTOM` like
[OhMyZsh]) to specify additional plugin search directories.

### Disable plugins

Run the following command to disable a currently enabled plugin:

```sh
axzshctl disable-plugin <identifier> [<identifier> […]]
```

*Hint:* *Tab-completion* works for sub-commands and plugin names!

### Update plugin cache

AX-ZSH uses a "plugin cache" to speedup ZSH start times. This cache is
automatically updated when using the `axzshctl` sub-commands, for example when
enabling or disabling plugins, or when  upgrading the AX-ZSH installation and
all plugins.

But you *have to* update the cache when manually installing plugins or during
development of a own local plugin after updating its code!

Run the following command to update the AX-ZSH cache:

```sh
axzshctl update-caches
```

### Other `axzshctl` sub-commands

Please run `axzshctl --help` to get a full list of a available sub-commands:

```sh
axzshctl --help
```

## Integration with other projects

### Powerlevel10k

AX-ZSH supports [Powerlevel10k] out of the box, you just have to install it as a
plugin:

```sh
axzshctl enable-plugin romkatv/powerlevel10k
```

*Hint:* Once the Powerlevel10k plugin theme is installed, you can use the
regular `axzshctl set-theme` command to enable it, like for any other installed
theme: `axzshctl set-theme powerlevel10k`.

## AX-ZSH & local ZSH configuration

Don't modify `~/.zprofile`, `~/.zshrc`, `~/.zlogin`, or `~/.zlogout`! These
are links to "AX-ZSH"-private files that can become overwritten when updating.

You can use the following files for local ZSH configuration:

1. AX-ZSH doesn't use `~/.zshenv` in any way. So you can use this file for your
   own purposes (for example, to set up some environment variables that AX-ZSH
   relies on).

2. AX-ZSH reads the optional files `~/.zprofile.local`, `~/.zshrc.local`,
   `~/.zlogin.local`, and `~/.zlogout.local` after its own core initialization
   files when present.

## Environment variables

Expected to be already set:

* `HOME`
* `LOGNAME`

Validated and/or set up by core plugins:

* `AXZSH` – AX-ZSH installation directory
* `HOST`
* `HOSTNAME` (same as HOST, deprecated)
* `LOCAL_HOME`
* `PS1`
* `SHORT_HOST`
* `TMPDIR` (set and always ends with a "/")
* `XDG_CACHE_HOME`
* `XDG_RUNTIME_DIR`
* `ZSH_CACHE_DIR`

___
[AX-ZSH]: <https://github.com/alexbarton/ax-zsh> "AX-ZSH Homepage"
[Git]: <https://git-scm.com/> "Git Homepage"
[GitHub]: <https://github.com/> "GitHub Homepage"
[OhMyZsh]: <https://ohmyz.sh/> "OhMyZsh Homepage"
[Powerlevel10k]: <https://github.com/romkatv/powerlevel10k> "Powerlevel10k Homepage"
[ZSH]: <https://www.zsh.org/> "ZSH Homepage"

[AX-ZSH] Copyright (c) 2015-2025 Alexander Barton <alex@barton.de>
