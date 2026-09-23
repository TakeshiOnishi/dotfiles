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

個人のツール構成や作業規約を含むファイルは age で暗号化している。

- `dot_zsh/rc/encrypted_*.tmpl` — PATH・環境変数・エイリアス
- `dot_claude/encrypted_settings.json.tmpl` — Claude Code の設定
- `.chezmoitemplates/claude-*.md.age` — CLAUDE.md の構成部品

`.chezmoitemplates/` 配下では `encrypted_` 接頭辞が機能しない。
`decrypt (include ...)` で明示的に復号している。

## マシン別の差分

`machine` 変数で分岐する。値は `personal` か `work`。

```
{{ if eq .machine "work" }}
職場マシンだけに適用される内容
{{ end }}
```

職場固有の設定は `.chezmoitemplates/claude-work.md.age` に書く。

## 日常の操作

### 前提：ソースとホームは別の実体

symlink 方式とは異なり、ホーム側のファイルはソースから生成された独立した実体になる。
ホーム側を直接編集してもソースには反映されない。

そのため編集には次のどちらかを使う。

```
chezmoi edit --apply <file>   # ソースを編集して即反映する
chezmoi re-add <file>         # 直接編集した結果をソースへ取り込む
```

### 使い分け

| 状況 | コマンド |
| --- | --- |
| 設定を自分で書き換えたい | `chezmoi edit --apply ~/.zshrc` |
| アプリが勝手に書き換えた | `chezmoi re-add ~/.claude/settings.json` |
| 適用前に差分を見たい | `chezmoi diff` |
| まとめて反映したい | `chezmoi apply` |

`chezmoi edit` は暗号化ファイルでも使える。復号して開き、保存時に再暗号化する。
暗号文を手で扱う必要はない。

Claude Code の `settings.json` のようにアプリ自身が書き換える設定は、
変更後に `chezmoi re-add` で取り込み直す。忘れるとソースが古いまま残る。

### 補足

ここに書いたのは日常で使う範囲に絞った内容になる。
オプションの全容と最新の仕様は公式ドキュメントを参照すること。

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
