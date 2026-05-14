# spec-fill — 拆解卡 / 规范卡 逐行填充

> 抽自 2026-05-13 claude-design-codex-image / 04-s1-flow.html / beat 4 / 9-13 秒。
> Catalog 里没有同类零件，下次任何"把一个东西拆解给观众看"叙事都能复用。

---

## 用途

视频里需要**把一个抽象的东西拆解成 N 个维度，依次填进卡片**时使用。

可以用来表达：

- 拆解一个设计稿（颜色 / 字号 / 排版 / 留白）— 原始用例
- 拆解一个产品（用户 / 场景 / 动作 / 结果）
- 拆解一个技术栈（前端 / 后端 / 数据 / 部署）
- 拆解一个工作流（输入 / 处理 / 输出 / 反馈）
- 拆解一个体检项（项 / 阈值 / 结果 / 趋势）

叙事节奏：spec 卡浮起 → 4 行 row 依次淡入（key 字先出、val 还空）→ val 视觉依次蹦起填入。

## 两个变体

- **变体 A · 纯拆解卡**（最常用）：卡浮起 + 行依次入场 + val 蹦起，约 3.5 秒。
- **变体 B · 拆解卡 + 飞入块**：左边的视觉素材（5 个 block）飞向对应 row 落位变成 val 视觉，约 4 秒。适合"左边有可视化素材要拆解到 spec"的叙事。

---

## 最小用法

```html
<!-- 1. CSS link（先 tokens 后 spec-fill）-->
<link rel="stylesheet" href="../components/xcyj-tokens/xcyj-tokens.css" />
<link rel="stylesheet" href="../components/spec-fill/spec-fill.css" />

<!-- 2. 复制 spec-fill.html 里你需要的变体（A 或 B）粘到 body -->
<!-- 3. 改 .sf-head 标题、.sf-key 维度词、val 视觉 -->
<!-- 4. 写 GSAP timeline 见下 -->
```

---

## GSAP 时序参考（原 9-13s 段简化版）

```js
const START = 9.0;  // 改成你想从第几秒起

// ① 卡浮起（接住即将到来的内容）
tl.fromTo('.sf-card',
  { x: 30, opacity: 0 },
  { x: 0, opacity: 1, duration: 0.45, ease: 'power3.out' },
  START);

// ② val chip 全部 hidden 初始态
tl.set('.sf-chip-color', { opacity: 0, scale: 0.6 }, START + 0.1);
tl.set('.sf-chip-type',  { opacity: 0, y: 12 },     START + 0.1);
tl.set('.sf-chip-bar',   { opacity: 0, scaleX: 0.4 }, START + 0.1);
tl.set('.sf-chip-box',   { opacity: 0, scale: 0.6 }, START + 0.1);
tl.set('.sf-chip-rule',  { opacity: 0, x: -8 },     START + 0.1);

// ③ row 容器依次入场（先显 key，val 还空）
tl.fromTo('.sf-row',
  { y: 14, opacity: 0 },
  { y: 0, opacity: 1, stagger: 0.08, duration: 0.35, ease: 'power3.out' },
  START + 0.2);

// ④ val chip 依次蹦起（按节奏分批，配合口播）
// 维度 1 · 色块
tl.to('.sf-row:nth-of-type(2) .sf-chip-color',
  { opacity: 1, scale: 1, stagger: 0.06, duration: 0.35, ease: 'back.out(1.8)' },
  START + 1.75);

// 维度 2 · 字号 A
tl.to('.sf-row:nth-of-type(3) .sf-chip-type',
  { y: 0, opacity: 1, stagger: 0.06, duration: 0.35, ease: 'back.out(1.8)' },
  START + 2.3);

// 维度 3 · 横条
tl.to('.sf-row:nth-of-type(4) .sf-chip-bar',
  { opacity: 1, scaleX: 1, stagger: 0.08, duration: 0.35, ease: 'power3.out' },
  START + 2.85);

// 维度 4 · 方框 + 数字
tl.to('.sf-row:nth-of-type(5) .sf-chip-box',
  { opacity: 1, scale: 1, duration: 0.35, ease: 'back.out(1.8)' },
  START + 3.4);
tl.to('.sf-row:nth-of-type(5) .sf-chip-rule',
  { opacity: 1, x: 0, duration: 0.3, ease: 'power2.out' },
  START + 3.55);
```

### 变体 B · 飞入块附加段

```js
// 5 个 block 飞向 spec 卡对应 row，落位坐标要按你的卡位置调整
// 原视频坐标：spec 卡在 right:12% 处，block 在左半屏

// 维度 1 · b1 + b2 飞向"色块"行
tl.to('.sf-block-1',
  { x: 1180, y: -10, scaleX: 0.18, scaleY: 0.32, rotate: 8, duration: 1.0, ease: 'power2.inOut' },
  START + 0.8);
tl.to('.sf-block-1', { opacity: 0, duration: 0.2, ease: 'power2.in' }, START + 1.6);

tl.to('.sf-block-2',
  { x: 920, y: -10, scaleX: 0.16, scaleY: 0.32, rotate: -6, duration: 1.0, ease: 'power2.inOut' },
  START + 0.9);
tl.to('.sf-block-2', { opacity: 0, duration: 0.2, ease: 'power2.in' }, START + 1.7);

// 维度 3 · b3 + b4 飞向"横条"行
tl.to('.sf-block-3',
  { x: 1060, y: 8, scaleX: 0.25, scaleY: 0.30, rotate: 4, duration: 1.0, ease: 'power2.inOut' },
  START + 1.85);
tl.to('.sf-block-3', { opacity: 0, duration: 0.2, ease: 'power2.in' }, START + 2.7);

tl.to('.sf-block-4',
  { x: 1120, y: -22, scaleX: 0.24, scaleY: 0.30, rotate: -4, duration: 1.0, ease: 'power2.inOut' },
  START + 1.95);
tl.to('.sf-block-4', { opacity: 0, duration: 0.2, ease: 'power2.in' }, START + 2.78);

// 维度 4 · b5 飞向"方框"行
tl.to('.sf-block-5',
  { x: 1080, y: -40, scaleX: 0.08, scaleY: 0.74, rotate: 6, duration: 1.0, ease: 'power2.inOut' },
  START + 2.4);
tl.to('.sf-block-5', { opacity: 0, duration: 0.2, ease: 'power2.in' }, START + 3.3);
```

---

## 实战提示

- **卡位置**：CSS 只给宽度（620px）和 `position: absolute`，**调用方要自己加 `left/right/top`**（参考 04-s1-flow.html 是 `right: 12%; top: 50%; transform: translateY(-50%);`）
- **val 视觉是示例**：CSS 里给了 4 种类型（色块 / 字号 / 横条 / 方框）覆盖常见 val 形态。完全可以替换成 icon / 数字 / 图片 / 任何 HTML，照葫芦画瓢做新类型即可。
- **维度数量**：HTML 默认 4 行，加减 row 没有限制；但行数 > 5 时需要把 stagger 改小（0.08 → 0.06），否则整段超时。
- **变体 B 的 block 坐标**：默认是原视频"左半屏 article-card"的布局，**你的实际场景一定要重算**。可以先放变体 A 跑通节奏，再决定要不要补 block 飞入。
- **节奏与口播对齐**：原视频每行 val 蹦起对应一个口播词（"颜色" / "字号" / "排版" / "留白"），停顿 ~0.55s 一拍，正合 SRT。

---

## 来源

- 抽自 `2026-05-13/claude-design-codex-image/compositions/04-s1-flow.html`
- 对应原 CSS class 前缀 `b4-`，已重命名为 `sf-`
- 去掉了 `[data-composition-id="beat-4-s1flow"]` 命名空间约束
- GSAP 选择器 demo 用 `:nth-of-type` 选 row；用在工程里建议改成具体 class（`.sf-row-color` 等）避免 hyperframes bundler 的 wrapper strip 坑（见 HARD_CONSTRAINTS）
