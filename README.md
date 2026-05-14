# 陈与小金 · HyperFrames 视频源工程库

> [YouTube @cyxj_ai](https://www.youtube.com/@cyxj_ai) 的中文 Claude Code 教程视频公开源工程 + 我用 AI 协作做视频的全流程 SOP。

[![分享19个我自己使用 Claude 的技巧](https://i.ytimg.com/vi/fnKGWHSd0NE/hqdefault.jpg)](https://youtu.be/fnKGWHSd0NE)

**代表作**：[分享19个我自己使用 Claude 的技巧](https://youtu.be/fnKGWHSd0NE)（7.5 分钟 / 28 个 sub-composition / 源工程见 [`videos/2026-05-04-claude-19-tips/`](videos/2026-05-04-claude-19-tips/)）

---

## 这是什么

这个仓库是我（陈与小金）做中文 Claude Code 教程视频用的**生产工作台**：

- **9 条已发布视频**的全部源工程（HTML + GSAP，可直接复制改文案再发一条）
- 1 个真模板 [`tutorial-8beat`](templates/tutorial-8beat) + 一组可复用组件（终端 UI / 入场动效等）
- 我让 Claude Code 和 Codex 协作做视频的 [skill](skills/)（从 0 建工程 → 推荐参考 → lint / preview / render → 归档）
- 一套吃过亏沉淀下来的硬约束 [`docs/HARD_CONSTRAINTS.md`](docs/HARD_CONSTRAINTS.md) 和借鉴外部视觉的方法 [`docs/STYLE_BORROW_PLAYBOOK.md`](docs/STYLE_BORROW_PLAYBOOK.md)

视频底层用 HeyGen 的 [HyperFrames](https://hyperframes.heygen.com)（HTML + GSAP → MP4 的渲染管线）。**这不是 HyperFrames 本身**，是在它之上的个人方法论 + 作品归档。

---

## 这个仓库给谁看

- **想做技术教程视频但不会做动效的人** → 复制 [`templates/tutorial-8beat`](templates/tutorial-8beat) 改文案
- **想学怎么用 AI 协作做视频的人** → 看 [`videos/`](videos) 里 10 条工程的 README + [`skills/cyxj-new-video/`](skills/cyxj-new-video/SKILL.md) 的全流程
- **想抄具体动效的人** → 看 [`templates/components/`](templates/components)（终端 UI 等）+ [`templates/inspirations/`](templates/inspirations)（5 大 React 组件库的 vanilla 转译版）

---

## 5 分钟上手

```bash
# 1. 第一次运行 npx hyperframes 会自动下载 CLI 到 npx 缓存
npx hyperframes --version

# 2. 在日期工作区里复制模板（用日期目录是为了避免跟 videos/ 已发布作品撞）
DATE=$(date +%Y-%m-%d)
mkdir -p "$DATE"
cp -R templates/tutorial-8beat "$DATE/my-first-video"
cd "$DATE/my-first-video"

# 3. 改 meta.json 的 id 改成自己的，改 index.html 和 compositions/*.html 里的文案

# 4. 验证 + 预览
npx hyperframes lint
npx hyperframes preview              # 浏览器打开 http://localhost:3002

# 5. 渲染
npx hyperframes render --quality standard --format mp4 \
  --output renders/final.mp4

# 6. 满意了归档到 videos/，作为下一次开始的参照
mv ../my-first-video ../../videos/$DATE-my-first-video
```

详细复用 checklist：[`TEMPLATE_USAGE.md`](TEMPLATE_USAGE.md)。

---

## 目录结构

| 目录 | 内容 |
|---|---|
| [`videos/`](videos) | 10 条已归档视频的源工程，每条带 README 讲技术选型 + 怎么复用 |
| [`templates/tutorial-8beat/`](templates/tutorial-8beat) | 唯一从 0 设计的真模板（8 beat 教程结构）|
| [`templates/components/`](templates/components) | 可复用组件（cc-window 终端 UI / orbit-dots / pulse-bars / spec-fill 等）|
| [`templates/inspirations/`](templates/inspirations) | 5 大开源 React 组件库的 vanilla HTML + GSAP 转译版（灵感来源）|
| [`templates/catalog.json`](templates/catalog.json) | 模板零件清单（机器可读，给 skill 用）|
| [`skills/cyxj-new-video/`](skills/cyxj-new-video) | Claude / Codex 做新视频的全流程 skill |
| [`skills/cyxj-add-block/`](skills/cyxj-add-block) | 从 catalog 装零件到当前工程的 skill |
| [`docs/`](docs) | 方法论：硬约束、风格借鉴、HyperFrames 官方文档 78 页镜像 |
| [`docs/REFERENCE_INDEX.md`](docs/REFERENCE_INDEX.md) | 上游参考工程（Nate / HeyGen 官方）的索引 |
| [`assets/logos/`](assets/logos) | 33 个常用 AI 厂商 / 工具 SVG logo（Claude / OpenAI / GitHub …）|
| [`scripts/`](scripts) | 维护脚本（刷 catalog / 刷文档 / lint 各工程）|

---

## 用 AI 协作做视频

我做这些视频的流程是：起一个 Claude Code 会话，说一句「做个新视频，主题《XXX》」，然后 [`skills/cyxj-new-video/SKILL.md`](skills/cyxj-new-video/SKILL.md) 会接管：

1. 问形态 / 主题 / 时长
2. 读 [`docs/REFERENCE_INDEX.md`](docs/REFERENCE_INDEX.md) 推 2-3 个最贴的参考工程
3. 复制模板到 `2026-MM-DD/<slug>/`，改 `meta.json` 和 `index.html`
4. 等我提供文案 → 改 beats → lint → preview → render
5. 我说"做完了" → 自动归档进 `videos/<日期>-<slug>/`

OpenAI Codex CLI 用户能直接复用同一套 skill —— `.agents/skills/cyxj-{new-video,add-block}` 软链到 `skills/` 同一份源，两边 AI 共用。

---

## 学习路径

| 顺序 | 看哪个 |
|---|---|
| 1. 看成品长什么样 | [👉 YouTube 上看](https://youtu.be/fnKGWHSd0NE) 或读 [`videos/2026-05-04-claude-19-tips/README.md`](videos/2026-05-04-claude-19-tips/README.md)（28 composition / 7.5 分钟）|
| 2. 学动效美学纪律 | [`docs/STYLE_BORROW_PLAYBOOK.md`](docs/STYLE_BORROW_PLAYBOOK.md) |
| 3. 避坑 | [`docs/HARD_CONSTRAINTS.md`](docs/HARD_CONSTRAINTS.md) |
| 4. 查 HyperFrames 官方文档 | [`docs/hyperframes-official/`](docs/hyperframes-official)（78 页本地镜像）|
| 5. 看 10 条视频的不同设计思路 | [`videos/*/README.md`](videos) |

---

## 已知坑（吃过的亏）

完整版见 [`docs/HARD_CONSTRAINTS.md`](docs/HARD_CONSTRAINTS.md)。简表：

1. GSAP querySelector 不能用 template literal
2. 复制 beat html 时全局换 beat id（CSS class + GSAP selector 两处）
3. DaVinci 21 不能渲染含中文文字的手写 Lottie（含文字走 ProRes 4444 alpha）
4. 中文 Whisper transcribe 要绕开 hyperframes CLI（用 `whisper-cli`）
5. `npx hyperframes` 必须在工程目录里跑（仓库根无 package.json）
6. 中文字体在无头 Chromium 渲染时偶发回退（Google Fonts CDN 超时，本地化字体可避）

---

## 致谢

- HeyGen 的 [HyperFrames](https://hyperframes.heygen.com) —— 底层 HTML + GSAP 渲染管线
- Nate Herk 的 [hyperframes-student-kit](https://github.com/HeyGen-Official/hyperframes-student-kit) —— 上游视觉灵感、参考工程、基础 skill 来源
- [GSAP](https://gsap.com) —— 动效引擎
- 用 Claude Code 和 OpenAI Codex CLI 协作迭代

---

## License

见 [`LICENSE`](LICENSE)。
