# 视频工程模板复用指南

> ⚠️ **2026-05-07 状态注释**：本文档前半部分（"以 v2 / codex-intro 为半模板复制"方法论）已废弃。原因：v2 / codex-intro / 7-beat 这些都是早期一次性工程，复制起步会让新视频继承旧工程的 id、底色、特定文案——也就是"伪模板病"。当前唯一从 0 设计的真模板是 `templates/tutorial-8beat/`（见下文 tutorial-8beat 节）。其他形态请**从 0 写工程**，参考 `docs/hyperframes-official/getting-started/quickstart.md` 的最小骨架。旧 `videos/2026-05-02-*` 工程可看拓扑作参考，但不要 cp 起步。本文档全面重写排在 P2。

> 两个工程是"半模板"——下次做新视频时复制 + 改内容，不是全自动。
> 文件位置：`hyperframes-student-kit/video-projects/`（git ignore，git 里只有 `xcyj-progress/*-snapshot/` 快照）

---

## 选哪个模板？

| 视频类型 | 用哪个工程 | 原因 |
|---|---|---|
| 主播口播为主 + 旁边浮动效讲解 | `xcyj-claude-demo-v2` | 录屏铺底 + 4 个 beat overlay 的拓扑 |
| 含中文文字的"虚构 demo" 整片 + 配音后期加 | `xcyj-codex-claude-intro` | 7 beat 串联，无录屏，输出 H.264 mp4 |
| **AI/软件工具教程，≥30s，≥6 beat，有hook-痛点-解法-流程结构** | `templates/tutorial-8beat/` | 8 beat 完整教程骨架，占位符文案，面向实战复用 |
| 混合（片头主播 + 中段演示 + outro 主播） | 拼两个：v2 风格做片头/outro mp4 + codex-intro 风格做中段 mp4，达芬奇里串联 | — |

> 关键词：**"主体是真人 → v2"，"主体是 hyperframes 画面 → codex-intro 或 tutorial-8beat"**
>
> `codex-intro` vs `tutorial-8beat`：前者是 7 beat 固定结构（debate/terminal/topics/thesis），后者是 8 beat 教程通用结构（hook/pain/verdict/punchline/promise/concept/flow/outro），后者更适合新主题快速复用。

---

## tutorial-8beat 模板

路径：`templates/tutorial-8beat/`  
详细文档：[templates/tutorial-8beat/README.md](templates/tutorial-8beat/README.md)

### 快速开始

```bash
# 1. 复制到日期工作区
cp -R ~/项目/参考仓库/hyperframes/templates/tutorial-8beat \
       ~/项目/参考仓库/hyperframes/2026-MM-DD/your-topic

# 2. 改 meta.json 的 id（xcyj-tutorial-8beat-PLACEHOLDER → 你的 id）
# 3. 在 index.html 改对应 id（共 2 处）和 data-duration（默认 64.6）
# 4. 逐 beat 替换 {{...}} 占位符（参见 README.md 的占位符清单）
# 5. lint + preview
npx hyperframes lint
npx hyperframes preview
```

### Beat 结构一览

```
01-hook         [0→6.5s]   删除线气泡 + 大字 hero
02-pain-list    [6.5→13s]  三痛点卡片栈（stagger）
03-pain-verdict [13→19s]   左右双栏对比（✓ vs ✗）
04-punchline    [19→25s]   大字 + 终端 + 弧线箭头（⭐ hero beat）
05-promise      [25→31.5s] 章节卡（数字徽章 + 蓝色 halo）
06-concept      [31.5→42.5s] 三步流程卡（箭头连接）
07-flow         [42.5→56.5s] 5步 checkbox 执行计划
08-outro        [56.5→64.6s] 品牌 hero hold + 粒子爆发
```

### 关键参数（改 index.html 时）

- `--c-hot: #d97757` → 全局 hot 色（默认 Claude 橙，改此即全局换色）
- PiP 时序：face 在 18.4s 缩为右上角，60.0s 回归全屏
- 总时长默认 64.6s，按文案调整时需同步修改 3 处（data-duration + GSAP 锚点 + FULL 第二段时间点）

---

## 复用流程（以 codex-intro 为例）

### 1. 复制工程

```bash
cd ~/项目/参考仓库/hyperframes/hyperframes-student-kit/video-projects
cp -R xcyj-codex-claude-intro xcyj-NEW-TOPIC-intro
cd xcyj-NEW-TOPIC-intro
```

### 2. 改 `meta.json`

把 `id` 和 `name` 都改成 `xcyj-NEW-TOPIC-intro`，**否则与原工程冲突**。

### 3. 改 `index.html` 主合成

| 要改的 | 位置 | 内容 |
|---|---|---|
| `<title>` | `<head>` | 视频标题 |
| `data-composition-id="xcyj-codex-claude-intro"` | `<div id="root">` 和最后 `window.__timelines["..."]` | 改成新 id（共 2 处） |
| 7 段字幕 `<div class="caption clip">` | body 末尾 | 按新文案改文字、`data-start`、`data-duration` |
| `data-duration="52"` 和 `tl.to({}, { duration: 52 }, 0)` | 主 timeline | 总时长（如果 beat 时长变了） |
| 7 个 `<div id="beat-X">` 的 `data-start` / `data-duration` | body 中部 | 如果 beat 时长变了要重新对齐 |

### 4. 逐个 beat 改内容

每个 `compositions/0X-*.html` 里要改的：

| Beat | 主要改什么 |
|---|---|
| 01-hook | 标题文字（`<span class="b1-codex">` / `<span class="b1-cc">`）、eyebrow、tagline |
| 02-debate | 左右对决卡（`b2-card-name` × 2、`tag` × 2、`tagline` × 2）、merge 卡名字 |
| 03-terminal | prompt 命令（`b3-prompt-cmd` / `b3-prompt-arg`）、4 个 tool log row、code block JSON、done 文案、HUD server |
| 04-topics | 9 个 `<li class="b4-item">`（中文 + 英文）、headline 数字（如果不是 9 项要改 timeline 的 `FOCUS_DUR` 和 `forEach` 长度） |
| 05-thesis | `b5-token` 内文字（如果不是 `1+1>2` 要重新设计） |
| 06-cta | `b6-headline` / `b6-tagline` / `b6-button` / `b6-channel` |
| 07-outro | `b7-channel-name` / `b7-handle` / `b7-tagline` |

**不要改的**：CSS 颜色、动画时间表、`data-composition-id`（除非真的要换 beat 名）、selector 字符串。

### 5. 时间码调整

如果文案长度变了，beat 时长要重算：

| 文案字数 | 建议总时长 | 估算公式 |
|---|---|---|
| 200 字 | ~40s | 中文播报 5 字/秒 |
| 250 字 | ~50s | 当前模板 |
| 300 字 | ~60s | — |

调整时按比例分配到 7 个 beat：
- Hook 占总长 11-13%
- Debate 占 13-14%
- Terminal 占 19-20%（这个 beat 信息密度高，不要太短）
- Topics 占 25-27%（按列表项数：9 项 14s，6 项 ~10s）
- Thesis 占 10-12%
- CTA 占 9-10%
- Outro 占 7-8%

### 6. lint + preview + render

```bash
# 必须从工程目录跑
cd ~/项目/参考仓库/hyperframes/hyperframes-student-kit/video-projects/xcyj-NEW-TOPIC-intro

npx hyperframes lint                         # 必须 0 errors
npx hyperframes preview                      # http://localhost:3002 验收
npx hyperframes render --quality draft --format mp4 --output renders/draft.mp4
# 抽帧看（每个 beat 中点）
mkdir -p renders/frames
for t in 3 9.5 18 30 40 45.5 50.5; do
  ffmpeg -y -ss $t -i renders/draft.mp4 -frames:v 1 -q:v 2 "renders/frames/t${t}.png"
done
# 验收 OK 后跑 standard
npx hyperframes render --quality standard --format mp4 --output renders/final.mp4
```

---

## 常见坑

通用坑（GSAP template literal、beat id 替换、中文字体回退、不 commit 上游目录等）见仓库根 [`docs/HARD_CONSTRAINTS.md`](docs/HARD_CONSTRAINTS.md)。下面是 TEMPLATE_USAGE 场景特定的：

1. **typewriter selector 失效**（约束 #2 的具体复现）：从 `xcyj-codex-claude-intro` 复制 `03-terminal.html` 后忘换 `beat-3-terminal`，CSS class + GSAP selector 两处都要 sed 全局替换：
   ```bash
   sed -i '' 's/beat-3-terminal/beat-NEW-id/g' compositions/03-terminal.html
   ```
2. **commit 工程到 git**（约束 #6 的 workaround）：`hyperframes-student-kit/` 整个目录在 .gitignore 里。要保留代码到 git 必须 rsync 拷到 `xcyj-progress/工程名-snapshot/`：
   ```bash
   rsync -a --exclude='renders/' --exclude='*.mp4' --exclude='*.mov' \
     --exclude='*.mp3' --exclude='.DS_Store' --exclude='.debug-studio.mjs' \
     --exclude='.waveform-cache/' --exclude='.claude/' \
     hyperframes-student-kit/video-projects/xcyj-NEW-TOPIC-intro/ \
     xcyj-progress/NEW-TOPIC-snapshot/
   ```

---

## 达芬奇后期标准流程

| 模板风格 | 达芬奇 V1 | V2 | A1 | A2 |
|---|---|---|---|---|
| v2 (主播+overlay) | 录屏 mp4 | overlays-only.mov（ProRes 4444 alpha） | 录屏原音 / 配音 | BGM |
| codex-intro (整片) | hyperframes 输出 mp4 | 可选：再叠 alpha overlay 强化某段 | 配音 | BGM |

字幕选择：
- **保留 hyperframes 内嵌字幕**：方便快，但精度只到 beat 整段
- **关掉内嵌字幕（在 index.html 注释 `<div class="caption clip">`）+ 达芬奇 21 自动 AI 中文字幕**：精度高，可双语，达芬奇里调样式更灵活

---

## 时间预估

| 任务 | 第一次（设计 + 实施） | 复用（改内容） |
|---|---|---|
| codex-intro 整片（52s） | ~4-5 小时 | **~2 小时** |
| v2 风格（26s 含录屏） | ~3-4 小时 | **~1.5 小时** |

复用主要时间花在：改文案 / 调时间码 / 抽帧验证 / 等渲染。
