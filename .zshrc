# Return if zsh is called from Vim
if [[ -n $VIMRUNTIME ]]; then
    return 0
fi

# zsh$B$N@_Dj%m!<%I(B
source ~/.zsh/rc/init.zsh
