# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 这是什么仓库

XCYJ（陈与小金）的 YouTube 教程视频**生产工作台**——基于 HeyGen 的 [HyperFrames](https://hyperframes.heygen.com)（HTML + GSAP 渲染管线）做技术教程的片头、转场、整片演示。

## 顶层架构（2026-05 重构后）

仓库根 = 一站式工作台。在仓库根开 Claude Code，所有 9 个 skill、18 个参考工程、46 个 catalog 零件都直接可用。

```
~/项目/参考仓库/hyperframes/
├── .claude/skills/                       # 9 个 skill（7 软链 + 2 自写）
├── MOTION_PHILOSOPHY.md                  # 软链 → student-kit 的美学准则
├── templates/                            # 1 个真模板（tutorial-8beat）+ components 零件（cc-window / xcyj-tokens）
├── 参考库/
│   ├── INDEX.md                          # ⭐ 入口索引（每次做新视频先扫这里）
│   ├── catalog.json                      # 46 个 catalog 零件 metadata
│   ├── nate-demos/                       # 软链 12 个 Nate 工程
│   ├── heygen-launches/                  # 软链 3 个 HeyGen 官方工程
│   └── 我的作品/                          # 真存的 3 个旧项目（按日期前缀命名）
├── scripts/
│   ├── refresh-catalog.sh                # 刷新 catalog.json
│   └── refresh-docs.sh                   # 刷新 docs/hyperframes-official/ 官方文档镜像
├── 2026-MM-DD/                           # 新视频按日期建工作区
├── docs/
│   ├── hyperframes-official/             # 78 页官方文档本地镜像（mintlify .md 全集）
│   └── lottie-davinci-experiment/        # 自建实验记录
├── hyperframes-student-kit/              # 上游 (gitignored，可 git pull 跟进)
└── hyperframes-launches/                 # 上游 (gitignored，可 git pull 跟进)
```

**关键架构区分**：
- `templates/` —— git 跟踪的精简骨架（**只读参考**，不在这里编辑活工程）
- `参考库/我的作品/` —— git 跟踪的你的旧作品（含 final.mp4 但 mp4 gitignored）
- `参考库/nate-demos/` 和 `参考库/heygen-launches/` —— **软链**指向 gitignored 的上游，所以本身也 gitignored
- `2026-MM-DD/<slug>/` —— 当前在做的工作区（git 跟踪源工程，mp4 gitignored）
- `hyperframes-student-kit/` 和 `hyperframes-launches/` —— **gitignored**，是 Nate 和 HeyGen 的独立 git 仓库，需要时 `git pull` 更新

## 标准工作流（一句话开始）

**做新视频**：在仓库根开 Claude Code，说一句：

> "做个新视频，主题《XXX》，纯演示无录屏"

`/cyxj-new-video` skill 会自动：
1. 问形态/主题/时长
2. 读 `参考库/INDEX.md` 推荐参考工程
3. 复制模板到 `2026-MM-DD/<slug>/`
4. 改 `meta.json` 和 `index.html`
5. 等你提供文案 → 改 beats → lint → preview → render
6. 你说"做完了" → 自动归档到 `参考库/我的作品/<日期>-<slug>/`
7. 主动问"要抽成模板吗？" → 抽 / 不抽

**装零件**：在某个工程目录下说 "加个转场" / "加 macos 通知" / "Logo 落版"，`/cyxj-add-block` 会从 catalog 推荐 + 安装 + 给引用代码。

## Claude / Codex 边界

这两个 AI 可以共用同一个视频工作台，但边界必须按目录和指令文件分开：

| 使用方 | 读哪个指令 | skill 入口 | 负责什么 |
|---|---|---|---|
| Claude Code | `CLAUDE.md` | `.claude/skills/` | 继续按原流程制作视频、归档、抽模板 |
| Codex | `AGENTS.md` | `.agents/skills/` | 用同一套工作流制作视频、审查仓库、修模板/文档/边界 |

协作规则：
- 不要改 `.agents/skills/` 的 Codex 专属措辞，除非明确是在同步两边 SOP
- Codex 也不应该改 `.claude/skills/` 的 Claude 专属措辞，除非同步 SOP
- 正在制作的视频工程放在 `2026-MM-DD/<slug>/`，另一个 AI 做审查或基础设施修复时必须先排除这个施工目录
- 公共模板、参考库、README、INDEX、`.gitignore` 是共享层；修改共享层前先跑对应模板的 `npx hyperframes lint` 和必要的 `npx hyperframes inspect`

## 必须遵守的硬约束

详见 [`docs/HARD_CONSTRAINTS.md`](docs/HARD_CONSTRAINTS.md)（单源）。简表：

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

机制：第一次跑 `npx hyperframes <cmd>` 时，npx 从 npm registry 下载 `hyperframes` 包到 `~/.npm/_npx/<参数指纹>/`，之后命中缓存。所以工程的 `package.json` 里**不需要**也**不应该**列 `hyperframes` 依赖。

- 看版本：`npx hyperframes --version`
- 强制升级：`npx hyperframes@latest --version`
- 完全清掉重来：`rm -rf ~/.npm/_npx`

## 软链架构说明

仓库根的这些**都是软链**（指向 gitignored 上游，本身也 gitignored）：

| 软链 | 指向 |
|---|---|
| `MOTION_PHILOSOPHY.md` | `hyperframes-student-kit/MOTION_PHILOSOPHY.md` |
| `.claude/skills/{gsap,hyperframes,...}` (×7) | `hyperframes-student-kit/.claude/skills/<name>` |
| `参考库/nate-demos/<name>` (×12) | `hyperframes-student-kit/video-projects/<name>` |
| `参考库/heygen-launches/<name>` (×3) | `hyperframes-launches/<name>` |

**好处**：上游 `git pull` 自动跟进，不用手动同步。
**代价**：跨机器 clone 仓库后需要重新拉 student-kit 和 launches 才能让软链生效。

## 中文环境注意

- 路径含中文（仓库本身在 `~/项目/参考仓库/hyperframes/`），所有命令注意 UTF-8
- 模板默认字体栈：`"Noto Sans SC", "Inter", sans-serif`（中文 hero 字偏 Noto）；`JetBrains Mono` 用于终端/代码片段
- headless Chromium 渲染时 Google Fonts CDN 偶尔超时会回退系统字体——重渲一次或本地化字体

## 维护节奏

| 周期 | 命令 |
|---|---|
| 每月 | `bash scripts/refresh-catalog.sh` 刷新 `参考库/catalog.json` |
| 每 1-2 月 | `bash scripts/refresh-docs.sh` 刷新 `docs/hyperframes-official/` 官方文档镜像（动态读 llms.txt，自动跟进新增页面） |
| 每 1-2 月 | `cd hyperframes-student-kit && git pull && cd ../hyperframes-launches && git pull` |
| 每条新视频做完 | 让 `/cyxj-new-video` 阶段 B 自动归档 + 询问是否抽模板 |

## 仓库速查

| 路径 | 内容 |
|---|---|
| `参考库/INDEX.md` | ⭐ 一切入口：18 工程 + 46 catalog 零件 + 9 skill 索引 |
| `templates/tutorial-8beat/` | 8 beat 教程结构（hook→pain→punchline→concept→flow→outro）—— **当前唯一从 0 设计的真模板** |
| `templates/components/cc-window/` | Claude Code 终端 UI 零件（19-tips 沉淀） |
| `参考库/历史模板/` | 3 个伪模板档案（demo-fullscreen / host-overlay / host-overlay-alpha）—— ⚠️ **不要 cp 起步**，仅供回查旧形态 |
| `TEMPLATE_USAGE.md` | 模板复用 checklist |
| `MOTION_PHILOSOPHY.md` | Nate 的动效美学 10 法则 + Infinite 拆解 |
| `examples/codex-intro/script.md` | Codex × Claude Code 教程实际配音文案 |
| `docs/lottie-davinci-experiment/` | DaVinci 21 Lottie 兼容性实验记录 |

> ⚠️ **2026-05-07 模板状态**：原 `templates/host-overlay/`、`templates/host-overlay-alpha/`、`templates/demo-fullscreen/` 已移到 `参考库/历史模板/`（commit P1.1）。当前 `templates/` 下只有 `tutorial-8beat/` 是从 0 设计的真模板。非教程形态请从 0 写工程，不要 cp 历史模板起步。详见 [`参考库/历史模板/README.md`](参考库/历史模板/README.md)。
