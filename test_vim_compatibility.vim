" Vim 兼容性测试脚本

set nocp
source plugin/codebuddy.vim

echo "=== Vim 兼容性测试 ==="

" 基本检查
echo "g:loaded_codebuddy: " . get(g:, 'loaded_codebuddy', '未设置')

" 检查函数和命令
let commands = ['CodeBuddy', 'CodeBuddyShow', 'CodeBuddyHide', 'CodeBuddyToggle', 'CodeBuddyClose']
for cmd in commands
    echo exists(':' . cmd) ? "✓ " . cmd : "✗ " . cmd
endfor

echo "=== 测试完成 ==="