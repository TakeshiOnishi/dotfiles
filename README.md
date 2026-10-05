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

## 管理しないもの

認証情報と、万が一露出して困るものは、このリポジトリに一切入れない。
暗号化していても入れない。

- 対象の例
  - API トークン・アクセスキー・パスワード
  - 秘密鍵・証明書の秘密部分
- 置き場所は `~/.zsh/rc/*_local.zsh` にする
  - `init.zsh` が、各設定の最後に読み込む
  - `.chezmoiignore` に入れてあり、chezmoi の管理対象にならない
  - マシンごとに手で作る

## 暗号化の目的

暗号化は、個人の思考フローを公開しないためだけに使う。
秘密情報を守る手段としては使わない。
漏れても問題ない設計にする。

- 対象は `encrypted_*` のファイル
- マシン種別（`personal` / `work`）ごとのファイルは、接尾辞で分ける
  - `*_personal.zsh`：`personal` のマシンだけに置く
  - `*_work.zsh`：`work` のマシンだけに置く
  - `*_local.zsh`：そのマシンだけに置き、chezmoi で管理しない

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
