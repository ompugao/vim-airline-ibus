" vim: et ts=2 sts=2 sw=2

" if !get(g:, 'airline_ibusloaded', 0)
"   finish
" endif

let s:spc = g:airline_symbols.space

let s:Process = vital#vim_airline_ibus#import('System.Process')

function! airline#extensions#ibus#init(ext)
  call airline#parts#define_raw('ibus', '%{airline#extensions#ibus#get_current_engine()}')
  call a:ext.add_statusline_func('airline#extensions#ibus#apply')
endfunction

function! airline#extensions#ibus#apply(...)
  call airline#extensions#append_to_section('x',
        \ s:spc . g:airline_right_sep . s:spc . '%{airline#extensions#ibus#get_current_engine()}')
endfunction

function! airline#extensions#ibus#get_current_engine()
  let res = s:Process.execute(['ibus', 'engine'])
  if res.success == 1
    return trim(res.output)
  else
    return ""
  endif
endfunction

