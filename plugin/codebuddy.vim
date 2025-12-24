" ============================================================================="
" CodeBuddy Terminal Plugin - 独立版本
" 在右侧30%区域打开CodeBuddy终端，提供显示/隐藏/关闭功能
" 完全独立，不依赖vim-floaterm
" =============================================================================

" 防止重复加载
if exists('g:loaded_codebuddy')
    finish
endif
let g:loaded_codebuddy = 1

" ============================================================================="
" 全局变量配置
" ============================================================================="

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

    " 创建垂直分割窗口
    if g:codebuddy_position == 'right'
        execute 'vertical topleft rightbelow ' . string(float2nr(g:codebuddy_width * &columns)) . 'split'
    else
        execute 'vertical topleft leftabove ' . string(float2nr(g:codebuddy_width * &columns)) . 'split'
    endif

    " 创建终端缓冲区
    if has('nvim')
        let s:codebuddy_bufnr = nvim_create_buf(v:false, v:true)
        call nvim_win_set_buf(0, s:codebuddy_bufnr)
        call nvim_buf_call(s:codebuddy_bufnr, function('s:start_terminal_nvim'))
    else
        let s:codebuddy_bufnr = term_start(g:codebuddy_shell, {
              \ 'curwin': v:true,
              \ 'norestore': v:true,
              \ 'hidden': v:true
              \ })
    endif

    " 设置窗口选项
    setlocal winfixwidth
    setlocal nospell
    setlocal nonumber
    setlocal norelativenumber

    " 设置窗口标题
    let s:codebuddy_winid = win_getid()
    call s:set_window_title()

    " 进入终端模式
    if has('nvim')
        startinsert
    else
        :normal! i
    endif

    echom "CodeBuddy 终端已打开"
endfunction

" Neovim 终端启动函数
function! s:start_terminal_nvim()
    let s:terminal_job_id = termopen(g:codebuddy_shell, {
          \ 'on_exit': function('s:on_terminal_exit'),
          \ })
endfunction

" 终端退出回调
function! s:on_terminal_exit(job_id, status, event)
    if a:job_id == get(s:, 'terminal_job_id', -1)
        let s:codebuddy_bufnr = -1
        let s:codebuddy_winid = -1
        let s:is_visible = v:false
        echom "CodeBuddy 终端已退出"
    endif
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
            call s:set_window_title()
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
        " 尝试优雅关闭终端进程
        if has('nvim')
            if get(s:, 'terminal_job_id', -1) != -1
                call jobstop(s:terminal_job_id)
            endif
        else
            if bufloaded(s:codebuddy_bufnr)
                call term_sendkeys(s:codebuddy_bufnr, "exit\r")
            endif
        endif

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
        let s:terminal_job_id = -1

        echom "CodeBuddy 终端已关闭"
    endif
endfunction

" 重新创建窗口
function! s:recreate_window()
    let s:original_winid = win_getid()

    if g:codebuddy_position == 'right'
        execute 'vertical topleft rightbelow ' . string(float2nr(g:codebuddy_width * &columns)) . 'split'
    else
        execute 'vertical topleft leftabove ' . string(float2nr(g:codebuddy_width * &columns)) . 'split'
    endif

    execute 'buffer ' . s:codebuddy_bufnr
    setlocal winfixwidth
    setlocal nospell
    setlocal nonumber
    setlocal norelativenumber

    let s:codebuddy_winid = win_getid()
    let s:is_visible = v:true
    call s:set_window_title()
endfunction

" 设置窗口标题
function! s:set_window_title()
    if exists('+winhighlight')
        setlocal winhighlight=Normal:Normal
    endif
    if exists('&statusline')
        setlocal statusline=CodeBuddy
    endif
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
" =============================================================================

command! CodeBuddy call CodeBuddyOpen()
command! CodeBuddyShow call CodeBuddyShow()
command! CodeBuddyHide call CodeBuddyHide()
command! CodeBuddyToggle call CodeBuddyToggle()
command! CodeBuddyClose call CodeBuddyClose()

" ============================================================================="
" 快捷键绑定
" ============================================================================="

nnoremap <leader>cb :CodeBuddy<CR>
nnoremap <leader>th :CodeBuddyToggle<CR>
nnoremap <leader>ts :CodeBuddyShow<CR>
nnoremap <leader>td :CodeBuddyHide<CR>
nnoremap <leader>tk :CodeBuddyClose<CR>

" 终端模式快捷键
if has('nvim')
    tnoremap <C-t> <C-\><C-n>:CodeBuddyToggle<CR>
    tnoremap <C-q> <C-\><C-n>:CodeBuddyHide<CR>
else
    tnoremap <C-t> :CodeBuddyToggle<CR>
    tnoremap <C-q> :CodeBuddyHide<CR>
endif

" ============================================================================="
" 自动命令
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
        if has('nvim') && get(s:, 'terminal_job_id', -1) != -1
            call jobstop(s:terminal_job_id)
        endif
    endif
endfunction

" ============================================================================="
" 加载提示
" =============================================================================

echom "CodeBuddy Terminal Plugin 已加载!"
echom "命令: :CodeBuddy, :CodeBuddyShow, :CodeBuddyHide, :CodeBuddyToggle, :CodeBuddyClose"
echom "快捷键: <leader>cb, <leader>th, <leader>ts, <leader>td, <leader>tk"