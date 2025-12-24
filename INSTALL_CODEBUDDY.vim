" =============================================================================
" vim-floaterm with CodeBuddy Integration
" Installation and Usage Script
" =============================================================================

" ============================================================================
" USAGE:
" 1. Place this file in your vim config (or run it after floaterm loads)
" 2. Restart vim/nvim
" 3. Use :CodeBuddy to open CodeBuddy in right-side terminal
" 4. Use existing floaterm commands to manage terminals
" =============================================================================

" Force override floaterm configuration for CodeBuddy
let g:floaterm_shell            = 'codebuddy-code'
let g:floaterm_width            = 0.3
let g:floaterm_height           = 1.0
let g:floaterm_wintype          = 'vsplit'
let g:floaterm_position         = 'right'

" CodeBuddy命令：打开CodeBuddy终端
command! CodeBuddy call floaterm#new(0, 'codebuddy-code', {}, {
      \ 'wintype': 'vsplit',
      \ 'position': 'right',
      \ 'width': 0.3,
      \ 'height': 1.0
      \ })

" 可选的快捷键绑定
nnoremap <leader>cb :CodeBuddy<CR>

" 可选：添加常用管理命令的快捷键
" nnoremap <leader>th :FloatermToggle<CR>
" nnoremap <leader>tk :FloatermKill<CR>
" nnoremap <leader>ts :FloatermShow<CR>
" nnoremap <leader>td :FloatermHide<CR>

echo "CodeBuddy integration loaded."
echo "Commands:"
echo "  :CodeBuddy - 打开CodeBuddy终端"
echo "  :FloatermToggle - 显示/隐藏终端"
echo "  :FloatermHide - 隐藏终端"
echo "  :FloatermShow - 显示终端"
echo "  :FloatermKill - 关闭终端"