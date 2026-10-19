# AGENTS.md

Guidance for AI agents in this repository. User docs: `README.md`. Plugin
authoring conventions: `plugins/README.md`.

## Project

- AX-ZSH: pure shell codebase — `zsh` for plugins and tools, `sh` for
  `install.sh`. No build step, test suite, CI, or linter/formatter config.
- Wrap plain-text and Markdown files (including this one) at 80 columns.

## VCS

- Always check for `.jj/` first. When `.jj/` is present, use `jj` for all
  local operations (status, commit, log, diff). Only use `git` for remote
  operations (push, fetch, pull). Default branch: `master`.
- LLM-generated content must be attributed: commit messages for AI-assisted
  changes must include a `Co-authored-by` trailer and mention the AI model
  used.

## Runtime state

- This working tree doubles as a live AX-ZSH installation: `cache/`,
  `repos/`, `active_plugins/`, `active_theme`, `custom_plugins/`,
  `custom_themes/` are gitignored runtime state created by
  `install.sh`/`axzshctl` — never commit them.

## Architecture

- `ax.zsh` (repo root) is the single entry point; it derives its **stage**
  from the filename it was invoked as. `install.sh` copies repo files into
  `$AXZSH` (default `~/.axzsh`). The managed `~/.zsh*` symlinks and local
  configuration hooks (`*.local`, `~/.zshenv`) are documented in `README.md`
  — never edit the symlinks directly.
- Stages: `ax-io` (before `zprofile`; only stage where plugins may output or
  prompt — must run before Powerlevel10k instant prompt), `zprofile`, `zshrc`,
  `zlogin`, `zlogout`.
- Plugins: script layout, load order, and authoring conventions — see
  `plugins/README.md`.
- Directory roles: `core/` (always loaded), `default_plugins/`, `plugins/`
  (bundled), `active_plugins/` (symlinks to enabled), `repos/` (external
  clones), `themes/` (active theme = `active_theme` symlink).
- External GitHub plugins appear in `active_plugins/` as `owner#name`
  symlinks; OhMyZsh plugins are cloned into `repos/@ohmyzsh`.

## Plugin cache

- Plugin code always runs **inside an `axzsh_plugin_init()` function**:
  without a cache, `ax.zsh` wraps each plugin's code in it, `eval`s it, and
  appends the same code to `cache/<stage>.cache`, which is then
  `zcompile`d; later shells just source the cache. Each shell builds it in a
  private `cache/.build.<stage>.<pid>/` directory and moves it into place
  atomically, so concurrently starting shells can't garble it.
- Consequences: plain `typeset` or `local` variables are function-local (use
  `typeset -g` for globals), `return` ends only that plugin, `$0` is
  `axzsh_plugin_init` (use `$AXZSH/...` paths, not `${0:A:h}`), and aliases
  a plugin defines don't apply within that same plugin.
- `repos/` plugins are not inlined; the cache only records a `source` line,
  skipped on dumb terminals.
- The `ax-io` cache starts with `PATH=/usr/bin:/bin` (extended by
  `30_path`); the full `PATH` is set in the `zprofile` stage by `50_path`.

## Conventions

- Plugin exit codes, `AXZSH_PLUGIN_CHECK` runs, terminal-capability helpers,
  and theme mechanics: see `plugins/README.md`.

## Commands

- `bin/axzshctl` — admin CLI for plugin/theme management (see `README.md`);
  subcommands not covered there: `enable`/`disable`, `reset-plugins`,
  `enable-default-plugins`, `plugin-help`, `version`. Operates on `$AXZSH`
  (default `~/.axzsh`), **not** the repo checkout.
- The `axzshctl` shell function (`core/40_axzsh`) `exec`-restarts the shell
  after state-changing subcommands — expect process replacement.
- Rebuild caches after hand-editing plugins: `AXZSH_PLUGIN_CHECK=1 zsh -ilc ''`.
- Debug: `AXZSH_DEBUG=1`, or marker files `$AXZSH/debug`, `~/.axzsh.debug`.
- No tests: verify with `zsh -n <file>` and `axzshctl check-plugins`.
