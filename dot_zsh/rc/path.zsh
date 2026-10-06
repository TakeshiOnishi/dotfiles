# 重複したパスを自動で取り除く
typeset -gU path

export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"

export PATH="$HOME/.goenv/bin:$PATH"
export PATH="$HOME/.nodenv/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"

export PATH="$HOME/.local/bin:$PATH"
