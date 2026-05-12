# Magic UI / Retro Grid

## 1. 原始来源

- 原页面：https://magicui.design/docs/components/retro-grid
- 源码 .tsx：`github.com/magicuidesign/magicui` → 通过 shadcn registry: `https://magicui.design/r/retro-grid.json` → `registry/magicui/retro-grid.tsx`
- 抓取日期：2026-05-12

## 2. 视觉描述

经典 80s synthwave **复古透视网格**——视角从地面看出去，一片向远处推近、不断向下滚动的网格。配合粉紫渐变背景和大金色字标题，瞬间复古迪斯科风。

视频里非常适合做"hero 片头底图" / "Codex / Retro 类组件演示底纹" / "音乐 / 游戏类视频铺底"。

## 3. 翻译时丢了什么 ⚠️ **重要**

原版用 **WebGL fragment shader**（800+ 行 GLSL 代码）做这个网格，里头做了：
- **Anti-aliasing**：网格线在远处不糊不闪
- **LOD (Level of Detail)**：远处的网格线密度自动降半再降半，避免摩尔纹
- **Edge compression**：左右边的线压缩感
- **Top fade**：远处自然淡出
- **Device pixel ratio 适配**：高 DPI 屏锐利

**本版用的是原版自带的 CSS fallback** ——即原版 .tsx 文件里 `FALLBACK_STYLES` 和 `createFallbackGridStyle()` 那段。是同一个 Magic UI 团队为 WebGL 不可用时准备的降级方案，所以**视觉是"官方认可的简化版"**，不是我自己瞎做。

差异：
- ❌ **远处的网格线会出现摩尔纹**（CSS 没法做 LOD）
- ❌ **网格线锐利度在不同缩放下不一致**
- ❌ **没有 Top fade by shader**，本版用一层 `::before` 渐变蒙板模拟
- ✅ **滚动动画一致**（CSS keyframes vs WebGL u_time）
- ✅ **`prefers-reduced-motion` 兼容**（同原版）
- ✅ **角度 / 单元大小 / 颜色 / 透明度** 全部 1:1 可调

**如果你做出的视频在大屏上摩尔纹明显**，告诉我，下一版我可以把 WebGL shader 也搬过来（800 行 GLSL 是可移植的，但工作量大）。

## 4. 可调 CSS 变量

| 变量 | 默认 | 含义 |
|---|---|---|
| `--rg-angle` | `65deg` | 透视倾角，1-89，越大越平 |
| `--rg-cell-size` | `60px` | 单元尺寸 |
| `--rg-perspective` | `200px` | CSS perspective 远近感 |
| `--rg-line-color` | `rgba(255,255,255,0.45)` | 网格线颜色 |
| `--rg-opacity` | `0.5` | 整体不透明度 |
| `--rg-line-width` | `1px` | 线宽 |
| `--rg-scroll-duration` | `15s` | 一轮滚动周期（数越大越慢）|

## 5. 如何晋级到 templates/components/retro-grid/

1. `mkdir templates/components/retro-grid/`
2. 把 `index.html` 里 `CSS START → CSS END` 整段切到 `retro-grid.css`
3. 把 `index.html` 里 `HTML 片段 START → HTML 片段 END`（仅 3 行 div 嵌套）切到 `retro-grid.html`
4. `index.html` 里 `GSAP timeline START → END` 段实际是注释说明 + 可选 GSAP 钩子（不是必须）。**晋级时这段可保留为参考，可不带**
5. 给 `templates/components/retro-grid/` 写 README 说明：
   - 用法：作为 beat 的**背景层**（z-index 最底），用 `<div class="rg-root">` 放在 `.clip` 顶部
   - 调整复古感：调 `--rg-angle` 和 `--rg-cell-size`（小单元更"远看"，大单元更"近看"）
   - 配合 hero 文字：上层加 `text-shadow: 0 0 40px <accent>` 配复古发光
6. catalog.json:
   ```json
   {
     "name": "retro-grid",
     "type": "component",
     "title": "Retro Grid",
     "description": "80s synthwave 复古透视网格背景（CSS fallback 版）",
     "tags": ["background", "retro", "synthwave"]
   }
   ```
7. INDEX.md 「背景特效」类下加一行

## 6. 升级到 WebGL 版的路径（如果未来需要）

- 把原 `original.tsx` 里 VERTEX_SHADER_SOURCE 和 FRAGMENT_SHADER_SOURCE 两段 GLSL 直接拿走
- 用 vanilla JS 做 WebGL 初始化（同 .tsx 里 `createProgram` / `getProgramInfo`）
- 在 beat 里：
  ```html
  <div class="rg-root">
    <canvas class="rg-canvas"></canvas>
    <noscript>... CSS fallback 同本版 ...</noscript>
  </div>
  ```
- 用 requestAnimationFrame 喂 u_time 跑 shader
- **800 行 + WebGL context lost 处理，工作量约 2-3 小时**

但**先别做**——CSS 版可能已经够看，等真有摩尔纹问题再升级
