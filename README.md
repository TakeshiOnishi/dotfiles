# Dotfiles

Place the configuration file for development.

## QuickStart

1. `git clone https://github.com/TakeshiOnishi/dotfiles ~/dotfiles`
1. `cd $_`
1. `make init`

## Editor Configuration

This repository contains configuration files for both **Neovim** and **VS Code**.

### Neovim Setup
- Configuration files are located in the `nvim/` directory
- See `nvim/` for Neovim-specific setup instructions

### VS Code Setup
- Configuration files are located in the `vscode/` directory
- See [vscode/README.md](vscode/README.md) for detailed setup instructions
- Includes settings converted from Neovim configuration

## Additoinal Setup

### Setup Git Config

Place the following files `~/.gitconfig.local`. Write the following contents.

```
[user]
  name = MY_NAME
  email = MY_EMAIL_ADDRESS
```

### Setup diff-highlight

- macOS (Using brew)
  - x86
    - `ln -s /usr/local/share/git-core/contrib/diff-highlight/diff-highlight /usr/local/bin`
  - arm(M1)
    - `ln -s /opt/homebrew/share/git-core/contrib/diff-highlight/diff-highlight /usr/local/bin`
- RPM based Linux
  - `ln -s /usr/share/git-core/contrib/diff-highlight /usr/local/bin`

### Configuration file for local environment only

- Files to load before or after the standard settings file
  - `.zsh/rc/*.local_first
  - `.zsh/rc/*.local_last
