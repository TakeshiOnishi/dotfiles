" Vi�݊����[�h���I�t�iVim�̊g���@�\��L���j
set nocompatible

" �t�@�C�����Ɠ��e�ɂ���ăt�@�C���^�C�v�𔻕ʂ��A�t�@�C���^�C�v�v���O�C����L���ɂ���
filetype indent plugin on

" �F�Â����I��
syntax on

" �o�b�t�@��ۑ����Ȃ��Ă����̃o�b�t�@��\���ł���悤�ɂ���
set hidden

" �R�}���h���C���⊮��֗���
set wildmenu

" �^�C�v�r���̃R�}���h����ʍŉ��s�ɕ\��
set showcmd

" ������������\���i<C-L>�������ƌ��݂̋����\������������j
set hlsearch

" �������ɑ啶���E����������ʂ��Ȃ��B�������A������ɑ啶����������
" ���݂��Ă���Ƃ��͋�ʂ���
set ignorecase
set smartcase

" �I�[�g�C���f���g�A���s�A�C���T�[�g���[�h�J�n����Ƀo�b�N�X�y�[�X�L�[��
" �폜�ł���悤�ɂ���B
set backspace=indent,eol,start

" �I�[�g�C���f���g
set autoindent

" �ړ��R�}���h���g�����Ƃ��A�s���Ɉړ����Ȃ�
set nostartofline

" ��ʍŉ��s�Ƀ��[���[��\������
set ruler

" �X�e�[�^�X���C������ɕ\������
set laststatus=2

" �o�b�t�@���ύX����Ă���Ƃ��A�R�}���h���G���[�ɂ���̂łȂ��A�ۑ�����
" ���ǂ����m�F�����߂�
set confirm

" �r�[�v�̑���Ƀr�W���A���x���i��ʃt���b�V���j���g��
set visualbell

" �����ăr�W���A���x��������������
set t_vb=

" �S���[�h�Ń}�E�X��L����
set mouse=a

" �R�}���h���C���̍�����2�s��
set cmdheight=2

" �s�ԍ���\��
set number

" �L�[�R�[�h�͂����Ƀ^�C���A�E�g�B�}�b�s���O�̓^�C���A�E�g���Ȃ�
set notimeout ttimeout ttimeoutlen=200

" �^�u�����̑���ɃX�y�[�X2���g���ꍇ�̐ݒ�B
" ���̏ꍇ�A'tabstop'�̓f�t�H���g��8����ς��Ȃ��B
set shiftwidth=2
set softtabstop=2
set expandtab

" �C���f���g�Ƀn�[�h�^�u���g���ꍇ�̐ݒ�B
" �^�u������2�������̕��ŕ\������B
"set shiftwidth=2
"set tabstop=2


" Y�̓����D��C�Ɠ����ɂ���
map Y y$

" <C-L>�Ō�����̋����\������������
nnoremap <C-L> :nohl<CR><C-L>


"------------------------------------------------------------
"Append by Onishi

" �X�e�[�^�X�� [�t�@�C����][�����R�[�h][�t�@�C���^�C�v][�s,��][����][�S�̍s]
set statusline=%F%m%r%h%w\ [%{&fenc!=''?&fenc:&enc}]\ %{&ff}\ [TYPE=%Y]\ [POS=%04l,%04v][%p%%]\ [LEN=%L] 

" ���͒����s
noremap <CR> o<ESC>

"���Ɉړ�
inoremap <C-j> <Down>
"��Ɉړ�
inoremap <C-k> <Up>
"���Ɉړ�
inoremap <C-h> <Left>
"�E�Ɉړ�
inoremap <C-l> <Right>

" �V���[�g�J�b�g
" ����
nnoremap <silent> <C-x>1 :only<CR>
" �c����
nnoremap <silent> <C-x>2 :sp<CR>
" ������
nnoremap <silent> <C-x>3 :vsp<CR>

" ���t����
inoremap <Leader>date <C-R>=strftime('%Y/%m/%d (%a)')<CR>

" �J�[�\������URL���u���E�U�ŊJ��
nmap ,o <Plug>(openbrowser-open)
vmap ,o <Plug>(openbrowser-open)
" �O�O��
nnoremap ,g :<C-u>OpenBrowserSearch<Space><C-r><C-w><Enter>


if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    if has('mac')
      let &fileencodings = s:enc_jis .','. s:enc_euc
      let &fileencodings = &fileencodings .','. s:fileencodings_default
    else
      let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
      let &fileencodings = &fileencodings .','. s:fileencodings_default
    endif
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  unlet s:enc_euc
  unlet s:enc_jis
endif

" EUC-JP
nmap ,ee :e ++enc=euc-jp<CR>
" SJIS
nmap ,es :e ++enc=cp932<CR>
" JIS
nmap ,ej :e ++enc=iso-2022-jp<CR>
" UTF-8
nmap ,eu :e ++enc=utf-8<CR>

" Windows�̌`��
nmap ,fw :e ++ff=dos

" Mac�̌`��
nmap :fm ++ff=mac

" Unix�̌`��
nmap :fu ++ff=unix

" �U�蕪��
if has("win32") || has("win64")
  set rtp+=~/dotfiles/vimfiles/vundle.git/ 
  call vundle#rc('~/dotfiles/vimfiles/bundle/')
else
  set rtp+=~/.vim/vundle.git/ 
  call vundle#rc()
endif

" From GitHub
" �⊮
Bundle 'Shougo/neocomplcache'
" �X�j�y
Bundle 'mattn/zencoding-vim'
" �����I�u�W�F�N�g
Bundle 'tpope/vim-surround.git'
" �R�����g
Bundle 'scrooloose/nerdcommenter.git'
" �f�B���N�g���c���[
Bundle 'scrooloose/nerdtree.git'
" js���`
Bundle 'pangloss/vim-javascript'
" js�̓n�C���C�g
Bundle 'JavaScript-syntax'
" URL�I�[�v��
Bundle 'tyru/open-browser.vim'
" Git
Bundle 'tpope/vim-fugitive'
" �������`
Bundle 'h1mesuke/vim-alignta.git'
" JSON���`
Bundle 'vim-scripts/JSON.vim.git'
" Ct ^ IME�Œ�
Bundle 'fuenor/im_control.vim'
" �Č���
Bundle 'rhysd/clever-f.vim'
" less���`�n�C���C�g
Bundle 'groenewege/vim-less.git'
" css�J���[�⏕
Bundle 'skammer/vim-css-color.git'

" BundleEnd "


" NERDcomment ShortCut
let NERDSpaceDelims = 1
nmap ,, <Plug>NERDCommenterToggle
vmap ,, <Plug>NERDCommenterToggle

" neocomplcache
let g:neocomplcache_enable_at_startup = 1 " �N�����ɗL����

" NERDTree START "
"<C-e>��NERDTree���I���I�t�B���ł��ǂ��ł��B
nmap <silent> <C-e>      :NERDTreeToggle<CR>
vmap <silent> <C-e> <Esc>:NERDTreeToggle<CR>
omap <silent> <C-e>      :NERDTreeToggle<CR>
imap <silent> <C-e> <Esc>:NERDTreeToggle<CR>
cmap <silent> <C-e> <C-u>:NERDTreeToggle<CR>

"How can I close vim if the only window left open is a NERDTree?
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

"�t�@�C���I�[�v����̓��� 
"0 : ���̂܂�NERDTree���J���Ă����B
"1 : NERDTree�����B
"Values: 0 or 1.
"Default: 0
"let g:NERDTreeQuitOnOpen=0
"let g:NERDTreeQuitOnOpen=1

"NERDTreeIgnore ��������t�@�C����ݒ肷��B
"'\.vim$'�Ȃ��fugitive.vim�Ȃǂ̃t�@�C�������\������Ȃ��B
"\ �G�X�P�[�v�L��
"$ �t�@�C�����̍Ō�
let g:NERDTreeIgnore=['\.clean$', '\.swp$', '\.bak$', '\~$']

"NERDTreeShowHidden �B���t�@�C����\�����邩�H ->�\������
let g:NERDTreeShowHidden=1

"�J�[�\�����C�����n�C���C�g�\������B -> �J���[�\��
let g:NERDTreeHighlightCursorline=1

"�u�b�N�}�[�N���X�g�̕\���B -> �\������
let g:NERDTreeShowBookmarks=1

"NERDTree�̃c���[���J���ꏊ
"let g:NERDTreeWinPos="right"

"NERDTree�̃c���[�̕�
"Default: 31.
"let g:NERDTreeWinSize=45

"NERDTree��+|`�Ȃǂ��g���ăc���[�\��������B
"�f�B���N�g�������Ă���ꍇ�ɂ�+��擪�ɂ���B
"�f�B���N�g�����J���Ă���ꍇ�ɂ�~��擪�ɂ���B
"�t�@�C���ɂ�-��擪�ɂ���B
"0 : �Y��Ɍ�����B
"1 : +|`�Ȃǂ��g��Ȃ�
"Values: 0 or 1
"Default: 1.
let g:NERDTreeDirArrows=0
"let g:NERDTreeDirArrows=1

"1 : �t�@�C���A�f�B���N�g���������_�u���N���b�N�ŊJ���B
"2 : �f�B���N�g���̂݃V���O���N���b�N�ŊJ���B
"3 : �t�@�C���A�f�B���N�g���������V���O���N���b�N�ŊJ���B
"let g:NERDTreeMouseMode=1
" let g:NERDTreeMouseMode=2
let g:NERDTreeMouseMode=3

"NERDTreeBookmarksFile
"�u�b�N�}�[�N���L�^�����t�@�C���̐ݒu�ꏊ���w��B
"Values: a path
"Default: $HOME/.NERDTreeBookmarks

"NERDTreeShowLineNumbers
"let NERDTreeShowLineNumbers=1

" NERDTree END "


"backup
set nobackup

"<br>
autocmd FileType html,xhtml inoremap <br> <br<Space>/>
autocmd FileType html,xhtml inoremap <S-CR> <br<Space>/><CR>
autocmd FileType html,xhtml nnoremap <S-CR> $a<br<Space>/><Esc><S-J>i<CR><ESC>$

" �����ʂ������⊮
inoremap { {}<LEFT>
inoremap [ []<LEFT>
vnoremap { "zdi{<C-R>z}<ESC>
vnoremap [ "zdi[<C-R>z]<ESC>

"���^�O
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


"�����𒆉�
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" ESC
inoremap <silent><c-f> <ESC>

" NERDTree �⏕
nmap <silent> <C-@>      :NERDTreeFromBookmark 
vmap <silent> <C-@> <Esc>:NERDTreeFromBookmark 
omap <silent> <C-@>      :NERDTreeFromBookmark 
imap <silent> <C-@> <Esc>:NERDTreeFromBookmark 
cmap <silent> <C-@> <C-u>:NERDTreeFromBookmark 

"less�⊮
autocmd BufNewFile,BufRead *.less set filetype=css
autocmd BufNewFile,BufRead *.phtml set filetype=html
autocmd BufNewFile,BufRead *.tpl set filetype=html
