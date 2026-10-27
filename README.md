# Dotfiles

[chezmoi](https://www.chezmoi.io/) で管理している。

## QuickStart

```
brew install chezmoi age mise
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

言語のバージョンは、マシンごとに mise で入れる。
バージョンは `~/.config/mise/config.toml` に書かれ、dotfiles では管理しない。

```
mise use -g node@22
```

git のユーザー名とメールアドレスは、`~/.gitconfig.local` に手で書く。

```
[user]
  name = <名前>
  email = <メールアドレス>
```

## apply 前のバックアップ

`chezmoi apply` の直前に、上書き・削除されるファイルを退避する。
手で編集したファイルを、apply で誤って消す事故への備え。

- 仕組み
  - `.chezmoi.toml.tmpl` の `[hooks.apply.pre]` から `.chezmoi-backup.sh` を呼ぶ
  - 設定は `chezmoi init` で作られるため、初めて使うマシンの最初の apply から効く
- 退避先
  - `~/.local/state/chezmoi-backups/<日時>/<ホームからの相対パス>`
  - 各世代の `status.txt` に、退避したファイルの `chezmoi status` の行を残す
- 保持
  - 30 日を過ぎた世代を、次の apply のときに消す
  - 期限に関係なく、最新 5 世代は残す
- 退避に失敗したときは、apply を止める

復元するときは、退避先から `cp` で戻す。

```
ls ~/.local/state/chezmoi-backups/
cp -p ~/.local/state/chezmoi-backups/<日時>/.zshrc ~/.zshrc
```

## 構成

| パス | 配置先 |
| --- | --- |
| `dot_*` | ホーム直下 |
| `dot_config/` | `~/.config/` |
| `dot_claude/` | `~/.claude/` |
| `.chezmoi*` | 配置しない。chezmoi 自身の設定 |

`exact_` の付いたディレクトリは、ソースにないファイルを apply のときに消す。
ホーム側に直接ファイルを置かない（例: `~/.config/nvim/lua/plugins`）。

## zsh の設定

`~/.zshrc` は起点だけにする。
`~/.zsh/rc/init.zsh` を読み込む1行以外は書かない。

- 設定は `~/.zsh/rc/` 配下に置く
  - `init.zsh` が `path` → `basic` → `prompt` → `alias` → `env` の順に読む
  - 各設定の直後に、`_personal`・`_work`・`_local` の追加分を読む
  - 例：`compinit` の後に要る補完は `basic_*.zsh` に置く
- インストーラが `~/.zshrc` に追記したら、`~/.zsh/rc/` へ移す
  - 例：Google Cloud SDK は `path_work.zsh` と `basic_work.zsh` に移した
    - インストール先のパスを公開しないよう、どちらも暗号化した
  - 移した後に `chezmoi apply ~/.zshrc` で追記を消す

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
ただし `~/.claude/settings.json` は、次の節の手順で取り込む。

## Claude Code の settings.json

`~/.claude/settings.json` は、Claude Code 自身も書き換える。
そのため、ファイル全体ではなく、テンプレートに書いたキーだけを管理する。

- 管理するファイルは `dot_claude/modify_encrypted_settings.json`
  - apply のとき、現在の `~/.claude/settings.json` を読み、テンプレートのキーを差し込む
- キーごとに、次のどちらかで扱う
  - 値まで固定：apply のたびにテンプレートの値で上書きする
  - キーだけ固定：実ファイルにキーが無いときだけ、テンプレートの値を入れる
- `enabledPlugins` 配下だけを、キーだけ固定にしている
  - プラグインの有効・無効を Claude Code で切り替えても、apply で戻らない
- テンプレートに書いていないキーには触らない
- apply すると、キーがアルファベット順に並ぶ
  - Claude Code が新しいキーを足すと、diff に並び替えが出る
  - 次の apply で消える

値まで固定のキーを Claude Code で変えると、`chezmoi diff` に出る。
残したい値は、`chezmoi edit ~/.claude/settings.json` でテンプレートに書き写す。
書き写さずに apply すると、テンプレートの値に戻る。
