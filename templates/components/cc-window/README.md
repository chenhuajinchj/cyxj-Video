# cc-window — Claude Code 终端 UI 完整体系

> 19 招视频 12/21 章实战验证的项目自创组件。
> Catalog 里没有同类零件，下次任何 Claude Code 教程视频可直接复用。
> 抽取于 2026-05-06（装备库盘点 Step 2 · A1 动作）。

---

## 用途

视频里需要画一个**真实感的 Claude Code 终端窗口**时使用。覆盖 5 种场景：

- 用户在终端里输入命令（typing 戏）
- 命令执行回显（✓ + 状态文字）
- Claude 调用 agent（旋转 dot → done check）
- Claude 反问（⚠ 19-tips 未实战）
- Claude 列表回应（⚠ 19-tips 未实战）

底部还有 Claude Code 标志性的 5-segment statusline（model / ctx / cost / tokens / rate）。

---

## 最小用法

```html
<!-- 1. 在你的 composition 顶部 link CSS -->
<link rel="stylesheet" href="../components/cc-window/cc-window.css" />

<!-- 2. 复制 cc-window.html 里的某个变体粘到 body -->
<div class="cc-window" id="cc-window">
  <div class="cc-titlebar">
    <span class="mac-dot r"></span>
    <span class="mac-dot y"></span>
    <span class="mac-dot g"></span>
    <span class="cc-title">claude — ~/project</span>
  </div>
  <div class="cc-body">
    <div class="cc-prompt-line">
      <span class="cc-prompt-arrow">&gt;</span>
      <span class="cc-cmd" id="cc-cmd">/statusline</span>
      <span class="cc-cursor" id="cc-cursor"></span>
    </div>
  </div>
</div>

<!-- 3. GSAP 给 #cc-cursor / #cc-cmd 加动画 -->
<script>
  tl.to('[data-composition-id="..."] #cc-cursor',
    { opacity: 0, duration: 0.4, repeat: -1, yoyo: true, ease: 'steps(1)' }, 0);
</script>
```

---

## 5 种 body 变体速查

| 变体 | 文件锚点 | 实战次数 | 适用场景 |
|---|---|---|---|
| **A · prompt-line + cursor** | cc-window.html 第 23 行 | 多次（Tip 1/6/11 等）| "用户在终端输入命令"基础场景 |
| **B · prompt-line + cc-info** | cc-window.html 第 41 行 | Tip 6 等 | "命令执行回显"绿色 ✓ + 状态 |
| **C · cc-response + agent 调用** | cc-window.html 第 60 行 | Tip 1 起手戏 | Claude 调 agent，旋转 dot → done check |
| **D · cc-question** | cc-window.html 第 87 行 | ⚠ **0 实战**（19-tips 用了别的 questions-panel） | "Claude 在终端直接抛问"暗色背景场景 |
| **E · cc-bullets + active** | cc-window.html 第 109 行 | ⚠ **0 实战**（19-tips 用了别的 todo-panel） | "Claude 给步骤列表"暗色背景场景 |

> ⚠ D/E 两个变体在 19 招里 CSS 已定义但 12 章没用，因为 19 招是浅色（米色）背景为主，问题/列表用了项目自制的浅色面板（questions-panel / todo-panel）。如果你做的视频是**暗色背景为主**或者**镜头主体就是终端窗口**，D/E 是合理选择。

---

## statusline 6 种 segment 拼装

每个 `.cc-statusline` 内可放任意数量的 `.cc-sl-seg`，segment 之间自动加竖线分隔：

| segment | icon class | 典型 value | 实战次数 |
|---|---|---|---|
| **model** | `.cc-sl-icon.model` | `opus-4.7` | 多次 |
| **ctx**（context %）| `.cc-sl-icon.ctx` | `38%` 可加 `.warn` / `.danger` 染色 | 多次（Tip 3 ctx-meter）|
| **cost** | `.cc-sl-icon.cost` | `$0.74` | 多次 |
| **tokens** | `.cc-sl-icon.tok` | `12.4k` | 多次 |
| **rate**（5h 进度）| `.cc-sl-icon.rate` + `.cc-sl-bar` | `42%` 含进度条 | Tip 1 |
| **mode**（plan / build）| `.cc-sl-icon.mode` | `plan` 通常 inline 覆盖 color | Tip 6 |

进度条 `cc-sl-bar` 用 CSS 变量 `--cc-sl-bar-fill` 控制百分比：

```html
<span class="cc-sl-bar" style="--cc-sl-bar-fill: 42%;"></span>
```

GSAP 时可直接动 CSS 变量（注意要用 `--cc-sl-bar-fill` 字符串作为 prop，gsap 3.10+ 支持）：

```js
tl.to('#sl-rate-bar', { '--cc-sl-bar-fill': '78%', duration: 1.0 }, 4);
```

---

## Design token 依赖

CSS 文件顶部用 `:where(:root)` 提供 fallback，**开箱即用**。如果你的项目已用 brand-tokens.css 定义了下面这些 token，本组件自动跟随：

| 本组件 token | fallback 链 | 默认值 |
|---|---|---|
| `--cc-bg` | `var(--c-terminal, #221F1C)` | 深棕黑 |
| `--cc-bg-soft` | `var(--c-terminal-soft, #322D28)` | 标题栏底 |
| `--cc-text` | `var(--c-terminal-text, #F8F1E7)` | 暖白 |
| `--cc-orange` | `var(--c-orange, #D97757)` | Claude 橙 |
| `--cc-teal` | `var(--c-teal, #2F7D73)` | ctx 段 |
| `--cc-success` | `var(--c-success, #4E8F72)` | 绿 ✓ |
| `--cc-warning` | `var(--c-warning, #C78A3B)` | warn 染色 |
| `--cc-danger` | `var(--c-danger, #B85138)` | danger 染色 |
| `--cc-font-mono` | `var(--f-mono, "JetBrains Mono"...)` | 等宽字体 |

想完全 override，在你自己的 CSS 顶部 :root 写 `--cc-orange: #你的颜色;` 即可。

---

## 已知约束 + 实战教训（来自 19-tips）

### 1. GSAP 操作 cc-window 居中要用 `xPercent` 不是 CSS `translate(-50%, -50%)`

**坑**：CSS `transform: translate(-50%, -50%)` 居中后，GSAP 操作 `x` / `scale` 会**完全覆盖** transform 属性，居中失效，元素跑偏。

**修法**：居中用 GSAP 的 `xPercent: -50, yPercent: -50`，或者直接用 flexbox 居中（外层容器 `display:flex; align-items:center; justify-content:center`）。

> 出处：19-tips Tip 10 esc-stop（commit cc599ad），retrospective 02-pitfalls.md P10。

### 2. cc-window grid layout 实际高度 ≠ CSS 预期

**坑**：cc-window 用 `grid-template-rows: 56px 1fr auto`，实际渲染高度依赖内容（cc-body 高度可变 + cc-statusline 高度 auto）。如果你用 `top:50%; translate(-50%,-50%)` 居中，translate 算的中心点会偏。

**修法**：父容器用 `display:flex; align-items:center; inset:0`，不依赖元素自身高度。

> 出处：19-tips Tip 1 V5（commit f36f96e），retrospective 02-pitfalls.md P11。

### 3. cc-cmd typing 戏不要用 GSAP textContent 整段动画

**坑**：GSAP 不能直接 tween 字符串。

**修法**：用一个 helper 函数，按时间步长追加字符到 `cc-cmd` 的 textContent：

```js
function typeCmd(rootSelector, fullText, startTime, perCharDelay = 0.06) {
  const el = document.querySelector(rootSelector + ' #cc-cmd');
  for (let i = 0; i <= fullText.length; i++) {
    tl.call(() => { el.textContent = fullText.slice(0, i); }, null, startTime + i * perCharDelay);
  }
}
```

> 出处：19-tips Tip 1（commit 9757bb8）。

### 4. cc-cursor 闪烁用 `ease: "steps(1)"`，不要用 `power2.inOut`

**坑**：cursor 闪烁应该是"硬切"开/关，不是渐变。

**修法**：

```js
tl.to(root + ' #cc-cursor',
  { opacity: 0, duration: 0.4, repeat: -1, yoyo: true, ease: 'steps(1)' }, 0);
```

### 5. cc-window 入场用 blur(14px) → blur(0) + power3.out

DNA 第 6 条入场节奏：

```js
tl.fromTo(root + ' #cc-window',
  { opacity: 0, y: 20, filter: 'blur(14px)' },
  { opacity: 1, y: 0, filter: 'blur(0px)', duration: 0.6, ease: 'power3.out' },
  startTime);
```

### 6. cc-question / cc-bullets 在浅色背景下不好看

`cc-question` 和 `cc-bullets` 是为暗色背景设计的（color 用 `rgba(248, 241, 231, *)` 暖白）。如果你的整片是**米色教程风**（如 19-tips），这两个变体会看起来很突兀。

**替代方案**（19-tips 实际做法）：
- 反问场景：用浅色 `questions-panel` + `question-item` 自制
- 列表场景：用浅色 `todo-panel` + `todo-item` 自制

下次做暗色背景视频时再启用 D/E 变体。

---

## 与其他组件的关系

| 关联组件 | 关系 |
|---|---|
| `MY_VISUAL_DNA.md` 第 6 条入场节奏 | cc-window 入场遵循 DNA blur 14px + power3.out 0.6s |
| `MY_VISUAL_DNA.md` 候选 DNA 节 | cc-window 列在"候选 DNA 观察 #1"，待第 2 条视频用了升级到正式 DNA |
| `MY_MOTION_NOTES.md`（A2 待写） | GSAP transform 接管 + 居中规范两个教训会引用本 README §1 §2 |
| catalog `claude-code-window` block | 不存在 — 本组件是 catalog 缺失的填补，可贡献回上游 |

---

## 来源 / 演变历史

- **2026-05-04 18:45** 首次实现：commit `4b57ab9` Tip 1 V5（重写终端 UI）
- **2026-05-04 19:08** 复用：commit `4bade5b` Tip 3 callback Tip 1
- **2026-05-04 19:55–20:30** 多章扩展：Tip 4/6 加 mode segment + agent-call 完整结构
- **2026-05-04 22:53** 重写：commit `cc599ad` Tip 10 esc-stop（碎裂 + GSAP transform 教训）
- **2026-05-05 各章** 持续用：Tip 8/9/11/12/13/16/17 共 12 章
- **2026-05-06** 抽取到 `templates/components/cc-window/`（commit 待）

---

## TODO（下次有新教程视频时验证）

- [ ] 试试在暗色背景视频里用 D（cc-question）和 E（cc-bullets），看是否能取代 questions-panel / todo-panel
- [ ] 检查 cc-statusline 在 9:16 短视频里要不要缩小字号
- [ ] 考虑加变体 F：长命令换行（19-tips 没遇到，但下次可能要）
