# Dotfiles

Place the configuration file for development.

## QuickStart

1. `git clone https://github.com/TakeshiOnishi/dotfiles ~/dotfiles`
1. `cd $_`
1. `make init`

## Add LocalOnly Settings

- `.zsh/rc/*.local_(first|last)`
- `bin/_local/*`

## Other

#### Setting diff-highlight

- macOS
  - `ln -s /usr/local/share/git-core/contrib/diff-highlight/diff-highlight /usr/local/bin`
- RPM based Linux
  - `ln -s /usr/share/git-core/contrib/diff-highlight /usr/local/bin`
