" ColorScheme
set t_Co=256
colorscheme molokai

" 色づけ
syntax on

" カーソルカラー
if has('multi_byte_ime') || has('xim')
  highlight Cursor guifg=NONE guibg=White
  highlight CursorIM guifg=NONE guibg=Purple
endif

" Font
set guifont=Ricty\ Discord\ for\ Powerline:h12pt
