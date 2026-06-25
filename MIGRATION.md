# 项目迁移记录

## 迁移信息
- **迁移时间**: 2026-06-25 15:40
- **原位置**: `/home/ubuntu/.local/opt/codex-web-trial/repo/`
- **新位置**: `/home/ubuntu/workspace/codex-web/`
- **备份位置**: `/home/ubuntu/.local/opt/codex-web-backup-20260625-154015.tar.gz`

## 迁移原因
原目录位于临时路径 (`~/.local/opt/codex-web-trial/`)，可能被误认为是临时文件或试用版本。
迁移到 workspace 目录便于长期维护和管理。

## 迁移内容
✅ 完整的 Git 仓库（包含所有历史提交）
✅ 所有源代码文件
✅ 14个自定义补丁文件
✅ 构建脚本和配置文件
✅ 本地修改（模型选择器优化等）

## 原目录处理
⚠️ **原目录已删除**，仅保留压缩备份：
- 备份文件: `codex-web-backup-20260625-154015.tar.gz`
- 备份大小: 187MB
- 备份位置: `/home/ubuntu/.local/opt/`

如需恢复原目录：
```bash
cd /home/ubuntu/.local/opt
tar -xzf codex-web-backup-20260625-154015.tar.gz
```

## Git 状态
- **当前分支**: `main`
- **本地提交**: 
  - `eafc5ae`: fix: show Codex catalog models in web selector
  - `8eaa937`: patch out the codex_app_sunset feature flag (#18)
- **远程配置**:
  - `upstream`: https://github.com/0xcaff/codex-web.git (原始仓库)
  - `origin`: 未设置（可添加个人远程仓库）

## 验证步骤
1. 检查项目完整性: `git status` 和 `git log --oneline`
2. 验证补丁文件: `ls -la patches/`
3. 确认构建配置: `cat package.json`

## 注意事项
1. 所有 AI 助手/Agent 应使用此新位置
2. 原目录已被删除，避免误操作
3. 备份文件保留30天，之后可安全删除
4. 如需回滚，从备份恢复即可
