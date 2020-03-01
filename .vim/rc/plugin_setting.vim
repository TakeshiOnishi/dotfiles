" neocomplete
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3

" NERDcomment
let NERDSpaceDelims = 1

" NERDTree
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

" NERDcomment
" 機能呼び出し
nmap ,, <Plug>NERDCommenterToggle
vmap ,, <Plug>NERDCommenterToggle

" NERDTree
" ツリー呼び出し
nmap <silent> <C-e>      :NERDTreeToggle<CR>
vmap <silent> <C-e> <Esc>:NERDTreeToggle<CR>
omap <silent> <C-e>      :NERDTreeToggle<CR>
imap <silent> <C-e> <Esc>:NERDTreeToggle<CR>
cmap <silent> <C-e> <C-u>:NERDTreeToggle<CR>

" previm Markdownファイル認識
augroup PrevimSettings
  autocmd!
  autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END


" indentGuide
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
let g:indent_guides_start_level = 1
let g:indent_guides_guide_size = 1
hi IndentGuidesOdd  ctermbg=235
hi IndentGuidesEven ctermbg=239

" Dash
" nmap <silent> <C-i> <Plug>DashGlobalSearch
