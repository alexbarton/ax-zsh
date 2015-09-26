## editor_select

Search for the "best" editor and setup environment (`$EDITOR`) accordingly.

The plugin looks for the following editors and stops at the first one it finds:

- atom
- mate
- subl
- vim
- nano
- joe
- vi

### Command Aliases

- `zshenv`: Edit `~/.zshenv` using `$EDITOR`
  (only available if an editor was found).

### Environment

- `$EDITOR`: Command (including parameters) to run an text editor.
