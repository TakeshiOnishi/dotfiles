script_dir=$(cd $(dirname $0); pwd)

load_if_exists () {
  if [ -e $1 ]; then
    source $1
  fi
}

# 各設定の直後に個人用の追加分を読む
for name in path basic prompt alias env; do
  load_if_exists "${script_dir}/${name}.zsh"
  load_if_exists "${script_dir}/${name}_personal.zsh"
done
