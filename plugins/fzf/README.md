## fzf

Integrate *fzf*, "a command-line fuzzy finder", into ZSH.

### Usage

This plugin uses the ZSH configuration files of *fzf*(1) itself to enable
*fzf* functionality in ZSH;
at the time of this writing, September 26 2015 using *fzf* 0.10.5, this is

1. Fuzzy completion for in the command line, triggered by `**`+`<TAB>`, see
   https://github.com/junegunn/fzf#fuzzy-completion-for-bash-and-zsh for
   details.
2. Add Keybindings.

### Key Bindings

- `CTRL-T`: Paste the selected file path(s) into the command line.
- `ALT-C`: `cd` into the selected directory.
- `CTRL-R`: Paste the selected command from history into the command line.
