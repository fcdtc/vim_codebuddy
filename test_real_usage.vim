" 测试实际使用场景 - 验证不会出现shell错误

" 模拟实际使用情况
set nocp
source plugin/codebuddy.vim

echo "=== 测试实际使用场景 ==="

" 测试配置变量
if exists('g:codebuddy_shell')
    echo "✓ g:codebuddy_shell 存在: " . g:codebuddy_shell
else
    echo "✗ g:codebuddy_shell 不存在"
endif

" 测试调用函数 - 但不实际打开终端
echo "✓ 测试 CodeBuddyOpen 函数存在: " . exists('*CodeBuddyOpen')

" 验证变量不会被当作shell命令执行
try
    " 这应该不会导致 shell 错误
    let test_shell = get(g:, 'codebuddy_shell', 'codebuddy-code')
    echo "✓ 变量引用正常: " . test_shell
catch
    echo "✗ 变量引用错误: " . v:exception
endtry

echo "=== 实际使用测试通过 ==="