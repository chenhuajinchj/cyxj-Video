# Aceternity / Typewriter Effect

## 1. 原始来源

- 原页面：https://ui.aceternity.com/components/typewriter-effect
- 源码 .tsx：通过 shadcn registry 拉取 — `https://ui.aceternity.com/registry/typewriter-effect.json` → `components/ui/typewriter-effect.tsx`（仓库 Aceternity Labs，闭源 demo 站，源码以 shadcn registry JSON 形式公开）
- 抓取日期：2026-05-12

## 2. 视觉描述

一行加粗大字，每个字符**从左到右逐个出现**——不是简单淡入，而是字符在出现瞬间从 width:0 撑开到 width:auto，给"打字机咔咔"的感觉。整句结束在一个**闪烁的蓝色竖条光标**。可以给某些"重点词"换颜色（demo 里 "freedom" 高亮蓝）。

原版有两个变体：`TypewriterEffect`（字符 stagger 入场）和 `TypewriterEffectSmooth`（容器 width: 0 → fit-content 整体滑出）。本版只转译了**第一个变体**，因为它更适合教程视频"逐字强调"的节奏。

## 3. 翻译时丢了什么 ⚠️

- **原版 `useInView` 触发**：滚动进入视口才开始。本版改成"页面加载即播 + replay 按钮"——因为 hyperframes 是连续渲染管线，不需要 scroll trigger
- **原版 `display: 'inline-block'` 配合 `hidden` 切换**：本版改用 `width: 0 → width: auto` + `opacity` 双轴动画，视觉效果几乎一致，但**字符出现的瞬间宽度变化是 GSAP 渐变而非 React 重 mount**——细看会有 ~16ms 的差异
- **Tailwind 响应式字号** (`text-base sm:text-xl md:text-3xl lg:text-5xl`)：本版只给一个固定 `--tw-size: 48px`，等同于原版 lg 断点。要响应式自己加 media query
- **`stagger(0.1)` motion API**：GSAP `stagger: 0.1` 行为等价，无差异
- **第二个变体 `TypewriterEffectSmooth` 没转译**：那个是另一种动效（容器整体滑出而非字符 stagger），不在本批

## 4. 可调 CSS 变量

| 变量 | 默认 | 含义 |
|---|---|---|
| `--tw-text` | `#f8f1e7` | 普通文字颜色 |
| `--tw-accent` | `#3b82f6` | 高亮词 + 光标颜色（蓝色）|
| `--tw-char-stagger` | `100ms` | 每个字符出现的间隔（数字越大越慢）|
| `--tw-char-fade` | `300ms` | 单字符淡入持续时间 |
| `--tw-cursor-blink` | `800ms` | 光标闪烁周期（完整一开一合）|
| `--tw-size` | `48px` | 主字号 |
| `--tw-cursor-w` | `4px` | 光标宽度 |
| `--tw-cursor-h` | `40px` | 光标高度 |
| `--tw-word-gap` | `0.4em` | 单词间距 |

## 5. 如何晋级到 templates/components/typewriter/

1. `mkdir templates/components/typewriter/`
2. 把 `index.html` 里 `CSS START → CSS END` 整段切到 `typewriter.css`（顶部 `:root` 保留）
3. 把 `index.html` 里 `HTML 片段 START → HTML 片段 END` 整段切到 `typewriter.html`
   - 注意：DOM 里每个字符都要单独 `<span class="tw-char">` 包起来，做这个组件时**写一个生成器**比手敲快
   - 给重点词的 `.tw-word` 加 `accent` class 即可换色
4. `index.html` 里 `GSAP timeline START → END` 段作为 `templates/components/typewriter/README.md` 的"动画时序参考"。用户在 composition 里嵌时调用 `play()` 即可
5. 给 `templates/components/typewriter/` 写 README 说明：
   - 文案拆字符的方法（也许写个 helper：`splitToChars(text)` 自动生成 `.tw-char` 嵌套结构）
   - 怎么标记高亮词（`<span class="tw-word accent">`）
   - 时序在 hyperframes beat 里怎么对齐 SRT（每个字符出现 = 100ms × N，配合数据驱动的 stagger）
6. 在 `参考库/catalog.json` 加：
   ```json
   {
     "name": "typewriter",
     "type": "component",
     "title": "Typewriter Effect",
     "description": "字符逐个 stagger 入场打字机效果 + 闪烁光标",
     "tags": ["text-anim", "typewriter", "stagger"]
   }
   ```
7. INDEX.md 「文字动画」类下加一行
