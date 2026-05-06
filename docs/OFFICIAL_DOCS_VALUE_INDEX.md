# 官方文档启发性索引（AI 视角）

> 生成于 2026-05-04 · 更新于 2026-05-06 · 扫读 72/78 页 · 10 个 sonnet agent 并行 + 1 个补扫 agent
> 重跑：刷新 `docs/hyperframes-official/`（`bash scripts/refresh-docs.sh`）后，重发"派 agent 扫读"任务即可

**判定标准**：每页是否对小陈做中文教程视频/片头有"启发性"，并能否提炼到 `MOTION_PHILOSOPHY.md` / `MY_VISUAL_DNA.md` / `STYLE_BORROW_PLAYBOOK.md` / `cyxj-new-video` skill。已扫范围：guides 全套（13）+ concepts（4）+ getting-started（2）+ reference（1）+ packages（6）+ catalog 抽样（11）= 37 页（第一轮）；catalog 剩余 35 块（第二轮）= 72 页合计。剩余 6 页（catalog 个别页面）暂跳过。

---

## ⭐⭐⭐ 必读（15 页 · 优先注入工作流）

| 页面 | 一句话价值 | 建议落地位置 | 已体现 |
|---|---|---|---|
| `guides/prompting.md` | 词汇表+提示模板，决定 AI 出稿质量的效率倍增器 | cyxj-new-video skill（标准 prompt 前缀） | 否 |
| `guides/rendering.md` | 透明 MOV ProRes 4444 = 片头叠加层核心工具，工作流完全缺失 | cyxj-new-video skill + STYLE_BORROW_PLAYBOOK.md | 部分 |
| `guides/video-editor-cheatsheet.md` | 非程序员导演 Agent 的操作手册：手动微调 → Agent 清理循环 | cyxj-new-video skill + MOTION_PHILOSOPHY.md | 否 |
| `guides/hyperframes-vs-remotion.md` | 解释为何 HTML+GSAP 比 React 更适合 AI 写视频，建立技术选型认知 | MOTION_PHILOSOPHY.md（哲学注脚） | 否 |
| `concepts/data-attributes.md` | 相对时序 `data-start="intro + 2"` 让 beat 自动跟随上游变化，省改稿 | cyxj-new-video skill + MOTION_PHILOSOPHY.md §3.1 | 否 |
| `reference/html-schema.md` | 7 条 Timeline Contract + 相对时序 + data-variable-values 权威表 | MOTION_PHILOSOPHY.md + cyxj-new-video skill | 部分 |
| `packages/cli.md` | `tts` / `capture` / `inspect` / `snapshot` 4 个未用过的生产力命令 | cyxj-new-video skill + CLAUDE.md（QA 步骤） | 部分 |
| `catalog/blocks/whip-pan.md` | beat 间隔转场默认首选，DNA 漏列 | cyxj-new-video skill + MY_VISUAL_DNA.md | 部分 |
| `catalog/blocks/flash-through-white.md` | 幕间大转场首选 shader，DNA 已点名 | cyxj-new-video skill（操作规范） | 是 |
| `catalog/blocks/cinematic-zoom.md` | 文字穿越进入 3D 空间的首选 shader，DNA 漏了 | MY_VISUAL_DNA.md（补转场备选） | 否 |
| `catalog/blocks/macos-notification.md` | 5s macOS 风悬浮通知卡，教程"触发提示"场景首选 overlay | cyxj-new-video skill（社交 UI 卡片备选表） | 部分 |
| `catalog/blocks/transitions-blur.md` | 模糊系列转场套装（20s 多样本），章节间柔和切换高频调用 | cyxj-new-video skill（转场选单） | 否 |
| `catalog/blocks/transitions-dissolve.md` | 溶解淡入淡出套装（24s），教程长视频章节间最通用的柔和转场 | cyxj-new-video skill（转场选单） | 否 |
| `catalog/blocks/transitions-light.md` | 光效/闪光转场套装（21s），含 flash 系类，暖米色教程幕间大转场备选 | cyxj-new-video skill（转场选单）+ MY_VISUAL_DNA.md | 否 |
| `catalog/blocks/yt-lower-third.md` | YouTube 订阅下三分之一字条，教程片内引导关注/订阅的标配 overlay | cyxj-new-video skill（社交 UI 卡片备选表） | 否 |

## ⭐⭐ 值得读（21 页）

| 页面 | 一句话价值 | 建议落地位置 | 已体现 |
|---|---|---|---|
| `guides/gsap-animation.md` | 时间线长度=视频长度的非直觉陷阱 + `<video>` 包裹规则 | MOTION_PHILOSOPHY.md Law 11 补注 | 部分 |
| `guides/common-mistakes.md` | 8 个 linter 查不出的真实 bug，含 Debugging Checklist | cyxj-new-video skill（渲染前 QA） | 否 |
| `guides/performance.md` | backdrop-filter blur 上限 2-3 层，每 beat 性能警戒线 | MOTION_PHILOSOPHY.md（liquid glass 注记） | 否 |
| `guides/timeline-editing.md` | Studio move/trim/stack 三种操作的 HTML 映射 + row 排列规则 | cyxj-new-video skill（caption 放置说明） | 部分 |
| `concepts/compositions.md` | composition 嵌套 + Variables 传参，模块化复用骨架 | MOTION_PHILOSOPHY.md §3.1 + cyxj-new-video skill | 部分 |
| `getting-started/quickstart.md` | 揭示 `/lottie` `/animejs` `/waapi` 子 skill 触发条件 | cyxj-new-video skill（init 步骤） | 部分 |
| `packages/producer.md` | WebM VP9 alpha 透明 + 外部资产自动 copy（VO 放 Downloads 即可） | cyxj-new-video skill（渲染选项） | 否 |
| `catalog/blocks/logo-outro.md` | 6s 片尾：piece-by-piece + glow bloom + URL pill | cyxj-new-video skill + MY_VISUAL_DNA.md | 部分 |
| `catalog/blocks/ui-3d-reveal.md` | 13s 透视 3D UI 入场，适合工具界面展示段落 | MOTION_PHILOSOPHY.md + cyxj-new-video skill | 否 |
| `catalog/components/grain-overlay.md` | 安装入口确认（DNA §3 已写引用路径） | 不必落地 | 是 |
| `catalog/components/shimmer-sweep.md` | logo hold 阶段的铬光扫，MOTION_PHILOSOPHY §2.4 已记录 | 不必落地 | 部分 |
| `catalog/blocks/instagram-follow.md` | 竖版 Instagram 关注卡（1080×1920），教程片内社交引流 overlay | cyxj-new-video skill（社交 UI 卡片备选表） | 否 |
| `catalog/blocks/light-leak.md` | 电影漏光 shader，暖米色底色+温暖光感，教程风格适配度高 | cyxj-new-video skill（转场备选） | 否 |
| `catalog/blocks/reddit-post.md` | Reddit 帖子卡，教程"有人提问"/"社区反应"场景直接调用 | cyxj-new-video skill（社交 UI 卡片备选表） | 否 |
| `catalog/blocks/sdf-iris.md` | 光圈收缩 shader，精致开场/章节标题揭示感 | cyxj-new-video skill（转场备选） | 否 |
| `catalog/blocks/spotify-card.md` | Spotify 正在播放卡（竖版），短视频/节奏段落氛围营造 | cyxj-new-video skill（社交 UI 卡片备选表） | 否 |
| `catalog/blocks/transitions-cover.md` | 遮盖/划过套装（21s），章节标题推入感，与 push 互补 | cyxj-new-video skill（转场选单） | 否 |
| `catalog/blocks/transitions-push.md` | 推移/滑动套装（24s），PPT 风横向翻页，步骤讲解场景 | cyxj-new-video skill（转场选单） | 否 |
| `catalog/blocks/transitions-radial.md` | 径向擦除套装（20s），圆形收放感，与 sdf-iris 风格互补 | cyxj-new-video skill（转场选单） | 否 |
| `catalog/blocks/transitions-scale.md` | 缩放套装（15s），含 zoom 类与 cinematic-zoom 单 shader 互补 | cyxj-new-video skill（转场选单） | 否 |
| `catalog/blocks/x-post.md` | X/Twitter 帖子卡，引用 tweets/社区讨论场景直接调用 | cyxj-new-video skill（社交 UI 卡片备选表） | 否 |

## ⭐ 翻一下（22 页）

| 页面 | 一句话价值 | 已体现 |
|---|---|---|
| `guides/troubleshooting.md` | `npx hyperframes doctor` + preview 不刷新等急救 | 否（但纯工具性） |
| `guides/claude-design.md` | claude.ai/design 起草路径，与 Claude Code 流重叠 | 部分 |
| `guides/website-to-video.md` | URL→视频自动管线，`STORYBOARD.md` 模型可参考 | 部分 |
| `concepts/determinism.md` | `Math.random()` 禁用规则（已记录） | 是 |
| `getting-started/introduction.md` | 框架定位概述 | 是 |
| `packages/engine.md` | seek-and-capture 原理 + WebM alpha 透明通道 | 部分 |
| `packages/studio.md` | 嵌入自有 Web App 时才用，普通流程无需 | 是 |
| `catalog/blocks/data-chart.md` | 数据可视化场景可调用 | 否 |
| `catalog/blocks/flowchart.md` | 流程/决策图场景可调用 | 否 |
| `catalog/components/grid-pixelate-wipe.md` | 复古/游戏风转场，与蓝调科技风不符 | 否 |
| `catalog/blocks/domain-warp-dissolve.md` | 分形噪声域扭曲溶解，视觉独特，场景特殊时可调 | 否 |
| `catalog/blocks/glitch.md` | 数字故障特效 shader，教程"系统出错"/"高能时刻"主题偶发用 | 否 |
| `catalog/blocks/ripple-waves.md` | 同心涟漪扭曲，"影响扩散"/"系统震荡"主题时可考虑 | 否 |
| `catalog/blocks/swirl-vortex.md` | 漩涡扭曲 shader，视觉冲击强但暖米色教程少用 | 否 |
| `catalog/blocks/thermal-distortion.md` | 热扭曲 shader，炎热/能量/AI 推理主题时偶发调用 | 否 |
| `catalog/blocks/tiktok-follow.md` | 竖版 TikTok 关注卡，主战场是 YouTube 但多平台分发时备用 | 否 |
| `catalog/blocks/transitions-3d.md` | 3D 透视翻转套装（11s），需要立体感翻页时调用 | 否 |
| `catalog/blocks/transitions-destruction.md` | 破坏/碎裂套装（14s），"系统崩溃"/"重装上阵"叙事节点偶发用 | 否 |
| `catalog/blocks/transitions-distortion.md` | 扭曲系列套装（21s），科技/赛博感偏强，风格不符时跳过 | 否 |
| `catalog/blocks/transitions-grid.md` | 网格瓷砖套装（11s），像素/复古风格，与暖米色教程不匹配 | 否 |
| `catalog/blocks/transitions-mechanical.md` | 机械快门/虹膜套装（15s），工业感偏强，偶发装置感场景可调 | 否 |
| `catalog/blocks/transitions-other.md` | 杂项转场套装（20s），内容混杂，当其他套装找不到合适时翻 | 否 |

## ✗ 跳过（14 页）

| 页面 | 跳过理由 |
|---|---|
| `guides/open-design.md` | BYOK 开源替代，已用 Claude Code 不需要 |
| `guides/hdr.md` | HDR10 渲染管线，教程视频不用 |
| `concepts/frame-adapters.md` | 自建 runtime 底层 API，GSAP 足够 |
| `packages/core.md` | 纯 API 参考，CLI 已封装 |
| `packages/player.md` | Web Component 嵌入网页用，YouTube 视频不需要 |
| `catalog/blocks/app-showcase.md` | Fitness app 产品广告模板，与中文教程不符 |
| `catalog/blocks/apple-money-count.md` | Apple 风金融数字计数，场景高度特定，与教程 DNA 不符 |
| `catalog/blocks/chromatic-radial-split.md` | 色差径向分裂 shader，赛博/故障感与暖米色教程相悖 |
| `catalog/blocks/cross-warp-morph.md` | 交叉变形 shader，视觉过强，非主流教程转场 |
| `catalog/blocks/goonvpn-youtube-spot.md` | 品牌特定 VPN 广告模板，内容高度专属 |
| `catalog/blocks/gravitational-lens.md` | 引力透镜 shader，极度艺术化，与教程简洁节奏不符 |
| `catalog/blocks/north-korea-locked-down.md` | 政治地图标注场景，与中文教程方向无关 |
| `catalog/blocks/nyc-paris-flight.md` | 航班地图动画，场景高度特定，非教程通用 |
| `catalog/blocks/ridged-burn.md` | 灼烧边缘 shader，风格暗黑与暖米色教程 DNA 相悖 |

---

## 关键发现：工作流的具体漏洞

按"⭐⭐⭐ 但未体现 / 部分体现"交叉看，最值得做的注入有 7 条：

1. **相对时序写法** —— `concepts/data-attributes.md` + `reference/html-schema.md` 都强调，但所有现有工程都用绝对秒数。注入到 cyxj-new-video skill 后，改 beat 时长不必逐个手算偏移。
2. **CLI 子命令 4 件套** —— `tts`（本地无 API 语音）+ `capture`（抓站点风格 token）+ `inspect`（逐帧文字溢出扫描）+ `snapshot`。`tts+transcribe` 直接补齐配音工作流；`inspect` 是 QA 自动化关键。
3. **透明视频输出** —— MOV ProRes 4444（达芬奇用）+ WebM VP9 alpha（网页/AE 用）。STYLE_BORROW_PLAYBOOK 只讲了 mp4 两步渲染，叠加层路径完全没文档化。
4. **prompting 词汇表 + Caption Tone 表** —— smooth/snappy/bouncy 映射 ease，fast/medium/slow 对应时长，Hype/Tutorial/Storytelling 对应字体+尺寸。这是 AI 出稿质量的杠杆。
5. **手动 DOM 编辑 → Agent 清理** 循环 —— 最后 10% 的视觉调整自己拖拽更快，再让 Agent 清理 diff。当前 skill 没这条循环。
6. **backdrop-filter 性能上限**（2-3 层 blur，单帧 200ms）—— MY_VISUAL_DNA 用了 `blur(14px)` 但没警戒线。每 region 限 2-3 层是硬约束。
7. **三件转场标准化**：`whip-pan`（默认 cut）+ `flash-through-white`（幕间大转场）+ `cinematic-zoom`（文字进 3D）。MY_VISUAL_DNA 漏列 `whip-pan` 和 `cinematic-zoom`。

---

## 下一步建议

把上述 7 条按"工作流文件"分组，分别另起任务执行：

| 落地文件 | 注入内容 |
|---|---|
| `MY_VISUAL_DNA.md` | 漏列的 whip-pan + cinematic-zoom 加进"可调整-转场类型" |
| `MOTION_PHILOSOPHY.md` | backdrop-filter 上限 / `<video>` 包裹规则 / 技术选型哲学注脚 |
| `cyxj-new-video` skill | 相对时序写法 + tts/capture/inspect 步骤 + 透明输出决策树 + prompting 词汇表 + 手动微调循环 |
| `STYLE_BORROW_PLAYBOOK.md` | 透明 MOV / WebM alpha 输出规范章节 |

**建议**：每条注入单独起一次对话执行，避免一次改太多文件、PR 评估困难。本任务只到"建索引"为止，不动其他文件。

---

## 各 agent 原始报告

> 全文存档，方便逐条核验。

### Agent 1 — guides 启发组 A

#### `guides/prompting.md`（284 行）
- **评级**：⭐⭐⭐
- **一句话价值**：包含词汇表 + 提示模板，直接决定 AI 出稿质量，是上手效率倍增器
- **3 个金句/要点**：
  1. "Describe how motion should *feel* and the agent picks the matching GSAP ease" — smooth/snappy/bouncy 等形容词直接映射 ease 曲线
  2. "Timing shorthand: fast (0.2s) = energy, medium (0.4s) = professional, slow (0.6s) = luxury, very slow (1–2s) = cinematic"
  3. Caption Tone 表格：Hype / Tutorial / Storytelling 各有对应字体+动画+尺寸范围
- **建议落地位置**：cyxj-new-video skill（词汇表作为标准 prompt 前缀模板）
- **是否已在工作流体现**：否

#### `guides/gsap-animation.md`（141 行）
- **评级**：⭐⭐
- **一句话价值**：GSAP 时间线技术规则，核心是"时间线长度决定视频长度"这一非直觉陷阱
- **3 个金句/要点**：
  1. "A composition's duration equals its GSAP timeline duration" — GSAP 决定视频长度，不是 `data-duration`
  2. `tl.set({}, {}, 283)` — 用零时长 tween 在末尾撑满时间线，无副作用
  3. "Don't animate `width`, `height`, `top`, `left` directly on `<video>` elements — wrap in a `<div>`"
- **建议落地位置**：MOTION_PHILOSOPHY.md Law 11 已有"时间线锚"，可补充 `<video>` 包裹规则作为注释
- **是否已在工作流体现**：部分

#### `guides/common-mistakes.md`（272 行）
- **评级**：⭐⭐
- **一句话价值**：8 个"linter 查不出"的真实 bug 逐一给出 before/after，调试优先级清单可直接复用
- **3 个金句/要点**：
  1. "Oversized source images: a 7000×5000 JPEG is 140MB decoded even if 2MB on disk" — 图片尺寸应 ≤ 2× canvas 分辨率
  2. "Keep stacked `backdrop-filter` layers to 2-3 per region; avoid radii above 64px over large areas"
  3. Debugging Checklist 顺序：lint → timeline 注册 → GSAP-only 属性 → timeline 够长 → console errors
- **建议落地位置**：cyxj-new-video skill（渲染前 QA checklist 段落）
- **是否已在工作流体现**：否

### Agent 2 — guides 启发组 B

#### `guides/rendering.md`（384 行）
- **评级**：⭐⭐⭐
- **一句话价值**：透明视频输出（MOV ProRes 4444）是片头叠加层的核心工具，工作流里完全缺失
- **3 个金句/要点**：
  1. MOV ProRes 4444 = 行业标准透明视频，CapCut/Premiere/DaVinci 均支持
  2. `--quality draft` 迭代，`--quality standard`（CRF 18）= 1080p 视觉无损，final 交付
  3. 本地 local 模式迭代，Docker 模式保证跨机器字体/输出一致性
- **建议落地位置**：cyxj-new-video skill（渲染决策树）+ STYLE_BORROW_PLAYBOOK.md（透明视频输出规范）
- **是否已在工作流体现**：部分

#### `guides/performance.md`（130 行）
- **评级**：⭐⭐
- **一句话价值**：backdrop-filter blur 叠层是最贵操作，小陈片头用 liquid glass 卡片必须知道上限
- **3 个金句/要点**：
  1. 叠加 blur 层超过 2-3 层，单帧可达 200ms，预览必卡
  2. 源图超过 canvas 2x（即 3840×2160）就是浪费内存，不影响画质
  3. "预览卡但 render 正常"是合理现象，直接 `--quality draft` 渲 mp4 看是合法工作流
- **建议落地位置**：MOTION_PHILOSOPHY.md（liquid glass 卡片 blur 上限注记）
- **是否已在工作流体现**：否

#### `guides/troubleshooting.md`（181 行）
- **评级**：⭐
- **一句话价值**：查错速查表，非程序员遇到 FFmpeg/lint/preview 不刷新时的应急手册
- **3 个金句/要点**：
  1. `npx hyperframes doctor` 一键诊断环境，出问题先跑这个
  2. preview 不刷新 → 先 `Cmd+Shift+R` 硬刷新，再重启 preview server
  3. render 结果与 preview 不一致 → 加 `--docker` 消除字体/Chrome 版本差异
- **建议落地位置**：不必落地
- **是否已在工作流体现**：否

### Agent 3 — guides 启发组 C

#### `guides/claude-design.md`（161 行）
- **评级**：⭐
- **一句话价值**：介绍 claude.ai/design 起草初稿的工作流，与小陈现有 Claude Code 流基本重叠
- **3 个金句/要点**：1. "template-first approach — output passes lint with zero errors on first download" 2. "attachments > pasted content > web research > URLs（可靠性排序）" 3. "Ask ONE short clarifying question before generating（稀疏 brief 策略）"
- **建议落地位置**：cyxj-new-video skill（可补一句"brief 稀疏时让 Claude 先问一个问题"）
- **是否已在工作流体现**：部分

#### `guides/open-design.md`（189 行）
- **评级**：✗
- **一句话价值**：Open Design 是 BYOK 开源替代品，小陈已用 Claude Code，无需再加一层工具
- **3 个金句/要点**：1. 72 shipped DESIGN.md systems 2. 5-dimensional self-critique gate 3. active DESIGN.md > attachments > pasted content
- **建议落地位置**：不必落地
- **是否已在工作流体现**：否

#### `guides/video-editor-cheatsheet.md`（274 行）
- **评级**：⭐⭐⭐
- **一句话价值**：非程序员导演 Agent 的操作手册，补齐"手动微调 + Agent 泛化"这条关键工作流
- **3 个金句/要点**：1. "Use manual DOM editing for the final 10% of creative adjustment where dragging is faster than describing" 2. "Ask the agent to inspect the diff and keep the source clean（手动改完让 Agent 收拾）" 3. "`tl.set({}, {}, 5)` — keeps timeline at least 5s long"
- **建议落地位置**：cyxj-new-video skill（Step 3–4 补"手动微调→Agent 清理"循环）；MOTION_PHILOSOPHY.md（Law 11 可引用 tl.set 模式）
- **是否已在工作流体现**：否

### Agent 4 — guides 启发组 D

#### `guides/timeline-editing.md`（119 行）
- **评级**：⭐⭐
- **一句话价值**：理解 move/trim/stack 三种操作的底层 HTML 映射，直接影响 Studio 编辑决策
- **3 个金句/要点**：1. move 改 `data-start`，right-trim 改 `data-duration`，left-trim 仅限媒体 clip 2. 顶部 row 渲染在上，captions/lower-thirds 要放更高 row 3. 所有编辑结果以 `data-*` 写回 HTML，可 git diff 追溯
- **建议落地位置**：cyxj-new-video skill（overlay/caption 放置步骤说明）
- **是否已在工作流体现**：部分

#### `guides/website-to-video.md`（243 行）
- **评级**：⭐
- **一句话价值**：整套 URL→视频自动管线，小陈做自有选题暂不需要，但 `STORYBOARD.md` 迭代模型值得参考
- **3 个金句/要点**：1. Creative direction 比视频类型更重要 2. `STORYBOARD.md` 是创意北极星，改一个 beat 不必重跑全管线 3. 7 步管线：Capture → Design → Script → Storyboard → VO → Build → Validate
- **建议落地位置**：不必落地
- **是否已在工作流体现**：部分

#### `guides/hyperframes-vs-remotion.md`（166 行）
- **评级**：⭐⭐⭐
- **一句话价值**：解释了为什么 HTML+GSAP 比 React 更适合 AI 写视频，为工具选择建立底层认知
- **3 个金句/要点**：1. 同一个 GSAP 动画在 Remotion 里只用了 1 秒，在 Hyperframes 里精确播满 4 秒——框架不同天壤之别 2. LLM 训练数据里 HTML/CSS/CodePen 远多于 React，写 HTML 创意空间更大 3. "一个文件进，视频出"——无 package.json、无构建步骤，agentic 工作流天然友好
- **建议落地位置**：MOTION_PHILOSOPHY.md（补一节"为什么是 HTML+GSAP"的哲学注脚）
- **是否已在工作流体现**：否

#### `guides/hdr.md`（208 行）
- **评级**：✗
- **一句话价值**：HDR10 渲染管线技术文档，小陈目前片头/教程视频不使用 HDR 素材
- **3 个金句/要点**：1. HDR 需要 BT.2020 PQ/HLG 标记的 MP4 2. GPU 编码不能嵌入 HDR10 静态元数据 3. `--format webm/mov` 自动降 SDR
- **建议落地位置**：不必落地
- **是否已在工作流体现**：否

### Agent 5 — concepts 全套

#### `concepts/compositions.md`（216 行）
- **评级**：⭐⭐
- **一句话价值**：理解 composition 嵌套结构与 Variables 传参，是视频工程组织的核心骨架
- **3 个金句/要点**：① "External files are the recommended approach for reusable compositions" ② "HTML = 声明结构（what plays, when），Script = 动画效果，两层职责严格分离" ③ `data-variable-values` 支持向嵌套 composition 传参，脚本手动读取并应用
- **建议落地位置**：MOTION_PHILOSOPHY.md / cyxj-new-video skill
- **是否已在工作流体现**：部分

#### `concepts/data-attributes.md`（113 行）
- **评级**：⭐⭐⭐
- **一句话价值**：相对时序 `data-start="intro + 2"` 可让 beat 自动跟随上游时长变化，大幅减少改稿成本
- **3 个金句/要点**：① `data-start="intro"` = "start when that clip ends"，下游 clip 自动位移 ② `data-start="intro - 0.5"` 实现交叉淡入，省去手算 overlap ③ "Keep chains under 3-4 levels for readability"
- **建议落地位置**：cyxj-new-video skill / MOTION_PHILOSOPHY.md 3.1 节
- **是否已在工作流体现**：否

#### `concepts/determinism.md`（114 行）
- **评级**：⭐
- **一句话价值**：解释渲染为何可复现，防止小陈误用 `Math.random()` / `Date.now()` 导致每帧不一致
- **3 个金句/要点**：① "No unseeded randomness — `Math.random()` without a seed breaks determinism" ② "Preview can stutter; render never drops frames" ③ Docker mode 锁定 Chrome + 字体版本
- **建议落地位置**：不必落地
- **是否已在工作流体现**：是

#### `concepts/frame-adapters.md`（152 行）
- **评级**：✗
- **一句话价值**：面向自建动画 runtime 的底层 API，小陈目前用 GSAP 足够
- **3 个金句/要点**：① "The adapter never controls its own clock" ② 支持 GSAP / Anime.js / Lottie / Three.js / CSS keyframes / WAAPI ③ Conformance tests: seekFrame 同帧两次必须幂等
- **建议落地位置**：不必落地
- **是否已在工作流体现**：是

### Agent 6 — 入门 + reference

#### `getting-started/introduction.md`（124 行）
- **评级**：⭐
- **一句话价值**：框架定位概述，工作流已全面覆盖
- **3 个金句/要点**：① "Write HTML. Render video. Built for agents." ② 帧渲染公式 `frame = floor(time * fps)` ③ 50+ catalog blocks
- **建议落地位置**：不必落地
- **是否已在工作流体现**：是

#### `getting-started/quickstart.md`（257 行）
- **评级**：⭐⭐
- **一句话价值**：揭示了 skill 体系的正式用法，skill 名称与触发方式小陈工作流中未被系统归档
- **3 个金句/要点**：① `npx skills add heygen-com/hyperframes` 一次安装所有 skill，含 `/hyperframes`、`/gsap`、`/lottie` 等 8 个子 skill ② "Skills encode HyperFrames-specific patterns" ③ `--non-interactive --example blank` 让 agent 无提示初始化工程
- **建议落地位置**：cyxj-new-video skill（skill 安装入口 + `--non-interactive` 标志）
- **是否已在工作流体现**：部分

#### `reference/html-schema.md`（246 行）
- **评级**：⭐⭐⭐
- **一句话价值**：权威 HTML 属性全表 + 7 条 Timeline Contract 规则
- **3 个金句/要点**：① "Do not manually call `video.play()`…The framework owns media playback" ② 相对时序 `data-start="intro + 2"` / `data-start="intro - 0.5"` 可做 gap/overlap ③ `data-variable-values` 传参给嵌套 composition，模块化复用关键
- **建议落地位置**：MOTION_PHILOSOPHY.md / cyxj-new-video skill
- **是否已在工作流体现**：部分

### Agent 7 — packages 心智模型

#### `packages/core.md`（443 行）
- **评级**：✗
- **一句话价值**：纯 API 参考，小陈不写工具
- **3 个金句/要点**：① `SUPPORTED_PROPS` / `SUPPORTED_EASES` 列出所有可动属性和缓动名 ② `lintHyperframeHtml` 可编程 lint，CLI 已覆盖 ③ `data-composition-variables` 支持动态参数化合成
- **建议落地位置**：不必落地
- **是否已在工作流体现**：是

#### `packages/engine.md`（429 行）
- **评级**：⭐
- **一句话价值**：讲清 seek-and-capture 原理 + WebM alpha 透明通道
- **3 个金句/要点**：① "seek-and-capture 而非屏幕录制：每帧独立定位，无掉帧" ② 质量预设 draft/standard/high + fps 24/30/60 适用场景表 ③ WebM VP9 alpha 透明通道
- **建议落地位置**：cyxj-new-video skill（渲染参数选择提示）
- **是否已在工作流体现**：部分

#### `packages/producer.md`（388 行）
- **评级**：⭐⭐
- **一句话价值**：渲染管线全景 + WebM 透明/HDR/外部资产三个未用的实用功能
- **3 个金句/要点**：① `format: 'webm'` 输出 VP9 alpha 透明视频 ② `hdr: true` 自动探测 HDR 源 ③ 外部资产自动 copy+rewrite：VO 放 Downloads 就能引用
- **建议落地位置**：cyxj-new-video skill（渲染步骤提示 WebM/外部 VO 两个选项）
- **是否已在工作流体现**：否

### Agent 8 — packages 工具

#### `packages/cli.md`（818 行）
- **评级**：⭐⭐⭐
- **一句话价值**：包含 `tts` / `capture` / `inspect` / `snapshot` 等小陈从未用过的生产力命令
- **3 个金句/要点**：
  1. `tts` 命令本地生成语音（Kokoro-82M，无需 API），可接 `transcribe` 自动生成逐字时间戳
  2. `capture` 可抓取任意网站的视觉 token、字体、截图，直接为视频借鉴参考站风格
  3. `inspect` 逐帧扫描文字溢出/容器裁切，每条 finding 带修复提示，agent 可直接消费
- **建议落地位置**：cyxj-new-video skill + CLAUDE.md（QA 步骤）
- **是否已在工作流体现**：部分

#### `packages/studio.md`（278 行）
- **评级**：⭐
- **一句话价值**：仅在嵌入自有 Web App 时有用
- **3 个金句/要点**：1. 正常用 `npx hyperframes preview` 即可 2. Timeline 行高 = z-index 3. preview 与 render 完全一致
- **建议落地位置**：不必落地
- **是否已在工作流体现**：是

#### `packages/player.md`（246 行）
- **评级**：✗
- **一句话价值**：Web Component 嵌入网页用，YouTube 视频不需要
- **3 个金句/要点**：1. 零依赖 3KB 2. API 镜像原生 `<video>` 3. Shadow DOM 隔离
- **建议落地位置**：不必落地
- **是否已在工作流体现**：否

### Agent 9 — catalog 教程能用上的

#### `catalog/blocks/data-chart.md`（46 行）
- **评级**：⭐
- **一句话价值**：教程视频中呈现数据对比时可直接调用
- **3 个金句/要点**：① 15s 带 staggered reveal 的柱状+折线图 ② NYT-style typography ③ `npx hyperframes add data-chart`
- **建议落地位置**：cyxj-new-video skill（"数据场景"可选 block 备注）
- **是否已在工作流体现**：否

#### `catalog/blocks/flowchart.md`（46 行）
- **评级**：⭐
- **一句话价值**：讲解流程/决策逻辑时有现成动态节点图可调用
- **3 个金句/要点**：① SVG connectors + sticky-note nodes ② cursor interaction + typing correction ③ 12s 时长
- **建议落地位置**：cyxj-new-video skill（流程图场景 block 备注）
- **是否已在工作流体现**：否

#### `catalog/blocks/logo-outro.md`（46 行）
- **评级**：⭐⭐
- **一句话价值**：6s 片尾 logo 动画含 glow bloom + tagline
- **3 个金句/要点**：① piece-by-piece assembly：logo 逐件拼合 ② glow bloom + tagline fade-in ③ URL pill
- **建议落地位置**：cyxj-new-video skill / MY_VISUAL_DNA.md（outro 视觉规范）
- **是否已在工作流体现**：部分

#### `catalog/blocks/app-showcase.md`（46 行）
- **评级**：✗
- **一句话价值**：Fitness app 产品广告模板
- **建议落地位置**：不必落地
- **是否已在工作流体现**：否

#### `catalog/blocks/ui-3d-reveal.md`（46 行）
- **评级**：⭐⭐
- **一句话价值**：13s 透视 3D UI 入场动画，适合教程片头或工具界面展示段落
- **3 个金句/要点**：① perspective 3D reveal ② 13s 时长 ③ 标签 `showcase/3d/reveal`
- **建议落地位置**：MOTION_PHILOSOPHY.md / cyxj-new-video skill
- **是否已在工作流体现**：否

### Agent 10 — catalog 高频转场+overlay

#### `catalog/components/grain-overlay.md`（40 行）
- **评级**：⭐⭐
- **一句话价值**：纹理三件套官方安装入口
- **3 个金句/要点**：① `npx hyperframes add grain-overlay` ② Type: Component ③ 无方法论，纯安装指引
- **建议落地位置**：不必落地（DNA §3 已记录）
- **是否已在工作流体现**：是

#### `catalog/components/shimmer-sweep.md`（40 行）
- **评级**：⭐⭐
- **一句话价值**：logo hold 阶段的铬光扫
- **3 个金句/要点**：① "ideal for AI accents and premium reveals" ② CSS gradient mask 实现 ③ MOTION_PHILOSOPHY §2.4 已有指引
- **建议落地位置**：不必落地
- **是否已在工作流体现**：部分

#### `catalog/components/grid-pixelate-wipe.md`（40 行）
- **评级**：⭐
- **一句话价值**：复古/游戏风转场，与小陈蓝调科技风不符
- **3 个金句/要点**：① "grid of squares that fade out with staggered timing" ② 风格偏复古 ③ 文档无方法论
- **建议落地位置**：STYLE_BORROW_PLAYBOOK.md（"风格不符"备忘）
- **是否已在工作流体现**：否

#### `catalog/blocks/whip-pan.md`（46 行）
- **评级**：⭐⭐⭐
- **一句话价值**：beat 间隔转场默认首选，且 MOTION_PHILOSOPHY 点名推荐
- **3 个金句/要点**：① "Shader transition simulating a fast camera whip pan" ② Block 类型，1920×1080，Duration 4s ③ MOTION_PHILOSOPHY §2.5 推荐
- **建议落地位置**：cyxj-new-video skill / MY_VISUAL_DNA.md
- **是否已在工作流体现**：部分（DNA"可调整-转场类型"未列 whip-pan）

#### `catalog/blocks/flash-through-white.md`（46 行）
- **评级**：⭐⭐⭐
- **一句话价值**：大幕段落切换的白闪 shader
- **3 个金句/要点**：① "Shader transition with white flash crossfade" ② Block，4s ③ DNA"可调整-转场类型"已点名
- **建议落地位置**：cyxj-new-video skill（操作规范）
- **是否已在工作流体现**：是

#### `catalog/blocks/cinematic-zoom.md`（46 行）
- **评级**：⭐⭐⭐
- **一句话价值**：教程视频"文字穿越进入 3D 空间"节奏点的首选 shader
- **3 个金句/要点**：① "Shader transition with dramatic zoom blur" ② MOTION_PHILOSOPHY §2.5 推荐 ③ 1920×1080，4s
- **建议落地位置**：MY_VISUAL_DNA.md（漏列）
- **是否已在工作流体现**：否
