" Vi互換モードをオフ（Vimの拡張機能を有効）
set nocompatible

" ファイル名と内容によってファイルタイプを判別し、ファイルタイププラグインを有効にする
filetype indent plugin on

" 色づけをオン
syntax on

" バッファを保存しなくても他のバッファを表示できるようにする
set hidden

" コマンドライン補完を便利に
set wildmenu

" タイプ途中のコマンドを画面最下行に表示
set showcmd

" 検索語を強調表示（<C-L>を押すと現在の強調表示を解除する）
set hlsearch

" 検索時に大文字・小文字を区別しない。ただし、検索後に大文字小文字が
" 混在しているときは区別する
set ignorecase
set smartcase

" オートインデント、改行、インサートモード開始直後にバックスペースキーで
" 削除できるようにする。
set backspace=indent,eol,start

" オートインデント
set autoindent

" 移動コマンドを使ったとき、行頭に移動しない
set nostartofline

" 画面最下行にルーラーを表示する
set ruler

" ステータスラインを常に表示する
set laststatus=2

" バッファが変更されているとき、コマンドをエラーにするのでなく、保存する
" かどうか確認を求める
set confirm

" ビープの代わりにビジュアルベル（画面フラッシュ）を使う
set visualbell

" 全モードでマウスを有効化
set mouse=a

" コマンドラインの高さを2行に
set cmdheight=2

" 行番号を表示
set number

" インデントにハードタブを使う場合の設定。
" タブ文字を2文字分の幅で表示する。
set shiftwidth=4
set tabstop=4
set softtabstop=0


" Yの動作をDやCと同じにする
map Y y$

" <C-L>で検索後の強調表示を解除する
nnoremap <C-L> :nohl<CR><C-L>


"------------------------------------------------------------
"Append by Onishi

" ステータスを [ファイル名][文字コード][ファイルタイプ][行,列][割合][全体行]
set statusline=%F%m%r%h%w\ [%{&fenc!=''?&fenc:&enc}]\ %{&ff}\ [TYPE=%Y]\ [POS=%04l,%04v][%p%%]\ [LEN=%L] 

" 入力中改行
noremap <CR> o<ESC>

" 一画面
nnoremap <silent> <C-x>1 :only<CR>
" 縦分割
nnoremap <silent> <C-x>2 :sp<CR>
" 横分割
nnoremap <silent> <C-x>3 :vsp<CR>

" 日付入力
inoremap <Leader>date <C-R>=strftime('%Y/%m/%d (%a)')<CR>

" カーソル下のURLをブラウザで開く
nmap ,o <Plug>(openbrowser-open)
vmap ,o <Plug>(openbrowser-open)


set encoding=utf-8
set fileencodings=ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932,utf-8

" EUC-JP
nmap ,ee :e ++enc=euc-jp<CR>
" SJIS
nmap ,es :e ++enc=cp932<CR>
" UTF-8
nmap ,eu :e ++enc=utf-8<CR>

" Windowsの形式
nmap ,fw :e ++ff=dos

" Unixの形式
nmap :fu ++ff=unix

" 振り分け
if has("win32") || has("win64")
  set rtp+=~/dotfiles/vimfiles/vundle.git/ 
  call vundle#rc('~/dotfiles/vimfiles/bundle/')
else
  set rtp+=~/.vim/vundle.git/ 
  call vundle#rc()
endif

" From GitHub
" 補完
Bundle 'Shougo/neocomplcache'
" スニペ
Bundle 'mattn/zencoding-vim'
" 文字オブジェクト
Bundle 'tpope/vim-surround.git'
" コメント
Bundle 'scrooloose/nerdcommenter.git'
" ディレクトリツリー
Bundle 'scrooloose/nerdtree.git'
" js整形
Bundle 'pangloss/vim-javascript'
" jsはハイライト
Bundle 'JavaScript-syntax'
" URLオープン
Bundle 'tyru/open-browser.vim'
" Git
Bundle 'tpope/vim-fugitive'
" 文字整形
Bundle 'h1mesuke/vim-alignta.git'
" JSON整形
Bundle 'vim-scripts/JSON.vim.git'
" Ct ^ IME固定
Bundle 'fuenor/im_control.vim'
" 再検索
Bundle 'rhysd/clever-f.vim'
" less整形ハイライト
Bundle 'groenewege/vim-less.git'
" cssカラー補助
Bundle 'skammer/vim-css-color.git'
" MarkDownプレビュー
Bundle 'kannokanno/previm'

" BundleEnd "


" NERDcomment ShortCut
let NERDSpaceDelims = 1
nmap ,, <Plug>NERDCommenterToggle
vmap ,, <Plug>NERDCommenterToggle

" neocomplcache
let g:neocomplcache_enable_at_startup = 1 " 起動時に有効化

" NERDTree START "
"<C-e>でNERDTreeをオンオフ。いつでもどこでも。
nmap <silent> <C-e>      :NERDTreeToggle<CR>
vmap <silent> <C-e> <Esc>:NERDTreeToggle<CR>
omap <silent> <C-e>      :NERDTreeToggle<CR>
imap <silent> <C-e> <Esc>:NERDTreeToggle<CR>
cmap <silent> <C-e> <C-u>:NERDTreeToggle<CR>

"How can I close vim if the only window left open is a NERDTree?
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

"ファイルオープン後の動作 
"0 : そのままNERDTreeを開いておく。
"1 : NERDTreeを閉じる。
"Values: 0 or 1.
"Default: 0
"let g:NERDTreeQuitOnOpen=0
"let g:NERDTreeQuitOnOpen=1

"NERDTreeIgnore 無視するファイルを設定する。
"'\.vim$'ならばfugitive.vimなどのファイル名が表示されない。
"\ エスケープ記号
"$ ファイル名の最後
let g:NERDTreeIgnore=['\.clean$', '\.swp$', '\.bak$', '\~$']

"NERDTreeShowHidden 隠しファイルを表示するか？ ->表示する
let g:NERDTreeShowHidden=1

"カーソルラインをハイライト表示する。 -> カラー表示
let g:NERDTreeHighlightCursorline=1

"ブックマークリストの表示。 -> 表示する
let g:NERDTreeShowBookmarks=1

"NERDTreeのツリーの幅
"Default: 31.
"let g:NERDTreeWinSize=45

"NERDTreeを+|`などを使ってツリー表示をする。
"ディレクトリが閉じている場合には+を先頭につける。
"ディレクトリが開いている場合には~を先頭につける。
"ファイルには-を先頭につける。
"0 : 綺麗に見せる。
"1 : +|`などを使わない
"Values: 0 or 1
"Default: 1.
let g:NERDTreeDirArrows=0
"let g:NERDTreeDirArrows=1

"1 : ファイル、ディレクトリ両方共ダブルクリックで開く。
"2 : ディレクトリのみシングルクリックで開く。
"3 : ファイル、ディレクトリ両方共シングルクリックで開く。
"let g:NERDTreeMouseMode=1
" let g:NERDTreeMouseMode=2
let g:NERDTreeMouseMode=3

" NERDTree END "


"backup
set nobackup

"<br>
autocmd FileType html,xhtml inoremap <S-CR> <br<Space>/><CR>
autocmd FileType html,xhtml nnoremap <S-CR> $a<br<Space>/><Esc><S-J>i<CR><ESC>$

" 閉じ括弧を自動補完
inoremap { {}<LEFT>
inoremap [ []<LEFT>

"閉じタグ
function! Endtagcomment()
    let reg_save = @@

    try
        silent normal vaty
    catch
        execute "normal \<Esc>"
        echohl ErrorMsg
        echo 'no match html tags'
        echohl None
        return
    endtry

    let html = @@

    let start_tag = matchstr(html, '\v(\<.{-}\>)')
    let tag_name  = matchstr(start_tag, '\v([a-zA-Z]+)')

    let id = ''
    let id_match = matchlist(start_tag, '\vid\=["'']([^"'']+)["'']')
    if exists('id_match[1]')
        let id = '#' . id_match[1]
    endif

    let class = ''
    let class_match = matchlist(start_tag, '\vclass\=["'']([^"'']+)["'']')
    if exists('class_match[1]')
        let class = '.' . join(split(class_match[1], '\v\s+'), '.')
    endif

    execute "normal `>va<\<Esc>`<"

    let comment = g:endtagcommentFormat
    let comment = substitute(comment, '%tag_name', tag_name, 'g')
    let comment = substitute(comment, '%id', id, 'g')
    let comment = substitute(comment, '%class', class, 'g')
    let @@ = comment

    normal ""P

    let @@ = reg_save
endfunction

let g:endtagcommentFormat = '<!-- /%tag_name%id%class -->'
nnoremap ,t :<C-u>call Endtagcomment()<CR>


"検索を中央
nnoremap n nzz
nnoremap N Nzz

" ESC
inoremap <silent><c-f> <ESC>

" ファイルタイプ
autocmd BufNewFile,BufRead *.less set filetype=css
autocmd BufNewFile,BufRead *.phtml set filetype=html
autocmd BufNewFile,BufRead *.tpl set filetype=html

"辞書
autocmd FileType php :set dictionary=dictionary/PHP.dict

" 幅拡大縮小
nnoremap [winsize] <Nop>
nmap <C-X> [winsize]
nnoremap [winsize]j :resize +5<CR>
nnoremap [winsize]k :resize -5<CR>
nnoremap [winsize]l :vertical resize +50<CR>   
nnoremap [winsize]h :vertical resize -50<CR>
