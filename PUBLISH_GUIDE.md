# 文档发布指南

## 🚀 发布方式概览

只为记账文档支持多种发布方式，您可以根据需求选择最适合的方案：

| 发布方式 | 费用 | 难度 | 自定义域名 | 推荐指数 |
|---------|------|------|-----------|----------|
| GitHub Pages | 免费 | ⭐⭐ | ✅ | ⭐⭐⭐⭐⭐ |
| GitBook.com | 免费/付费 | ⭐ | ✅(付费) | ⭐⭐⭐⭐ |
| Vercel | 免费 | ⭐⭐ | ✅ | ⭐⭐⭐⭐ |
| Netlify | 免费 | ⭐⭐ | ✅ | ⭐⭐⭐⭐ |
| 自建服务器 | 付费 | ⭐⭐⭐⭐ | ✅ | ⭐⭐⭐ |

## 📖 方式一：GitHub Pages（推荐）

### 优势
- ✅ 完全免费
- ✅ 自动部署
- ✅ 支持自定义域名
- ✅ 与GitHub仓库集成

### 设置步骤

#### 1. 启用GitHub Pages

1. 进入GitHub仓库设置页面
2. 找到"Pages"选项
3. 选择"GitHub Actions"作为源

#### 2. 配置自动部署

我已经为您创建了自动部署配置文件 `.github/workflows/deploy.yml`，它会：
- 在推送到main分支时自动触发
- 安装GitBook和依赖
- 构建文档
- 部署到GitHub Pages

#### 3. 推送代码触发部署

```bash
# 添加所有文件
git add .

# 提交更改
git commit -m "初始化GitBook文档"

# 推送到GitHub
git push origin main
```

#### 4. 访问文档

部署完成后，文档将在以下地址可用：
- `https://your-username.github.io/zhiweijz-docs/`

#### 5. 自定义域名（可选）

如果您有自己的域名：

1. 在域名DNS设置中添加CNAME记录：
   ```
   docs.your-domain.com -> your-username.github.io
   ```

2. 修改 `.github/workflows/deploy.yml` 中的 `cname` 设置：
   ```yaml
   cname: docs.your-domain.com
   ```

3. 推送更改，文档将在 `https://docs.your-domain.com` 可用

## 🌐 方式二：GitBook.com 官方平台

### 优势
- ✅ 专业的文档平台
- ✅ 优秀的阅读体验
- ✅ 内置搜索和分析
- ✅ 团队协作功能

### 设置步骤

#### 1. 注册GitBook账户

访问 [GitBook.com](https://gitbook.com) 注册账户

#### 2. 创建新的Space

1. 点击"New Space"
2. 选择"Import from GitHub"
3. 连接您的GitHub仓库

#### 3. 配置同步

GitBook会自动同步您的GitHub仓库内容，每次推送都会自动更新。

#### 4. 自定义设置

- 设置Space名称和描述
- 配置访问权限（公开/私有）
- 自定义域名（付费功能）

## ⚡ 方式三：Vercel 部署

### 优势
- ✅ 免费额度充足
- ✅ 全球CDN加速
- ✅ 自动HTTPS
- ✅ 支持自定义域名

### 设置步骤

#### 1. 创建vercel.json配置

```json
{
  "version": 2,
  "builds": [
    {
      "src": "package.json",
      "use": "@vercel/static-build",
      "config": {
        "distDir": "_book"
      }
    }
  ],
  "scripts": {
    "build": "gitbook install && gitbook build"
  }
}
```

#### 2. 连接Vercel

1. 访问 [Vercel.com](https://vercel.com)
2. 使用GitHub账户登录
3. 导入您的文档仓库
4. Vercel会自动检测并部署

#### 3. 配置自定义域名

在Vercel项目设置中添加您的域名。

## 🌊 方式四：Netlify 部署

### 设置步骤

#### 1. 创建netlify.toml配置

```toml
[build]
  command = "npm install -g gitbook-cli && npm install && gitbook install && gitbook build"
  publish = "_book"

[build.environment]
  NODE_VERSION = "18"
```

#### 2. 连接Netlify

1. 访问 [Netlify.com](https://netlify.com)
2. 连接GitHub仓库
3. 配置构建设置
4. 部署

## 🖥️ 方式五：自建服务器

### 适用场景
- 需要完全控制
- 内网部署
- 特殊安全要求

### 部署步骤

#### 1. 服务器环境准备

```bash
# 安装Node.js
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs

# 安装GitBook
npm install -g gitbook-cli
```

#### 2. 构建和部署

```bash
# 克隆仓库
git clone https://github.com/your-username/zhiweijz-docs.git
cd zhiweijz-docs

# 安装依赖
npm install
gitbook install

# 构建文档
gitbook build

# 部署到Web服务器
sudo cp -r _book/* /var/www/html/
```

#### 3. 配置Nginx

```nginx
server {
    listen 80;
    server_name docs.your-domain.com;
    
    root /var/www/html;
    index index.html;
    
    location / {
        try_files $uri $uri/ =404;
    }
    
    # 启用gzip压缩
    gzip on;
    gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;
}
```

## 🔄 自动化部署脚本

我已经为您创建了 `deploy.sh` 脚本，支持多种操作：

```bash
# 安装依赖
./deploy.sh install

# 本地预览
./deploy.sh serve

# 构建文档
./deploy.sh build

# 部署到GitHub Pages
./deploy.sh deploy

# 生成PDF
./deploy.sh pdf
```

## 📊 部署监控

### GitHub Actions状态

在GitHub仓库的"Actions"标签页可以查看部署状态：
- ✅ 成功：文档已更新
- ❌ 失败：检查构建日志

### 常见问题排查

#### 1. 构建失败
```bash
# 检查本地构建
./deploy.sh build

# 查看错误日志
gitbook build --debug
```

#### 2. 插件安装失败
```bash
# 清除缓存重新安装
rm -rf node_modules
npm install
gitbook install
```

#### 3. 页面无法访问
- 检查GitHub Pages设置
- 确认域名DNS配置
- 等待DNS传播（最多24小时）

## 🎯 推荐发布流程

### 开发阶段
1. 本地编写文档
2. 使用 `./deploy.sh serve` 预览
3. 提交到GitHub

### 发布阶段
1. 推送到main分支
2. GitHub Actions自动构建
3. 文档自动发布到GitHub Pages

### 维护阶段
1. 定期更新内容
2. 监控访问统计
3. 收集用户反馈

## 📈 访问统计

### Google Analytics

在 `book.json` 中添加：

```json
{
  "plugins": ["ga"],
  "pluginsConfig": {
    "ga": {
      "token": "UA-XXXXXXXX-X"
    }
  }
}
```

### 百度统计

添加统计代码到模板文件中。

## 🔗 SEO优化

### 1. 设置合适的标题和描述

在每个页面开头添加：
```markdown
---
title: 页面标题
description: 页面描述
---
```

### 2. 配置sitemap

GitBook会自动生成sitemap.xml

### 3. 提交搜索引擎

- Google Search Console
- 百度站长平台
- 必应网站管理员工具

---

## 🎉 开始发布

选择您喜欢的发布方式：

1. **快速开始**：使用GitHub Pages（推荐）
2. **专业平台**：使用GitBook.com
3. **高性能**：使用Vercel或Netlify
4. **完全控制**：自建服务器

无论选择哪种方式，您的文档都将为用户提供优秀的阅读体验！
