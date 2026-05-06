# Host-Overlay Alpha Template

## 适用场景

**适合：在达芬奇里精修录屏、需要把 overlay 和录屏分轨独立调色的视频。**

这个模板只渲染 4 个浮层（overlay），背景完全透明，输出 ProRes 4444 alpha MOV。
拿到 MOV 后，在 DaVinci Resolve 里把 overlay 轨叠在录屏轨上方，两轨可以独立调色、加效果、随时换录屏素材。

不适合：
- 不需要在达芬奇精修，直接出成品 MP4 → 用 `host-overlay` 模板（录屏和 overlay 烧死在一起）
- 纯演示无录屏 → 用 `demo-fullscreen` 模板

---

## 模板结构

仅包含 4 个 overlay 浮层，背景 alpha = 0（透明），无录屏背景层。

```
index.html（主合成，总时长 26s，1920×1080，30fps）
├── beat-1  [0–3.95s]    compositions/01-hook.html
│                        Claude Code 品牌卡片（logo + 频道名 + 标题），屏幕左侧滑入
├── beat-2  [5.46–11.24s] compositions/02-claude-terminal.html
│                        Claude Code 终端演示窗口 + 右上角状态 HUD
├── beat-3  [11.24–15.12s] compositions/03-motion-grid.html
│                        2×2 动效展示网格（配合录屏 PiP 布局）
└── beat-5  [15.12–26s]   compositions/05-pip.html
                          Claude Code 终端 + mini 片头/片尾 + outro（PiP 主舞台）
```

其余文件（`02-text-on-screen.html`、`03-karaoke-captions.html`、`04-mg-and-charts.html`）是备用 beat，
按需换入，默认不挂在 index.html 上。

---

## 怎么用

### 1. 复制到日期工作区

```bash
cp -R ~/项目/参考仓库/hyperframes/templates/host-overlay-alpha \
       ~/项目/参考仓库/hyperframes/2026-MM-DD/your-topic
cd ~/项目/参考仓库/hyperframes/2026-MM-DD/your-topic
```

### 2. 修改 meta.json

把 `id` 和 `name` 从 `xcyj-claude-overlays-only` 改成你的工程 id（全局唯一，如 `xcyj-20260506-demo`）。

### 3. 替换 index.html 里的关键字段

| 要改的地方 | 位置 | 说明 |
|---|---|---|
| `data-composition-id="xcyj-claude-overlays-only"` | `<div id="root">` | 改成与 meta.json 相同的 id |
| `data-duration="26"` | `<div id="root">` | 按实际总时长调整（秒） |
| `window.__timelines["xcyj-claude-overlays-only"]` | `<script>` 底部 | 同上，改成新 id |
| `mainTl.to({}, { duration: 26 }, 0)` | `<script>` | 时长锚点同步改 |

各 beat 的 `data-start` / `data-duration` 按实际口播时间轴调整。

### 4. 逐 beat 替换文案

打开 `compositions/01-hook.html`，把 `.b1-agent-name`（频道名）、`.b1-line-1/.b1-line-2`（标题两行）
改成当前视频的内容。其余 beat 同理，按注释找到对应文字节点。

### 5. Lint + Preview

```bash
# 必须在工程目录跑
npx hyperframes lint     # 必须 0 errors
npx hyperframes preview  # 浏览器验收，确认透明背景显示正常
```

**硬约束**：GSAP querySelector 不能用 template literal（`` `${root} .class` ``），
永远硬编码 selector 字符串，否则 lint 报 `template_literal_selector` error。

### 6. 达芬奇合成步骤

渲染出 MOV 后，在 DaVinci Resolve 里按以下步骤合成：

1. **导入素材**：把录屏 MP4 和 overlay MOV 都拖进媒体池。
2. **建时间线**：新建 1920×1080 / 30fps 时间线。
3. **铺轨道**：
   - 轨道 V1（最底层）：放录屏 MP4。
   - 轨道 V2（上层）：放 overlay MOV（`overlay.mov`）。
4. **设混合模式**：选中 V2 上的 overlay clip，
   在检查器 > 合成（Composite）面板，把模式改为 **Normal**（默认即 Normal）。
   ProRes 4444 自带 alpha 通道，DaVinci 会自动识别透明区域，无需额外节点。
5. **对齐起点**：把 overlay MOV 的起始帧对齐录屏的 00:00:00。
   如果两者帧率不同，DaVinci 会提示转换，选"使用时间线帧率"即可。
6. **验证透明**：在预览窗口，录屏底层应透过 overlay 的空白区域正常显示。
7. **分轨调色**（可选）：在调色页面，在节点图里对 V1（录屏）和 V2（overlay）各自加调色节点，互不干扰。
8. **交付输出**：交付页面选目标格式（H.264 MP4 或 ProRes），勾选"单片段输出"即可。

---

## 占位符清单

这个模板没有 `{{...}}` 格式的字符串占位符，所有内容直接写在 HTML 里，手动替换对应元素的文字。

| 需要修改的内容 | 所在文件 | 元素 class / 说明 |
|---|---|---|
| 工程 id | meta.json + index.html | `"id"` 字段 / `data-composition-id` 属性（共 3 处） |
| 总时长锚点 | index.html | `data-duration` + `mainTl.to(...)` duration 值 |
| 频道名 / eyebrow | 01-hook.html | `.b1-eyebrow`（CLAUDE CODE）、`.b1-agent-name`（陈与小金 · XCYJ） |
| 标题两行 | 01-hook.html | `.b1-line-1`、`.b1-line-2` |
| 终端命令参数 | 02-claude-terminal.html | `.b2-prompt-arg`（引号内的命令描述） |
| HUD 型号 | 02-claude-terminal.html | `.b2-hud-model`（claude-opus-4） |
| 各 beat 的 data-start / data-duration | index.html | 按实际口播时间轴调整 |

---

## 输出说明

| 项目 | 值 |
|---|---|
| 分辨率 | 1920×1080 |
| 帧率 | 30fps |
| 格式 | ProRes 4444 MOV（含 alpha 通道） |
| 背景 | 透明 |
| 文件大小 | 约 10–40 MB（ProRes 是编辑中间格式，体积较大，正常） |

**渲染命令**（在工程目录下执行）：

```bash
npx hyperframes render --format mov --output overlay.mov
```

与 `host-overlay` 模板的区别：

| | host-overlay-alpha（本模板） | host-overlay |
|---|---|---|
| 输出格式 | ProRes 4444 MOV（alpha 透明） | H.264 MP4（不透明） |
| 录屏 | 不包含，在达芬奇合成 | 烧进同一文件 |
| 达芬奇工作量 | 需要分轨叠合 | 直接用，无需额外操作 |
| 适合场景 | 需要分轨调色 / 替换录屏 | 一次出片，不改了 |
