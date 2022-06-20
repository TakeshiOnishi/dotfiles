if has('win32') || has('win64')
	set rtp+="$HOME/dotfiles/vimfiles/vundle.git/"
	call vundle#rc("$HOME/dotfiles/vimfiles/bundle/")
else
	set rtp+=~/.vim/vundle.git/ 
	call vundle#rc()
endif

Bundle 'neoclide/coc.nvim'
Bundle 'mattn/emmet-vim'
Bundle 'tpope/vim-surround.git'
Bundle 'scrooloose/nerdcommenter.git'
Bundle 'scrooloose/nerdtree.git'
Bundle 'tyru/open-browser.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'fuenor/im_control.vim'
Bundle 'gko/vim-coloresque'
Bundle 'previm/previm'
Bundle 'vim-airline/vim-airline-themes'
Bundle 'vim-airline/vim-airline'
Bundle 'itchyny/calendar.vim'
Bundle 'AndrewRadev/linediff.vim'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'tomasr/molokai'
Bundle 'ConradIrwin/vim-bracketed-paste'
Bundle 'maxmellon/vim-jsx-pretty'
