## hstr

Integrate *hstr*, a "bash and zsh shell history suggest box", into ZSH.

### Usage

This plugin uses the "hstr --show-configuration" itself to enable *hstr*
functionality in ZSH.
at the time of this writing, April 22 2020 using *fzf* 2.2.0, this is

1. set "histignorespace" shell option,
2. add "hh" alias,
3. add Keybindings.

### Command Aliases

- `hh`: `hstr`

### Key Bindings

- `CTRL-R`: Paste the selected command from history into the command line.
