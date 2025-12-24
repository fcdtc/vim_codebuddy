" vim:sw=2:
" ============================================================================
" FileName: plugin/floaterm.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" ============================================================================

if exists('g:loaded_floaterm')
  finish
elseif !has('nvim') && !has('terminal')
  call floaterm#util#show_msg("floaterm requires vim to be compiled with 'terminal'", "error")
  finish
endif
let g:loaded_floaterm = 1

" Force set our custom configuration
let g:floaterm_shell            = 'codebuddy-code'
let g:floaterm_title            = 'floaterm($1/$2)'
let g:floaterm_width            = 0.3
let g:floaterm_height           = 1.0
let g:floaterm_wintype          = 'vsplit'
let g:floaterm_autoclose        = 1
let g:floaterm_autoinsert       = v:true
let g:floaterm_autohide         = 1
let g:floaterm_position         = 'right'
let g:floaterm_borderchars      = get(g:, 'floaterm_borderchars', '─│─│┌┐┘└')
let g:floaterm_rootmarkers      = get(g:, 'floaterm_rootmarkers', ['.project', '.git', '.hg', '.svn', '.root'])
let g:floaterm_opener           = get(g:, 'floaterm_opener', 'split')
let g:floaterm_giteditor        = get(g:, 'floaterm_giteditor', v:true)
let g:floaterm_titleposition    = get(g:, 'floaterm_titleposition', 'left')


command! -nargs=* -complete=customlist,floaterm#cmdline#complete -bang -range
                          \ FloatermNew    call floaterm#run('new', <bang>0, [visualmode(), <range>, <line1>, <line2>], <q-args>)
command! -nargs=* -complete=customlist,floaterm#cmdline#complete
                          \ FloatermUpdate call floaterm#run('update', 0, [], <q-args>)
command! -nargs=? -count=0 -bang -complete=customlist,floaterm#cmdline#complete_names1
                          \ FloatermShow   call floaterm#show(<bang>0, <count>, <q-args>)
command! -nargs=? -count=0 -bang -complete=customlist,floaterm#cmdline#complete_names1
                          \ FloatermHide   call floaterm#hide(<bang>0, <count>, <q-args>)
command! -nargs=? -count=0 -bang -complete=customlist,floaterm#cmdline#complete_names1
                          \ FloatermKill   call floaterm#kill(<bang>0, <count>, <q-args>)
command! -nargs=? -count=0 -bang -complete=customlist,floaterm#cmdline#complete_names1
                          \ FloatermToggle call floaterm#toggle(<bang>0, <count>, <q-args>)
command! -nargs=? -range   -bang -complete=customlist,floaterm#cmdline#complete_names2
                          \ FloatermSend   call floaterm#send(<bang>0, visualmode(), <range>, <line1>, <line2>, <q-args>)
command! -nargs=0           FloatermPrev   call floaterm#prev()
command! -nargs=0           FloatermNext   call floaterm#next()
command! -nargs=0           FloatermFirst  call floaterm#first()
command! -nargs=0           FloatermLast   call floaterm#last()

hi def link Floaterm       Normal
hi def link FloatermNC     NormalNC
hi def link FloatermBorder NormalFloat

let g:floaterm_keymap_new    = get(g:, 'floaterm_keymap_new', '')
let g:floaterm_keymap_prev   = get(g:, 'floaterm_keymap_prev', '')
let g:floaterm_keymap_next   = get(g:, 'floaterm_keymap_next', '')
let g:floaterm_keymap_first  = get(g:, 'floaterm_keymap_first', '')
let g:floaterm_keymap_last   = get(g:, 'floaterm_keymap_last', '')
let g:floaterm_keymap_hide   = get(g:, 'floaterm_keymap_hide', '')
let g:floaterm_keymap_show   = get(g:, 'floaterm_keymap_show', '')
let g:floaterm_keymap_kill   = get(g:, 'floaterm_keymap_kill', '')
let g:floaterm_keymap_toggle = get(g:, 'floaterm_keymap_toggle', '')

function! s:bind_keymap(mapvar, command) abort
  if !empty(a:mapvar)
    execute printf('nnoremap <silent> %s :%s<CR>', a:mapvar, a:command)
    execute printf('tnoremap <silent> %s <C-\><C-n>:%s<CR>', a:mapvar, a:command)
  endif
endfunction
call s:bind_keymap(g:floaterm_keymap_new,    'FloatermNew')
call s:bind_keymap(g:floaterm_keymap_prev,   'FloatermPrev')
call s:bind_keymap(g:floaterm_keymap_next,   'FloatermNext')
call s:bind_keymap(g:floaterm_keymap_first,  'FloatermFirst')
call s:bind_keymap(g:floaterm_keymap_last,   'FloatermLast')
call s:bind_keymap(g:floaterm_keymap_hide,   'FloatermHide')
call s:bind_keymap(g:floaterm_keymap_show,   'FloatermShow')
call s:bind_keymap(g:floaterm_keymap_kill,   'FloatermKill')
call s:bind_keymap(g:floaterm_keymap_toggle, 'FloatermToggle')

" Custom command for opening codebuddy in right-side terminal
command! CodeBuddy call floaterm#new(0, 'codebuddy-code', {}, {'wintype': 'vsplit', 'position': 'right', 'width': 0.3, 'height': 1.0})
