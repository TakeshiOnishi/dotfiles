set nocompatible
set number
set autoindent
set mouse=a
set noswapfile
set clipboard=unnamed
set encoding=utf-8
set fileencodings=utf-8,ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932
set nobackup
set noundofile
filetype indent plugin on

set hidden          " バッファ未保存時移動許可
set wildmenu        " CMDファイル名保管
set showcmd         " CMD途中でも表示
set cmdheight=1

set hlsearch        " 検索ハイライト
set ignorecase      " 検索大文字小文字未区別
set smartcase       " 検索大文字利用時区別
set nostartofline   " 移動コマンド時の位置抑制
set laststatus=2    " ステータスライン常時表示
set confirm         " バッファ変更時の確認
set visualbell

let IM_CtrlMode = 4 " 日本語入力固定
set expandtab
set shiftwidth=2
set softtabstop=0

set wrap
set breakat=\ 
set showbreak=+\ 

set t_SI=[6\ q
set t_SR=[4\ q
set t_EI=[2\ q

set nocursorline
autocmd InsertEnter,InsertLeave * set cursorline!
