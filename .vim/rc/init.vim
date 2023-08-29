if &compatible
  set nocompatible
endif

let g:false = 0
let g:true  = 1

" Base functions
" From: https://github.com/b4b4r07/dotfiles/blob/master/.vim/rc/init.vim
function! s:glob(from, pattern)
  return split(globpath(a:from, a:pattern), "[\r\n]")
endfunction

function! s:source(from, ...)
  let found = g:false
  for pattern in a:000
    for script in s:glob(a:from, pattern)
      execute 'source' escape(script, ' ')
      let found = g:true
    endfor
  endfor
  return found
endfunction

function! s:load(...) abort
  let base = expand($HOME.'/.vim/rc')
  let found = g:true

  if len(a:000) > 0
    " Stop to load
    if index(a:000, g:false) != -1
      return g:false
    endif
    for file in a:000
      if !s:source(base, file)
        let found = s:source(base, '*[0-9]*_'.file)
      endif
    endfor
  else
    " Load all files starting with number
    let found = s:source(base, '*[0-9]*_*.vim')
  endif

  return found
endfunction

call s:load('bundle.vim')
call s:load('basic.vim')
call s:load('status_line.vim')
call s:load('keymap.vim')
call s:load('colors.vim')
call s:load('plugin_setting.vim')
