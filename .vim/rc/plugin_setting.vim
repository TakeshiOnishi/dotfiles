" neocomplcache
" 起動時に有効化
let g:neocomplcache_enable_at_startup = 1 
let g:neocomplcache_min_syntax_length = 3
inoremap <expr><Space> pumvisible() ? neocomplcache#close_popup() . "\<Space>" : "\<Space>"

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

" vim-r-plugin settings
let maplocalleader = ","
let vimrplugin_vsplit = 1
let vimrplugin_assign = 0

let vimrplugin_vimpager = "horizontal"
let vimrplugin_objbr_place = "console,right"
let vimrplugin_objbr_opendf = 0
