# Vercel 部署指南

## ⚠️ 重要说明

由于GitBook CLI是较老的工具，在现代部署平台（如Vercel）上可能会遇到兼容性问题。我们推荐以下几种解决方案：

## 🚀 推荐方案一：使用GitHub Pages（最稳定）

GitHub Pages对GitBook支持最好，推荐使用：

1. 推送代码到GitHub
2. 在仓库设置中启用GitHub Pages
3. 选择GitHub Actions作为源
4. 自动部署配置已经准备好

## 🔧 方案二：Vercel部署（需要调整）

如果您坚持使用Vercel，请按以下步骤操作：

### 步骤1：修改构建方式

我们已经更新了配置文件，但您可能需要在Vercel控制台中手动设置：

**Build Command:**
```bash
npm run vercel-build
```

**Output Directory:**
```
_book
```

**Install Command:**
```bash
npm install
```

### 步骤2：环境变量设置

在Vercel项目设置中添加环境变量：

```
NODE_VERSION=18
NPM_VERSION=8
```

### 步骤3：如果仍然失败

如果GitBook CLI在Vercel上仍然有问题，可以考虑以下替代方案：

#### 方案A：使用VitePress替代

创建 `docs/.vitepress/config.js`：
```javascript
export default {
  title: '只为记账',
  description: '智能家庭记账应用用户文档',
  themeConfig: {
    nav: [
      { text: '首页', link: '/' },
      { text: '产品介绍', link: '/product/' },
      { text: '部署指南', link: '/deployment/' },
      { text: '用户手册', link: '/user-guide/' }
    ],
    sidebar: {
      '/product/': [
        { text: '产品概述', link: '/product/overview' },
        { text: '核心功能', link: '/product/features' }
      ],
      '/deployment/': [
        { text: '部署概述', link: '/deployment/overview' },
        { text: 'Docker部署', link: '/deployment/docker' }
      ],
      '/user-guide/': [
        { text: '快速开始', link: '/user-guide/quick-start' }
      ]
    }
  }
}
```

然后修改 `package.json`：
```json
{
  "scripts": {
    "docs:dev": "vitepress dev docs",
    "docs:build": "vitepress build docs",
    "docs:preview": "vitepress preview docs"
  },
  "devDependencies": {
    "vitepress": "^1.0.0"
  }
}
```

#### 方案B：使用Docusaurus

创建Docusaurus项目：
```bash
npx create-docusaurus@latest docs classic
```

#### 方案C：使用简单的静态站点

如果您只需要简单的文档展示，可以使用我们提供的静态HTML生成脚本。

## 🌐 方案三：使用其他平台

### Netlify部署
Netlify对GitBook的支持更好：

1. 连接GitHub仓库到Netlify
2. 使用我们提供的 `netlify.toml` 配置
3. 自动部署

### GitHub Pages部署
最推荐的方式：

1. 代码已经推送到GitHub
2. GitHub Actions配置已经准备好
3. 在仓库设置中启用Pages即可

## 🔍 故障排除

### 常见Vercel错误

#### 错误1：GitBook CLI安装失败
```
Error: Cannot find module 'gitbook-cli'
```

**解决方案：**
在 `package.json` 中添加：
```json
{
  "dependencies": {
    "gitbook-cli": "^2.3.2"
  }
}
```

#### 错误2：Node版本不兼容
```
Error: Node version not supported
```

**解决方案：**
在Vercel项目设置中设置：
```
NODE_VERSION=16
```

#### 错误3：构建超时
```
Error: Build timeout
```

**解决方案：**
简化构建过程或使用其他平台。

## 📋 当前状态

我已经为您更新了以下文件：

1. **vercel.json** - 简化了配置，移除了无效的 `scripts` 属性
2. **package.json** - 添加了 `vercel-build` 脚本
3. **VERCEL_DEPLOY.md** - 本指南文档

## 🎯 推荐操作

1. **立即可用：** 使用GitHub Pages部署（最稳定）
2. **如果需要Vercel：** 尝试更新后的配置
3. **长期方案：** 考虑迁移到VitePress或Docusaurus

## 📞 获取帮助

如果您在部署过程中遇到问题：

1. 查看Vercel构建日志
2. 尝试本地构建：`npm run vercel-build`
3. 考虑使用GitHub Pages作为备选方案

---

> 💡 **建议**: GitBook CLI是较老的工具，现代文档工具如VitePress、Docusaurus或Nextra可能更适合现代部署平台。如果您需要，我可以帮您迁移到这些现代工具。
