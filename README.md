# 只为记账 - 用户文档

<p align="center">
  <img src="https://img.shields.io/badge/Version-1.8.x-blue" alt="Version">
  <img src="https://img.shields.io/badge/Platform-Web%20%7C%20iOS%20%7C%20Android-green" alt="Platform">
  <img src="https://img.shields.io/badge/License-MIT-yellow" alt="License">
</p>

<p align="center">
  <strong>智能家庭记账应用 - 让记账变得简单高效</strong>
</p>

<p align="center">
  只为记账是一款现代化的家庭记账应用，支持多平台使用，提供AI智能记账、家庭共享、数据分析等功能。
</p>

---

## 📖 文档目录

### 🚀 [产品介绍](product/overview.md)
- [产品概述](product/overview.md) - 了解只为记账的核心理念
- [核心功能](product/features.md) - 探索强大的功能特性
- [技术架构](product/architecture.md) - 深入了解技术实现
- [版本历史](product/changelog.md) - 查看更新日志

### 🛠️ [部署文档](deployment/overview.md)
- [Docker部署](deployment/docker.md) - 快速容器化部署
- [开发环境部署](deployment/development.md) - 本地开发环境搭建
- [NAS平台部署](deployment/nas/README.md) - 支持多种NAS平台
- [环境配置](deployment/configuration.md) - 详细配置说明

### 📱 [用户手册](user-guide/quick-start.md)
- [快速开始](user-guide/quick-start.md) - 5分钟上手指南
- [记账操作](user-guide/accounting/README.md) - 基础记账功能
- [家庭记账](user-guide/family/README.md) - 多人协作记账
- [AI智能功能](user-guide/ai/README.md) - 语音和图片识别
- [移动端使用](user-guide/mobile/README.md) - iOS/Android应用

## ✨ 核心特性

### 🎯 智能记账
- **语音记账**: 说话即可记录，AI自动识别金额和分类
- **图片识别**: 拍照小票自动提取交易信息
- **智能分类**: AI学习用户习惯，自动推荐分类

### 👨‍👩‍👧‍👦 家庭共享
- **多成员管理**: 支持家庭成员共同记账
- **权限控制**: 灵活的权限设置，保护隐私
- **实时同步**: 数据实时同步，随时查看家庭财务状况

### 📊 数据分析
- **可视化图表**: 直观的收支趋势和分类分析
- **预算管理**: 设置预算目标，实时监控执行情况
- **报表导出**: 支持多种格式的数据导出

### 🔒 安全可靠
- **本地部署**: 数据完全掌控在自己手中
- **加密存储**: 敏感数据加密保护
- **备份恢复**: 完善的数据备份和恢复机制

## 🚀 快速开始

### 方式一：Docker部署（推荐）
```bash
# 克隆项目
git clone https://github.com/your-username/zhiweijz.git
cd zhiweijz

# 启动服务
docker-compose up -d
```

### 方式二：本地开发
```bash
# 安装依赖
npm install

# 启动后端服务
npm run start:server

# 启动前端服务
npm run start:web
```

访问 `http://localhost:3001` 开始使用！

## 📋 系统要求

### 最低配置
- **CPU**: 1核心
- **内存**: 512MB
- **存储**: 1GB可用空间
- **网络**: 支持HTTP/HTTPS访问

### 推荐配置
- **CPU**: 2核心或以上
- **内存**: 2GB或以上
- **存储**: 10GB可用空间
- **数据库**: PostgreSQL 12+

## 🌟 支持的平台

### 💻 Web端
- 现代浏览器支持（Chrome、Firefox、Safari、Edge）
- 响应式设计，支持桌面和移动端访问
- PWA支持，可安装到桌面

### 📱 移动端
- **iOS**: 支持iOS 12+，通过App Store下载
- **Android**: 支持Android 8+，提供APK直接安装
- **快捷指令**: iOS快捷指令集成，一键记账

### 🏠 NAS平台
- 群晖 Synology DSM 6.0+
- 威联通 QNAP QTS 4.0+
- 绿联 UGREEN
- 极空间 Zspace
- 铁威马 TerraMaster

## 📞 获取帮助

### 📚 文档资源
- [用户手册](user-guide/quick-start.md) - 详细的使用说明
- [部署指南](deployment/overview.md) - 完整的部署文档
- [常见问题](faq/general.md) - 常见问题解答

### 💬 社区支持
- [GitHub Issues](https://github.com/your-username/zhiweijz/issues) - 问题反馈
- [讨论区](https://github.com/your-username/zhiweijz/discussions) - 功能讨论
- QQ群: 123456789 - 用户交流群

## 🔄 更新日志

### v1.8.x (最新)
- ✨ 新增AI语音记账功能
- 🔧 优化移动端用户体验
- 🐛 修复iOS边缘滑动手势问题
- 📊 增强数据分析功能

### v1.7.x
- 🏠 完善家庭记账功能
- 💰 新增预算管理模块
- 📱 发布移动端应用
- 🔐 增强安全性

[查看完整更新日志](product/changelog.md)

## 📄 许可证

本项目采用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情。

## 🙏 致谢

感谢以下开源项目的支持：

- [Next.js](https://nextjs.org/) - React框架
- [Prisma](https://prisma.io/) - 数据库ORM
- [Tailwind CSS](https://tailwindcss.com/) - CSS框架
- [React Native](https://reactnative.dev/) - 移动端框架

---

<p align="center">
  <strong>让记账变得简单高效 ✨</strong>
</p>

<p align="center">
  如果这个项目对您有帮助，请给我们一个 ⭐️
</p>
