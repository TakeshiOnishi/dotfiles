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

**秘密鍵を失うと復号できない。必ずバックアップすること。**

## マシン別の差分

`machine` 変数で分岐する。値は `personal` か `work`。

```
{{ if eq .machine "work" }}
職場マシンだけに適用される内容
{{ end }}
```

職場固有の設定は `.chezmoitemplates/claude-work.md.age` に書く。

## 日常の操作

```
chezmoi diff                 # 適用前に差分を見る
chezmoi apply                # 反映する
chezmoi edit --apply <file>  # 編集して即反映する
chezmoi re-add <file>        # 手で書き換えたファイルを取り込む
```

アプリ自身が書き換える設定（`settings.json` など）を更新したときは
`chezmoi re-add` で取り込み直す。

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
