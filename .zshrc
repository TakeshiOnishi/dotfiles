# Return if zsh is called from Vim
if [[ -n $VIMRUNTIME ]]; then
    return 0
fi

# zshの設定ロード
source ~/.zsh/rc/init.zsh

# asdf設定
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash
