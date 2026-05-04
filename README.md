# XCYJ HyperFrames Templates

陈与小金（XCYJ）的 YouTube 教程视频模板库 —— 用 [HyperFrames](https://hyperframes.heygen.com)（HTML + GSAP 渲染管线）做技术教程的片头、转场、整片演示。

> **状态**：私有仓库，整理中。计划在后续视频发布时切换为公开仓库，让观众可以直接复用。

---

## 三个模板

| 模板 | 适合的视频类型 | 拓扑 | 输出 |
|---|---|---|---|
| [`templates/host-overlay`](templates/host-overlay) | 主播口播为主，旁边浮一些动效辅助讲解 | 录屏铺满 + 4 个 beat overlay | 整片 MP4（含录屏 + overlay） |
| [`templates/host-overlay-alpha`](templates/host-overlay-alpha) | 同上，但希望在达芬奇里精修录屏 | 仅 overlay，背景透明 | ProRes 4444 alpha MOV |
| [`templates/demo-fullscreen`](templates/demo-fullscreen) | 含中文文字的"虚构 demo" 整片，配音后期加 | 7 beat 串联，无录屏 | 整片 MP4 |

**选哪个**：
- 主体是真人 → `host-overlay` (整片) 或 `host-overlay-alpha` (达芬奇精修)
- 主体是 hyperframes 画面 → `demo-fullscreen`
- 一个视频里多种段落 → 都用，达芬奇里串联

详细复用指南见 [`TEMPLATE_USAGE.md`](TEMPLATE_USAGE.md)。

---

## 目录结构

```
.
├── README.md                  ← 你在看的这个
├── TEMPLATE_USAGE.md          ← 复用 checklist（下次做新视频翻这个）
├── AGENTS.md                  ← Codex 工作边界
├── CLAUDE.md                  ← Claude Code 工作边界
├── .agents/skills/            ← Codex wrapper skills
├── .claude/skills/            ← Claude Code skills
├── templates/                 ← 三个可复用模板（git 跟踪）
│   ├── host-overlay/          ← 主播 + overlay（v2 风格）
│   ├── host-overlay-alpha/    ← 主播 + overlay 的 alpha 变体
│   └── demo-fullscreen/       ← 演示风格整片
├── examples/                  ← 已经做过的视频的脚本/文案
│   └── codex-intro/
│       └── script.md          ← Codex × Claude Code 教程片头文案
├── docs/                      ← 文档与实验记录
│   ├── lottie-davinci-experiment/  ← DaVinci 21 Lottie 兼容性实验
│   ├── round-1-next-steps.md  ← 第一轮工作历史归档
│   └── round-1-progress.md
├── 参考库/                     ← 参考工程、catalog、我的作品
├── 2026-MM-DD/                ← 当前视频工作区
├── hyperframes-launches/      ← HeyGen 官方参考工程（git ignored）
├── hyperframes-student-kit/   ← Nate Herk 学习套件（git ignored）
└── 录屏/                       ← 个人录屏素材（git ignored，不会推 GitHub）
```

`hyperframes-launches/` 和 `hyperframes-student-kit/` 是上游 git 仓库，本仓库**不重复跟踪**。它们只作为参考库/上游 skill 的来源；新视频工程不要放回这两个目录。

Claude Code 看 `CLAUDE.md` 和 `.claude/skills/`；Codex 看 `AGENTS.md` 和 `.agents/skills/`。两个 AI 共用 `templates/`、`参考库/`、`2026-MM-DD/`，但正在制作的 `2026-MM-DD/<slug>/` 视为施工区，另一个 AI 做审查/修基础设施时应先排除它。

---

## 快速开始

### 用模板做新视频（30 秒了解）

```bash
# 1. 在仓库根复制模板成日期工作区
DATE=$(date +%Y-%m-%d)
mkdir -p "$DATE"
cp -R templates/demo-fullscreen "$DATE/my-new-intro"

# 2. 改文案 / 时间码 / beat 内容（看 TEMPLATE_USAGE.md 的 checklist）

# 3. 渲染
cd "$DATE/my-new-intro"
npx hyperframes lint
npx hyperframes preview              # http://localhost:3002 验收
npx hyperframes render --quality standard --format mp4 \
  --output renders/my-new-intro.mp4
```

详见 [`TEMPLATE_USAGE.md`](TEMPLATE_USAGE.md)。

---

## 已知坑（吃过的亏）

1. **DaVinci 21 不能渲染含中文文字的手写 Lottie** —— 详见 [`docs/lottie-davinci-experiment/`](docs/lottie-davinci-experiment/)。手写 Lottie 仅适合纯图形装饰（光圈、icon、装饰线），含文字必须走视频路径。
2. **hyperframes 渲染时 GSAP querySelector 不能用 template literal** —— `\`${root} .x\`` 会让 lint 报 `template_literal_selector` error，必须硬编码字符串。
3. **中文字体在无头 Chromium 渲染时偶发回退** —— Google Fonts CDN 超时会用系统默认字体。本地化或加 `document.fonts.ready` 等待门可以避免。
4. **Whisper transcribe 中文要绕开 hyperframes CLI** —— CLI 传给 whisper-cli 的 DTW preset 是 `large-v3`（破折号），但 whisper-cpp 期望 `large.v3`（点号）。中文转写要直接用 whisper-cli。

---

## 致谢

- [HyperFrames](https://hyperframes.heygen.com) by HeyGen — HTML + GSAP 视频渲染框架
- Nate Herk 的 hyperframes-student-kit — 学习参考
- Anthropic Claude — AI pair programmer

---

## License

暂未定。计划公开仓库时采用 MIT 或 CC BY 4.0。
