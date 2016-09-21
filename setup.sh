#!/bin/bash

DOT_FILES=( .gitconfig .gitignore .gitignore_global .vimrc .vim .tmux.conf )

for file in ${DOT_FILES[@]}
do
  ln -s $HOME/dotfiles/$file $HOME/$file
done
# 引用元: https://github.com/yuroyoro/dotfiles/blob/master/setup.sh
