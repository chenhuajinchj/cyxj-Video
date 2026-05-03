# HyperFrames 官方文档（本地镜像）

源自 [hyperframes.mintlify.app/llms.txt](https://hyperframes.mintlify.app/llms.txt)，77 个页面全量镜像。

- **最后刷新**：2026-05-03
- **总大小**：564K
- **刷新方式**：`bash scripts/refresh-docs.sh`（动态读 llms.txt，会自动跟进官网新增页面）
- **官网入口**：https://hyperframes.heygen.com

---

## 入门

- [introduction](getting-started/introduction.md) — Write HTML. Render video. Built for agents.
- [quickstart](getting-started/quickstart.md) — 2 分钟做出第一条视频

## 核心概念

- [compositions](concepts/compositions.md) — composition 是 hyperframes 的基本单元
- [data-attributes](concepts/data-attributes.md) — 控制时序和行为的核心属性
- [determinism](concepts/determinism.md) — 同输入同输出的渲染保证
- [frame-adapters](concepts/frame-adapters.md) — 接入自定义动画 runtime

## 指南

- [prompting](guides/prompting.md) — 怎么给 Claude/Cursor/Codex 下指令做 hyperframes
- [gsap-animation](guides/gsap-animation.md) — GSAP 动画用法（**关键**）
- [rendering](guides/rendering.md) — 渲染 mp4/mov/webm（含 Docker）
- [common-mistakes](guides/common-mistakes.md) — 容易踩的坑（**必读**）
- [troubleshooting](guides/troubleshooting.md) — 故障排查
- [performance](guides/performance.md) — 让 preview 流畅
- [hdr](guides/hdr.md) — HDR10 渲染（BT.2020 PQ / HLG）
- [claude-design](guides/claude-design.md) — Claude Design 起草 + AI agent 精修
- [open-design](guides/open-design.md) —
- [timeline-editing](guides/timeline-editing.md) — Studio 时间轴里能改什么
- [website-to-video](guides/website-to-video.md) — 抓任意网页直接转视频
- [video-editor-cheatsheet](guides/video-editor-cheatsheet.md) — 给视频编辑师/创意人的快速参考
- [hyperframes-vs-remotion](guides/hyperframes-vs-remotion.md) — 和 Remotion 的对比与选型

## 包文档

- [cli](packages/cli.md) — `npx hyperframes` 命令行
- [core](packages/core.md) — types / 解析 / runtime / linter
- [engine](packages/engine.md) — Chrome BeginFrame 抓帧引擎
- [producer](packages/producer.md) — HTML→视频完整流水线
- [studio](packages/studio.md) — 可视化编辑器
- [player](packages/player.md) — 嵌入网页的 web component

## Reference

- [html-schema](reference/html-schema.md) — HTML 完整 schema 参考

## 贡献

- [contributing](contributing/contributing.md)
- [release-channels](contributing/release-channels.md) — alpha / stable 分流
- [testing-local-changes](contributing/testing-local-changes.md) — 本地 CLI 调试

## 社区

- [adopters](community/adopters.md) — 谁在用 hyperframes

## 示例

- [examples](examples.md) — 内置示例索引

---

## Catalog Blocks（43 个）

完整动效成品块，可 `npx hyperframes add <name>` 装到工程里。

### 社交叠层（用得上）
- [instagram-follow](catalog/blocks/instagram-follow.md)
- [tiktok-follow](catalog/blocks/tiktok-follow.md)
- [yt-lower-third](catalog/blocks/yt-lower-third.md)
- [x-post](catalog/blocks/x-post.md)
- [reddit-post](catalog/blocks/reddit-post.md)
- [spotify-card](catalog/blocks/spotify-card.md)
- [macos-notification](catalog/blocks/macos-notification.md)

### 内容/演示（技术教程能用上）
- [data-chart](catalog/blocks/data-chart.md) — 柱状+折线图，NYT 风格
- [flowchart](catalog/blocks/flowchart.md) — 决策树 / 流程图，含光标交互
- [logo-outro](catalog/blocks/logo-outro.md) — 片尾 logo 落版
- [app-showcase](catalog/blocks/app-showcase.md) — 三屏手机展示
- [ui-3d-reveal](catalog/blocks/ui-3d-reveal.md) — 3D UI 揭示

### 案例展示（可参考做法）
- [apple-money-count](catalog/blocks/apple-money-count.md)
- [goonvpn-youtube-spot](catalog/blocks/goonvpn-youtube-spot.md)
- [north-korea-locked-down](catalog/blocks/north-korea-locked-down.md)
- [nyc-paris-flight](catalog/blocks/nyc-paris-flight.md)

### Shader 转场（14 个，整片演示用）
- [chromatic-radial-split](catalog/blocks/chromatic-radial-split.md)
- [cinematic-zoom](catalog/blocks/cinematic-zoom.md)
- [cross-warp-morph](catalog/blocks/cross-warp-morph.md)
- [domain-warp-dissolve](catalog/blocks/domain-warp-dissolve.md)
- [flash-through-white](catalog/blocks/flash-through-white.md)
- [glitch](catalog/blocks/glitch.md)
- [gravitational-lens](catalog/blocks/gravitational-lens.md)
- [light-leak](catalog/blocks/light-leak.md)
- [ridged-burn](catalog/blocks/ridged-burn.md)
- [ripple-waves](catalog/blocks/ripple-waves.md)
- [sdf-iris](catalog/blocks/sdf-iris.md)
- [swirl-vortex](catalog/blocks/swirl-vortex.md)
- [thermal-distortion](catalog/blocks/thermal-distortion.md)
- [whip-pan](catalog/blocks/whip-pan.md)

### 转场 showcase 集（13 个分类合集）
- [transitions-3d](catalog/blocks/transitions-3d.md)
- [transitions-blur](catalog/blocks/transitions-blur.md)
- [transitions-cover](catalog/blocks/transitions-cover.md)
- [transitions-destruction](catalog/blocks/transitions-destruction.md)
- [transitions-dissolve](catalog/blocks/transitions-dissolve.md)
- [transitions-distortion](catalog/blocks/transitions-distortion.md)
- [transitions-grid](catalog/blocks/transitions-grid.md)
- [transitions-light](catalog/blocks/transitions-light.md)
- [transitions-mechanical](catalog/blocks/transitions-mechanical.md)
- [transitions-other](catalog/blocks/transitions-other.md)
- [transitions-push](catalog/blocks/transitions-push.md)
- [transitions-radial](catalog/blocks/transitions-radial.md)
- [transitions-scale](catalog/blocks/transitions-scale.md)

## Catalog Components（3 个）

可复用零件，往 composition 里嵌。

- [grain-overlay](catalog/components/grain-overlay.md) — 颗粒纹理叠层
- [grid-pixelate-wipe](catalog/components/grid-pixelate-wipe.md) — 网格像素化擦除
- [shimmer-sweep](catalog/components/shimmer-sweep.md) — 光泽扫光

---

## 维护

- 每 1-2 月跑一次 `bash scripts/refresh-docs.sh`，配合 `refresh-catalog.sh` 一起
- 如果官网新增/删减页面，刷新会自动跟进，但**这份 README 是手写的**——分组归类需要手动更新
- 文件本身是 mintlify 自动暴露的 `.md` 原文，可直接 grep / 给 Claude Code 当 context
