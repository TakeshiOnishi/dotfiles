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

" ファイルタイプ
autocmd BufNewFile,BufRead *.less set filetype=css
autocmd BufNewFile,BufRead *.phtml set filetype=html
autocmd BufNewFile,BufRead *.tpl set filetype=html
autocmd FileType php setlocal sw=2

" 入力中の疑似キー移動
imap A <Up>
imap B <Down>
imap C <Right>
imap D <Left>

" 改行コード変更
" win/unix
nmap :fw :e ++ff=dos
nmap :fu ++ff=unix

"改行入力 Shift + Enter
autocmd FileType html,xhtml inoremap <S-CR> <br<Space>/><CR>
autocmd FileType html,xhtml nnoremap <S-CR> $a<br<Space>/><Esc><S-J>i<CR><ESC>$

" 閉じ括弧を自動補完
inoremap { {}<LEFT>
inoremap [ []<LEFT>
inoremap ( ()<LEFT>

" 背景透過きりかえ
function! s:toggle_transparence()
    if &transparency == 15
        set transparency=0
    else
        set transparency=15
    endif

endfunction
nnoremap <silent> <Space>oT :<C-u>call <SID>toggle_transparence()<CR>

" Escの2回でハイライト削除
nmap <ESC><ESC> :nohlsearch<CR><ESC>
