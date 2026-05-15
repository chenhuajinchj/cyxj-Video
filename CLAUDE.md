# CLAUDE.md

XCYJ（陈与小金）的 YouTube 教程视频生产工作台 —— 基于 HeyGen [HyperFrames](https://hyperframes.heygen.com)（HTML + GSAP → MP4）。

仓库整体说明、5 分钟上手、目录树、学习路径见 [`README.md`](README.md)。这份文件只放 AI 每次都要知道的硬规则。

## 关键路径速查

```
videos/<日期>-<slug>/        已发布视频源工程（10 条）
templates/                   tutorial-8beat 真模板 + components + inspirations + catalog.json（只读参考，活工程在 2026-MM-DD/）
2026-MM-DD/<slug>/           当前在做的工作区（可并存多个日期）
归档/                         早期废弃探索（保留参考，不在这里做活）
skills/cyxj-{new-video,add-block}/   skill 真源（.claude/.agents 软链到这里）
docs/HARD_CONSTRAINTS.md     硬约束单源（12 条完整版）
docs/REFERENCE_INDEX.md      上游参考工程 + catalog 零件 + skill 索引
assets/logos/                33 个 AI 厂商 / 工具 SVG（产品引用用真 logo，不准 emoji / 字母）
```

`参考库/` 与 `assets/` 并列；`remotion-text-effects/` 是 Remotion（非 HyperFrames）管线，不要混做。

## skill 触发词

- 「新视频 / 做视频 / 片头 / 做完了 / 归档 / 抽成模板」→ `/cyxj-new-video`
- 「加个零件 / 加个转场 / 加 macos 通知 / Logo 落版」→ `/cyxj-add-block`
- 插 AI 厂商 / 工具 logo：先查 `assets/logos/`，命名规则全小写无分隔符（`claudecode.svg`），文档见 [`assets/logos/LOGOS.md`](assets/logos/LOGOS.md)。`claude-code-logo.png` 像素拟人头像不在本库，由各视频工程自存

## 硬约束铁律（完整版见 [`docs/HARD_CONSTRAINTS.md`](docs/HARD_CONSTRAINTS.md)）

1. **不准** 在 GSAP selector 里用 template literal —— 永远硬编码 `'[data-composition-id="X"] .child'`
2. **不准** 复制 beat html 后忘记全局换 beat id（CSS class + GSAP selector 两处）
3. **不准** 在 sub-composition CSS/JS 里用 `#X .child` —— bundler 会 strip 内层 wrapper，必须用 `[data-composition-id="X"]`
4. **不准** 在 DaVinci 21 里渲含中文文字的手写 Lottie —— 含文字走 hyperframes ProRes 4444 alpha
5. **不准** 用 `npx hyperframes transcribe` 跑中文音频 —— 直接用 `whisper-cli`
6. **不准** 在仓库根跑 `npx hyperframes` —— 必须先 `cd` 进工程目录
7. **不准** 把视觉做成字幕逐字翻译 —— 写 beat 前 PLAN 里先填 metaphor 表
8. **不准** 只 kill preview server 不关浏览器 tab —— renderer 进程能涨到 12 GB
9. **不准** 在 `onUpdate` 里每帧 `document.getElementById` 或 new closure —— 8+ sub-composition 工程会内存爆
10. **不准**（协作）主动 render —— preview 反复打磨完，用户明确说「render 吧」才跑（memory `feedback_workflow_polish_in_browser`）

## 常用命令（工程目录里跑）

```bash
npx hyperframes lint                                # 验证 meta.json + html 结构
npx hyperframes preview                             # http://localhost:3002 浏览器打磨
npx hyperframes render --quality standard \
  --format mp4 --output renders/final.mp4           # 满意了才跑；中文字体回退见 HARD_CONSTRAINTS.md §8
```

仓库根维护脚本（refresh-catalog / refresh-docs / lint-projects）+ CLI 版本管理 / 软链架构 / 维护节奏见 [`docs/ops.md`](docs/ops.md)。

## Claude / Codex 边界

| AI | 读 | skill 入口 |
|---|---|---|
| Claude Code | `CLAUDE.md` | `.claude/skills/cyxj-*` |
| Codex | `AGENTS.md` | `.agents/skills/cyxj-*` |

两边 cyxj-* 都软链到 `skills/` 同一份源。**改 skill 只在 `skills/` 改**。正在做的视频工程在 `2026-MM-DD/<slug>/`，做基础设施修复时先排除。

## 中文环境

- 仓库本身在 `~/项目/参考仓库/hyperframes/`，命令注意 UTF-8
- 模板默认字体栈：`"Noto Sans SC", "Inter", sans-serif`，代码用 `JetBrains Mono`

## 个人笔记（gitignored，AI 可读，不要在公开输出引用具体内容）

- `MY_VISUAL_DNA.md` —— 个人美学宪法（颜色 / 字体 / 节奏）
- `MY_MOTION_NOTES.md` —— 19 招实战沉淀
