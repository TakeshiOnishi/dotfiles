自分用設定ファイル
====

## Description

自分用の色々な設定ファイルをまとめたもの

- vim
- tmux
- git
- bashrc or zshrc(今度)

## vimrcSetings

- Vundle管理
  - .vimrc.bundle
- 基本設定
  - .vimrc.basic
- StatusLine設定
  - .vimrc.statusline
- keyMap設定
  - .vimrc.keymap
- Color関連
  - .vimrc.colors
- プラグイン依存設定
  - .vimrc.plugins_setting

## Requirement

-  vim
  - Vundle.vim

## Install

1. cd ~/
1. git clone https://github.com/TakeshiOnishi/dotfiles
1. cd dotfiles
1. git submodule update
1. sh.setup.sh
1. vim (:BundleInstall)
