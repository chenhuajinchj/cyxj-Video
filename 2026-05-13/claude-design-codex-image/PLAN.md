# 反 PPT 化大改造 — 2026-05-13 AI 生图工作流复盘视频

## Context

用户反馈 13 beat 工程「动效太像 PPT 了」。诊断有**两层根因**：

### 根因 1：动效层 PPT 化（表面问题）

对照仓库根 `MOTION_PHILOSOPHY.md`（基于 Infinite Payments 30s 反向工程的 11 条法则）量化扫描：

- **零持续微动**：13 个 beat `repeat: -1` 一次都没用，元素入场即定格（违反 Law #4 Camera Never Sleeps）
- **零 motion-blur transition**：13 个 beat 间硬切 / fade（违反 Law #5 Motion Blur is a feature）
- **fade-up 一招吃天**：113 次 `{y, opacity:0}→{y:0, opacity:1}` + 84 次 `power3.out`

### 根因 2：字幕翻译病（根本问题，用户 2026-05-13 反馈确诊）

13 个 beat 都是"把口播翻译成 HTML 元素"——口播说"Anthropic"屏幕就显示 "Anthropic" tag，说"挖角副总裁"就画 F→A 箭头，说"股价下跌"就画 sparkline。**视觉是字幕的伴奏，不是叙事的载体**。

对照 Law #6「Object metaphors carry meaning」（Red card = 老/broken；Teal coin = 新/working）：Infinite Payments 30s 视频用红卡象征"问题"用青币象征"解法"，用**物体象征**承载概念，不用**文字解释**。

**根因 2 是根因 1 的源头**：如果每个 beat 都是"几张卡片 fade-up"，不管动效多花，永远是 PPT。先解决根因 2（视觉 metaphor 重构），动效层升级才有意义。

用户决策：**大改造（Tier 1+2+3 全上）**，但**视觉 DNA 锁死**——颜色 + 字体不动，**重构视觉 metaphor + 动效层 + 时间码对齐**。

## 不可动的边界（视觉 DNA 锁死）

| 维度 | 锁死值 |
|---|---|
| 颜色 | 极浅米 `#fafaf8` 底 / 墨黑 `#0b0b08` ink / 荧光柠檬 lime `#dcff45` accent / Claude 橙 `#D97757` 仅产品 logo |
| Hero 字体 | Songti SC 衬线（不引入 chrome gradient + halo，原因：米底上 chrome 不 work） |
| 正文字体 | SF Pro / PingFang SC |
| Beat 结构 | 13 beat 切分不动、SRT 时间码不动、文案不动 |
| 产品 logo | b3/b6/b7 已用真 SVG（Claude / Codex / Figma / Anthropic），不动 |

**可动**：所有 GSAP timeline / 元素入场出场 / 持续微动 / beat 间转场 / hero 元素的动作幅度（scale / motion blur） / 节奏 stagger。

## 核心约束 — SRT 时间码对齐

工程根有 `2026-05-13/AI生图(1).srt`（452 行）= 8 句/beat 切分的逐字稿。每个 beat 的 HTML 顶端注释已经标了 SRT 时间码切分（例如 b3 注释里 `0.633–3.066 "是Anthropic上个月发了一个新产品"`）。

**Hard rule**：每个视觉变化（元素入场 / hero scale 启动 / shader transition 落点）的 `tl` 时间码**必须对齐 SRT 关键词瞬间**。teaser 不准 spoiler 下一句视觉。空窗段（>1s 没口播）加过程视觉。

对应已有 memory `feedback_visual_sync_to_srt`。

## 技术栈升级

- **GSAP CDN 升级**：`gsap@3.14.2` → `gsap@3.15`（v3.15 已全部 free，含以前付费的 plugin）
- **新加载 plugin**：`SplitText`（字符 / 词级 stagger）、`Flip`（A→B morph）
- **注入位置**：`2026-05-13/claude-design-codex-image/index.html` 的 `<head>` 顶部
- **改造前置**：`<script>` 顶部加 `gsap.registerPlugin(SplitText, Flip);`

CDN URLs:
```html
<script src="https://cdn.jsdelivr.net/npm/gsap@3.15/dist/gsap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/gsap@3.15/dist/SplitText.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/gsap@3.15/dist/Flip.min.js"></script>
```

## Tier 0 — 视觉 metaphor 重构（根本改造，先于动效层）

每个 beat 不再"把口播翻成 HTML 元素"，而是先做**语义扩展联想**：这句话拍成电影是什么画面？用什么**物体 / 动作 / 场景**承载概念？

### 联想方法

每句 SRT 问 3 个问题：

1. **这句话的核心概念是什么**？（不是关键词，是底层意思）
2. **如果不能用文字解释，画面怎么传达**？（找 object metaphor）
3. **这个画面如何延续到下一句**？（visual continuity / callback）

### b1-b3 示范（用户拍板这个方向后，b4-b13 同样套路展开）

#### b1 hook (0-8.3s) — "设计师对 AI 默认审美零容忍 / 工作流跑出来的图一个比一个简单/好看"

| 句 | 当前做法（字幕翻译病） | 视觉 metaphor 联想 |
|---|---|---|
| "作为设计师出身的我" | 字符 stagger 出 11 个汉字 | 一只**手** / **眼睛**的剪影（设计师标志），或 **设计工具光标**在屏幕上点击留下印记 |
| "对 AI 默认审美零容忍" | 字符 scramble + lime 划线 + shake-error 抖动 | **撕毁纸张**的动作（拒绝感）/ AI 生成的"丑图"原型从画面飞过被**红 X 叉掉**/ 一堆"丑图"塞满画面然后**被一只手扫掉** |
| "工作流跑出来的图一个比一个简单/好看" | 3 张参考卡 + 2 个 chip | 3 张图**从远到近浮起**（从最简单 → 最好看），第三张**放大占满画面**——观众感受到"递进"而不是看到 3 张并排卡 |

#### b2 teaser (8.3-11.2s) — "三个阶段"

| 句 | 当前 | metaphor |
|---|---|---|
| "三个阶段" 之前 | "AI" 大字 + 副标 | **时间线 / 跑道** 横贯画面，3 个发光的**节点**沿时间线排列；"三" 这个字不直接显示，而是观众**数出 3 个亮点** |

#### b3 s1-intro (11.2-23s) — "Anthropic 上月发了 Claude Design / 把 Figma 副总裁挖过来 / Figma 股价持续下跌"

| 句 | 当前 | metaphor |
|---|---|---|
| "Anthropic 上月发了新产品" | "Anthropic" 黑 tag + 副标 | **产品发布会聚光灯**从黑暗中打下来，光圈下浮现一个**未开启的"盒子"或"光柱"** |
| "叫 Claude Design" | 产品卡 + Claude logo + 副标 | 光柱中产品**升起 / 拆封**，Claude logo + "Claude Design" 字**刻**在产品下方（不是 fade-up） |
| "专门干设计这件事情" | 副 chip "DESIGN" | 产品周围浮现**设计工具图标光环**（Figma / Sketch / Procreate 等同类工具图标围绕一圈） |
| "把 Figma 副总裁挖过来" | F→arrow→A | Figma 大楼/logo 里**一个人形剪影被一只手抓出来 → 飞越画面 → 落到 Anthropic 一侧**（真"挖"的动作） |
| "Figma 股价持续下跌" | sparkline 折线 | Figma logo 在画面顶部，**像石头一样掉下来**，掉落过程留下 motion blur trail；落地时画面震动，"−14.2%" 红字从地面**砸出**裂缝 |

### Tier 0 设计原则

- **概念 → 物体**：每 beat 先定 1-2 个核心 metaphor 物体（产品发布的"光柱"、挖角的"被抓出来的人形"、下跌的"掉落物"），整 beat 围绕这个物体设计
- **callback**：beat 间复用同一物体强化记忆（Law #6）。比如 Claude Design 的"光柱"在 b13 outro 可以再次出现作收尾呼应
- **避免文字解释**：能用画面说的就不用 tag 文字。Tag 只在画面无法承载抽象概念（比如 "PHASE 01" kicker）时用
- **保 DNA**：所有 metaphor 用米色 / 墨黑 / lime 三色实现，物体用衬线/无衬线字体的"图形剪影"或现成 SVG（Heroicons / Phosphor / lobe-icons）

### 实施流程

1. **Tier 0 优先**：先把 13 beat 的 metaphor 表逐个填完（plan 现在只示范 b1-b3，b4-b13 等用户拍板这个方向后再展开）
2. **每个 beat 实施前**：在 plan 里有 metaphor 表 → 设计师（用户）确认 → 我再写 HTML/CSS/GSAP
3. **不要**："先把 Tier 1 动效层做完再讲 metaphor" —— 没有 metaphor 的话动效再花还是 PPT

---

## Tier 1 — 全 13 beat 必做（铺底，反 PPT 化骨架）

| 招式 | Law | 每 beat 实施 |
|---|---|---|
| **持续微动 idle motion** | #4 | Hero 元素（产品卡 / 节点 / hero 大字）入场后追加 `gsap.to(el, {y:'-=8', scale:1.02, repeat:-1, yoyo:true, duration:2.5, ease:'sine.inOut'})` |
| **非均匀 stagger** | — | 把所有 `stagger: 0.14` 替换为 `stagger: {each:0.12, from:'center', ease:'power2.inOut'}` |
| **cut-the-curve vertical whip transition** | #5 | 每个 sub-composition timeline 头加 entry blur（`{y:150, filter:'blur(30px)'} → {y:0, filter:'blur(0px)', duration:1.0, ease:'power2.out'}`），尾加 exit blur（`{y:-150, filter:'blur(30px)', duration:0.33, ease:'power2.in'}` 在 beat 末 0.33s 触发）|
| **全片 vignette breath + grain overlay** | #4 #10 | 在 `index.html` 加一次：vignette layer + `gsap.to(vignette, {opacity:0.9, repeat:-1, yoyo:true, duration:4, ease:'sine.inOut'})` + 装 `npx hyperframes add grain-overlay` |

## Tier 2 — 用 GSAP 招式实现 Tier 0 metaphor

Tier 0 定 metaphor（"光柱下来 / 人形被抓出来 / 物体掉落"），Tier 2 定**用什么 GSAP 技巧实现**这些 metaphor。

**b1-b3 实施手法（示范，对应 Tier 0 b1-b3 metaphor 表）**：

| Beat | metaphor → 实现手法 |
|---|---|
| **b1 hook** | • "撕毁纸张拒绝丑图"：用 GSAP **clip-path inset wipe** 把"丑图"原型从中间撕开 + `filter:blur` 残影；红 X 用 SVG path stroke-dasharray 画出来<br>• 3 张图"从远到近浮起"：z 轴用 `z` + `scale` 模拟 perspective，配 `stagger:{from:'end'}` 让第三张最大最近；最末张做 dramatic `scale: 1→1.5` + 居中位移 |
| **b2 teaser** | • "时间线 3 节点"：SVG `<line>` 横贯画面用 `stroke-dasharray` 画出来；3 个节点用 `stagger:{each:0.4, from:0}` 沿线点亮；节点用 `box-shadow` glow + `repeat:-1 yoyo` breathing |
| **b3 s1-intro** | • "聚光灯打下来"：`<div>` radial-gradient 锥形光，用 `scaleY 0→1` + `transform-origin: top` 从顶部铺下来<br>• "产品从光柱中升起"：产品卡 `y: 200, opacity: 0 → y: 0, opacity: 1`，配 cinematic ease `back.out(1.2)` 微 bounce；Claude logo + 字"刻"用 SplitText chars + `clip-path inset` 从下到上揭<br>• "挖角人形被抓出飞过画面"：在 `参考库/assets/logos/` 找 person SVG（或现成 Heroicons `user`），从 Figma 大楼位置 → 飞越中线 → 落到 Anthropic 位置，路径用 GSAP **MotionPath plugin** 沿 SVG 曲线移动 + motion blur trail（`filter:blur` 在路径中段加大，落地时归零）<br>• "Figma logo 掉下来砸出裂缝"：Figma logo `gsap.to({y: '+=600', rotation: 15, duration: 1.4, ease: 'power3.in'})` 重力感掉落；"−14.2%" 用 SVG path 模拟裂缝从落地点扩散开 |

**b4-b13 实施手法**：等 Tier 0 metaphor 联想 b4-b13 落定后展开（**先 metaphor 后手法**，不能跳）

### GSAP plugin 必装清单（v3.15）

- **核心**：`gsap.min.js`
- **SplitText**：字符 / 词级 stagger（b1 字符、b3 "刻字"、b5 词 ghost）
- **Flip**：A→B 状态 morph（b6 双脑 morph、可能 b8 / b11）
- **MotionPathPlugin**：沿 SVG 曲线移动（b3 人形飞越、可能 b10 平台 chip 炸开）
- **TextPlugin**：count-up 数字（可能 b8 / b12）
- **CustomEase**（可选）：seam velocity-matched 二次缓动（MOTION_PHILOSOPHY §3.9）

## Tier 3 — Shader transition（act 边界，2 处）

只在两个 act 边界用 shader transition（节制使用避免内存炸；按 memory `feedback_hf_composition_count_memory`）：

| 边界 | 位置 | shader block |
|---|---|---|
| Act 1 → Act 2 | b5 末 → b6 头（40.25s）| `npx hyperframes add cinematic-zoom` —— "从痛点"穿过去到"双脑解法" |
| Act 2 → Act 3 | b9 末 → b10 头（69s）| `npx hyperframes add cross-warp-morph` —— "反思"morph 进"流量操盘" |

其他 11 处 beat 切换用 Tier 1 的 cut-the-curve vertical whip（轻量、确定性、不耗 GPU）。

## 关键文件

**改造目标**：
- `2026-05-13/claude-design-codex-image/index.html` —— GSAP plugin 加载 + vignette / grain 全片层 + Tier 3 shader transition 注入
- `2026-05-13/claude-design-codex-image/compositions/01-hook.html` ~ `13-outro.html` —— 每个加 idle motion + 非均匀 stagger + entry/exit blur transition + hero 招式

**参考源**（已读 / 已 fetch）：
- `/Users/chenhuajin/项目/参考仓库/hyperframes/MOTION_PHILOSOPHY.md` —— 11 Laws + 完整 motion vocab + GSAP recipe（§2.4 移动词表、§3.4 whip、§3.5 recolor、§3.11 camera pan）
- `https://gsap.com/docs/v3/Installation/` —— v3.15 全 free，CDN 加载所有 plugin
- `https://hyperframes.mintlify.app/launch-videos.md` —— HeyGen 官方 launch 工程参考
- `2026-05-13/AI生图(1).srt` —— **每个动效都对齐这个时间码**

**SRT 时间码索引**（每个 beat 的 SRT 切分已写在 composition HTML 顶端注释里，无需额外解析）

## 落地步骤（分阶段执行）

**关键节点：Tier 0 metaphor 表必须先于任何代码改造**。Plan 现在只有 b1-b3 的 metaphor 示范，**用户拍板 b1-b3 方向后**，先把 b4-b13 metaphor 表展开到 plan，**所有 metaphor 都过设计师评审通过**，才进入 Stage 0 开始写代码。

1. **Stage M — Metaphor 评审**（不写代码，只填表 + 你拍板）
   - 在 plan 文件里展开 b4-b13 的 Tier 0 metaphor 表（每 beat 给 2-3 个 metaphor 候选）
   - 你逐 beat 拍板用哪个 metaphor
   - 13 beat metaphor 表全部锁定后才进 Stage 0

2. **Stage 0 — GSAP 升级 + 全片层**（先做，影响所有 beat）
   - `index.html` 头部：升 `gsap@3.14.2` → `gsap@3.15` + 加 SplitText + Flip CDN + registerPlugin
   - `index.html` 加 vignette layer（top of all content, pointer-events: none, radial-gradient soft）
   - `npx hyperframes add grain-overlay` 一次性
   - 全片 vignette breath tween（Tier 1 #4）

2. **Stage 1 — Tier 1 铺底（13 beat 批量）**
   - 每个 `compositions/*.html` 加 entry/exit blur transition（cut-the-curve）
   - 每个 `*.html` 的 hero 元素加 idle motion（breathing / drift）
   - 全工程 stagger 改 `from: 'center', ease: 'power2.inOut'`

3. **Stage 2 — Tier 2 hero beat 升级（13 beat 各自的 hero 招式）**
   - 按 Tier 2 表逐 beat 实施
   - 每改一个 beat 在 Studio preview 看 baseline → 改后对比
   - SRT 时间码严格对齐（每个动效启动点对应 SRT 重音瞬间）

4. **Stage 3 — Tier 3 shader transition 注入（2 处）**
   - `npx hyperframes add cinematic-zoom` + 接 b5→b6
   - `npx hyperframes add cross-warp-morph` + 接 b9→b10

5. **Stage 4 — Visual verify + commit**
   - 清 `.thumbnails/`（已有 memory `feedback_thumbnails_cache_gotcha`）
   - Studio 完整 preview 1 遍
   - 量化扫描确认：`repeat: -1` ≥ 13、blur-transition ≥ 12
   - 按 Law #11 跑 timeline-duration 诊断
   - commit

## Verification

- **量化扫描**（重构后跑）：`repeat: -1` 数 ≥ 13、`filter:'blur` transition ≥ 12 处、`SplitText` ≥ 5 处、`stagger.*from.*center` ≥ 10 处
- **timeline 完整性**（防 black-frame，Law #11）：Studio devtools 跑
  ```js
  const p = document.querySelector('hyperframes-player');
  const iw = p.shadowRoot.querySelector('iframe').contentWindow;
  Object.fromEntries(Object.entries(iw.__timelines).map(([k, v]) => [k, +v.duration().toFixed(4)]));
  ```
- **SRT 对齐人工核**：preview 时口播每句重音点位的视觉变化是否对齐
- **内存监控**（13 sub-composition + 2 个 shader transition 是高内存场景，按 memory `feedback_hf_composition_count_memory`）：preview 久看后浏览器 tab 关掉重开避免 12GB renderer 涨

## 风险 + 缓解

1. **shader transition 内存炸**：只用 2 处 act 边界（不到处铺）。每次改完关 tab 重开
2. **SplitText / Flip CDN 加载失败**：备用 unpkg CDN（`https://unpkg.com/gsap@3.15/dist/SplitText.min.js`）
3. **GSAP 3.15 vs 3.14.2 兼容性**：v3 系列 API 向后兼容，已有 tween 代码不需要改
4. **改造工作量大（13 beat × 3 个 Tier）**：分 5 个 stage 推进，每 stage 完都 preview 验证；用户可以在 Stage 1/2 之间停下来看效果决定是否继续
