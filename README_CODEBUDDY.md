# vim-floaterm CodeBuddy Integration

这个修改版的vim-floaterm插件提供了在右侧30%区域打开CodeBuddy终端的功能，同时保留原有的终端管理功能（隐藏、关闭、多终端管理等）。

## 功能特性

- 在右侧30%区域打开垂直分割终端，自动执行`codebuddy-code`命令
- 终端占满全高度（100%）
- 保留完整的终端管理功能：显示/隐藏、关闭、多终端切换
- 提供便捷的快捷键支持

## 安装和配置

### 方法1：使用完整配置（推荐）

1. 将`INSTALL_CODEBUDDY_COMPLETE.vim`文件复制到你的vim配置目录
2. 在你的vimrc或init.vim中添加：
   ```vim
   source /path/to/INSTALL_CODEBUDDY_COMPLETE.vim
   ```

### 方法2：使用基础配置

1. 将`INSTALL_CODEBUDDY.vim`文件复制到你的vim配置目录
2. 在你的vimrc或init.vim中添加：
   ```vim
   source /path/to/INSTALL_CODEBUDDY.vim
   ```

### 方法3：手动配置

在你的vimrc或init.vim中添加：
```vim
" 强制覆盖floaterm配置用于CodeBuddy
let g:floaterm_shell = 'codebuddy-code'
let g:floaterm_width = 0.3
let g:floaterm_height = 1.0
let g:floaterm_wintype = 'vsplit'
let g:floaterm_position = 'right'

" CodeBuddy命令
command! CodeBuddy call floaterm#new(0, 'codebuddy-code', {}, {
      \ 'wintype': 'vsplit',
      \ 'position': 'right',
      \ 'width': 0.3,
      \ 'height': 1.0
      \ })

" 基础快捷键
nnoremap <leader>cb :CodeBuddy<CR>
nnoremap <leader>th :FloatermToggle<CR>
```

## 命令参考

### 核心 CodeBuddy 命令

| 命令 | 功能 | 说明 |
|------|------|------|
| `:CodeBuddy` | 打开CodeBuddy终端 | 在右侧30%区域打开codebuddy-code终端 |

### 终端管理命令

| 命令 | 功能 | 说明 |
|------|------|------|
| `:FloatermToggle` | 显示/隐藏终端 | 切换当前终端的显示状态 |
| `:FloatermHide` | 隐藏终端 | 隐藏当前终端窗口 |
| `:FloatermShow` | 显示终端 | 显示当前终端窗口 |
| `:FloatermKill` | 关闭终端 | 永久关闭当前终端 |

### 多终端管理命令

| 命令 | 功能 | 说明 |
|------|------|------|
| `:FloatermNew [cmd]` | 打开新终端 | 可选择执行特定命令 |
| `:FloatermNext` | 下一个终端 | 切换到下一个终端实例 |
| `:FloatermPrev` | 上一个终端 | 切换到上一个终端实例 |
| `:FloatermFirst` | 第一个终端 | 跳转到第一个终端实例 |
| `:FloatermLast` | 最后一个终端 | 跳转到最后一个终端实例 |

### 其他命令

| 命令 | 功能 | 说明 |
|------|------|------|
| `:FloatermSend [cmd]` | 发送命令 | 向终端发送命令或选中文本 |
| `:FloatermUpdate` | 更新配置 | 更新终端窗口配置 |

## 快捷键参考

### Normal模式快捷键

| 快捷键 | 命令 | 功能 |
|--------|------|------|
| `<leader>cb` | `:CodeBuddy` | 打开CodeBuddy终端 |
| `<leader>th` | `:FloatermToggle` | 显示/隐藏终端 |
| `<leader>tk` | `:FloatermKill` | 关闭终端 |
| `<leader>ts` | `:FloatermShow` | 显示终端 |
| `<leader>td` | `:FloatermHide` | 隐藏终端 |

### Terminal模式快捷键

| 快捷键 | 功能 |
|--------|------|
| `<C-t>` | 显示/隐藏终端 |
| `<C-q>` | 隐藏终端 |

## 使用场景

### 基础使用

1. 启动vim/nvim
2. 运行`:CodeBuddy`或按`<leader>cb`
3. CodeBuddy将在右侧30%区域打开

### 日常管理

```vim
" 打开CodeBuddy
:CodeBuddy

" 快速隐藏/显示（工作时隐藏，需要时显示）
:FloatermToggle

" 手动隐藏终端
:FloatermHide

" 重新显示隐藏的终端
:FloatermShow

" 关闭不需要的终端
:FloatermKill
```

### 多终端管理

```vim
" 打开CodeBuddy终端
:CodeBuddy

" 打开另一个终端（如系统shell）
:FloatermNew bash

" 在两个终端之间切换
:FloatermNext
:FloatermPrev

" 发送当前行到终端
:FloatermSend

" 发送选中的代码到终端
:'<,'>FloatermSend
```

## 测试

运行测试脚本验证配置：
```bash
# 测试基础配置
nvim -S final_test.vim

# 测试完整配置
nvim -S test_complete_config.vim
```

## 注意事项

- 需要已安装vim-floaterm插件
- 需要系统中已安装`codebuddy-code`命令
- 此配置会覆盖全局floaterm默认设置，但所有管理功能仍然可用
- 快捷键中的`<leader>`默认为`\`键

## 文件说明

- `INSTALL_CODEBUDDY_COMPLETE.vim` - 完整版配置文件（推荐）
- `INSTALL_CODEBUDDY.vim` - 基础版配置文件
- `test_complete_config.vim` - 完整功能测试脚本
- `final_test.vim` - 基础测试脚本
- `README_CODEBUDDY.md` - 本说明文档