" =============================================================================
" vim-floaterm with CodeBuddy Integration - 完整版本
" ===========================================================================

" 强制覆盖floaterm配置用于CodeBuddy
let g:floaterm_shell            = 'codebuddy-code'
let g:floaterm_width            = 0.3
let g:floaterm_height           = 1.0
let g:floaterm_wintype          = 'vsplit'
let g:floaterm_position         = 'right'

" ========== 核心命令 ==========

" CodeBuddy命令：打开CodeBuddy终端
command! CodeBuddy call floaterm#new(0, 'codebuddy-code', {}, {
      \ 'wintype': 'vsplit',
      \ 'position': 'right',
      \ 'width': 0.3,
      \ 'height': 1.0
      \ })

" ========== 快捷键绑定 ==========

" CodeBuddy常用操作快捷键
nnoremap <leader>cb :CodeBuddy<CR>
nnoremap <leader>th :FloatermToggle<CR>  " 显示/隐藏终端
nnoremap <leader>tk :FloatermKill<CR>    " 关闭终端
nnoremap <leader>ts :FloatermShow<CR>    " 显示终端
nnoremap <leader>td :FloatermHide<CR>    " 隐藏终端

" 终端模式下的快捷键
tnoremap <C-t> :FloatermToggle<CR>
tnoremap <C-q> :FloatermHide<CR>

" ========== 说明 ==========

echo "CodeBuddy集成已加载！"
echo ""
echo "=== 核心命令 ==="
echo "  :CodeBuddy         - 打开CodeBuddy终端"
echo "  :FloatermToggle    - 显示/隐藏终端"
echo "  :FloatermHide      - 隐藏终端"
echo "  :FloatermShow      - 显示终端"
echo "  :FloatermKill      - 关闭终端"
echo ""
echo "=== 多终端管理 ==="
echo "  :FloatermNew [cmd] - 打开新终端"
echo "  :FloatermNext      - 切换到下一个终端"
echo "  :FloatermPrev      - 切换到上一个终端"
echo "  :FloatermFirst     - 切换到第一个终端"
echo "  :FloatermLast      - 切换到最后一个终端"
echo ""
echo "=== 发送命令到终端 ==="
echo "  :FloatermSend [cmd] - 发送命令到终端"
echo "  在选中模式下使用:'<,'>FloatermSend 发送选中文本"
echo ""
echo "=== 快捷键 ==="
echo "  <leader>cb - 打开CodeBuddy"
echo "  <leader>th - 显示/隐藏终端"
echo "  <leader>tk - 关闭终端"
echo "  <leader>ts - 显示终端"
echo "  <leader>td - 隐藏终端"
echo "  <C-t> (终端模式) - 显示/隐藏终端"
echo "  <C-q> (终端模式) - 隐藏终端"