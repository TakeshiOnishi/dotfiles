[[ -t 0 ]] && stty stop undef # Ctrl+s Lock killer。端末につながっているときだけ実行する

autoload -Uz compinit && compinit # codeComplete

export HISTFILE=${HOME}/.zhistory
export HISTSIZE=10000
export SAVEHIST=10000

setopt share_history        # コマンド履歴共有
setopt hist_ignore_dups     # 直前コマンドは追加しない
setopt hist_ignore_all_dups # 古い重複コマンドを削除
setopt hist_ignore_space    # スペース開始コマンドは追加しない
setopt hist_reduce_blanks   # 余分な空白削除
setopt hist_no_store        # history コマンド自体は履歴に残さない
setopt nonomatch            # wildcard対応
disable r                   # zsh以外でrコマンドを利用する為
