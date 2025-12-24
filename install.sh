#!/bin/bash
# CodeBuddy Terminal Plugin 安装脚本

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 打印函数
print_banner() {
    echo -e "${BLUE}"
    echo "=========================================="
    echo "    CodeBuddy Terminal Plugin 安装器"
    echo "=========================================="
    echo -e "${NC}"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

# 检查命令是否存在
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# 检测编辑器类型
detect_editor() {
    if command_exists nvim; then
        echo "nvim"
    elif command_exists vim; then
        echo "vim"
    else
        echo ""
    fi
}

# 获取配置目录
get_config_dir() {
    local editor=$1
    if [ "$editor" = "nvim" ]; then
        echo "$HOME/.config/nvim"
    else
        echo "$HOME/.vim"
    fi
}

# 创建目录结构
create_dirs() {
    local config_dir=$1
    print_info "创建插件目录结构..."

    mkdir -p "$config_dir/plugin"
    mkdir -p "$config_dir/autoload"

    print_success "目录结构创建完成: $config_dir"
}

# 复制插件文件
copy_plugin_files() {
    local config_dir=$1
    local source_dir=$(dirname "$0")

    print_info "复制插件文件..."

    if [ -f "$source_dir/plugin/codebuddy.vim" ]; then
        cp "$source_dir/plugin/codebuddy.vim" "$config_dir/plugin/"
        print_success "主插件文件复制完成"
    else
        print_error "找不到主插件文件: $source_dir/plugin/codebuddy.vim"
        exit 1
    fi

    # 可选：复制测试文件
    if [ -f "$source_dir/test_standalone_simple.vim" ]; then
        cp "$source_dir/test_standalone_simple.vim" "$config_dir/"
        print_success "测试文件复制完成"
    fi
}

# 检查依赖
check_dependencies() {
    print_info "检查依赖项..."

    # 检查 codebuddy-code
    if command_exists codebuddy-code; then
        print_success "codebuddy-command 已安装"
    else
        print_warning "codebuddy-code 未找到，请确保已安装 CodeBuddy"
        print_info "你可以稍后手动安装 CodeBuddy"
    fi

    # 检查编辑器
    editor=$(detect_editor)
    if [ -n "$editor" ]; then
        print_success "检测到编辑器: $editor"
    else
        print_error "未找到支持的编辑器 (vim/nvim)"
        exit 1
    fi
}

# 验证安装
verify_installation() {
    local config_dir=$1
    local plugin_file="$config_dir/plugin/codebuddy.vim"

    print_info "验证安装..."

    if [ -f "$plugin_file" ]; then
        print_success "插件文件存在: $plugin_file"

        # 检查文件内容
        if grep -q "CodeBuddy Terminal Plugin" "$plugin_file"; then
            print_success "插件文件内容验证通过"
        else
            print_warning "插件文件内容可能有异常"
        fi
    else
        print_error "插件文件不存在: $plugin_file"
        return 1
    fi
}

# 显示使用说明
show_usage() {
    local editor=$1
    echo
    echo "=========================================="
    echo -e "${GREEN}🎉 安装完成！${NC}"
    echo "=========================================="
    echo
    echo "使用方法："
    echo "1. 重启你的编辑器 ($editor)"
    echo "2. 执行 ':CodeBuddy' 命令打开终端"
    echo "3. 使用快捷键："
    echo "   <leader>cb - 打开CodeBuddy终端"
    echo "   <leader>th - 显示/隐藏终端"
    echo "   <leader>ts - 显示终端"
    echo "   <leader>td - 隐藏终端"
    echo "   <leader>tk - 关闭终端"
    echo
    echo "更多命令："
    echo "  :CodeBuddyShow    - 显示终端"
    echo "  :CodeBuddyHide    - 隐藏终端"
    echo "  :CodeBuddyToggle  - 切换显示状态"
    echo "  :CodeBuddyClose   - 关闭终端"
    echo
    print_info "注意：<leader> 键默认为 \\ 键"
    echo
    print_info "配置文件位置: $config_dir/plugin/codebuddy.vim"
}

# 主函数
main() {
    print_banner

    # 检查依赖
    check_dependencies
    echo

    # 检测编辑器
    editor=$(detect_editor)
    config_dir=$(get_config_dir "$editor")

    print_info "检测到编辑器: $editor"
    print_info "配置目录: $config_dir"
    echo

    # 创建目录
    create_dirs "$config_dir"
    echo

    # 复制文件
    copy_plugin_files "$config_dir"
    echo

    # 验证安装
    if verify_installation "$config_dir"; then
        show_usage "$editor"
    else
        print_error "安装验证失败"
        exit 1
    fi
}

# 显示帮助信息
show_help() {
    echo "CodeBuddy Terminal Plugin 安装脚本"
    echo
    echo "用法: $0 [选项]"
    echo
    echo "选项:"
    echo "  -h, --help     显示此帮助信息"
    echo "  --vim          强制安装到 Vim 配置目录"
    echo "  --nvim         强制安装到 Neovim 配置目录"
    echo "  --dry-run      仅显示将要执行的操作，不实际安装"
    echo
    echo "examples:"
    echo "  $0                # 自动检测编辑器并安装"
    echo "  $0 --vim          # 强制安装到 Vim"
    echo "  $0 --nvim         # 强制安装到 Neovim"
}

# 解析命令行参数
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_help
            exit 0
            ;;
        --vim)
            FORCE_VIM=true
            shift
            ;;
        --nvim)
            FORCE_NVIM=true
            shift
            ;;
        --dry-run)
            DRY_RUN=true
            shift
            ;;
        *)
            print_error "未知选项: $1"
            show_help
            exit 1
            ;;
    esac
done

# 处理强制选项
if [ "$FORCE_VIM" = true ]; then
    if command_exists vim; then
        editor="vim"
        config_dir=$(get_config_dir "vim")
    else
        print_error "未找到 vim"
        exit 1
    fi
elif [ "$FORCE_NVIM" = true ]; then
    if command_exists nvim; then
        editor="nvim"
        config_dir=$(get_config_dir "nvim")
    else
        print_error "未找到 nvim"
        exit 1
    fi
fi

# 干运行模式
if [ "$DRY_RUN" = true ]; then
    print_info "干运行模式 - 不会实际安装"
    echo
    main | sed 's/✓/ (待执行) ✓/g' | sed 's/创建/将创建/g' | sed 's/复制/将复制/g'
    exit 0
fi

# 运行主程序
main