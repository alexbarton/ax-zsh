## homebrew

Setup "Homebrew" ("The missing package manager for OS X", http://brew.sh):

- Enable ZSH completions installed by Homebrew formulae.
- Install a `brew` wrapper function.

This wrapper function for the `brew`(1) command does the following:

- Detect the location of the "real" brew(1) command.
- Change user and group when the Homebrew installation is owned by a different
  user (to preserve sane file permissions).
- Set a relaxed umask(1) so that other users can use software installed by
  Homebrew.
- Call the "real" `brew`(1) command.
