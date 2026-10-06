#!/usr/bin/env bash
# chezmoi apply の直前に、上書き・削除されるファイルを退避する
# .chezmoi.toml.tmpl の [hooks.apply.pre] から呼ばれる。名前が . で始まるため、chezmoi は配置しない
#   退避先 : ~/.local/state/chezmoi-backups/<日時>/<配置先からの相対パス>
#   保持   : 30 日を過ぎた世代を消す。ただし最新 5 世代は残す
# 退避に失敗したら apply を止める
set -euo pipefail

backup_root="${XDG_STATE_HOME:-$HOME/.local/state}/chezmoi-backups"
keep_generations=5
expire_days=30

chezmoi="${CHEZMOI_EXECUTABLE:-chezmoi}"
dest_dir="${CHEZMOI_DEST_DIR:-$HOME}"
config_file="${CHEZMOI_CONFIG_FILE:-$HOME/.config/chezmoi/chezmoi.toml}"

# apply 中の chezmoi が状態ファイルをロックしているため、複製を読ませる
# 複製しないと、ここで呼ぶ chezmoi status がロック待ちで止まる
state_file="$(dirname "$config_file")/chezmoistate.boltdb"
work=$(mktemp -d "${TMPDIR:-/tmp}/chezmoi-backup.XXXXXX")
trap 'rm -rf "$work"' EXIT
if [[ -f "$state_file" ]]; then
  cp "$state_file" "$work/state.boltdb"
fi

# 1 列目：chezmoi が前回書いた後に、配置先が変わった
# 2 列目：apply で配置先が変わる（A 追加・M 変更・D 削除・R スクリプト実行）
"$chezmoi" --config "$config_file" --persistent-state "$work/state.boltdb" \
  status --no-tty > "$work/status.txt"

# 退避したファイルは本人だけが読めるようにする
# chezmoi status より前に設定すると、権限の差を変更と判定してしまう
umask 077

generation="$backup_root/$(date +%Y%m%d-%H%M%S)"
hand_edited=()
count=0
while IFS= read -r line; do
  [[ -n "$line" ]] || continue
  last_written=${line:0:1}
  will_change=${line:1:1}
  path=${line:3}
  target="$dest_dir/$path"

  case "$will_change" in
    M | D) ;;
    *) continue ;;
  esac
  # 存在しないものと、ディレクトリそのものは退避しない
  if [[ ! -e "$target" && ! -L "$target" ]] || [[ -d "$target" && ! -L "$target" ]]; then
    continue
  fi

  mkdir -p "$generation/$(dirname "$path")"
  cp -pP "$target" "$generation/$path"
  printf '%s\n' "$line" >> "$generation/status.txt"
  count=$((count + 1))
  if [[ "$last_written" != " " ]]; then
    hand_edited+=("$path")
  fi
done < "$work/status.txt"

if ((count > 0)); then
  printf 'chezmoi-backup: %d 件を退避した: %s\n' "$count" "$generation" >&2
fi
if ((${#hand_edited[@]} > 0)); then
  printf 'chezmoi-backup: 前回の apply 後に変更されたファイルがある（退避済み）:\n' >&2
  printf '  %s\n' "${hand_edited[@]}" >&2
fi

# 古い世代を消す。最新 keep_generations 世代は、期限を過ぎていても残す
[[ -d "$backup_root" ]] || exit 0
generations=()
while IFS= read -r dir; do
  generations+=("$dir")
done < <(find "$backup_root" -mindepth 1 -maxdepth 1 -type d -name '[0-9]*-[0-9]*' | sort -r)
for ((i = keep_generations; i < ${#generations[@]}; i++)); do
  dir=${generations[$i]}
  if [[ -n "$(find "$dir" -maxdepth 0 -mtime +"$expire_days")" ]]; then
    rm -rf "$dir"
  fi
done
