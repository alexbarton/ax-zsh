# AX-ZSH: Alex' Modular ZSH Configuration - Plugin Documentation

## Plugin Exit Codes

- `0`: OK
- `1`: Error
- `91`: Ignore
- `92`: Optional

## Detecting "Plugin Check" Run

When `axzshctl check-plugins` is doing a _plugin check_ run, the environment
variable `AXZSH_PLUGIN_CHECK` is "non-zero"; this can be tested like this:

```zsh
[[ -z "$AXZSH_PLUGIN_CHECK" ]] || return 92
```

## Plugin Layout

A plugin is a directory containing one or more scripts, one per initialization
stage, named `<name>.<stage>` — for example `git.zshrc` or `30_path.ax-io`.
The supported stages are `ax-io`, `zprofile`, `zshrc`, `zlogin`, and `zlogout`.

An optional `functions/` directory inside a plugin directory is added to the
function search path (`fpath`) in the `zprofile` stage, making all functions
found there available to ZSH.

The script type is auto-detected, in the following order:

- Native AX-ZSH stage files (`<name>.<stage>`)
- OhMyZsh plugins (`<name>.plugin.zsh`, with optional `zsh-` prefix)
- Prezto modules (`init.zsh`)
- ZSH themes (`*.zsh-theme`, handled as "theme plugins")
- Raw scripts (`.zsh`, `.sh`, or no suffix)

## Load Order

A plugin's position is determined by the **first character** of its directory
name, then alphabetically within each group. `ax.zsh` loads plugins in the
following groups, in order:

- `core/` and `active_plugins/` plugins numbered `00-49`
- `core/` and `active_plugins/` plugins with letter-initial names
- `core/` and `active_plugins/` plugins numbered `50-79`
- `core/` and `active_plugins/` plugins numbered `80-99`

The numbering keeps core infrastructure ahead of the plugins relying on it:
`01_zprofile` through `40_prompt` (terminal, locale, environment and prompt
setup) load before regular plugins, while `80_local_config`, `90_theme` and
`99_cleanup` still run after all of them. Within each group, `core/` plugins
load before `active_plugins/`.

For example, `11_terminal` (a `core/` plugin, which defines the terminal helper
functions) always loads before `00-newline` (an `active_plugins/` plugin) —
even though `00` is less than `11` numerically — because within each band all
`core/` plugins load before `active_plugins/`. Likewise, `git` (letter-initial)
loads after all `00-49` plugins but before `99_cleanup`.

## Terminal Capabilities

Do not test `$TERM` directly in plugins. Instead use the helper functions
provided by the `11_terminal` core plugin:

- `axzsh_is_dumb_terminal`
- `axzsh_is_modern_terminal`
- `axzsh_is_utf_terminal`
- `axzsh_is_widechar_terminal`

Note that external plugins installed in `repos/` are skipped entirely on dumb
terminals, which most of them would not support.

## Themes

Themes are sourced by `ax.zsh` itself in the `zshrc` stage, in global scope,
immediately before `99_cleanup`.

An AX-ZSH *native* theme sets `PS1` (and `RPS1`), and may use the `ZSH_THEME_*`
variables and `axzsh_*_prompt_functions` hooks (which are defined in the
`40_prompt` core plugin).
