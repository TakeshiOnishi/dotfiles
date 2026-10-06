script_dir=$(cd $(dirname $0); pwd)

load_if_exists () {
  if [ -e $1 ]; then
    source $1
  fi
}

# 各設定の直後にマシン種別ごとの追加分を読む
for name in path basic prompt alias env; do
  load_if_exists "${script_dir}/${name}.zsh"
  load_if_exists "${script_dir}/${name}_personal.zsh"
  load_if_exists "${script_dir}/${name}_work.zsh"
  # chezmoi で管理しない、そのマシン限定の設定
  load_if_exists "${script_dir}/${name}_local.zsh"
done

# PATH の重複を取り除く。typeset -U は配列への代入でしか効かないため、すべて読み込んだ後に代入し直す
path=($path)
