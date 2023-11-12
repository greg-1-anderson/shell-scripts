# Shell Scripts
 
To get started, run:

```bash
source install
```

This will also install the following projects:

- [History Recall](https://github.com/g1a/history-recall)
- [fd](https://github.com/g1a/fd)
- [git-bashrc](https://github.com/g1a/git-bashrc)

Also, all of the scripts contained in this project are added to the `$PATH` once installed.

## Index of Scripts

- `base-linux-install`
Run with "sudo" on Linux systems; adds base components useful for software development et. al.

- `base-mac-install`
Run on MacOS systems to install base components needed for productive development.

- `codec-install`
Install all of the non-open Codec packages needed for multimedia access on Ubuntu Linux.

- `exodus`
Create a working local instance of one or more Pantheon sites; presumes target is using a LAMP stack.

- `gsvn`
Provides an svn-like wrapper tool to access Git repositories using svn syntax.

- `remove-dbprefix`
Remove the db-prefix from a Drupal site that uses one, renaming the sql table names to match.

- `resetmysqladminpw`
Reset the admin password on a local mysql server

- `restore-macos-preferences.sh`
Configure the preferences on a MacOS system to match a base set of configuration

- `save-macos-preferences.php`
Write a new version of the `restore-macos-preferences.sh` capturing the current values of all of the preference settings that are saved by these scripts.

- `sourcelines`
Make an attempt to count how many lines of code, not including comments, are in a given project.

- `ssh-copy-id.sh`
A version of the ssh-copy-id tool to run on MacOS machines.
