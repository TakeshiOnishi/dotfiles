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

# env系の設定
load_if_exists "${script_dir}/env.zsh"

# macのFinderCacheReset
load_if_exists "${script_dir}/mac_cache_clear.zsh"

# PATH追加
load_if_exists "${script_dir}/path.zsh"

# 環境ごとのalias (ignore対象)
for file in ${script_dir}/*.local; do
  load_if_exists "$file"
done
