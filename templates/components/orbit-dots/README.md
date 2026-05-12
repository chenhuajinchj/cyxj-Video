# orbit-dots — 8 点圆环 spinner

> 视频里需要表达"等待 / 加载 / 处理中"的中等比重场景，比 pulse-bars 更显眼、比满屏 splash 更克制。
> 适合作为 beat 中央的视觉锚点（待 API 返回、模型生成中、文件上传）。

---

## 来源 / 许可

- **上游仓库**：[lukehaas/css-loaders](https://github.com/lukehaas/css-loaders)
- **commit**：`c7fdf5ac73c71fec3142414adf8d592c7d2c6bf4`
- **原文件**：`css/load4.css`（8 点圆环 box-shadow 变体）
- **LICENSE**：MIT（Copyright © 2014 Luke Haas）
- **改动**：原版用单元素 + 8 段 `box-shadow` + 12 帧 `@keyframes load4` 模拟旋转点的"消长"。本组件改为 8 个独立 DOM `.od-slot > .od-dot`，slot 用 CSS 静态 transform 摆位，dot 留给 GSAP 控制 scale/opacity —— 时序确定、可中途暂停、HARD_CONSTRAINTS 安全。
- **抓取日期**：2026-05-12

---

## 最小用法

```html
<!-- 1. composition <head> 里 link CSS -->
<link rel="stylesheet" href="../components/orbit-dots/orbit-dots.css" />

<!-- 2. body 里粘变体 A -->
<div class="orbit-dots" id="loader-1">
  <span class="od-slot" style="--i: 0;"><span class="od-dot"></span></span>
  <!-- ... 8 个 slot, --i: 0..7 ... -->
</div>

<!-- 3. GSAP timeline -->
<script>
  const root = '[data-composition-id="beat-3-loading"]';
  const tl = gsap.timeline();

  // 入场
  tl.fromTo(root + ' #loader-1',
    { opacity: 0, scale: 0.6, filter: 'blur(14px)' },
    { opacity: 1, scale: 1,   filter: 'blur(0px)', duration: 0.5, ease: 'power3.out' }, 0);

  // 彗星追尾：每个 dot 依次缩小+变暗，循环
  tl.to(root + ' #loader-1 .od-dot', {
    scale: 0.3,
    opacity: 0.25,
    duration: 0.6,
    ease: 'sine.inOut',
    yoyo: true,
    repeat: -1,
    stagger: { each: 0.12, from: 'start' }
  }, 0.3);

  // 可选：同时让整圈缓慢旋转
  tl.to(root + ' #loader-1', {
    rotation: 360,
    duration: 4,
    ease: 'none',
    repeat: -1,
    transformOrigin: 'center center'
  }, 0.3);
</script>
```

---

## 可调 CSS 变量

| Token | 默认 | 说明 |
|---|---|---|
| `--od-color` | `var(--c-teal, #2F7D73)` | 点默认色（brand teal） |
| `--od-active` | `var(--c-orange, #D97757)` | 留给"高亮点"用（GSAP set 个别 dot 时引用） |
| `--od-dot-size` | `14px` | 单点直径 |
| `--od-radius` | `56px` | 圆环半径（圆心到点心） |

inline override：

```html
<div class="orbit-dots" style="--od-radius:90px; --od-dot-size:18px;">…</div>
```

整体宽高自动 = `radius * 2 + dot-size`。

---

## 3 种变体

| 变体 | 锚点 | 适用 |
|---|---|---|
| A · 8 点（推荐） | orbit-dots.html L17 | 标准 spinner，`--i: 0..7` × 45° 自动排布 |
| B · 6 点稀疏 | orbit-dots.html L34 | 节奏更慢，需要给每个 slot 写死 60° step |
| C · 大尺寸门户 | orbit-dots.html L50 | 中央站位强调，radius 90px |

---

## GSAP 节奏参考

| 节奏 | duration / each | 适用 |
|---|---|---|
| 紧凑 | 0.45 / 0.09 | 5s 内表达"快速加载完成" |
| 标准（推荐） | 0.60 / 0.12 | 普通"等待中" |
| 慢摇 | 0.90 / 0.18 | 长 beat（>8s）冥想感 |

旋转 `rotation: 360` 的 duration 与 stagger 总长 (`each × 8`) 不必严格成倍数 —— 两个独立节奏叠加产生"非周期性活感"。

---

## 已知约束

- **CSS transform 和 GSAP transform 分离**：本组件刻意把摆位（CSS `.od-slot`）和动画（GSAP `.od-dot`）分到两个 DOM 层。改的时候不要把 transform 合并到一层。
- **整圈旋转作用在 `.orbit-dots` 父容器上**，不要作用在 `.od-slot`（会和 CSS 静态 rotate 冲突）。
- **selector 硬编码**：HARD_CONSTRAINTS 第 1 条。

---

## 与其他组件关系

| 关联 | 关系 |
|---|---|
| `pulse-bars` | 同库（css-loaders）的姊妹组件。pulse-bars 偏"指示"（小、跟文字）；orbit-dots 偏"等待"（中央站位） |
| `cc-window` `.cc-agent-dot` | cc-agent-dot 在终端窗口内、单点旋转；orbit-dots 独立站位、多点圆环。完全不同语义不冲突 |
