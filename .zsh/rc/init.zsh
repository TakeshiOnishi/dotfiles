# 実行ディレクトリ取得
script_dir=$(cd $(dirname $0); pwd)


load_if_exists () {
  if [ -e $1 ]; then
    source $1
  fi
}

# zshの基本設定
load_if_exists "${script_dir}/basic.zsh"

# prompt表示
load_if_exists "${script_dir}/prompt.zsh"

# alias設定
load_if_exists "${script_dir}/alias.zsh"

# macの場合のmysql/apach起動コマンド
load_if_exists "${script_dir}/mac_server.zsh"

# 環境ごとのalias (ignore対象)
for file in ${script_dir}/*.local; do
  source "$file"
done
