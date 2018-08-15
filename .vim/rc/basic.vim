" Vi互換モードをオフ
set nocompatible

" 同時編集できるように
set hidden

" コマンドライン補完を便利に
set wildmenu

" タイプ途中のコマンドを画面最下行に表示
set showcmd

" 検索語を強調表示（<C-L>を押すと現在の強調表示を解除する）
set hlsearch

" 検索に大文字小文字無視できるよう
set ignorecase
set smartcase

" バックスペースで削除の開始タイミング
set backspace=indent,eol,start

" オートインデント
set autoindent
set smartindent

" 移動コマンドを使ったときに先頭にいかないように
set nostartofline

" ステータスライン常時表示
set laststatus=2

" バッファ変更時の確認
set confirm

" エラー時に画面フラッシュ
set visualbell

" 行数を表示
set number

" マウスの有効
set mouse=a

" 日本語入力固定
let IM_CtrlMode = 4

" コマンドライン高さ
set cmdheight=1

" Vimを使ってくれてありがとう!
set notitle

" swap保存せず
set noswapfile

" コピペ用
set clipboard=unnamed

" インデント設定
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=0
au BufNewFile,BufRead * setlocal sw=2 sts=2 ts=2

" ファイルタイプ分岐
filetype indent plugin on

" 保存文字コード
set encoding=utf-8
" 読み取り文字コード順
set fileencodings=utf-8,ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932

" swp削除
set nobackup

" unkファイル無視
set noundofile

" ウィンドウ幅によっての自動折り返し補完
set wrap
set breakat=\ 
set showbreak=+\ 
if (v:version == 704 && has("patch338")) || v:version >= 705
  set breakindent
  autocmd BufEnter * set breakindentopt=min:20,shift:0
endif

" INSERT時のカーソル
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" カーソル行の強調表示OFF
set nocursorline
" INSERT時の強調表示
autocmd InsertEnter,InsertLeave * set cursorline!
