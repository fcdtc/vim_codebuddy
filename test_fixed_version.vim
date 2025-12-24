" 测试修复版本的 CodeBuddy 集成

" 模拟没有 floaterm 的情况来测试错误处理
" 将 packpath 设置为当前目录，确保使用当前的插件设置
set packpath+=.

" 加载修复版本配置
source INSTALL_CODEBUDDY_FIXED.vim

echo ""
echo "=== 修复版本测试开始 ==="

" 等待一小段时间让配置加载完成
sleep 100m

" 检查命令是否正确注册
if exists(':CodeBuddy')
    echo "✓ CodeBuddy 命令已正确注册"
else
    echo "✗ CodeBuddy 命令注册失败"
endif

" 检查诊断命令
if exists(':CodeBuddyCheck')
    echo "✓ CodeBuddyCheck 诊断命令已注册"
else
    echo "✗ CodeBuddyCheck 诊断命令注册失败"
endif

" 检查配置变量
echo ""
echo "=== 配置检查 ==="
echo "floaterm_shell: " . get(g:, 'floaterm_shell', '未设置')
echo "floaterm_width: " . get(g:, 'floaterm_width', '未设置')
echo "floaterm_height: " . get(g:, 'floaterm_height', '未设置')
echo "floaterm_wintype: " . get(g:, 'floaterm_wintype', '未设置')
echo "floaterm_position: " . get(g:, 'floaterm_position', '未设置')

" 运行诊断命令
if exists(':CodeBuddyCheck')
    echo ""
    echo "=== 运行诊断命令 ==="
    CodeBuddyCheck
endif

echo ""
echo "=== 测试完成 ==="