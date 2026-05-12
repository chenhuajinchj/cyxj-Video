# Eldora UI / Terminal

## 1. 原始来源

- 原页面：https://www.eldoraui.site/docs/components/terminal
- 源码 .tsx：`github.com/karthikmudunuri/eldoraui` → 通过 shadcn registry: `https://www.eldoraui.site/r/terminal.json` → `registry/eldoraui/terminal.tsx`
- 抓取日期：2026-05-12

## 2. 视觉描述

明亮色 Mac 风格终端窗口。三步动画：
1. **打字阶段**：第一行命令逐字符打出来，末尾跟一个闪烁竖条光标（约 100ms 一字符）
2. **Reveal 阶段**：命令打完后，下方逐行 reveal 输出内容（每行可加粗，仿 shadcn CLI 的安装日志）
3. **通知气泡**：全部 reveal 完，右下角从上往下**滑入**一个 `localhost:3000` 通知卡片，写 "New App Created!"——这是 Eldora 这个 Terminal 的**独门视觉**，Aceternity / Magic UI 都没有

非常适合教程视频里"在终端跑 `npx hyperframes init` 然后弹出 'preview ready'" 这种节奏。

## 3. 翻译时丢了什么 ⚠️

- **原版用 React state machine（counter）每 pulseInterval 拍一帧驱动**：本版 1:1 用 `setInterval` 驱动相同的 counter 状态机，**逻辑零差异**
- **原版 lucide-react + react-icons/go 引入 icon**：本版手写 SVG 内联（terminal 三角形图标），**视觉一致**，但 lucide 的 stroke-linecap 细节略不同
- **原版用 `bg-card` `bg-muted` `text-foreground` 等 Tailwind theme token**：本版写死浅色配色到 CSS 变量。**主题切换（暗黑模式）丢失**——要做暗黑加一组 `[data-theme="dark"]` 变量
- **原版 `animate-in fade-in slide-in-from-top-10` （tailwindcss-animate 的预设）**：本版用纯 CSS `@keyframes et-slide-in`，**ease 曲线不完全一样**（原版可能用 `ease-out`，本版 `cubic-bezier(0.16, 1, 0.3, 1)` —— 我觉得后者更"果断"，但是审美差异）
- **原版 `animate-pulse` 光标**：原版是脉冲（透明度正弦波），本版是硬切换（`steps(1)`），**更像真终端**。差异是审美选择，原版的 pulse 更"温柔"

## 4. 可调 CSS 变量

| 变量 | 默认 | 含义 |
|---|---|---|
| `--et-width` | `600px` | 终端窗口宽度 |
| `--et-font-size` | `13px` | 字号 |
| `--et-radius` | `12px` | 窗口圆角 |
| `--et-bg` | `#fafafa` | 终端主色（亮色）|
| `--et-fg` | `#18181b` | 文字色 |
| `--et-fg-muted` | `#71717a` | 次要文字色 |
| `--et-border` | `#e4e4e7` | 边框色 |
| `--et-muted-bg` | `#f4f4f5` | titlebar 灰底色 |
| `--et-body-bg-from` | `#ffffff` | body 渐变起点 |
| `--et-body-bg-to` | `#f4f4f5` | body 渐变终点 |
| `--et-dot-red/yellow/green` | tailwind 默认 | mac 三色灯 |
| `--et-pulse-interval` | `100ms` | 每拍间隔（数越大越慢；100=fast, 200=正常）|

DOM 上：
- `data-command="..."` 控制打字内容
- `<template id="et-steps-1">` 里的 `<span class="et-step" data-bold="...">` 控制 reveal 行

## 5. 如何晋级到 templates/components/et-terminal/

1. `mkdir templates/components/et-terminal/`
2. 把 `index.html` 里 `CSS START → CSS END` 整段切到 `et-terminal.css`
3. 把 `index.html` 里 `HTML 片段 START → HTML 片段 END` 整段切到 `et-terminal.html`
4. `index.html` 里 `GSAP timeline START → END` 段是 setInterval 驱动的状态机，**晋级时整段保留**，在 composition 里用 `tl.call(play, [], <time>)` 在指定 beat 时刻触发
5. 给 `templates/components/et-terminal/` 写 README 说明：
   - 怎么改文案（直接改 DOM 里 `data-command` 和 `<template>` 内的 step）
   - 怎么改主题（改 `:root` 颜色组）
   - 时序在视频里怎么对齐：总时长 = `(命令长度 + steps数 + 1) × pulse-interval + 400ms通知滑入`
6. catalog.json:
   ```json
   {
     "name": "et-terminal",
     "type": "component",
     "title": "Eldora Terminal",
     "description": "Mac 风格终端 + 打字 + reveal + localhost 通知气泡",
     "tags": ["terminal", "typewriter", "notification"]
   }
   ```
7. INDEX.md 「终端类」下加一行
