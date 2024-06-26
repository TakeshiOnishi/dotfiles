" scrooloose/nerdtree.git
let g:NERDTreeQuitOnOpen=0
let g:NERDTreeIgnore=['\.clean$', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowHidden=1
let g:NERDTreeHighlightCursorline=1
let g:NERDTreeShowBookmarks=1
let g:NERDTreeWinSize=45
let g:NERDTreeDirArrows=0
nmap <silent> <C-e>      :NERDTreeToggle<CR>
vmap <silent> <C-e> <Esc>:NERDTreeToggle<CR>
omap <silent> <C-e>      :NERDTreeToggle<CR>
imap <silent> <C-e> <Esc>:NERDTreeToggle<CR>
cmap <silent> <C-e> <C-u>:NERDTreeToggle<CR>

" scrooloose/nerdcommenter.git
let NERDSpaceDelims = 1
nmap ,, <Plug>NERDCommenterToggle
vmap ,, <Plug>NERDCommenterToggle

" previm/previm
augroup PrevimSettings
  autocmd!
  autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END
autocmd BufNewFile,BufRead *.{tf} set filetype=tf

" vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
let g:indent_guides_start_level = 1
let g:indent_guides_guide_size = 1
hi IndentGuidesOdd  ctermbg=235
hi IndentGuidesEven ctermbg=239

" neoclide/coc.nvim
command! -nargs=0 Prettier :CocCommand prettier.formatFile
nmap <silent> <space>td   <Plug>(coc-type-definition)
nmap <silent> <space>df   <Plug>(coc-definition)
nmap <silent> <space>rf   <Plug>(coc-references)
nmap <silent> <space>rn   <Plug>(coc-rename)
vmap <silent> <space>fmt   <Plug>(coc-format-selected)
nmap <silent> <space>fmta  <Plug>(coc-format)
vmap <silent> <space>ff  <Plug>(coc-fix-current)
nmap <silent> <space>ffa <Plug>(coc-codeaction)
nmap <silent> <space>reg :exe CocAction('CocList lines')
nnoremap <silent> K :call ShowDocumentation()<CR>
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <c-space> coc#refresh()


function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  endif
endfunction

let g:coc_filetype_map = {
      \ 'yaml.ansible': 'ansible',
      \}
