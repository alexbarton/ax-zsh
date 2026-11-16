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
name, then alphabetically within each group. Plugin names must start with a
letter, a digit, or `@`. `ax.zsh` loads plugins in the following groups, in
order:

1. `core/` plugins numbered `00-49`: basic setup (terminal, locale,
   environment, prompt, etc.).
2. Plugins numbered `00-49` ("early"): after the basic setup, before regular
   plugins.
3. Plugins with letter-initial names ("default"): regular plugins.
4. `core/` plugins numbered `50-79`: setup that depends on regular plugins.
5. Plugins numbered `50-79` ("late"): after all regular plugins, but before
   the local configuration, which can still override them.
6. `core/` plugins numbered `80-89`: local configuration (`~/.zshrc.local`
   etc.).
7. Plugins numbered `80-99` ("last"): after the local configuration, which
   can't override them. Use this for plugins that perform a final action, not
   for regular settings.
8. `core/` plugins numbered `90-99`: theme and cleanup.

Only the first digit matters for the position relative to `core/` plugins:
for example, a plugin numbered `00` still loads after a `core/` plugin
numbered `40`. The exact number only orders plugins within their group.

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
