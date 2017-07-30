# 実行ディレクトリ取得
script_dir=$(cd $(dirname $0); pwd)

# zshの基本設定
source "${script_dir}/basic.zsh"

# prompt表示
source "${script_dir}/prompt.zsh"

# alias設定
source "${script_dir}/alias.zsh"

# macの場合のmysql/apach起動コマンド
source "${script_dir}/mac_server.zsh"
