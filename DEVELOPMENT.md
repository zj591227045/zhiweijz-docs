# 文档开发指南

本文档使用GitBook构建，为只为记账项目提供完整的用户文档。

## 🚀 快速开始

### 环境要求

- Node.js 14+
- npm 或 yarn
- Git

### 安装依赖

```bash
# 使用部署脚本安装（推荐）
./deploy.sh install

# 或手动安装
npm install -g gitbook-cli
npm install
gitbook install
```

### 本地预览

```bash
# 启动本地服务器
./deploy.sh serve

# 或手动启动
gitbook serve
```

访问 http://localhost:4000 查看文档。

### 构建文档

```bash
# 构建静态文件
./deploy.sh build

# 或手动构建
gitbook build
```

构建后的文件在 `_book` 目录中。

## 📁 项目结构

```
user-docs/
├── README.md                 # 文档首页
├── SUMMARY.md               # 文档目录结构
├── book.json                # GitBook配置
├── package.json             # 项目配置
├── deploy.sh                # 部署脚本
├── DEVELOPMENT.md           # 开发指南（本文件）
├── assets/                  # 静态资源
│   ├── images/             # 图片文件
│   ├── logo.png            # 项目Logo
│   └── favicon.ico         # 网站图标
├── product/                 # 产品介绍
│   ├── overview.md         # 产品概述
│   ├── features.md         # 核心功能
│   ├── architecture.md     # 技术架构
│   └── changelog.md        # 版本历史
├── deployment/              # 部署文档
│   ├── overview.md         # 部署概述
│   ├── docker.md           # Docker部署
│   ├── development.md      # 开发环境
│   ├── configuration.md    # 环境配置
│   ├── troubleshooting.md  # 故障排除
│   └── nas/                # NAS平台部署
│       ├── README.md       # NAS部署概述
│       ├── synology.md     # 群晖部署
│       ├── qnap.md         # 威联通部署
│       └── ...             # 其他NAS平台
├── user-guide/              # 用户手册
│   ├── quick-start.md      # 快速开始
│   ├── account-management.md # 账户管理
│   ├── accounting/         # 记账操作
│   ├── family/             # 家庭记账
│   ├── statistics/         # 统计分析
│   ├── ai/                 # AI功能
│   ├── data/               # 数据管理
│   ├── mobile/             # 移动端
│   └── settings/           # 设置配置
├── faq/                     # 常见问题
│   ├── general.md          # 一般问题
│   ├── technical.md        # 技术问题
│   └── tips.md             # 使用技巧
└── support/                 # 支持与反馈
    ├── help.md             # 获取帮助
    ├── feedback.md         # 问题反馈
    ├── feature-request.md  # 功能建议
    └── contact.md          # 联系我们
```

## ✍️ 编写文档

### Markdown语法

文档使用标准Markdown语法编写，支持以下扩展：

#### 代码块
```bash
# 带语法高亮的代码块
npm install
```

#### 提示框
> 💡 **提示**: 这是一个提示信息

> ⚠️ **警告**: 这是一个警告信息

> ❌ **错误**: 这是一个错误信息

#### 表格
| 列1 | 列2 | 列3 |
|-----|-----|-----|
| 内容1 | 内容2 | 内容3 |

#### 链接
- 内部链接：[快速开始](user-guide/quick-start.md)
- 外部链接：[GitHub](https://github.com)

#### 图片
```markdown
![图片描述](assets/images/screenshot.png)
```

### 文档规范

#### 文件命名
- 使用小写字母和连字符
- 英文文件名，便于URL访问
- 例如：`quick-start.md`、`docker-deployment.md`

#### 标题层级
```markdown
# 一级标题（页面标题）
## 二级标题（主要章节）
### 三级标题（子章节）
#### 四级标题（详细说明）
```

#### 内容结构
1. **页面开头**：简要说明页面内容
2. **目录导航**：复杂页面提供内部导航
3. **分步说明**：操作步骤清晰明确
4. **代码示例**：提供完整可执行的示例
5. **注意事项**：重要信息用提示框突出
6. **相关链接**：页面末尾提供相关页面链接

## 🔧 配置说明

### book.json配置

主要配置项说明：

```json
{
  "title": "文档标题",
  "description": "文档描述",
  "language": "zh-hans",
  "plugins": ["插件列表"],
  "pluginsConfig": {
    "插件配置"
  }
}
```

### 插件说明

- **search**: 搜索功能
- **sharing**: 社交分享
- **copy-code-button**: 代码复制按钮
- **expandable-chapters**: 可折叠章节
- **anchor-navigation-ex**: 锚点导航
- **github**: GitHub链接
- **edit-link**: 编辑链接

## 🚀 部署发布

### GitHub Pages部署

```bash
# 自动部署到GitHub Pages
./deploy.sh deploy
```

### 手动部署

```bash
# 构建文档
gitbook build

# 将_book目录内容部署到web服务器
cp -r _book/* /var/www/html/
```

### 生成PDF

```bash
# 生成PDF文档
./deploy.sh pdf
```

需要先安装Calibre：https://calibre-ebook.com/download

## 🔄 更新流程

### 内容更新

1. 编辑对应的Markdown文件
2. 本地预览确认效果
3. 提交到Git仓库
4. 自动或手动部署

### 结构调整

1. 修改`SUMMARY.md`文件
2. 创建或移动对应的文件
3. 更新内部链接
4. 测试所有链接有效性

### 版本发布

1. 更新版本号
2. 更新changelog
3. 创建Git标签
4. 部署新版本

## 🛠️ 开发工具

### 推荐编辑器

- **VS Code**: 支持Markdown预览和GitBook插件
- **Typora**: 所见即所得的Markdown编辑器
- **Mark Text**: 实时预览的Markdown编辑器

### 有用的VS Code插件

- Markdown All in One
- GitBook Editor
- Markdown Preview Enhanced
- Auto-Open Markdown Preview

### 图片处理

- 截图工具：Snipaste、LightShot
- 图片压缩：TinyPNG、ImageOptim
- 图片编辑：GIMP、Photoshop

## 📝 贡献指南

### 提交规范

```bash
# 提交信息格式
git commit -m "类型: 简短描述

详细描述（可选）"

# 类型说明
feat: 新增功能文档
fix: 修复文档错误
docs: 文档结构调整
style: 格式调整
refactor: 重构文档
```

### Pull Request

1. Fork项目到个人仓库
2. 创建功能分支
3. 编写或修改文档
4. 提交Pull Request
5. 等待审核和合并

## 🐛 问题排查

### 常见问题

1. **GitBook安装失败**
   - 检查Node.js版本
   - 使用npm镜像源
   - 清除npm缓存

2. **插件安装失败**
   - 检查网络连接
   - 更新插件版本
   - 手动安装插件

3. **构建失败**
   - 检查Markdown语法
   - 验证链接有效性
   - 查看错误日志

4. **预览异常**
   - 清除浏览器缓存
   - 重启GitBook服务
   - 检查端口占用

### 获取帮助

- 查看GitBook官方文档
- 搜索相关问题和解决方案
- 在项目Issues中提问

---

## 📞 联系我们

如果您在文档开发过程中遇到问题，可以通过以下方式联系我们：

- 📧 邮箱：docs@your-domain.com
- 💬 GitHub Issues
- 🔗 项目讨论区

感谢您为只为记账文档做出的贡献！
