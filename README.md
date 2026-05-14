# HyperFrames Video Production Toolkit

用 HTML + GSAP 做 YouTube 教程视频的工作台。可以复用模板、组件、方法论，从 0 搭一条技术教程片头 / 转场 / 整片演示。

> 这不是 HyperFrames 本身（[HeyGen 的 HyperFrames](https://hyperframes.heygen.com) 是 HTML → MP4 的渲染管线）。这是在它之上沉淀的生产 SOP + 模板 + 9 条已发布视频的源工程。

---

## 这个仓库给谁看

- **想做技术教程视频但不会做动效的人** → 复制 [`templates/tutorial-8beat`](templates/tutorial-8beat) 改文案
- **想学怎么用 AI 协作做视频的人** → 看 [`videos/`](videos) 里 9 条案例的 README + [`skills/`](skills) 里的 Claude / Codex 工作流
- **想抄具体动效的人** → 看 [`templates/components/`](templates/components)（cc-window 等）+ [`templates/inspirations/`](templates/inspirations)（5 大 React 组件库的 vanilla 转译版）

---

## 5 分钟上手

```bash
# 1. 装 HyperFrames CLI（用 npx 即可，不需要全局安装）
npx hyperframes --version

# 2. 复制模板到日期工作区
DATE=$(date +%Y-%m-%d)
cp -R templates/tutorial-8beat "videos/$DATE-my-first-video"
cd "videos/$DATE-my-first-video"

# 3. 改 meta.json 的 id + 改 index.html 和 compositions/*.html 里的文案

# 4. 验证 + 预览
npx hyperframes lint
npx hyperframes preview              # http://localhost:3002

# 5. 渲染
npx hyperframes render --quality standard --format mp4 \
  --output renders/final.mp4
```

详细复用 checklist：[`TEMPLATE_USAGE.md`](TEMPLATE_USAGE.md)。

---

## 目录结构

| 目录 | 内容 |
|---|---|
| [`videos/`](videos) | 9 条已发布视频的源工程，每条带 README 讲技术选型 + 怎么复用 |
| [`templates/tutorial-8beat/`](templates/tutorial-8beat) | 唯一从 0 设计的真模板（8 beat 教程结构）|
| [`templates/components/`](templates/components) | 可复用组件（cc-window 终端 UI / orbit-dots / pulse-bars 等）|
| [`templates/inspirations/`](templates/inspirations) | 5 大开源 React 组件库的 vanilla HTML + GSAP 转译版（灵感来源）|
| [`templates/catalog.json`](templates/catalog.json) | 模板零件清单（机器可读，给 skill 用）|
| [`skills/cyxj-new-video/`](skills/cyxj-new-video) | Claude / Codex 做新视频的全流程 skill |
| [`skills/cyxj-add-block/`](skills/cyxj-add-block) | 从 catalog 装零件到当前工程的 skill |
| [`docs/`](docs) | 方法论：硬约束、风格借鉴、HyperFrames 官方文档 78 页镜像 |
| [`docs/REFERENCE_INDEX.md`](docs/REFERENCE_INDEX.md) | 上游参考工程（Nate / HeyGen launches）的索引 |
| [`assets/logos/`](assets/logos) | 33 个常用 AI 厂商 / 工具 SVG logo（Claude / OpenAI / GitHub …）|
| [`scripts/`](scripts) | 维护脚本（刷 catalog / 刷文档 / lint 各工程）|

---

## 用 AI 协作做视频

我用 Claude Code 做视频。在仓库根开 Claude Code 说：

> "做个新视频，主题《XXX》"

[`skills/cyxj-new-video`](skills/cyxj-new-video) 会自动：建工作区 → 推荐参考 → 等你给文案 → 改 beats → lint → preview → render → 归档。

Codex 用户用 `.agents/skills/` 下的同名 skill（软链到同一份源文件）。

---

## 学习路径

| 顺序 | 看哪个 |
|---|---|
| 1. 看成品长什么样 | [`videos/2026-05-04-claude-19-tips/README.md`](videos/2026-05-04-claude-19-tips/README.md)（最大的工程，28 composition / 7.5 分钟）|
| 2. 学动效美学纪律 | [`docs/STYLE_BORROW_PLAYBOOK.md`](docs/STYLE_BORROW_PLAYBOOK.md) |
| 3. 避坑 | [`docs/HARD_CONSTRAINTS.md`](docs/HARD_CONSTRAINTS.md) |
| 4. 查官方文档 | [`docs/hyperframes-official/`](docs/hyperframes-official) |
| 5. 看 9 条视频的设计思路 | [`videos/*/README.md`](videos) |

---

## 已知坑（吃过的亏）

详见 [`docs/HARD_CONSTRAINTS.md`](docs/HARD_CONSTRAINTS.md)。简表：

1. GSAP querySelector 不能用 template literal
2. 复制 beat html 时全局换 beat id（CSS class + GSAP selector 两处）
3. DaVinci 21 不能渲染含中文文字的手写 Lottie（含文字走 ProRes 4444 alpha）
4. 中文 Whisper transcribe 要绕开 hyperframes CLI（用 `whisper-cli`）
5. `npx hyperframes` 必须在工程目录里跑（仓库根无 package.json）
6. 中文字体在无头 Chromium 渲染时偶发回退（Google Fonts CDN 超时）

---

## 致谢

- [HyperFrames](https://hyperframes.heygen.com) by HeyGen — HTML + GSAP 视频渲染管线
- Nate Herk 的 [hyperframes-student-kit](https://github.com/HeyGen-Official/hyperframes-student-kit) — 视觉灵感与上游 skill 来源
- [GSAP](https://gsap.com) — 动效引擎
- Anthropic Claude — AI pair programmer

---

## License

见 [`LICENSE`](LICENSE)。
