# pulse-bars — 3 条 / 5 条脉冲指示器

> 视频里需要表达"系统正在思考 / 处理 / 接收音频"时的轻量指示器。
> 比 spinner 更克制，与 cc-window 内的 `.cc-agent-dot` 旋转点互补：cc-agent-dot 在终端窗口里；pulse-bars 是独立站位组件。

---

## 来源 / 许可

- **上游仓库**：[lukehaas/css-loaders](https://github.com/lukehaas/css-loaders)
- **commit**：`c7fdf5ac73c71fec3142414adf8d592c7d2c6bf4`
- **原文件**：`css/load1.css`（3-bar equalizer 变体）
- **LICENSE**：MIT（Copyright © 2014 Luke Haas）
- **改动**：原版用 CSS `@keyframes load1` 自走动画。本组件移除了 @keyframes，改由 GSAP timeline 驱动 `.pb-bar` 的 `scaleY` —— 让 HyperFrames 无头 Chromium 渲染的时序确定，并允许任意 beat 时间点起停。
- **抓取日期**：2026-05-12

---

## 最小用法

```html
<!-- 1. composition <head> 里 link CSS -->
<link rel="stylesheet" href="../components/pulse-bars/pulse-bars.css" />

<!-- 2. body 里粘一个变体 -->
<div class="pulse-bars" id="thinking-bars">
  <span class="pb-bar"></span>
  <span class="pb-bar"></span>
  <span class="pb-bar"></span>
</div>

<!-- 3. GSAP timeline 驱动 scaleY，stagger 产生波浪感 -->
<script>
  const root = '[data-composition-id="beat-2-thinking"]';
  const tl = gsap.timeline();

  // 入场：DNA 第 6 条 blur(14px) → blur(0)
  tl.fromTo(root + ' #thinking-bars',
    { opacity: 0, y: 12, filter: 'blur(14px)' },
    { opacity: 1, y: 0, filter: 'blur(0px)', duration: 0.5, ease: 'power3.out' }, 0);

  // 持续脉冲：scaleY 在 0.4 ↔ 1.4 之间反复
  tl.to(root + ' #thinking-bars .pb-bar', {
    scaleY: 1.6,
    duration: 0.42,
    ease: 'sine.inOut',
    yoyo: true,
    repeat: -1,
    stagger: { each: 0.13, from: 'start' }
  }, 0.3);
</script>
```

---

## 可调 CSS 变量

| Token | 默认 | 说明 |
|---|---|---|
| `--pb-color` | `var(--c-orange, #D97757)` | 条柱颜色（默认 Claude 橙，brand token fallback） |
| `--pb-bar-w` | `8px` | 单条宽度 |
| `--pb-bar-h` | `36px` | 静止高度 |
| `--pb-gap` | `8px` | 条间距 |
| `--pb-radius` | `2px` | 条圆角 |

inline override 示例（文字内 inline）：

```html
<span class="pulse-bars" style="--pb-bar-w:4px; --pb-bar-h:14px; --pb-gap:3px;">…</span>
```

---

## 3 种变体

| 变体 | 锚点 | 适用 |
|---|---|---|
| A · 3 条 | pulse-bars.html L18 | "agent thinking" 主指示器 |
| B · 5 条 | pulse-bars.html L30 | "audio processing / voice in" 更密集场景 |
| C · inline 跟文字 | pulse-bars.html L47 | "Claude is thinking ▮▮▮" 行内伴生 |

---

## GSAP 节奏参考

| 节奏 | duration / each | 适用 |
|---|---|---|
| 紧凑思考 | duration 0.30 / stagger 0.10 | 短 beat (1-2s) 内表达"在算" |
| 标准（推荐） | duration 0.42 / stagger 0.13 | 一般"agent thinking" beat |
| 慢摇 | duration 0.65 / stagger 0.20 | "voice 接收 / 慢节奏 podcast 化" |

stagger `from: 'center'` 可做"中间向两边扩散"的波，适合长条数（>=5）。

---

## 已知约束

- **不要给 .pb-bar 加 CSS transform 静态偏移**：GSAP scaleY 会和 CSS transform 互相覆盖。如果非要旋转或位移整个组件，套一层外层 wrapper，给 wrapper 用 CSS transform，给 .pb-bar 留给 GSAP 独占。
- **selector 硬编码**：HARD_CONSTRAINTS 第 1 条。永远写 `[data-composition-id="beat-X-Y"] .pb-bar`，不要写 template literal。

---

## 与其他组件关系

| 关联 | 关系 |
|---|---|
| `cc-window` `.cc-agent-dot` | 终端窗口内的旋转点，跟 pulse-bars 互补：cc-agent-dot 在窗口内、pulse-bars 站位独立 |
| `orbit-dots` | 同库（css-loaders）的 8 点圆环 spinner，pulse-bars 偏"指示"、orbit-dots 偏"等待" |
