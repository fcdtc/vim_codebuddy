" ============================================================================="
" vim-floaterm with CodeBuddy Integration - 增强版本
" 解决命令注册问题的稳定版本
" =============================================================================

" 确保 vim-floaterm 已加载
if !exists('*floaterm#new')
    echom "错误：vim-floaterm 插件未加载，请先安装 vim-floaterm"
    finish
endif

" 强制覆盖floaterm配置用于CodeBuddy
let g:floaterm_shell            = 'codebuddy-code'
let g:floaterm_width            = 0.3
let g:floaterm_height           = 1.0
let g:floaterm_wintype          = 'vsplit'
let g:floaterm_position         = 'right'

" 等待插件完全加载后再注册命令
augroup CodeBuddySetup
    autocmd!
    autocmd VimEnter * call s:setup_codebuddy()
augroup END

" 主要设置函数
function! s:setup_codebuddy()
    " 清除可能存在的命令
    if exists(':CodeBuddy')
        delcommand CodeBuddy
    endif

    " 注册 CodeBuddy 命令 - 使用更可靠的方法
    command! CodeBuddy call s:codebuddy_new()

    echom "CodeBuddy 命令已注册"
endfunction

" CodeBuddy 终端创建函数
function! s:codebuddy_new()
    try
        " 使用 floaterm 的 autoload 函数
        call floaterm#new(0, 'codebuddy-code', {}, {
              \ 'wintype': 'vsplit',
              \ 'position': 'right',
              \ 'width': 0.3,
              \ 'height': 1.0
              \ })
    catch
        echom "创建 CodeBuddy 终端失败: " . v:exception
        " 备用方法：直接调用
        call floaterm#run('--wintype=vsplit', '--position=right', '--width=0.3', '--height=1.0', 'codebuddy-code')
    endtry
endfunction

" ========== 快捷键绑定 ==========

" CodeBuddy常用操作快捷键
nnoremap <leader>cb :<C-u>call <SID>codebuddy_new()<CR>
nnoremap <leader>th :FloatermToggle<CR>  " 显示/隐藏终端
nnoremap <leader>tk :FloatermKill<CR>    " 关闭终端
nnoremap <leader>ts :FloatermShow<CR>    " 显示终端
nnoremap <leader>td :FloatermHide<CR>    " 隐藏终端

" 终端模式下的快捷键
tnoremap <C-t> :FloatermToggle<CR>
tnoremap <C-q> :FloatermHide<CR>

" ========== 诊断命令 ==========

" 创建诊断命令来检查安装状态
command! CodeBuddyCheck call s:codebuddy_check()

function! s:codebuddy_check()
    echo "=== CodeBuddy 诊断信息 ==="
    echo "vim-floaterm 已加载: " . (exists('*floaterm#new') ? "是" : "否")
    echo "CodeBuddy 命令存在: " . (exists(':CodeBuddy') ? "是" : "否")
    echo "floaterm_shell: " . get(g:, 'floaterm_shell', '未设置')
    echo "floaterm_width: " . get(g:, 'floaterm_width', '未设置')
    echo "floaterm_height: " . get(g:, 'floaterm_height', '未设置')
    echo "floaterm_wintype: " . get(g:, 'floaterm_wintype', '未设置')
    echo "floaterm_position: " . get(g:, 'floaterm_position', '未设置')
    echo "codebuddy-code 可执行: " . (executable('codebuddy-code') ? "是" : "否")
endfunction

" ========== 说明 ==========

echo "CodeBuddy集成已加载！"
echo "使用 :CodeBuddyCheck 来检查安装状态"
echo "使用 :CodeBuddy 来启动 CodeBuddy 终端"