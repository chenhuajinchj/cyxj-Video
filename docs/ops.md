# Ops —— CLI 位置 / 维护节奏 / 仓库速查

从 CLAUDE.md 外移过来的低频信息。AI 不需要每次会话加载，需要时来这里查。

## hyperframes CLI 本体在哪

不在本仓库，也不在 `hyperframes-student-kit/node_modules/`，在 npx 全局缓存里：

```
~/.npm/_npx/<hash>/node_modules/hyperframes/   (~109M，含 Playwright/ffmpeg-static)
```

- 看版本：`npx hyperframes --version`
- 强制升级：`npx hyperframes@latest --version`
- 完全清掉重来：`rm -rf ~/.npm/_npx`

## 软链全表

| 软链 | 指向 | 是否进 git |
|---|---|---|
| `MOTION_PHILOSOPHY.md` | `hyperframes-student-kit/MOTION_PHILOSOPHY.md` | gitignored |
| `.claude/skills/{gsap,hyperframes,...}` (×7) | `hyperframes-student-kit/.claude/skills/<name>` | gitignored |
| `.agents/skills/{gsap,hyperframes,...}` (×7) | `hyperframes-student-kit/.claude/skills/<name>` | gitignored |
| `.claude/skills/cyxj-{new-video,add-block}` | `skills/cyxj-<name>` | ✅ 进 git |
| `.agents/skills/cyxj-{new-video,add-block}` | `skills/cyxj-<name>` | ✅ 进 git |

## 维护节奏

| 周期 | 命令 |
|---|---|
| 每月 | `bash scripts/refresh-catalog.sh` 刷新 `templates/catalog.json` |
| 每 1-2 月 | `bash scripts/refresh-docs.sh` 刷新 `docs/hyperframes-official/` 官方文档镜像 |
| 每 1-2 月 | `cd hyperframes-student-kit && git pull && cd ../hyperframes-launches && git pull` |
| 每条新视频做完 | 让 `/cyxj-new-video` 阶段 B 自动归档进 `videos/` + 询问是否抽模板 |

## 仓库速查（CLAUDE.md 外移）

| 路径 | 内容 |
|---|---|
| `docs/REFERENCE_INDEX.md` | ⭐ 上游参考工程入口：18 工程 + 46 catalog 零件 + 9 skill 索引 |
| `assets/logos/` | ⭐ 33 个 AI 厂商 / 工具 SVG logo |
| `templates/tutorial-8beat/` | 8 beat 教程结构 —— 当前唯一从 0 设计的真模板 |
| `templates/components/cc-window/` | Claude Code 终端 UI 零件（19-tips 沉淀） |
| `templates/inspirations/` | 5 大 React 组件库的 vanilla 转译版 |
| `videos/2026-05-04-claude-19-tips/` | 最大工程参考：28 composition / 7.5 分钟 |
| `videos/2026-05-02-codex-claude-intro/` | 含 SCRIPT.md 范本 |
| `videos/2026-05-09-mywebsite-teaser/` | DESIGN-first 工作流范本 |
| `TEMPLATE_USAGE.md` | 模板复用 checklist |
| `MOTION_PHILOSOPHY.md` | Nate 的动效美学 10 法则（gitignored 软链）|

## 标准工作流详细

短描述：
- **做新视频** → 在仓库根开 Claude Code，说「做个新视频，主题《XXX》」，`/cyxj-new-video` skill 自动接管全流程（建工程 → 推参考 → 改文案 → lint → preview → render → 归档 → 抽模板）
- **装零件** → 工程目录里说「加个转场 / 加 macos 通知 / Logo 落版」，`/cyxj-add-block` 从 catalog 推荐 + 安装 + 给引用代码

完整流程见 [`../skills/cyxj-new-video/SKILL.md`](../skills/cyxj-new-video/SKILL.md) 和 [`../skills/cyxj-add-block/SKILL.md`](../skills/cyxj-add-block/SKILL.md)。
