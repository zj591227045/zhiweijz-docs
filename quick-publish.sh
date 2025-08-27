#!/bin/bash

# 只为记账文档快速发布脚本
# 帮助用户快速选择和配置发布方式

set -e

echo "🚀 只为记账文档发布向导"
echo "================================"

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 显示选项
show_options() {
    echo ""
    echo "请选择发布方式："
    echo ""
    echo "1. 🐙 GitHub Pages (推荐 - 免费)"
    echo "2. 📖 GitBook.com (专业平台)"
    echo "3. ⚡ Vercel (高性能 - 免费)"
    echo "4. 🌊 Netlify (简单易用 - 免费)"
    echo "5. 🖥️  自建服务器"
    echo "6. 📋 查看所有发布方式对比"
    echo "7. ❓ 帮助"
    echo "8. 🚪 退出"
    echo ""
}

# GitHub Pages设置
setup_github_pages() {
    echo -e "${GREEN}🐙 设置GitHub Pages发布${NC}"
    echo ""
    
    # 检查是否在Git仓库中
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        echo -e "${RED}❌ 当前目录不是Git仓库${NC}"
        echo "请先初始化Git仓库："
        echo "  git init"
        echo "  git remote add origin https://github.com/your-username/zhiweijz-docs.git"
        return 1
    fi
    
    echo "✅ GitHub Actions配置文件已创建"
    echo "📁 位置: .github/workflows/deploy.yml"
    echo ""
    echo "下一步操作："
    echo "1. 推送代码到GitHub:"
    echo "   git add ."
    echo "   git commit -m \"初始化GitBook文档\""
    echo "   git push origin main"
    echo ""
    echo "2. 在GitHub仓库设置中启用Pages:"
    echo "   - 进入仓库 Settings > Pages"
    echo "   - Source选择 \"GitHub Actions\""
    echo ""
    echo "3. 文档将在以下地址可用:"
    echo "   https://your-username.github.io/zhiweijz-docs/"
    echo ""
    
    read -p "是否现在推送到GitHub? (y/n): " push_now
    if [[ $push_now =~ ^[Yy]$ ]]; then
        echo "推送代码到GitHub..."
        git add .
        git commit -m "初始化GitBook文档和发布配置" || echo "没有新的更改需要提交"
        git push origin main || git push origin master
        echo -e "${GREEN}✅ 代码已推送到GitHub${NC}"
    fi
}

# GitBook.com设置
setup_gitbook_com() {
    echo -e "${BLUE}📖 设置GitBook.com发布${NC}"
    echo ""
    echo "GitBook.com是专业的文档平台，提供优秀的阅读体验。"
    echo ""
    echo "设置步骤："
    echo "1. 访问 https://gitbook.com 注册账户"
    echo "2. 创建新的Space"
    echo "3. 选择 \"Import from GitHub\""
    echo "4. 连接您的GitHub仓库"
    echo "5. GitBook会自动同步内容"
    echo ""
    echo "优势："
    echo "✅ 专业的文档平台"
    echo "✅ 优秀的阅读体验"
    echo "✅ 内置搜索和分析"
    echo "✅ 团队协作功能"
    echo ""
    echo "💡 提示: 免费版有一定限制，付费版功能更全面"
}

# Vercel设置
setup_vercel() {
    echo -e "${YELLOW}⚡ 设置Vercel发布${NC}"
    echo ""
    echo "Vercel提供高性能的静态网站托管服务。"
    echo ""
    echo "✅ vercel.json配置文件已创建"
    echo ""
    echo "设置步骤："
    echo "1. 访问 https://vercel.com"
    echo "2. 使用GitHub账户登录"
    echo "3. 点击 \"New Project\""
    echo "4. 导入您的GitHub仓库"
    echo "5. Vercel会自动检测配置并部署"
    echo ""
    echo "优势："
    echo "✅ 免费额度充足"
    echo "✅ 全球CDN加速"
    echo "✅ 自动HTTPS"
    echo "✅ 支持自定义域名"
}

# Netlify设置
setup_netlify() {
    echo -e "${GREEN}🌊 设置Netlify发布${NC}"
    echo ""
    echo "Netlify是简单易用的静态网站托管平台。"
    echo ""
    echo "✅ netlify.toml配置文件已创建"
    echo ""
    echo "设置步骤："
    echo "1. 访问 https://netlify.com"
    echo "2. 使用GitHub账户登录"
    echo "3. 点击 \"New site from Git\""
    echo "4. 选择您的GitHub仓库"
    echo "5. 配置会自动检测"
    echo ""
    echo "优势："
    echo "✅ 简单易用"
    echo "✅ 免费版功能丰富"
    echo "✅ 表单处理功能"
    echo "✅ 分支预览"
}

# 自建服务器设置
setup_self_hosted() {
    echo -e "${RED}🖥️  自建服务器发布${NC}"
    echo ""
    echo "适合需要完全控制或内网部署的场景。"
    echo ""
    echo "环境要求："
    echo "- Linux服务器"
    echo "- Node.js 18+"
    echo "- Nginx或Apache"
    echo ""
    echo "部署步骤："
    echo "1. 安装Node.js:"
    echo "   curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -"
    echo "   sudo apt-get install -y nodejs"
    echo ""
    echo "2. 安装GitBook:"
    echo "   npm install -g gitbook-cli"
    echo ""
    echo "3. 克隆和构建:"
    echo "   git clone <your-repo-url>"
    echo "   cd zhiweijz-docs"
    echo "   npm install"
    echo "   gitbook install"
    echo "   gitbook build"
    echo ""
    echo "4. 部署到Web服务器:"
    echo "   sudo cp -r _book/* /var/www/html/"
    echo ""
    echo "💡 提示: 可以使用deploy.sh脚本简化操作"
}

# 显示对比表
show_comparison() {
    echo ""
    echo "📋 发布方式对比"
    echo "================================"
    echo ""
    printf "%-15s %-8s %-8s %-12s %-8s\n" "平台" "费用" "难度" "自定义域名" "推荐度"
    echo "--------------------------------------------------------"
    printf "%-15s %-8s %-8s %-12s %-8s\n" "GitHub Pages" "免费" "⭐⭐" "✅" "⭐⭐⭐⭐⭐"
    printf "%-15s %-8s %-8s %-12s %-8s\n" "GitBook.com" "免费/付费" "⭐" "✅(付费)" "⭐⭐⭐⭐"
    printf "%-15s %-8s %-8s %-12s %-8s\n" "Vercel" "免费" "⭐⭐" "✅" "⭐⭐⭐⭐"
    printf "%-15s %-8s %-8s %-12s %-8s\n" "Netlify" "免费" "⭐⭐" "✅" "⭐⭐⭐⭐"
    printf "%-15s %-8s %-8s %-12s %-8s\n" "自建服务器" "付费" "⭐⭐⭐⭐" "✅" "⭐⭐⭐"
    echo ""
}

# 显示帮助
show_help() {
    echo ""
    echo "❓ 帮助信息"
    echo "================================"
    echo ""
    echo "🎯 推荐选择:"
    echo "- 个人项目: GitHub Pages"
    echo "- 团队协作: GitBook.com"
    echo "- 高性能需求: Vercel"
    echo "- 简单部署: Netlify"
    echo "- 企业内网: 自建服务器"
    echo ""
    echo "📚 更多信息:"
    echo "- 详细发布指南: PUBLISH_GUIDE.md"
    echo "- 开发文档: DEVELOPMENT.md"
    echo "- 部署脚本: deploy.sh"
    echo ""
    echo "🔗 有用链接:"
    echo "- GitHub Pages: https://pages.github.com/"
    echo "- GitBook: https://gitbook.com/"
    echo "- Vercel: https://vercel.com/"
    echo "- Netlify: https://netlify.com/"
}

# 主循环
main() {
    while true; do
        show_options
        read -p "请选择 (1-8): " choice
        
        case $choice in
            1)
                setup_github_pages
                ;;
            2)
                setup_gitbook_com
                ;;
            3)
                setup_vercel
                ;;
            4)
                setup_netlify
                ;;
            5)
                setup_self_hosted
                ;;
            6)
                show_comparison
                ;;
            7)
                show_help
                ;;
            8)
                echo "👋 再见！"
                exit 0
                ;;
            *)
                echo -e "${RED}❌ 无效选择，请输入1-8${NC}"
                ;;
        esac
        
        echo ""
        read -p "按回车键继续..."
    done
}

# 运行主程序
main
