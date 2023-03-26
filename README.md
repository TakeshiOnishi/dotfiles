# Dotfiles

Place the configuration file for development.

## QuickStart

1. `git clone https://github.com/TakeshiOnishi/dotfiles ~/dotfiles`
1. `cd $_`
1. `make init`
1. (Option) Manual installation for coc.nvim (LSP)
    - ruby
      - solargraph
    - sh
      - shellcheck
    - c, c++, c#
      - clangd
    - python
      - black
      - flake8

## Add LocalOnly Settings

- `.zsh/rc/*.local_(first|last)`
- `bin/_local/*`

## Other

### Git Config

Place the following files `~/.gitconfig.local`
And write the following contents.

```
FILE: .gitconfig.local
[user]
  name = YOUR_NAME
  email = EMAIL_ADDRESS
```

#### Setting diff-highlight

- macOS (Using brew)
  - x86
    - `ln -s /usr/local/share/git-core/contrib/diff-highlight/diff-highlight /usr/local/bin`
  - arm(M1)
    - `ln -s /opt/homebrew/share/git-core/contrib/diff-highlight/diff-highlight /usr/local/bin`
- RPM based Linux
  - `ln -s /usr/share/git-core/contrib/diff-highlight /usr/local/bin`

### RelatedLink

- [neovim install-from-package](https://github.com/neovim/neovim/wiki/Installing-Neovim#install-from-package)

### Use ENV VersionManagementSystem

- Add PathSettings to `.zsh/rc/path.zsh.local_first`
  - `ex: export PYENV_ROOT="$HOME/.pyenv"; export PATH="$PYENV_ROOT/bin:$PATH`
- Add InitializeSettings to `.zsh/rc/env.zsh.local_last`
  - eval "$(pyenv init --path)"
