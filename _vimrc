" ####Init####

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

" コマンドラインを一行
set cmdheight=1

" バッファ変更時の確認
set confirm

" エラー時に画面フラッシュ
set visualbell

" 行数を表示
set number

" マウスの有効
set mouse=a

" インデント設定
set noexpandtab
set shiftwidth=2
set tabstop=2
set softtabstop=0

" 保存文字コード
set encoding=utf-8
" 読み取り文字コード順
set fileencodings=ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932,utf-8

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


" コメントを改行時に挿入しない
autocmd FileType * setlocal formatoptions-=ro

" 日本語入力固定
let IM_CtrlMode = 4

" [p]neocomplcache
" 起動時に有効化
let g:neocomplcache_enable_at_startup = 1 
let g:neocomplcache_min_syntax_length = 3
inoremap <expr><Space> pumvisible() ? neocomplcache#close_popup() . "\<Space>" : "\<Space>"



" [p]NERDcomment
let NERDSpaceDelims = 1

" [p]NERDTree
" ファイルOpen後 開いたまま
let g:NERDTreeQuitOnOpen=0
" 非表示ファイルリスト
let g:NERDTreeIgnore=['\.clean$', '\.swp$', '\.bak$', '\~$']
" 隠しファイル表示
let g:NERDTreeShowHidden=1
" カーソル強調
let g:NERDTreeHighlightCursorline=1
" ブックマーク表示
let g:NERDTreeShowBookmarks=1
" ツリーサイズ
let g:NERDTreeWinSize=45
" ツリーの表示に記号使用
let g:NERDTreeDirArrows=0
" ツリー内部はダブルクリックで起動
let g:NERDTreeMouseMode=1


" ファイルタイプ分岐
filetype indent plugin on

" 色づけ
syntax on


" ####Keymap####

" Yで行末までコピー
map Y y$

"検索箇所を中央
nnoremap n nzz
nnoremap N Nzz

" 検索後の強調表示解除
nnoremap <C-L> :nohl<CR><C-L>

" 設定ファイル編集
nnoremap <F4> :<C-u>edit $MYVIMRC<CR>
nnoremap <F5> :<C-u>source $MYVIMRC<CR>

" 一画面/縦/横
nnoremap <silent> <C-s>1 :only<CR>
nnoremap <silent> <C-s>2 :sp<CR>
nnoremap <silent> <C-s>3 :vsp<CR>

" サイズ変更
nnoremap [winsize] <Nop>
nmap <C-s> [winsize]
nnoremap [winsize]j :resize +5<CR>
nnoremap [winsize]k :resize -5<CR>
nnoremap [winsize]l :vertical resize +50<CR>   
nnoremap [winsize]h :vertical resize -50<CR>

" 現在の日時
inoremap <Leader>date <C-R>=strftime('%Y/%m/%d (%a) %H:%M:%S')<CR>

" カーソル下URLオープン
nmap ,o <Plug>(openbrowser-open)
vmap ,o <Plug>(openbrowser-open)

" 文字コード変換
" EUC-JP/SJIS/UTF-8
nmap ,ee :e ++enc=euc-jp<CR>
nmap ,es :e ++enc=cp932<CR>
nmap ,eu :e ++enc=utf-8<CR>

" エスケープ入力補助
inoremap <silent><c-f> <ESC>

" ファイルタイプ
autocmd BufNewFile,BufRead *.less set filetype=css
autocmd BufNewFile,BufRead *.phtml set filetype=html
autocmd BufNewFile,BufRead *.tpl set filetype=html

"PHp辞そ
autocmd FileType php :set dictionary=dictionary/PHP.dict


" 入力中の疑似キー移動
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>


" 改行コード変更
" win/unix
nmap :fw :e ++ff=dos
nmap :fu ++ff=unix

"改行入力 Shift + Enter
autocmd FileType html,xhtml inoremap <S-CR> <br<Space>/><CR>
autocmd FileType html,xhtml nnoremap <S-CR> $a<br<Space>/><Esc><S-J>i<CR><ESC>$


" [p]NERDcomment
" 機能呼び出し
nmap ,, <Plug>NERDCommenterToggle
vmap ,, <Plug>NERDCommenterToggle

" [p]NERDTree
" ツリー呼び出し
nmap <silent> <C-e>      :NERDTreeToggle<CR>
vmap <silent> <C-e> <Esc>:NERDTreeToggle<CR>
omap <silent> <C-e>      :NERDTreeToggle<CR>
imap <silent> <C-e> <Esc>:NERDTreeToggle<CR>
cmap <silent> <C-e> <C-u>:NERDTreeToggle<CR>


" ####Vundle####

" win/macでのVundle場所
if has("win32") || has("win64")
	set rtp+=~/dotfiles/vimfiles/vundle.git/ 
	call vundle#rc('~/dotfiles/vimfiles/bundle/')
else
	set rtp+=~/.vim/vundle.git/ 
	call vundle#rc()
endif

" GitHubリポジトリ
" wordPress
Bundle "vim-scripts/VimRepress"
" Chalice
Bundle 'koron/chalice'
" 補完
Bundle 'Shougo/neocomplcache'
" スニペ
Bundle 'mattn/emmet-vim'
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
Bundle 'lilydjwg/colorizer'
" MarkDownプレビュー
Bundle 'kannokanno/previm'
"CUIみため
Bundle 'Lokaltog/vim-powerline'
" カレンダー
Bundle 'itchyny/calendar.vim'
" カラーセレクタ
Bundle 'colorsel.vim'
" php,html混在インデント
Bundle 'TakeshiOnishi/php.vim-html-enhanced'
" sftp
Bundle 'eshion/vim-sftp-sync'
" Diff
Bundle 'AndrewRadev/linediff.vim'


" 閉じ括弧を自動補完
inoremap { {}<LEFT>
inoremap [ []<LEFT>


" mdファイル認識
augroup PrevimSettings
    autocmd!
    autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
	augroup END

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


" 背景透過きりかえ
function! s:toggle_transparence()
    if &transparency == 15
        set transparency=0
    else
        set transparency=15
    endif

endfunction
nnoremap <silent> <Space>oT :<C-u>call <SID>toggle_transparence()<CR>

" Dash起動
function! s:dash(...)
  let ft = &filetype
  if &filetype == 'python'
    let ft = ft.'2'
  endif
  let ft = ft.':'
  let word = len(a:000) == 0 ? input('Dash search: ', ft.expand('<cword>')) : ft.join(a:000, ' ')
  call system(printf("open dash://'%s'", word))
endfunction
command! -nargs=* Dash call <SID>dash(<f-args>)

" powerline
" スキン引用元
" http://d.hatena.ne.jp/itchyny/20120609/1339249777
let g:Powerline_symbols='fancy'
let g:Powerline_mode_n = 'NORMAL'
call Pl#Hi#Allocate({
			\ 'black'          : 16,
			\ 'white'          : 231,
			\
			\ 'darkestgreen'   : 22,
			\ 'darkgreen'      : 28,
			\
			\ 'darkestcyan'    : 21,
			\ 'mediumcyan'     : 117,
			\
			\ 'darkestblue'    : 24,
			\ 'darkblue'       : 31,
			\
			\ 'darkestred'     : 52,
			\ 'darkred'        : 88,
			\ 'mediumred'      : 124,
			\ 'brightred'      : 160,
			\ 'brightestred'   : 196,
			\
			\ 'darkestyellow'  : 59,
			\ 'darkyellow'     : 100,
			\ 'darkestpurple'  : 57,
			\ 'mediumpurple'   : 98,
			\ 'brightpurple'   : 189,
			\
			\ 'brightorange'   : 208,
			\ 'brightestorange': 214,
			\
			\ 'gray0'          : 233,
			\ 'gray1'          : 235,
			\ 'gray2'          : 236,
			\ 'gray3'          : 239,
			\ 'gray4'          : 240,
			\ 'gray5'          : 241,
			\ 'gray6'          : 244,
			\ 'gray7'          : 245,
			\ 'gray8'          : 247,
			\ 'gray9'          : 250,
			\ 'gray10'         : 252,
			\ })
" 'n': normal mode
" 'i': insert mode
" 'v': visual mode
" 'r': replace mode
" 'N': not active
let g:Powerline#Colorschemes#my#colorscheme = Pl#Colorscheme#Init([
			\ Pl#Hi#Segments(['SPLIT'], {
			\ 'n': ['white', 'gray2'],
			\ 'N': ['gray0', 'gray0'],
			\ }),
			\
			\ Pl#Hi#Segments(['mode_indicator'], {
			\ 'i': ['darkestgreen', 'white', ['bold']],
			\ 'n': ['darkestcyan', 'white', ['bold']],
			\ 'v': ['darkestpurple', 'white', ['bold']],
			\ 'r': ['mediumred', 'white', ['bold']],
			\ 's': ['white', 'gray5', ['bold']],
			\ }),
			\
			\ Pl#Hi#Segments(['fileinfo', 'filename'], {
			\ 'i': ['white', 'darkestgreen', ['bold']],
			\ 'n': ['white', 'darkestcyan', ['bold']],
			\ 'v': ['white', 'darkestpurple', ['bold']],
			\ 'r': ['white', 'mediumred', ['bold']],
			\ 'N': ['gray0', 'gray2', ['bold']],
			\ }),
			\
			\ Pl#Hi#Segments(['branch', 'scrollpercent', 'raw', 'filesize'], {
			\ 'n': ['gray2', 'gray7'],
			\ 'N': ['gray0', 'gray2'],
			\ }),
			\
			\ Pl#Hi#Segments(['fileinfo.filepath', 'status'], {
			\ 'n': ['gray10'],
			\ 'N': ['gray5'],
			\ }),
			\
			\ Pl#Hi#Segments(['static_str'], {
			\ 'n': ['white', 'gray4'],
			\ 'N': ['gray1', 'gray1'],
			\ }),
			\
			\ Pl#Hi#Segments(['fileinfo.flags'], {
			\ 'n': ['white'],
			\ 'N': ['gray4'],
			\ }),
			\
			\ Pl#Hi#Segments(['currenttag', 'fileformat', 'fileencoding', 'pwd', 'filetype', 'charcode', 'currhigroup'], {
			\ 'n': ['gray9', 'gray4'],
			\ }),
			\
			\ Pl#Hi#Segments(['lineinfo'], {
			\ 'n': ['gray2', 'gray10'],
			\ 'N': ['gray2', 'gray4'],
			\ }),
			\
			\ Pl#Hi#Segments(['errors'], {
			\ 'n': ['white', 'gray2'],
			\ }),
			\
			\ Pl#Hi#Segments(['lineinfo.line.tot'], {
			\ 'n': ['gray2'],
			\ 'N': ['gray2'],
			\ }),
			\
			\ Pl#Hi#Segments(['paste_indicator', 'ws_marker'], {
			\ 'n': ['white', 'brightred', ['bold']],
			\ }),
			\
			\ Pl#Hi#Segments(['gundo:static_str.name'], {
			\ 'n': ['white', 'mediumred', ['bold']],
			\ 'N': ['brightred', 'darkestred', ['bold']],
			\ }),
			\
			\ Pl#Hi#Segments(['gundo:static_str.buffer'], {
			\ 'n': ['white', 'darkred'],
			\ 'N': ['brightred', 'darkestred'],
			\ }),
			\
			\ Pl#Hi#Segments(['gundo:SPLIT'], {
			\ 'n': ['white', 'gray2'],
			\ 'N': ['white', 'gray0'],
			\ }),
			\ ])
let g:Powerline_colorscheme='my'

set list
set listchars=tab:\|\ 
hi SpecialKey guifg=#333333
