## git

Enable ZSH *Git* integration:

1. Enhance shell prompt inside *Git* trees.
2. Define some aliases.

### Command Aliases

- `fix`: `git diff --name-only | uniq | xargs $EDITOR`
- `g`: `git`
- `ga`: `git add`
- `gapa`: `git add --patch`
- `gc`: `git commit --verbose`
- `gc!`: `git commit --verbose --amend`
- `gca`: `git commit --verbose --all`
- `gcam`: `git commit --verbose --all --message`
- `gcmsg`: `git commit --verbose --message`
- `gcn`: `git commit --verbose --no-edit`
- `gcn!`: `git commit --verbose --no-edit --amend`
- `gco`: `git checkout`
- `gd`: `git diff`
- `gdca`: `git diff --cached`
- `gdcw`: `git diff --cached --word-diff`
- `gdw`: `git diff --word-diff`
- `gf`: `git fetch`
- `gfa`: `git fetch --all --prune`
- `gfo`: `git fetch origin`
- `gl`: `git pull`
- `glo`: `git log --oneline --decorate`
- `gloo`: `git log --oneline --decorate ORIG_HEAD..`
- `gp`: `git push`
- `gr`: `git remote`
- `grb`: `git rebase`
- `grbi`: `git rebase --interactive`
- `gsb`: `git status --short --branch`
- `gsh`: `git show`
- `gss`: `git status --short`
- `gst`: `git status`
- `gsta`: `git stash push`
- `gstl`: `git stash list`
- `gstp`: `git stash pop`
