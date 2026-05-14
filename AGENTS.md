# AGENTS.md

This file provides guidance to Codex (Codex.ai/code) when working with code in this repository.

## 这是什么仓库

XCYJ（陈与小金）的 YouTube 教程视频**生产工作台**——基于 HeyGen 的 [HyperFrames](https://hyperframes.heygen.com)（HTML + GSAP 渲染管线）做技术教程的片头、转场、整片演示。

**仓库结构按开源项目规范整理（2026-05-14 重构后）**——顶层扁平，对 GitHub 上想复用方法的人友好。AI 自动读取是次要目标。

## 顶层架构

```
.
├── README.md / CLAUDE.md / AGENTS.md     # 入口
├── LICENSE
├── videos/                                # 9 条已发布视频源工程，每条带 README
├── templates/
│   ├── tutorial-8beat/                    # 唯一从 0 设计的真模板
│   ├── components/                        # 可复用组件（cc-window 等）
│   ├── inspirations/                      # 5 大 React 库的 vanilla 转译版
│   └── catalog.json                       # 模板零件清单（机器可读）
├── skills/
│   ├── cyxj-new-video/                    # 做新视频的全流程 skill
│   └── cyxj-add-block/                    # 装零件 skill
├── docs/
│   ├── REFERENCE_INDEX.md                 # 上游参考工程的索引
│   ├── HARD_CONSTRAINTS.md                # 必读硬约束（8 条）
│   ├── STYLE_BORROW_PLAYBOOK.md           # 借鉴外部视觉的方法论
│   ├── OFFICIAL_DOCS_VALUE_INDEX.md       # 官方文档摘要
│   ├── hyperframes-official/              # 78 页官方文档本地镜像
│   └── lottie-davinci-experiment/         # DaVinci 21 Lottie 兼容性实验
├── assets/
│   └── logos/                             # 33 个常用 AI 厂商 / 工具 SVG logo
├── scripts/                               # 维护脚本（refresh-catalog 等）
├── 2026-MM-DD/                            # 当前视频工作区（按日期建）
├── _待定/                                  # gitignored；整理时不确定的暂存
├── hyperframes-student-kit/               # gitignored 上游
└── hyperframes-launches/                  # gitignored 上游
```

**关键架构区分**：
- `.agents/skills/cyxj-{new-video,add-block}` —— Codex 专用入口，**软链**到 `skills/cyxj-<name>`
- `.claude/skills/cyxj-{new-video,add-block}` —— Claude Code 专用入口，同样**软链**到 `skills/cyxj-<name>`
- `skills/` —— skill 源文件的唯一存放处。改 skill 只改这里
- `videos/` —— 9 条已发布视频的源工程（git 跟踪源码，mp4 gitignored）
- `templates/` —— 真模板 + 组件（**只读参考**，不在这里编辑活工程）
- `2026-MM-DD/<slug>/` —— 当前在做的工作区
- `_待定/` —— 整理过程中暂存的不确定项（**已 gitignore**，不会进开源仓库）

## 标准工作流（一句话开始）

**做新视频**：在仓库根开 Codex，说一句：

> "做个新视频，主题《XXX》，纯演示无录屏"

`/cyxj-new-video` skill 会自动：
1. 问形态/主题/时长
2. 读 `docs/REFERENCE_INDEX.md` 推荐参考工程
3. 复制模板到 `2026-MM-DD/<slug>/`
4. 改 `meta.json` 和 `index.html`
5. 等你提供文案 → 改 beats → lint → preview → render
6. 你说"做完了" → 自动归档到 `videos/<日期>-<slug>/`
7. 主动问"要抽成模板吗？" → 抽 / 不抽

**装零件**：在某个工程目录下说 "加个转场" / "加 macos 通知" / "Logo 落版"，`/cyxj-add-block` 会从 `templates/catalog.json` 推荐 + 安装 + 给引用代码。

## Claude / Codex 边界

| 使用方 | 读哪个指令 | skill 入口 | 软链关系 |
|---|---|---|---|
| Claude Code | `CLAUDE.md` | `.claude/skills/` | cyxj-* 软链 → `skills/` |
| Codex | `AGENTS.md` | `.agents/skills/` | cyxj-* 软链 → `skills/` |

**单一源**：skill 源文件在 `skills/cyxj-{new-video,add-block}/`，两边 AI 都软链到同一份。改 skill 只在 `skills/` 改，不要改软链。

**协作规则**：
- 正在制作的视频工程放在 `2026-MM-DD/<slug>/`，另一个 AI 做审查或基础设施修复时必须先排除这个施工目录
- 公共层（`templates/` / `skills/` / `docs/` / `assets/` / `.gitignore`）改动前先跑 `npx hyperframes lint`

## 必须遵守的硬约束

详见 [`docs/HARD_CONSTRAINTS.md`](docs/HARD_CONSTRAINTS.md)。简表：

1. GSAP querySelector 不能用 template literal
2. 复制 beat html 时全局换 beat id（CSS class + GSAP selector 两处）
3. DaVinci 21 不能渲染含中文文字的手写 Lottie（含文字走 ProRes 4444 alpha）
4. 中文 Whisper transcribe 要绕开 hyperframes CLI（用 `whisper-cli`）
5. `npx hyperframes` 必须在工程目录里跑（不在仓库根）
6. 不要 commit `hyperframes-student-kit/` 或 `hyperframes-launches/`
7. 大视频/音频不进 git（`.mp4 .mov .mp3 .wav .m4a` + `录屏/`）
8. 中文字体在无头 Chromium 渲染时偶发回退（Google Fonts CDN 超时）

## hyperframes CLI 本体在哪

**不在本仓库，也不在 `hyperframes-student-kit/node_modules/`，在 npx 全局缓存里**：

```
~/.npm/_npx/<hash>/node_modules/hyperframes/   (~109M，含 Playwright/ffmpeg-static)
```

- 看版本：`npx hyperframes --version`
- 强制升级：`npx hyperframes@latest --version`
- 完全清掉重来：`rm -rf ~/.npm/_npx`

## 软链架构说明

| 软链 | 指向 | 是否进 git |
|---|---|---|
| `MOTION_PHILOSOPHY.md` | `hyperframes-student-kit/MOTION_PHILOSOPHY.md` | gitignored |
| `.claude/skills/{gsap,hyperframes,...}` (×7) | `hyperframes-student-kit/.claude/skills/<name>` | gitignored |
| `.agents/skills/{gsap,hyperframes,...}` (×7) | `hyperframes-student-kit/.claude/skills/<name>` | gitignored |
| `.claude/skills/cyxj-{new-video,add-block}` | `skills/cyxj-<name>` | ✅ 进 git |
| `.agents/skills/cyxj-{new-video,add-block}` | `skills/cyxj-<name>` | ✅ 进 git |

跨机器 clone 仓库后需要重新拉 `hyperframes-student-kit/` 和 `hyperframes-launches/` 才能让上游软链生效。

## 中文环境注意

- 路径含中文（仓库本身在 `~/项目/参考仓库/hyperframes/`），所有命令注意 UTF-8
- 模板默认字体栈：`"Noto Sans SC", "Inter", sans-serif`（中文 hero 字偏 Noto）；`JetBrains Mono` 用于终端/代码片段
- headless Chromium 渲染时 Google Fonts CDN 偶尔超时会回退系统字体——重渲一次或本地化字体

## 维护节奏

| 周期 | 命令 |
|---|---|
| 每月 | `bash scripts/refresh-catalog.sh` 刷新 `templates/catalog.json` |
| 每 1-2 月 | `bash scripts/refresh-docs.sh` 刷新 `docs/hyperframes-official/` 官方文档镜像 |
| 每 1-2 月 | `cd hyperframes-student-kit && git pull && cd ../hyperframes-launches && git pull` |
| 每条新视频做完 | 让 `/cyxj-new-video` 阶段 B 自动归档进 `videos/` + 询问是否抽模板 |

## 仓库速查

| 路径 | 内容 |
|---|---|
| `docs/REFERENCE_INDEX.md` | ⭐ 上游参考工程入口：18 工程 + 46 catalog 零件 + 9 skill 索引 |
| `assets/logos/` | ⭐ 33 个 AI 厂商 / 工具 SVG logo |
| `templates/tutorial-8beat/` | 8 beat 教程结构 —— **当前唯一从 0 设计的真模板** |
| `templates/components/cc-window/` | Claude Code 终端 UI 零件（19-tips 沉淀） |
| `templates/inspirations/` | 5 大 React 组件库的 vanilla 转译版（晋级前的灵感区） |
| `videos/2026-05-04-claude-19-tips/` | 最大工程参考：28 composition / 7.5 分钟 |
| `videos/2026-05-02-codex-claude-intro/` | 含 SCRIPT.md 范本 |
| `videos/2026-05-09-mywebsite-teaser/` | DESIGN-first 工作流范本 |
| `TEMPLATE_USAGE.md` | 模板复用 checklist |
| `MOTION_PHILOSOPHY.md` | Nate 的动效美学 10 法则（gitignored 软链）|
