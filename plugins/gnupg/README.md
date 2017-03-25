## gnupg

Setup *GnuPG* using *gpg*(1) or *gpg2*(1) command and try to setup a *GnuPG
agent* as well, either by reusing an already running agent process or by
starting a new one.

- `gpg2`: use the same completions than for `gpg`.
- When `gpg` isn't installed but `gpg2` is, alias it to `gpg`, too.
- Store "agent information" in `$HOME/.gnupg/agent.info-$HOST:$DISPLAY`.

### Command Aliases

- `gpg`: When `gpg2` is available but `gpg` isn't.
