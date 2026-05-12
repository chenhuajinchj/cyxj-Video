# Magic UI / Terminal

## 1. 原始来源

- 原页面：https://magicui.design/docs/components/terminal
- 源码 .tsx：`github.com/magicuidesign/magicui` → 通过 shadcn registry: `https://magicui.design/r/terminal.json` → `registry/magicui/terminal.tsx`
- 抓取日期：2026-05-12

## 2. 视觉描述

暗色 Mac 终端窗口（圆角 + 三色灯 + 黑底），里面**按顺序播放多行内容**——每行可以是两种类型之一：

- **typing**：逐字符打字出现（带闪烁光标）
- **reveal**：从上往下淡入 + 滑入（带颜色化类如 ✔ 绿 / ℹ 蓝 / 灰色注释）

视觉灵感就是 **shadcn-ui CLI 的安装日志**——`✔ Preflight checks. ✔ Verifying framework...` 这种逐行飘出的感觉。

非常适合教程视频里"演示 npx install / 部署日志"的桥段。

## 3. 翻译时丢了什么 ⚠️

- **原版用 React Context（SequenceContext + ItemIndexContext）做序列调度**：每个子组件等待前一个 `onAnimationComplete` 才开始。本版改用 **GSAP timeline + setInterval** 顺序触发，**视觉一致但调度机制完全不同**——React 版本是"事件链"（前一个真正动完才推下一个），本版是"时间线"（按预估时长排好）。如果某行 typing 因为浏览器卡顿超时，本版可能时序错乱（实际 60fps 现代浏览器无感）
- **原版 `useInView` 启动**：本版页面加载就播 + replay 按钮。原因同 typewriter
- **`AnimatedSpan` 的 `motion.div` 入场动画**（opacity + y）：本版用 CSS `transition` + class toggle，**视觉一致**
- **原版 children 是任意 React 节点**：本版要求每行是 `.mt-item` 加 `data-type`。**灵活度降低**，但更显式更可控
- **Tailwind `bg-background` `text-foreground` theme token**：本版固定深色配色。**亮色模式丢失**

## 4. 可调 CSS 变量

| 变量 | 默认 | 含义 |
|---|---|---|
| `--mt-width` | `560px` | 终端宽度 |
| `--mt-bg` | `#0a0a0a` | 终端底色 |
| `--mt-fg` | `#f5f5f4` | 默认文字色 |
| `--mt-fg-muted` | `#a3a3a3` | 次要文字色 |
| `--mt-border` | `#262626` | 边框色 |
| `--mt-radius` | `12px` | 圆角 |
| `--mt-font-size` | `14px` | 字号 |
| `--mt-color-success` | `#22c55e` | success 类色（绿）|
| `--mt-color-info` | `#3b82f6` | info 类色（蓝）|
| `--mt-color-warn` | `#f59e0b` | warn 类色（黄）|
| `--mt-color-comment` | `#71717a` | comment 类色（灰）|
| `--mt-typing-speed` | `40ms` | 每字符打字时长 |
| `--mt-reveal-fade` | `250ms` | 单行淡入时长 |
| `--mt-reveal-gap` | `80ms` | 行间间隔 |

DOM：每个 `.mt-item` 加 class（`success` / `info` / `warn` / `comment`）+ `data-type="typing"` 或 omit（默认 reveal）+ `data-text="..."`（typing 必填）。

## 5. 如何晋级到 templates/components/mt-terminal/

1. `mkdir templates/components/mt-terminal/`
2. 把 `index.html` 里 `CSS START → CSS END` 整段切到 `mt-terminal.css`
3. 把 `index.html` 里 `HTML 片段 START → HTML 片段 END` 整段切到 `mt-terminal.html`
4. `index.html` 里 `GSAP timeline START → END` 段是 GSAP timeline + setInterval 调度。**晋级时整段保留**，在 composition 里：
   - 视频起手时机：`tl.call(play, [], <beat-start>)`
   - 或：让 `play()` 返回的 timeline 嵌入主 timeline `mainTl.add(play(), <time>)`
5. 给 `templates/components/mt-terminal/` 写 README 说明：
   - 怎么改日志内容（编辑 `.mt-item` 们）
   - 怎么估总时长：`Σ(typing.length × typing-speed) + reveal数 × (reveal-fade + reveal-gap)`
   - 第一行 typing 通常配视频里口播"我跑这个命令"，后续 reveal 配口播"它装了 X、Y、Z"
6. catalog.json:
   ```json
   {
     "name": "mt-terminal",
     "type": "component",
     "title": "Magic Install Log Terminal",
     "description": "shadcn 风格安装日志终端 + typing + reveal 颜色化",
     "tags": ["terminal", "install-log", "shadcn"]
   }
   ```
7. INDEX.md 「终端类」下加一行
