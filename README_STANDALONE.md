# CodeBuddy Terminal Plugin - 独立版本

这是一个完全独立的 Vim/Neovim 插件，用于在右侧30%区域打开 CodeBuddy 终端，提供完整的终端管理功能（显示、隐藏、关闭等）。**完全独立，不依赖 vim-floaterm 或其他插件**。

## 🎯 主要特性

- ✅ **完全独立**：不依赖 vim-floaterm 或任何其他插件
- ✅ **右侧布局**：在屏幕右侧30%区域打开终端
- ✅ **CodeBuddy集成**：自动执行 `codebuddy-code` 命令
- ✅ **完整管理**：支持打开、显示、隐藏、关闭、切换功能
- ✅ **快捷键支持**：提供丰富的快捷键操作
- ✅ **兼容性**：支持 Vim 8.0+ 和 Neovim

## 📦 安装方法

### 方法1：使用插件管理器（推荐）

#### vim-plug
```vim
Plug 'your-repo/codebuddy-terminal'
```

#### Vundle
```vim
Plugin 'your-repo/codebuddy-terminal'
```

#### Packer (Neovim)
```lua
use 'your-repo/codebuddy-terminal'
```

### 方法2：手动安装

1. 将插件目录复制到你的 Vim 包目录：
```bash
git clone https://github.com/your-repo/codebuddy-terminal.git ~/.vim/pack/plugins/start/codebuddy-terminal
```

2. 或对于 Neovim：
```bash
git clone https://github.com/your-repo/codebuddy-terminal.git ~/.local/share/nvim/site/pack/plugins/start/codebuddy-terminal
```

### 方法3：直接加载

将 `plugin/codebuddy.vim` 文件复制到你的配置目录：
- Vim: `~/.vim/plugin/codebuddy.vim`
- Neovim: `~/.config/nvim/plugin/codebuddy.vim`

## 🚀 快速开始

安装后重新启动 Vim/Neovim，然后：

```vim
" 打开 CodeBuddy 终端
:CodeBuddy

" 或使用快捷键
<leader>cb
```

## 📋 命令参考

### 核心命令

| 命令 | 功能 | 说明 |
|------|------|------|
| `:CodeBuddy` | 打开CodeBuddy终端 | 在右侧30%区域打开codebuddy-code终端 |
| `:CodeBuddyShow` | 显示终端 | 显示已隐藏的终端 |
| `:CodeBuddyHide` | 隐藏终端 | 隐藏当前终端但保持后台运行 |
| `:CodeBuddyToggle` | 切换显示状态 | 在隐藏和显示之间切换 |
| `:CodeBuddyClose` | 关闭终端 | 完全关闭终端和进程 |

## ⌨️ 快捷键

### Normal模式快捷键

| 快捷键 | 命令 | 功能 |
|--------|------|------|
| `<leader>cb` | `:CodeBuddy` | 打开CodeBuddy终端 |
| `<leader>th` | `:CodeBuddyToggle` | 显示/隐藏终端 |
| `<leader>ts` | `:CodeBuddyShow` | 显示终端 |
| `<leader>td` | `:CodeBuddyHide` | 隐藏终端 |
| `<leader>tk` | `:CodeBuddyClose` | 关闭终端 |

### Terminal模式快捷键

| 快捷键 | 功能 |
|--------|------|
| `<C-t>` | 显示/隐藏终端 |
| `<C-q>` | 隐藏终端 |

> **注意**：`<leader>` 键默认为 `\` 键

## ⚙️ 配置选项

可以在你的 `.vimrc` 或 `init.vim` 中自定义配置：

```vim
" 指定要执行的命令（默认：codebuddy-code）
let g:codebuddy_shell = 'codebuddy-code'

" 终端宽度比例（默认：0.3 表示30%）
let g:codebuddy_width = 0.3

" 终端高度比例（默认：1.0 表示100%）
let g:codebuddy_height = 1.0

" 终端位置（默认：right）
" 可选值：'right', 'left'
let g:codebuddy_position = 'right'
```

## 🎮 使用场景

### 日常开发工作流

```vim
" 1. 启动 Vim/Neovim
vim your_file.py

" 2. 打开 CodeBuddy 终端
:CodeBuddy

" 3. 工作时隐藏终端以获得更多编辑空间
<leader>th

" 4. 需要时快速显示终端
<leader>th

" 5. 完成工作后关闭终端
<leader>tk
```

### 多文件编辑

```vim
" 编辑多个文件时保持终端在后台
vim file1.c file2.c file3.h

" 打开并隐藏终端
:CodeBuddy | :CodeBuddyHide

" 在文件间切换时随时激活终端
<leader>th
```

## 🧪 测试

运行提供的测试脚本验证安装：

```bash
# 测试基础功能
nvim --headless -S test_standalone_simple.vim

# 或使用 vim
vim --headless -S test_standalone_simple.vim
```

## 🔍 故障排除

### 插件未加载

如果 `:CodeBuddy` 命令不可用，检查：

1. 确保插件文件在正确位置
2. 重启 Vim/Neovim
3. 检查插件是否被其他配置影响

```vim
" 检查变量是否存在
:echo exists('g:loaded_codebuddy')

" 手动加载（临时测试）
:source /path/to/plugin/codebuddy.vim
```

### 终端配置问题

如果终端显示异常，检查：

1. 确保 `codebuddy-code` 命令可执行：
   ```bash
   which codebuddy-code
   ```

2. 检查终端配置：
   ```vim
   :echo g:codebuddy_shell
   :echo g:codebuddy_width
   :echo g:codebuddy_position
   ```

### 快捷键冲突

如果快捷键不生效，可能是：

1. `<leader>` 键被重新映射
2. 快捷键被其他插件占用

可以重新映射：

```vim
" 使用不同的 leader 键
let mapleader = ','

" 或直接映射到其他键
nnoremap <F6> :CodeBuddy<CR>
```

## 📁 文件结构

```
codebuddy-terminal/
├── plugin/
│   └── codebuddy.vim          # 主插件文件
├── test_standalone_simple.vim # 测试脚本
├── README_STANDALONE.md      # 本文档
└── ...                       # 其他配置文件
```

## ✅ 要求

- **Vim**: 8.0 或更高版本（支持终端功能）
- **Neovim**: 任意版本
- **外部工具**: `codebuddy-code` 命令需要在系统 PATH 中

## 📄 许可证

本项目采用 MIT 许可证。

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

## 📝 更新日志

### v1.0.0
- 🎉 首次发布
- ✅ 完全独立，不依赖 vim-floaterm
- ✅ 完整的终端管理功能
- ✅ 丰富的快捷键支持
- ✅ 兼容 Vim 和 Neovim