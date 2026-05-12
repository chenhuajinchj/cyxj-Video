# Magic UI / Hyper Text

## 1. 原始来源

- 原页面：https://magicui.design/docs/components/hyper-text
- 源码 .tsx：`github.com/magicuidesign/magicui` → 通过 shadcn registry: `https://magicui.design/r/hyper-text.json` → `registry/magicui/hyper-text.tsx`
- 抓取日期：2026-05-12

## 2. 视觉描述

一段加粗大字，初始所有字母是**随机大写字母（A-Z）**，然后**从左到右**逐个"解密"成最终字符——给一种"乱码破解"或"密码学翻牌"的感觉。字符宽度等宽（mono 字体）所以 scramble 过程中字不抖。空格保持空格不参与。

原版默认 hover 触发，**本版** demo 加载时自动播 + hover 重触发 + replay 按钮。

## 3. 翻译时丢了什么 ⚠️

- **基本无丢失**：原版 React 实现就是 `requestAnimationFrame + setState` 改 DOM 文本。本版直接 `requestAnimationFrame + textContent` 改 DOM，**算法 1:1 还原**
- **原版 `<AnimatePresence>` + `motion.span` 包装**：原版每个 span 是 motion 组件，但**实际上没给任何动画 prop**（看 .tsx L173-181）——所以是死代码。本版去掉，无视觉影响
- **`startOnView` (IntersectionObserver)**：原版默认 false（即页面挂载 +delay 后自动跑），本版 1:1 保留这个行为。如果要 scroll-trigger，加 4 行 IntersectionObserver 即可
- **`characterSet` prop**：原版可传 custom charset（比如改成 katakana 仿 Matrix）。本版硬编码 A-Z；要 katakana 改 `CHARSET` 常量即可
- **Tailwind `font-mono` 等宽字体**：本版用 `JetBrains Mono → Menlo`，等价

## 4. 可调 CSS 变量

| 变量 | 默认 | 含义 |
|---|---|---|
| `--ht-color` | `#f8f1e7` | 字符颜色 |
| `--ht-size` | `48px` | 字号 |
| `--ht-duration` | `800ms` | 整段 scramble 完成时间（数越大越慢越神秘）|
| `--ht-charset` | `ABCDEFGHIJKLMNOPQRSTUVWXYZ` | 仅供查阅；改字符集去改 JS 常量 `CHARSET` |

并且：DOM 上 `data-final="..."` 决定最终展示文本。

## 5. 如何晋级到 templates/components/hyper-text/

1. `mkdir templates/components/hyper-text/`
2. 把 `index.html` 里 `CSS START → CSS END` 整段切到 `hyper-text.css`
3. 把 `index.html` 里 `HTML 片段 START → HTML 片段 END` 整段切到 `hyper-text.html`
4. `index.html` 里 `GSAP timeline START → END` 段实际是 vanilla JS（用 `requestAnimationFrame` 不是 GSAP）。**晋级时这段保持原样**摘到 composition 的 script 里。如果想让它和 GSAP timeline 配合，用 `tl.call(() => scramble(root, text, dur), [], start)` 在指定时刻触发
5. 给 `templates/components/hyper-text/` 写 README 说明：
   - 通过 `data-final` 属性设最终文本
   - `--ht-duration` 控制神秘感
   - 配合 hyperframes：在 beat 入场后 200ms 触发 scramble，等 scramble 完再走下一步
6. catalog.json:
   ```json
   {
     "name": "hyper-text",
     "type": "component",
     "title": "Hyper Text",
     "description": "随机字母 scramble 到目标字符的解密效果",
     "tags": ["text-anim", "scramble", "decrypt"]
   }
   ```
7. INDEX.md 「文字动画」类下加一行
