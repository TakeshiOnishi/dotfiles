# Dotfiles

Place the configuration file for development.
Managed by [chezmoi](https://www.chezmoi.io/).

## QuickStart

### 1. 前提ツールを入れる

```
brew install chezmoi age
```

### 2. age 秘密鍵を配置する

既存マシンから `~/.config/chezmoi/key.txt` を移送する。

- 転送時は `age -p` でパスフレーズ保護をかける
- パスフレーズはメール本文に書かず、別経路で伝える
- 転送が済んだらクラウドやメール上の鍵ファイルを削除する

```
chmod 600 ~/.config/chezmoi/key.txt
```

### 3. 取り込む

```
chezmoi init --apply TakeshiOnishi/dotfiles
```

`init` 時にマシン種別（`personal` / `work`）を尋ねられる。

## 構成

| パス | 配置先 |
| --- | --- |
| `dot_*` | ホーム直下 |
| `dot_config/` | `~/.config/` |
| `dot_claude/` | `~/.claude/` |
| `.chezmoitemplates/` | 配置しない。暗号化された部品置き場 |

## 暗号化

汎用的な設定は平文で残し、個人固有の部分だけを切り出して age で暗号化する。

- `.chezmoitemplates/zsh-*-personal.age` — 個人環境の PATH・環境変数・エイリアス
- `.chezmoitemplates/claude-*.md.age` — CLAUDE.md の構成部品
- `dot_claude/encrypted_settings.json.tmpl` — Claude Code の設定

`encrypted_` 接頭辞が効くのは、ホームへ配置されるファイルだけになる。
`.chezmoitemplates/` はどこにも配置されないため接頭辞が解釈されず、暗号文がそのまま出る。
そのため参照側で `decrypt (include ...)` を呼んで明示的に復号している。

末尾の `.age` は chezmoi の規約ではない。
中身が暗号文だと分かるようにした命名で、chezmoi はこの拡張子を解釈しない。

## マシン別の差分

`machine` 変数で分岐する。値は `personal` か `work`。

```
{{ if eq .machine "personal" }}
個人用マシンだけに適用される内容
{{ end }}
```

職場固有の設定は `.chezmoitemplates/claude-work.md.age` に書く。

## 日常の操作

symlink 方式とは違い、ホーム側はソースから生成された別の実体になる。
ホーム側を直接編集してもソースへは反映されない。

- `chezmoi diff` — 適用前に差分を見る
- `chezmoi apply` — 反映する
- `chezmoi edit --apply <file>` — ソースを編集して即反映する
- `chezmoi re-add <file>` — 直接編集した結果をソースへ取り込む

`chezmoi edit` は暗号化ファイルも扱える。
復号して開き、保存時に再暗号化するため、暗号文を手で触る必要はない。

Claude Code の `settings.json` のようにアプリ自身が書き換える設定は、
変更後に `chezmoi re-add` が要る。忘れるとソースが古いまま残る。

ここに挙げたのは日常で使う範囲に絞っている。
全容と最新の仕様は公式ドキュメントを参照すること。

- <https://www.chezmoi.io/>
- <https://github.com/twpayne/chezmoi>

## Additional Setup

### Setup Git Config

Place the following files `~/.gitconfig.local`. Write the following contents.

```
[user]
  name = MY_NAME
  email = MY_EMAIL_ADDRESS
```

### Setup diff-highlight

- macOS (Using brew)
  - x86
    - `ln -s /usr/local/share/git-core/contrib/diff-highlight/diff-highlight /usr/local/bin`
  - arm(M1)
    - `ln -s /opt/homebrew/share/git-core/contrib/diff-highlight/diff-highlight /usr/local/bin`
- RPM based Linux
  - `ln -s /usr/share/git-core/contrib/diff-highlight /usr/local/bin`
