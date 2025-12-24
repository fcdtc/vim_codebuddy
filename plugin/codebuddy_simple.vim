" ============================================================================="
" CodeBuddy Terminal Plugin - 简化兼容版本
" 在右侧30%区域打开CodeBuddy终端，提供显示/隐藏/关闭功能
" 完全兼容 Vim 8.0+ 和 Neovim
" =============================================================================

" 防止重复加载
if exists('g:loaded_codebuddy')
    finish
endif
let g:loaded_codebuddy = 1

" ============================================================================="
" 全局变量配置
" =============================================================================

let g:codebuddy_shell = get(g:, 'codebuddy_shell', 'codebuddy-code')
let g:codebuddy_width = get(g:, 'codebuddy_width', 0.3)
let g:codebuddy_height = get(g:, 'codebuddy_height', 1.0)
let g:codebuddy_position = get(g:, 'codebuddy_position', 'right')

" 终端状态管理
let s:codebuddy_bufnr = -1
let s:codebuddy_winid = -1
let s:is_visible = v:false

" ============================================================================="
" 核心函数
" =============================================================================

" 打开CodeBuddy终端
function! s:open_codebuddy()
    " 如果已经存在终端，直接显示
    if s:codebuddy_bufnr != -1 && bufexists(s:codebuddy_bufnr)
        call s:show_codebuddy()
        return
    endif

    " 保存当前窗口
    let s:original_winid = win_getid()

    " 计算窗口宽度
    let width = float2nr(g:codebuddy_width * &columns)

    " 创建终端 - 使用统一的方法
    try
        if g:codebuddy_position == 'right'
            execute 'topleft ' . width . 'vsplit'
        else
            execute 'botright ' . width . 'vsplit'
        endif

        " 创建终端
        if has('nvim')
            terminal g:codebuddy_shell
            let s:codebuddy_bufnr = bufnr('%')
        else
            let s:codebuddy_bufnr = term_start(g:codebuddy_shell, {'curwin': v:true})
        endif

        " 设置窗口ID
        let s:codebuddy_winid = win_getid()
        let s:is_visible = v:true

        " 设置窗口选项
        setlocal winfixwidth
        setlocal nospell
        setlocal nonumber
        setlocal norelativenumber
        setlocal statusline=CodeBuddy

        " 进入终端模式
        if !has('nvim')
            startinsert
        endif

        echom "CodeBuddy 终端已打开"

    catch
        echom "打开 CodeBuddy 终端失败: " . v:exception
        " 回退到原始窗口
        if win_gotoid(s:original_winid)
            " 成功返回
        endif
    endtry
endfunction

" 显示CodeBuddy终端
function! s:show_codebuddy()
    if s:codebuddy_bufnr == -1 || !bufexists(s:codebuddy_bufnr)
        call s:open_codebuddy()
        return
    endif

    if !s:is_visible
        " 检查窗口是否还存在
        if s:codebuddy_winid != -1 && win_gotoid(s:codebuddy_winid)
            " 窗口存在，直接显示
            let s:is_visible = v:true
        else
            " 窗口不存在，重新创建
            call s:recreate_window()
        endif
    endif
endfunction

" 隐藏CodeBuddy终端
function! s:hide_codebuddy()
    if s:is_visible && s:codebuddy_winid != -1
        if win_gotoid(s:codebuddy_winid)
            hide
            let s:is_visible = v:false
            echom "CodeBuddy 终端已隐藏"
        endif
    endif
endfunction

" 关闭CodeBuddy终端
function! s:close_codebuddy()
    if s:codebuddy_bufnr != -1 && bufexists(s:codebuddy_bufnr)
        " 关闭窗口
        if s:codebuddy_winid != -1 && win_gotoid(s:codebuddy_winid)
            close!
        endif

        " 删除缓冲区
        if bufexists(s:codebuddy_bufnr)
            execute 'bdelete! ' . s:codebuddy_bufnr
        endif

        " 重置状态
        let s:codebuddy_bufnr = -1
        let s:codebuddy_winid = -1
        let s:is_visible = v:false

        echom "CodeBuddy 终端已关闭"
    endif
endfunction

" 重新创建窗口
function! s:recreate_window()
    " 保存当前窗口
    let s:original_winid = win_getid()

    " 计算窗口宽度
    let width = float2nr(g:codebuddy_width * &columns)

    " 创建新窗口
    try
        if g:codebuddy_position == 'right'
            execute 'topleft ' . width . 'vsplit'
        else
            execute 'botright ' . width . 'vsplit'
        endif

        " 切换到终端缓冲区
        execute 'buffer ' . s:codebuddy_bufnr

        " 更新窗口ID和状态
        let s:codebuddy_winid = win_getid()
        let s:is_visible = v:true

        " 设置窗口选项
        setlocal winfixwidth
        setlocal nospell
        setlocal nonumber
        setlocal norelativenumber
        setlocal statusline=CodeBuddy

    catch
        echom "重新创建窗口失败: " . v:exception
        " 回退到原始窗口
        if win_gotoid(s:original_winid)
            " 成功返回
        endif
    endtry
endfunction

" 切换显示/隐藏状态
function! s:toggle_codebuddy()
    if s:is_visible
        call s:hide_codebuddy()
    else
        call s:show_codebuddy()
    endif
endfunction

" ============================================================================="
" 公共接口
" =============================================================================

function! CodeBuddyOpen()
    call s:open_codebuddy()
endfunction

function! CodeBuddyShow()
    call s:show_codebuddy()
endfunction

function! CodeBuddyHide()
    call s:hide_codebuddy()
endfunction

function! CodeBuddyToggle()
    call s:toggle_codebuddy()
endfunction

function! CodeBuddyClose()
    call s:close_codebuddy()
endfunction

" ============================================================================="
" 命令定义
" ============================================================================="

command! CodeBuddy call CodeBuddyOpen()
command! CodeBuddyShow call CodeBuddyShow()
command! CodeBuddyHide call CodeBuddyHide()
command! CodeBuddyToggle call CodeBuddyToggle()
command! CodeBuddyClose call CodeBuddyClose()

" ============================================================================="
" 快捷键绑定
" =============================================================================

nnoremap <leader>cb :CodeBuddy<CR>
nnoremap <leader>th :CodeBuddyToggle<CR>
nnoremap <leader>ts :CodeBuddyShow<CR>
nnoremap <leader>td :CodeBuddyHide<CR>
nnoremap <leader>tk :CodeBuddyClose<CR>

" 终端模式快捷键 - 简化版本
if has('nvim')
    tnoremap <buffer> <C-t> <C-\><C-n>:CodeBuddyToggle<CR>
    tnoremap <buffer> <C-q> <C-\><C-n>:CodeBuddyHide<CR>
else
    " Vim 终端模式快捷键
    tnoremap <buffer> <C-t> <C-w>:CodeBuddyToggle<CR>
    tnoremap <buffer> <C-q> <C-w>:CodeBuddyHide<CR>
endif

" ============================================================================="
" 自动命令和清理
" =============================================================================

augroup CodeBuddy
    autocmd!
    " 当退出Vim时确保终端进程被正确关闭
    autocmd VimLeave * call s:cleanup_on_exit()
    autocmd QuitPre * call s:cleanup_on_exit()
augroup END

" 退出时清理
function! s:cleanup_on_exit()
    if s:codebuddy_bufnr != -1 && bufexists(s:codebuddy_bufnr)
        " 这里不做特殊处理，让Vim自动清理
    endif
endfunction

" ============================================================================="
" 加载提示
" ============================================================================="

echom "CodeBuddy Terminal Plugin 已加载!"
echom "命令: :CodeBuddy, :CodeBuddyShow, :CodeBuddyHide, :CodeBuddyToggle, :CodeBuddyClose"
echom "快捷键: <leader>cb, <leader>th, <leader>ts, <leader>td, <leader>tk"