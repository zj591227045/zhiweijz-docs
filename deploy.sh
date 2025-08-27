#!/bin/bash

# 只为记账文档部署脚本
# 用于构建和部署GitBook文档

set -e

echo "🚀 开始部署只为记账用户文档..."

# 检查是否安装了必要的工具
check_dependencies() {
    echo "📋 检查依赖..."
    
    if ! command -v node &> /dev/null; then
        echo "❌ Node.js 未安装，请先安装 Node.js"
        exit 1
    fi
    
    if ! command -v npm &> /dev/null; then
        echo "❌ npm 未安装，请先安装 npm"
        exit 1
    fi
    
    echo "✅ 依赖检查完成"
}

# 安装GitBook和插件
install_gitbook() {
    echo "📦 安装GitBook和插件..."
    
    # 安装gitbook-cli
    if ! command -v gitbook &> /dev/null; then
        echo "安装 gitbook-cli..."
        npm install -g gitbook-cli
    fi
    
    # 安装项目依赖
    echo "安装项目依赖..."
    npm install
    
    # 安装GitBook插件
    echo "安装GitBook插件..."
    gitbook install
    
    echo "✅ 安装完成"
}

# 构建文档
build_docs() {
    echo "🔨 构建文档..."
    
    # 清理之前的构建
    if [ -d "_book" ]; then
        rm -rf _book
    fi
    
    # 构建GitBook
    gitbook build
    
    echo "✅ 构建完成"
}

# 本地预览
serve_docs() {
    echo "👀 启动本地预览服务器..."
    echo "📖 文档将在 http://localhost:4000 可用"
    echo "按 Ctrl+C 停止服务器"
    
    gitbook serve
}

# 部署到GitHub Pages
deploy_github() {
    echo "🚀 部署到GitHub Pages..."
    
    # 检查是否有未提交的更改
    if ! git diff-index --quiet HEAD --; then
        echo "⚠️  检测到未提交的更改，请先提交所有更改"
        exit 1
    fi
    
    # 构建文档
    build_docs
    
    # 部署到gh-pages分支
    npm run deploy
    
    echo "✅ 部署完成"
}

# 生成PDF
generate_pdf() {
    echo "📄 生成PDF文档..."
    
    # 检查是否安装了calibre
    if ! command -v ebook-convert &> /dev/null; then
        echo "❌ 需要安装 Calibre 来生成PDF"
        echo "请访问 https://calibre-ebook.com/download 下载安装"
        exit 1
    fi
    
    gitbook pdf . ./zhiweijz-docs.pdf
    
    echo "✅ PDF生成完成: zhiweijz-docs.pdf"
}

# 显示帮助信息
show_help() {
    echo "只为记账文档部署脚本"
    echo ""
    echo "用法: $0 [命令]"
    echo ""
    echo "命令:"
    echo "  install    安装GitBook和依赖"
    echo "  build      构建文档"
    echo "  serve      本地预览文档"
    echo "  deploy     部署到GitHub Pages"
    echo "  pdf        生成PDF文档"
    echo "  help       显示此帮助信息"
    echo ""
    echo "示例:"
    echo "  $0 install    # 安装依赖"
    echo "  $0 serve      # 本地预览"
    echo "  $0 deploy     # 部署到GitHub Pages"
}

# 主函数
main() {
    case "${1:-help}" in
        "install")
            check_dependencies
            install_gitbook
            ;;
        "build")
            check_dependencies
            build_docs
            ;;
        "serve")
            check_dependencies
            serve_docs
            ;;
        "deploy")
            check_dependencies
            deploy_github
            ;;
        "pdf")
            check_dependencies
            generate_pdf
            ;;
        "help"|*)
            show_help
            ;;
    esac
}

# 运行主函数
main "$@"
