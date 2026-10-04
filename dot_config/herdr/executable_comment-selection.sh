#!/usr/bin/env bash
# 選択範囲へのコメントを貯めて、まとめて元のペインのプロンプトへ貼り付ける（Enter は押さない）
# config.toml の [[keys.command]]（type = "popup"）から起動する
#   add  : 選択範囲にコメントを書いて貯める
#   send : 貯めたコメントを見直して貼り付ける
set -euo pipefail
umask 077
export PATH="/opt/homebrew/bin:$PATH"

marker='# ---- この行から下は送らない ----'
# 送らずに残ったコメントは 24 時間で消す
store_dir="${TMPDIR:-/tmp}/herdr-comment"
expire_minutes=1440

pause() {
  printf '%s\n' "$1" "Enter で閉じる"
  read -r _
}

# 保存して閉じたときだけ成功を返す。:q・:q!・通常モードの Esc は中止になる
# スワップと shada を無効にして、内容をディスクに残さない
edit() {
  rm -f "$saved"
  nvim -n -i NONE \
    -c 'nnoremap <buffer><nowait> <Esc> <Cmd>cq<CR>' \
    -c "autocmd BufWritePost <buffer> call writefile([], '$saved')" \
    "$@" || return 1
  [[ -e "$saved" ]]
}

notify() {
  herdr notification show "$1" --body "$2" || true
}

# ポップアップはレイアウト上のペインではないため、UI のフォーカスは元のペインに残る
target=$(herdr pane current | jq -r 'first(.. | .pane_id? | strings)')
if [[ -z "$target" ]]; then
  pause "送り先のペインを特定できなかった"
  exit 1
fi
mkdir -p "$store_dir"
find "$store_dir" -type f -mmin +"$expire_minutes" -delete
store="$store_dir/${target//:/_}.md"

tmp=$(mktemp "${TMPDIR:-/tmp}/herdr-comment.XXXXXX")
saved="$tmp.saved"
trap 'rm -f "$tmp" "$saved"' EXIT

case "${1:-}" in
  add)
    # herdr は copy_on_select（既定で有効）で選択範囲をクリップボードに入れる
    selection=$(pbpaste)
    if [[ -z "${selection//[[:space:]]/}" ]]; then
      pause "選択範囲が空。テキストを選択してから押す"
      exit 0
    fi
    {
      printf '\n\n%s\n' "$marker"
      printf '# 送り先: %s\n' "$target"
      printf '# 1 行目からコメントを書く。:wq で貯める。Esc で中止する\n#\n'
      printf '%s\n' "$selection" | sed 's/^/# /'
    } > "$tmp"
    edit -c startinsert "$tmp" || exit 0
    comment=$(awk -v m="$marker" '$0 == m { exit } { print }' "$tmp")
    [[ -n "${comment//[[:space:]]/}" ]] || exit 0
    count=$(grep -c '^## ' "$store" 2>/dev/null || true)
    count=$(( ${count:-0} + 1 ))
    {
      [[ -s "$store" ]] && printf '\n'
      printf '## %d\n\n' "$count"
      printf '%s\n' "$selection" | sed 's/^/> /'
      printf '\n%s\n' "$comment"
    } >> "$store"
    notify "コメントを貯めた" "${count} 件目（送り先: ${target}）"
    ;;
  send)
    if [[ ! -s "$store" ]]; then
      pause "貯めたコメントがない（送り先: ${target}）"
      exit 0
    fi
    cp "$store" "$tmp"
    edit "$tmp" || exit 0
    message=$(cat "$tmp")
    if [[ -z "${message//[[:space:]]/}" ]]; then
      rm -f "$store"
      notify "コメントを破棄した" "送り先: ${target}"
      exit 0
    fi
    # 制御文字を除く
    message=${message//$'\e'/}
    # 折りたたみ表示を避けるため、ブラケットペーストを使わず 1 行ずつ入力する
    # 行の間は Shift+Enter で改行し、送信はしない
    first=1
    while IFS= read -r line || [[ -n "$line" ]]; do
      (( first )) || herdr pane send-keys "$target" shift+enter
      first=0
      [[ -z "$line" ]] || herdr pane send-text "$target" "${line//$'\r'/}"
    done <<< "$message"
    rm -f "$store"
    ;;
  *)
    pause "使い方: $0 add|send"
    exit 1
    ;;
esac
