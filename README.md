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
chezmoi init --source ~/dotfiles --apply TakeshiOnishi/dotfiles
```

`init` 時にマシン種別（`personal` / `work`）を尋ねられる。

`--source` は clone 先の指定になる。
省略すると `~/.local/share/chezmoi` へ展開されるため、必ず付ける。

## 構成

| パス | 配置先 |
| --- | --- |
| `dot_*` | ホーム直下 |
| `dot_config/` | `~/.config/` |
| `dot_claude/` | `~/.claude/` |
| `.chezmoi*` | 配置しない。chezmoi 自身の設定 |

## 暗号化

個人固有の情報を含むファイルは age で暗号化する。

- `dot_zsh/rc/encrypted_*_personal.zsh` — 個人環境の PATH・環境変数・エイリアス
- `encrypted_CLAUDE.md.tmpl` — CLAUDE.md
- `dot_claude/encrypted_settings.json.tmpl` — Claude Code の設定

zsh は汎用部分を平文ファイルに残し、個人固有だけを暗号化した別ファイルへ置く。
`init.zsh` が両方を読むため、分岐を書かずに済む。

CLAUDE.md と settings.json は1ファイルへまとめる必要があるため、この方法が使えない。
ファイル全体を暗号化し、中でマシン種別ごとに分岐させている。

`encrypted_` と `.tmpl` を併用すると、復号してからテンプレート評価される。
そのため暗号化ファイルの中でも `{{ .chezmoi.homeDir }}` などが使える。

## マシン別の差分

`machine` 変数で分岐する。値は `personal` か `work`。

ファイルの中身を出し分けるときはテンプレートに書く。

```
{{ if eq .machine "personal" }}
個人用マシンだけに適用される内容
{{ end }}
```

ファイルごと配置を切り替えるときは `.chezmoiignore` に書く。
このファイル自体がテンプレートとして評価される。

```
{{ if ne .machine "personal" }}
.zsh/rc/*_personal.zsh
{{ end }}
```

Claude 関連は共通部分を持たず、マシン種別ごとに全体を分けている。
編集は `chezmoi edit ~/CLAUDE.md` のように行う。復号された状態で開かれる。

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
