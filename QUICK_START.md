# CodeBuddy Terminal Plugin - 快速开始

## 🚀 一键安装

运行安装脚本，自动检测你的编辑器并安装：

```bash
./install.sh
```

## 🎯 最小配置

无需任何配置！安装完即可使用：

1. **重启编辑器**
2. **运行命令**：`:CodeBuddy` 或按 `<leader>cb`
3. **享受coding！**

## ⚡ 核心功能

| 功能 | 命令 | 快捷键 |
|------|------|--------|
| 打开终端 | `:CodeBuddy` | `<leader>cb` |
| 显示/隐藏 | `:CodeBuddyToggle` | `<leader>th` |
| 显示终端 | `:CodeBuddyShow` | `<leader>ts` |
| 隐藏终端 | `:CodeBuddyHide` | `<leader>td` |
| 关闭终端 | `:CodeBuddyClose` | `<leader>tk` |

## 📦 安装验证

检查是否安装成功：

```vim
:echo g:loaded_codebuddy
" 应该输出: 1

:CodeBuddy
" 右侧应该出现 CodeBuddy 终端
```

## 🔧 常见问题

### Q: 命令不存在？
A: 重启编辑器，然后检查：`:echo exists(':CodeBuddy')`

### Q: 终端宽度不对？
A: 在配置文件中添加：`let g:codebuddy_width = 0.4`

### Q: 快捷键冲突？
A: 重新映射：`nnoremap <F6> :CodeBuddy<CR>`

---

🎉 **就这么简单！现在去享受 CodeBuddy 吧！**