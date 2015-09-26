## ssh_secure

Make `ssh`(1) more secure by adding command aliases.

### Usage

Make sure to enable *"strict hostkey checking"* for `ssh`, add something like
the following to you `~/.ssh/config` file to make `ssh` more secure by default:

    # Trusted test network with changing hosts
    Host *.example.net
        StrictHostKeyChecking no
        UserKnownHostsFile /dev/null

    # Be more secure by default!
    Host *
        CheckHostIP yes
        StrictHostKeyChecking yes

Now you can use the following commands (see aliases below):

- `ssh`: establish a new SSH connection to *known* hosts.
- `sshtmp`: establish a *temporary* SSH connection to an *unknown* host.
- `sshnew`: establish a SSH connection to an *unknown* host and add it to
  the "known hosts" list.


### Command Aliases

- `sshnew`: Don't use "strict host key checking", which allows adding new and
  unknown hosts.
- `sshtmp`: Don't use "strict host key checking" and don't use the "known
  hosts" list at all, which allows to temporarily `ssh` to an unknown host
  without the need to alter the *UserKnownHostsFile* at all.
