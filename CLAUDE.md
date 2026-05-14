# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 这是什么仓库

XCYJ（陈与小金）的 YouTube 教程视频**生产工作台**——基于 HeyGen 的 [HyperFrames](https://hyperframes.heygen.com)（HTML + GSAP 渲染管线）做技术教程的片头、转场、整片演示。

**仓库结构按开源项目规范整理（2026-05-14 重构后）**——顶层扁平，对 GitHub 上想复用方法的人友好。AI 自动读取是次要目标。

## 顶层架构

```
.
├── README.md / CLAUDE.md / AGENTS.md     # 入口
├── LICENSE
├── videos/                                # 10 条已发布视频源工程，每条带 README
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
├── 参考库/                                # 上游参考工程二级源
│   ├── heygen-launches/                   # HeyGen 官方落地页参考
│   ├── nate-demos/                        # Nate Herk 演示工程
│   └── 我的作品/                          # 自己旧作截图/源
├── scripts/                               # 维护脚本（refresh-catalog 等）
├── 2026-MM-DD/                            # 当前视频工作区（按日期建，可并存多个）
├── 归档/                                   # 已废弃的旧探索工程（不删，留参考）
├── 网页报错/                               # untracked；网页报错复现临时区
├── remotion-text-effects/                  # untracked；Remotion（非 HyperFrames）文字效果 skill
├── MY_VISUAL_DNA.md                       # gitignored；个人美学宪法
├── MY_MOTION_NOTES.md                     # gitignored；19 招实战沉淀
├── hyperframes-student-kit/               # gitignored 上游
└── hyperframes-launches/                  # gitignored 上游
```

**关键架构区分**：
- `videos/` —— 10 条已发布视频的源工程（git 跟踪源码，mp4 gitignored）
- `templates/` —— 真模板 + 组件（**只读参考**，不在这里编辑活工程）
- `skills/` —— 自写 skill 的真源；`.claude/skills/cyxj-*` 和 `.agents/skills/cyxj-*` 都是软链到这里
- `2026-MM-DD/<slug>/` —— 当前在做的工作区（git 跟踪源工程，mp4 gitignored）；可同时存在多个日期目录
- `归档/` —— 早期没做成型的探索（如 `2026-05-09-探going`），保留参考用，不在这里继续做活
- `参考库/` —— 上游参考工程的二级源，**与 `assets/` 并列**；memory 里出现 `参考库/assets/logos/` 路径就是这里
- `remotion-text-effects/` —— **不同渲染管线**（Remotion / React，非 HyperFrames），是 Codex 用的文字效果 skill；不要把它和 HyperFrames 工程混做

## 标准工作流（一句话开始）

**做新视频**：在仓库根开 Claude Code，说一句：

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

**插 AI 品牌 / 工具 logo**：不要用 emoji 凑数，也不要现去 Google 图片搜。统一从 `assets/logos/` 拿 SVG（33 个常用品牌已固化，覆盖 Claude / Anthropic / OpenAI / Codex / Cursor / GitHub / Gemini / DeepSeek / Grok / Meta / Mistral / Perplexity / MCP / Obsidian 等）。文件名规则：全小写、无分隔符（`claudecode.svg`、`geminicli.svg`）。用法、染色、添加新 logo 见 [`assets/logos/LOGOS.md`](assets/logos/LOGOS.md)。

> 注意：`claude-code-logo.png`（像素拟人头像，memory `feedback_use_claude_logo`）**不在这个库里**，是各视频工程自己保存的，做"Claude 在说话"的拟人形象时仍用它；本库的 `claudecode.svg` 是官方品牌 mark，用于工具栏 / 横向 logo 列。

## Claude / Codex 边界

| 使用方 | 读哪个指令 | skill 入口 | 软链关系 |
|---|---|---|---|
| Claude Code | `CLAUDE.md` | `.claude/skills/` | cyxj-* 软链 → `skills/` |
| Codex | `AGENTS.md` | `.agents/skills/` | cyxj-* 软链 → `skills/` |

**单一源**：skill 源文件在 `skills/cyxj-{new-video,add-block}/`，两边 AI 都软链到同一份。改 skill 就只在 `skills/` 改，不要改软链。

**协作规则**：
- 正在制作的视频工程放在 `2026-MM-DD/<slug>/`，另一个 AI 做审查或基础设施修复时必须先排除这个施工目录
- 公共层（`templates/` / `skills/` / `docs/` / `assets/` / `.gitignore`）改动前先跑 `npx hyperframes lint`

## 常用命令

**工程目录里跑**（不要在仓库根；仓库根没 package.json）：

```bash
npx hyperframes lint                                # 验证 meta.json + html 结构
npx hyperframes preview                             # http://localhost:3002 浏览器打磨
npx hyperframes render --quality standard \
  --format mp4 --output renders/final.mp4           # 渲染（满意了才跑）
```

**仓库根维护**：

```bash
bash scripts/refresh-catalog.sh                     # 刷 templates/catalog.json
bash scripts/refresh-docs.sh                        # 刷 docs/hyperframes-official/ 镜像
bash scripts/lint-projects.sh                       # 批量 lint 所有工程
```

**CLI 版本**：`npx hyperframes --version` / 强制升 `npx hyperframes@latest --version`。

## 必须遵守的硬约束

详见 [`docs/HARD_CONSTRAINTS.md`](docs/HARD_CONSTRAINTS.md)（单源）。简表（§9-§11 略，去单源看完整）：

1. GSAP querySelector 不能用 template literal
2. 复制 beat html 时全局换 beat id（CSS class + GSAP selector 两处）
3. DaVinci 21 不能渲染含中文文字的手写 Lottie（含文字走 ProRes 4444 alpha）
4. 中文 Whisper transcribe 要绕开 hyperframes CLI（用 `whisper-cli`）
5. `npx hyperframes` 必须在工程目录里跑（不在仓库根）
6. 不要 commit `hyperframes-student-kit/` 或 `hyperframes-launches/`
7. 大视频/音频不进 git（靠 `.gitignore` 里 `*.mp4 *.mov *.webm *.mp3 *.wav *.m4a *.srt` 通配；`录屏/` 这种目录就靠后缀通配生效，没显式 ignore 行）
8. 中文字体在无头 Chromium 渲染时偶发回退（Google Fonts CDN 超时）
12. 视觉 = 语义扩展联想，不是字幕翻译（口播关键词不能直接翻成 HTML 元素，要做 metaphor；色块占位临时可，但 PLAN.md 必须标 TODO）

## hyperframes CLI 本体在哪

**不在本仓库，也不在 `hyperframes-student-kit/node_modules/`，在 npx 全局缓存里**：

```
~/.npm/_npx/<hash>/node_modules/hyperframes/   (~109M，含 Playwright/ffmpeg-static)
```

- 看版本：`npx hyperframes --version`
- 强制升级：`npx hyperframes@latest --version`
- 完全清掉重来：`rm -rf ~/.npm/_npx`

## 软链架构说明

**所有软链**（gitignored 目标 → 软链本身也 gitignored；除 `.claude/skills/cyxj-*` 和 `.agents/skills/cyxj-*` 进 git）：

| 软链 | 指向 | 是否进 git |
|---|---|---|
| `MOTION_PHILOSOPHY.md` | `hyperframes-student-kit/MOTION_PHILOSOPHY.md` | gitignored |
| `.claude/skills/{gsap,hyperframes,...}` (×7) | `hyperframes-student-kit/.claude/skills/<name>` | gitignored |
| `.agents/skills/{gsap,hyperframes,...}` (×7) | `hyperframes-student-kit/.claude/skills/<name>` | gitignored |
| `.claude/skills/cyxj-{new-video,add-block}` | `skills/cyxj-<name>` | ✅ 进 git |
| `.agents/skills/cyxj-{new-video,add-block}` | `skills/cyxj-<name>` | ✅ 进 git |

跨机器 clone 仓库后需要重新拉 `hyperframes-student-kit/` 和 `hyperframes-launches/` 才能让上游软链生效。

## 个人笔记（gitignored）

- `MY_VISUAL_DNA.md` —— 我的个人美学宪法（颜色 / 字体 / 节奏的具体选择）
- `MY_MOTION_NOTES.md` —— 19 招实战沉淀的动效与工程笔记

这两份是私人 notes，不进开源仓库。AI 仍可读，但不要在公开输出里引用具体内容。

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
