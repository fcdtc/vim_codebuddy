" CodeBuddy configuration for floaterm
" This file should be sourced after floaterm is loaded

" Force override the floaterm configuration for CodeBuddy
let g:floaterm_shell            = 'codebuddy-code'
let g:floaterm_width            = 0.3
let g:floaterm_height           = 1.0
let g:floaterm_wintype          = 'vsplit'
let g:floaterm_position         = 'right'

" Custom command for CodeBuddy
command! CodeBuddy call floaterm#new(0, 'codebuddy-code', {}, {'wintype': 'vsplit', 'position': 'right', 'width': 0.3, 'height': 1.0})

echo "CodeBuddy floaterm configuration loaded"