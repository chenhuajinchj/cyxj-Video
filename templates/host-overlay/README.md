# Host-Overlay Template

## 适用场景

**主播口播为主，录屏铺满底层，4 个 overlay 浮在上面辅助讲解**（总时长 ≥30s，推荐 20–30s 片段）。

典型场景：
- 教程视频中"边说边演示"的核心段落（主播在画面中讲，旁边浮出终端/动效卡/数据图）
- 需要把录屏和动态字幕/图表同时呈现给观众的片段

不适合：纯动效无录屏（用 `demo-fullscreen` 模板）、纯录屏剪辑不需要叠加 overlay 的情况。

---

## 模板结构

录屏 `#face-wrapper` 铺满底层，4 个 beat overlay 叠在上方。录屏有两种状态（GSAP 主时间线控制）：
- **FULL 模式**（0–11.24s）：录屏铺满 1920×1080，overlay 浮在上面
- **PiP 模式**（11.24s 起）：录屏缩到右上角 540×960，左侧让给 beat 5 主舞台

| Beat | 文件 | 作用 | 默认时长 |
|------|------|------|---------|
| beat-1-hook | `compositions/01-hook.html` | 左侧毛玻璃卡片：logo + 品牌名 + 大字标题，FULL 模式下浮在录屏左侧 | 3.95s |
| beat-2-terminal | `compositions/02-claude-terminal.html` | 左侧终端窗口 + 右上 HUD 状态面板，展示 Claude Code 运行过程 | 5.78s |
| beat-c-motion-grid | `compositions/03-motion-grid.html` | 左侧 2×2 动效合集卡片（粒子爆发、字幕飞入、数字滚动、光效横扫），PiP 切换前的过渡 beat | 3.88s |
| beat-5-pip | `compositions/05-pip.html` | PiP 模式主舞台：终端 + 进度条 + 预览框（mini 片头/片尾）+ 最终 outro CTA | 10.88s |

---

## 怎么用

### 1. 复制到日期工作区

```bash
cp -R ~/项目/参考仓库/hyperframes/templates/host-overlay \
       ~/项目/参考仓库/hyperframes/2026-MM-DD/your-topic
cd ~/项目/参考仓库/hyperframes/2026-MM-DD/your-topic
```

### 2. 改 meta.json

把 `id` 和 `name` 从 `xcyj-claude-demo-v2` 改成你的工程 id（全局唯一，如 `xcyj-claude-tips-01`）。

### 3. 替换 index.html 占位符

- `data-composition-id="xcyj-claude-demo-v2"` → 改成与 `meta.json` 相同的 id（共 2 处：`#root` 和脚本末尾 `window.__timelines[...]`）
- `data-duration="26"` → 按实际总时长调整
- 录屏 PiP 切换时间点 `11.24` → 按实际语义边界调整（两处：`data-start` 和 `mainTl.to` 锚点）

### 4. 准备录屏底图

把录屏文件放到 `assets/recording.mp4`（muted），单独 audio 轨另放。把 `index.html` 里的 `#face-video` 占位 div 换成：

```html
<video id="face-video" src="assets/recording.mp4" muted playsinline></video>
```

然后在 GSAP 主时间线里 `.call(() => video.play(), [], 0)` 同步起播。

### 5. Lint + Preview

```bash
# 必须在工程目录里跑，不能在仓库根
npx hyperframes lint       # 必须 0 errors
npx hyperframes preview    # 浏览器验收后再 render
```

**硬约束**：GSAP `querySelector` 不能用 template literal（`` `${root} .x` `` 会触发 `template_literal_selector` error），永远硬编码 selector 字符串，如 `'[data-composition-id="beat-1-hook"] .b1-card'`。

---

## 占位符清单

| 需改的值 | 位置 | 说明 |
|---------|------|------|
| `xcyj-claude-demo-v2` | `meta.json` id/name | 工程唯一 id，改后同步到 index.html |
| `data-composition-id="xcyj-claude-demo-v2"` | `index.html` `#root`（1 处） | 与 meta.json id 保持一致 |
| `window.__timelines["xcyj-claude-demo-v2"]` | `index.html` 脚本末尾（1 处） | 同上 |
| `data-duration="26"` | `index.html` `#root` | 总时长（秒），按实际调整 |
| `11.24`（PiP 切换点） | `index.html` GSAP `mainTl.to` | 录屏从 FULL 切 PiP 的时间点 |
| beat 各 `data-start` | `index.html` 各 beat div | 每个 beat 相对于总时间线的起始秒数 |
| 录屏占位 div | `index.html` `#face-wrapper` 内 | 换成真实的 muted video 标签 |
| `01-hook.html` 文案 | `compositions/01-hook.html` | `.b1-eyebrow` / `.b1-agent-name` / `.b1-line-1` / `.b1-line-2` |
| `02-claude-terminal.html` 文案 | `compositions/02-claude-terminal.html` | 终端标题、命令文字、log 行文案、HUD model 名称 |
| `03-motion-grid.html` 文案 | `compositions/03-motion-grid.html` | 标题区 eyebrow / title-zh / title-en，4 张卡片名称 |
| `05-pip.html` 文案 | `compositions/05-pip.html` | kicker 文字、终端命令行、mini intro/outro 标题、outro CTA 品牌名 |

---

## 输出说明

- **输出格式**：整片 MP4，1920×1080，30fps
- **烧录方式**：录屏和所有 overlay 烧进同一个 MP4，不分轨
- **与 host-overlay-alpha 的区别**：本模板输出不透明 MP4（含录屏底层）；`host-overlay-alpha` 输出 ProRes 4444 alpha（overlay 透明层，供达芬奇合成用）
- **render 命令**（在工程目录）：

```bash
npx hyperframes render
```
