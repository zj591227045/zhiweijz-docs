# Docker部署指南

## 前置要求

### 系统要求
- **操作系统**: Linux、Windows、macOS
- **内存**: 至少512MB，推荐2GB+
- **存储**: 至少1GB可用空间，推荐10GB+
- **网络**: 稳定的网络连接

### 软件要求
- **Docker**: 20.10或更高版本
- **Docker Compose**: 2.0或更高版本

### 安装Docker

#### Ubuntu/Debian
```bash
# 更新包索引
sudo apt update

# 安装必要的包
sudo apt install apt-transport-https ca-certificates curl gnupg lsb-release

# 添加Docker官方GPG密钥
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# 添加Docker仓库
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# 安装Docker
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin
```

#### CentOS/RHEL
```bash
# 安装必要的包
sudo yum install -y yum-utils

# 添加Docker仓库
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# 安装Docker
sudo yum install docker-ce docker-ce-cli containerd.io docker-compose-plugin

# 启动Docker服务
sudo systemctl start docker
sudo systemctl enable docker
```

#### Windows/macOS
下载并安装 [Docker Desktop](https://www.docker.com/products/docker-desktop/)

## 快速部署

### 1. 下载项目文件

```bash
# 克隆项目
git clone https://github.com/your-username/zhiweijz.git
cd zhiweijz

# 或者直接下载docker-compose.yml文件
wget https://raw.githubusercontent.com/your-username/zhiweijz/main/docker-compose.yml
```

### 2. 配置环境变量

创建 `.env` 文件：

```bash
# 复制环境变量模板
cp .env.example .env

# 编辑环境变量
nano .env
```

基本配置示例：
```env
# 数据库配置
POSTGRES_DB=zhiweijz
POSTGRES_USER=zhiweijz
POSTGRES_PASSWORD=your_secure_password

# 应用配置
NODE_ENV=production
JWT_SECRET=your_jwt_secret_key
API_BASE_URL=http://localhost:3000

# 端口配置
WEB_PORT=3001
API_PORT=3000
DB_PORT=5432

# 数据目录
DATA_DIR=./data
LOGS_DIR=./logs
UPLOADS_DIR=./uploads
```

### 3. 启动服务

```bash
# 启动所有服务
docker-compose up -d

# 查看服务状态
docker-compose ps

# 查看日志
docker-compose logs -f
```

### 4. 初始化数据库

```bash
# 运行数据库迁移
docker-compose exec api npm run migrate

# 创建初始管理员用户（可选）
docker-compose exec api npm run seed
```

### 5. 访问应用

打开浏览器访问：
- **Web界面**: http://localhost:3001
- **API文档**: http://localhost:3000/docs

## 详细配置

### Docker Compose配置

完整的 `docker-compose.yml` 示例：

```yaml
version: '3.8'

services:
  # 数据库服务
  postgres:
    image: postgres:15-alpine
    container_name: zhiweijz-db
    environment:
      POSTGRES_DB: ${POSTGRES_DB}
      POSTGRES_USER: ${POSTGRES_USER}
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD}
    volumes:
      - postgres_data:/var/lib/postgresql/data
      - ./backups:/backups
    ports:
      - "${DB_PORT}:5432"
    restart: unless-stopped
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U ${POSTGRES_USER} -d ${POSTGRES_DB}"]
      interval: 30s
      timeout: 10s
      retries: 3

  # Redis缓存（可选）
  redis:
    image: redis:7-alpine
    container_name: zhiweijz-redis
    volumes:
      - redis_data:/data
    ports:
      - "6379:6379"
    restart: unless-stopped
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
      interval: 30s
      timeout: 10s
      retries: 3

  # 后端API服务
  api:
    image: zhiweijz/api:latest
    container_name: zhiweijz-api
    environment:
      NODE_ENV: ${NODE_ENV}
      DATABASE_URL: postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@postgres:5432/${POSTGRES_DB}
      REDIS_URL: redis://redis:6379
      JWT_SECRET: ${JWT_SECRET}
    volumes:
      - ${UPLOADS_DIR}:/app/uploads
      - ${LOGS_DIR}:/app/logs
    ports:
      - "${API_PORT}:3000"
    depends_on:
      postgres:
        condition: service_healthy
      redis:
        condition: service_healthy
    restart: unless-stopped
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:3000/health"]
      interval: 30s
      timeout: 10s
      retries: 3

  # 前端Web服务
  web:
    image: zhiweijz/web:latest
    container_name: zhiweijz-web
    environment:
      NEXT_PUBLIC_API_URL: ${API_BASE_URL}
    ports:
      - "${WEB_PORT}:3000"
    depends_on:
      api:
        condition: service_healthy
    restart: unless-stopped
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:3000"]
      interval: 30s
      timeout: 10s
      retries: 3

volumes:
  postgres_data:
  redis_data:

networks:
  default:
    name: zhiweijz-network
```

### 环境变量详解

#### 数据库配置
```env
# PostgreSQL数据库名称
POSTGRES_DB=zhiweijz

# 数据库用户名
POSTGRES_USER=zhiweijz

# 数据库密码（请使用强密码）
POSTGRES_PASSWORD=your_secure_password_here

# 数据库连接URL
DATABASE_URL=postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@postgres:5432/${POSTGRES_DB}
```

#### 应用配置
```env
# 运行环境
NODE_ENV=production

# JWT密钥（用于用户认证）
JWT_SECRET=your_jwt_secret_key_here

# API基础URL
API_BASE_URL=http://localhost:3000

# 文件上传限制（MB）
MAX_FILE_SIZE=10

# 会话过期时间（小时）
SESSION_TIMEOUT=24
```

#### 端口配置
```env
# Web前端端口
WEB_PORT=3001

# API后端端口
API_PORT=3000

# 数据库端口
DB_PORT=5432

# Redis端口
REDIS_PORT=6379
```

## 数据管理

### 数据持久化

Docker容器默认将数据存储在以下位置：
- **数据库数据**: Docker volume `postgres_data`
- **上传文件**: `./uploads` 目录
- **日志文件**: `./logs` 目录
- **备份文件**: `./backups` 目录

### 备份数据

#### 自动备份脚本
```bash
#!/bin/bash
# backup.sh

BACKUP_DIR="./backups"
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="zhiweijz_backup_${DATE}.sql"

# 创建备份目录
mkdir -p ${BACKUP_DIR}

# 备份数据库
docker-compose exec -T postgres pg_dump -U zhiweijz zhiweijz > ${BACKUP_DIR}/${BACKUP_FILE}

# 压缩备份文件
gzip ${BACKUP_DIR}/${BACKUP_FILE}

# 删除7天前的备份
find ${BACKUP_DIR} -name "*.gz" -mtime +7 -delete

echo "备份完成: ${BACKUP_FILE}.gz"
```

#### 手动备份
```bash
# 备份数据库
docker-compose exec postgres pg_dump -U zhiweijz zhiweijz > backup.sql

# 备份上传文件
tar -czf uploads_backup.tar.gz uploads/
```

### 恢复数据

```bash
# 恢复数据库
docker-compose exec -T postgres psql -U zhiweijz -d zhiweijz < backup.sql

# 恢复上传文件
tar -xzf uploads_backup.tar.gz
```

## 更新升级

### 更新到最新版本

```bash
# 拉取最新镜像
docker-compose pull

# 停止服务
docker-compose down

# 备份数据（重要！）
./backup.sh

# 启动新版本
docker-compose up -d

# 运行数据库迁移（如果需要）
docker-compose exec api npm run migrate
```

### 回滚到之前版本

```bash
# 停止服务
docker-compose down

# 恢复数据备份
docker-compose exec -T postgres psql -U zhiweijz -d zhiweijz < backups/backup.sql

# 使用指定版本的镜像
docker-compose up -d
```

## 故障排除

### 常见问题

#### 1. 端口被占用
```bash
# 检查端口占用
netstat -tlnp | grep :3001

# 修改端口配置
# 编辑 .env 文件中的 WEB_PORT 和 API_PORT
```

#### 2. 数据库连接失败
```bash
# 检查数据库服务状态
docker-compose ps postgres

# 查看数据库日志
docker-compose logs postgres

# 重启数据库服务
docker-compose restart postgres
```

#### 3. 内存不足
```bash
# 检查内存使用
docker stats

# 增加交换空间
sudo fallocate -l 2G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
```

### 日志查看

```bash
# 查看所有服务日志
docker-compose logs

# 查看特定服务日志
docker-compose logs api
docker-compose logs web
docker-compose logs postgres

# 实时查看日志
docker-compose logs -f
```

### 性能优化

#### 数据库优化
```bash
# 进入数据库容器
docker-compose exec postgres psql -U zhiweijz -d zhiweijz

# 分析查询性能
EXPLAIN ANALYZE SELECT * FROM transactions;

# 重建索引
REINDEX DATABASE zhiweijz;
```

#### 容器资源限制
```yaml
# 在docker-compose.yml中添加资源限制
services:
  api:
    deploy:
      resources:
        limits:
          memory: 512M
          cpus: '0.5'
        reservations:
          memory: 256M
          cpus: '0.25'
```

---

## 下一步

部署完成后，您可以：

1. 📖 [配置系统设置](configuration.md)
2. 👤 [创建用户账户](../user-guide/quick-start.md)
3. 📱 [下载移动端应用](../user-guide/mobile/README.md)
4. 🔧 [查看故障排除指南](troubleshooting.md)

> 💡 **提示**: 建议定期备份数据，并关注项目更新以获得最新功能和安全修复。
