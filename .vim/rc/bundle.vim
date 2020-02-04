" win/macでのVundle場所
if has("win32") || has("win64")
	set rtp+="$HOME/dotfiles/vimfiles/vundle.git/"
	call vundle#rc("$HOME/dotfiles/vimfiles/bundle/")
else
	set rtp+=~/.vim/vundle.git/ 
	call vundle#rc()
endif


" GitHubリポジトリ
" wordPress
Bundle "vim-scripts/VimRepress"
" 補完
Bundle 'Shougo/neocomplete'
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
Bundle 'gko/vim-coloresque'
" MarkDownプレビュー
Bundle 'previm/previm'
" powerline
Bundle 'vim-airline/vim-airline-themes'
Bundle 'vim-airline/vim-airline'
" カレンダー
Bundle 'itchyny/calendar.vim'
" カラーセレクタ
Bundle 'colorsel.vim'
" sftp
Bundle 'eshion/vim-sftp-sync'
" Diff
Bundle 'AndrewRadev/linediff.vim'
" Indent
Bundle 'nathanaelkane/vim-indent-guides'
" ColorScheme - molokai
Bundle 'tomasr/molokai'
" autoPasteMode
Bundle 'ConradIrwin/vim-bracketed-paste'
" mermaid txtToGraph
Bundle 'knsv/mermaid'
" Dash
Bundle 'rizzatti/dash.vim'
