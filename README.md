# Dotfiles

Place the configuration file for development.
Managed by [chezmoi](https://www.chezmoi.io/).

## QuickStart

```
brew install chezmoi age
```

age 秘密鍵を `~/.config/chezmoi/key.txt` へ配置する。

```
chmod 600 ~/.config/chezmoi/key.txt
```

```
git clone git@github.com:TakeshiOnishi/dotfiles.git ~/dotfiles
chezmoi init --source ~/dotfiles
chezmoi apply
```

`init` 時にマシン種別（`personal` / `work`）を尋ねられる。

## 構成

| パス | 配置先 |
| --- | --- |
| `dot_*` | ホーム直下 |
| `dot_config/` | `~/.config/` |
| `dot_claude/` | `~/.claude/` |
| `.chezmoi*` | 配置しない。chezmoi 自身の設定 |

## 日常の操作

`<target>` はホーム側の配置先パスを指す（例: `~/.zshrc`）。
ソース側のパスを渡すと `not managed` になる。

```
chezmoi diff                   # 適用したら何が変わるかを見る
chezmoi apply                  # ソースの内容をホームへ反映する
chezmoi edit --apply <target>  # ソースを編集して即座に反映する
chezmoi merge <target>         # ホーム側の変更をソースへ取り込む
```

`chezmoi re-add` はテンプレートに効かない。
アプリが書き換えた設定を取り込むときは `chezmoi merge` を使う。

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
