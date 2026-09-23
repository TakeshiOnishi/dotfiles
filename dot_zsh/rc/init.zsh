script_dir=$(cd $(dirname $0); pwd)

load_if_exists () {
  if [ -e $1 ]; then
    source $1
  fi
}

load_if_exists "${script_dir}/path.zsh"
load_if_exists "${script_dir}/path_personal.zsh"
load_if_exists "${script_dir}/basic.zsh"
load_if_exists "${script_dir}/prompt.zsh"
load_if_exists "${script_dir}/alias.zsh"
load_if_exists "${script_dir}/alias_personal.zsh"
load_if_exists "${script_dir}/env.zsh"
load_if_exists "${script_dir}/env_personal.zsh"
