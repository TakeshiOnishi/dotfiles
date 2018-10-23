# Return if zsh is called from Vim
if [[ -n $VIMRUNTIME ]]; then
    return 0
fi

# zshの設定ロード
source ~/.zsh/rc/init.zsh

# env設定
eval "$(rbenv init -)"
eval "$(nodenv init -)"
eval "$(pyenv init -)"
