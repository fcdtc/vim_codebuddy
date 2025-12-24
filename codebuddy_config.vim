" CodeBuddy configuration for floaterm
" This file should be sourced after floaterm is loaded

" Force override the floaterm configuration for CodeBuddy
let g:floaterm_shell            = 'claude-internal'
let g:floaterm_width            = 0.35
let g:floaterm_height           = 1.0
let g:floaterm_wintype          = 'vsplit'
let g:floaterm_position         = 'botright'

" Custom command for CodeBuddy
command! CodeBuddy call floaterm#new(0, 'claude-internal', {}, {'wintype': 'vsplit', 'position': 'botright', 'width': 0.35, 'height': 1.0})

echo "CodeBuddy floaterm configuration loaded"