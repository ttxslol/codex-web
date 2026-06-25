# Codex-Web 快速开始指南

## 项目位置
`/home/ubuntu/workspace/codex-web`

## 项目状态
✅ 已从临时目录成功迁移
✅ Git 历史完整（包含本地修改）
✅ 所有补丁文件已保留
✅ 配置文件已更新

## 主要功能
这是一个基于官方 codex-web 的自定义分支，包含以下修改：
1. **模型选择器优化** - 显示 Codex catalog 模型
2. **Sentry 禁用** - 移除监控
3. **CSP 限制移除** - 更灵活的内容安全策略
4. **自托管优化** - 针对自托管环境配置

## 常用命令

### 安装依赖
```bash
npm install
```

### 开发构建
```bash
npm run build:browser    # 构建前端
npm run build:server     # 构建服务器
```

### 完整构建
```bash
npm run build
```

### 开发服务器
```bash
npm run launch:unpacked:server  # 启动本地服务器 (端口 5175)
```

### 检查 Git 状态
```bash
git status
git log --oneline -5     # 查看最近提交
```

## 项目结构
```
├── src/                 # 源代码
│   ├── browser/        # 前端代码
│   └── server/         # 服务器代码
├── patches/            # 自定义补丁
├── scripts/            # 构建脚本
├── sentry/             # Sentry 配置
└── assets/             # 静态资源
```

## 与上游同步
```bash
# 拉取上游更新
git fetch upstream

# 合并到当前分支
git merge upstream/main

# 解决冲突后重新应用补丁
```

## 注意事项
1. 构建产物在 `scratch/` 目录（已被 .gitignore 排除）
2. 日志文件为 `*.log` 和 `*.pid`（已被 .gitignore 排除）
3. TypeScript 编译产物为 `*.js` 和 `*.d.ts`（已被 .gitignore 排除）

## 原目录位置
`/home/ubuntu/.local/opt/codex-web-trial/repo/`（已创建 MIGRATED.md 指路文件）
