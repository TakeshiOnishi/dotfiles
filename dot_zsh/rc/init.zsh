script_dir=$(cd $(dirname $0); pwd)

load_if_exists () {
  if [ -e $1 ]; then
    source $1
  fi
}

for file in ${script_dir}/*.local_first; do
  load_if_exists "$file"
done

load_if_exists "${script_dir}/path.zsh"
load_if_exists "${script_dir}/basic.zsh"
load_if_exists "${script_dir}/prompt.zsh"
load_if_exists "${script_dir}/alias.zsh"
load_if_exists "${script_dir}/env.zsh"

for file in ${script_dir}/*.local_last; do
  load_if_exists "$file"
done
