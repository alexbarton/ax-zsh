## gnupg

Setup *GnuPG* using *gpg*(1) or *gpg2*(1) command and try to setup a *GnuPG
agent* as well, either by reusing an already running agent process or by
starting a new one.

- `gpg2`: use the same completions than for `gpg`.
- When `gpg` isn't installed but `gpg2` is, alias it to `gpg`, too.
- In SSH sessions, set `PINENTRY_USER_DATA="USE_TTY=1"` so that a pinentry
  wrapper can use the terminal instead of a graphical dialog, for example
  [pinentry-auto](https://github.com/alexbarton/pinentry-auto).

### Command Aliases

- `gpg`: When `gpg2` is available but `gpg` isn't.
