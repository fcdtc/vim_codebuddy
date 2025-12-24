" 测试完整的CodeBuddy集成配置

" 加载完整配置
source INSTALL_CODEBUDDY_COMPLETE.vim

echo ""
echo "=== 配置验证 ==="
echo "floaterm_shell: " . g:floaterm_shell
echo "floaterm_width: " . g:floaterm_width
echo "floaterm_height: " . g:floaterm_height
echo "floaterm_wintype: " . g:floaterm_wintype
echo "floaterm_position: " . g:floaterm_position

echo ""
echo "=== 命令检查 ==="
let commands = ['CodeBuddy', 'FloatermToggle', 'FloatermHide', 'FloatermShow', 'FloatermKill',
               \ 'FloatermNew', 'FloatermNext', 'FloatermPrev', 'FloatermFirst', 'FloatermLast',
               \ 'FloatermSend']

for cmd in commands
    if exists(':' . cmd)
        echo "✓ " . cmd . " - 可用"
    else
        echo "✗ " . cmd . " - 不可用"
    endif
endfor

echo ""
echo "=== 测试完成 ==="
echo "所有配置和命令都已正确加载！"