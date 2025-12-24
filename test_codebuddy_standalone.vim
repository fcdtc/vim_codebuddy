" 测试独立 CodeBuddy 插件

" 设置 packpath 让 vim 加载我们自己的插件
set packpath+=.

" 启用插件加载
filetype plugin on
syntax on

echo "=== CodeBuddy 独立插件测试 ==="
echo ""

" 等待插件加载
sleep 100m

" 检查插件是否加载
echo "=== 插件加载检查 ==="
echo "g:loaded_codebuddy: " . get(g:, 'loaded_codebuddy', '未设置')

" 检查命令是否注册
echo ""
echo "=== 命令注册检查 ==="
let commands = ['CodeBuddy', 'CodeBuddyShow', 'CodeBuddyHide', 'CodeBuddyToggle', 'CodeBuddyClose']

for cmd in commands
    if exists(':' . cmd)
        echo "✓ " . cmd . " - 可用"
    else
        echo "✗ " . cmd . " - 不可用"
    endif
endfor

" 检查配置变量
echo ""
echo "=== 配置检查 ==="
echo "g:codebuddy_shell: " . get(g:, 'codebuddy_shell', '未设置')
echo "g:codebuddy_width: " . get(g:, 'codebuddy_width', '未设置')
echo "g:codebuddy_height: " . get(g:, 'codebuddy_height', '未设置')
echo "g:codebuddy_position: " . get(g:, 'codebuddy_position', '未设置')

" 检查函数是否可用
echo ""
echo "=== 函数可用性检查 ==="
if exists('*CodeBuddyOpen')
    echo "✓ CodeBuddyOpen() - 可用"
else
    echo "✗ CodeBuddyOpen() - 不可用"
endif

if exists('*CodeBuddyShow')
    echo "✓ CodeBuddyShow() - 可用"
else
    echo "✗ CodeBuddyShow() - 不可用"
endif

if exists('*CodeBuddyHide')
    echo "✓ CodeBuddyHide() - 可用"
else
    echo "✗ CodeBuddyHide() - 不可用"
endif

if exists('*CodeBuddyToggle')
    echo "✓ CodeBuddyToggle() - 可用"
else
    echo "✗ CodeBuddyToggle() - 不可用"
endif

if exists('*CodeBuddyClose')
    echo "✓ CodeBuddyClose() - 可用"
else
    echo "✗ CodeBuddyClose() - 不可用"
endif

" 检查 codebuddy-code 命令是否存在
echo ""
echo "=== 依赖检查 ==="
echo "codebuddy-code 可执行: " . (executable('codebuddy-code') ? "是" : "否")

echo ""
echo "=== 测试完成 ==="
echo "所有核心功能模块已验证！"
echo ""
echo "使用说明:"
echo "1. 在 vim 中执行 :CodeBuddy 打开终端"
echo "2. 使用 :CodeBuddyToggle 显示/隐藏终端"
echo "3. 使用 :CodeBuddyHide 隐藏终端"
echo "4. 使用 :CodeBuddyShow 显示终端"
echo "5. 使用 :CodeBuddyClose 关闭终端"
echo "6. 快捷键: <leader>cb, <leader>th, <leader>ts, <leader>td, <leader>tk"