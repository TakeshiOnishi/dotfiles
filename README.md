# Dotfiles

Place the configuration file for development.

## QuickStart

1. `git clone https://github.com/TakeshiOnishi/dotfiles ~/dotfiles`
1. `cd $_`
1. `make init`
1. (Option) Manual installation for coc.nvim (LSP)
    - ruby: [solargraph](https://github.com/castwide/solargraph)
    - sh: [shellcheck](https://github.com/koalaman/shellcheck)
    - c: [clangd](https://clangd.llvm.org/)
    - python: [black](https://github.com/psf/black), [flake8](https://flake8.pycqa.org/en/latest/)
    - terraform: [terraform-ls](https://github.com/hashicorp/terraform-ls/blob/main/docs/installation.md)

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

## Making the cli useful

### Configuration file for local environment only

- Files to load before or after the standard settings file
  - `.zsh/rc/*.local_first
  - `.zsh/rc/*.local_last

### Using Manage App Environment Tool

- e.g. [rbenv](https://github.com/rbenv/rbenv)
- PathSettings `.zsh/rc/path.zsh.local_first`
  - `export PATH="$HOME/.rbenv/bin:$PATH"`
- InitializeSettings `.zsh/rc/env.zsh.local_last`
  - `eval "$(rbenv init -zsh)"`

## Note

- [neovim install-from-package](https://github.com/neovim/neovim/wiki/Installing-Neovim)
