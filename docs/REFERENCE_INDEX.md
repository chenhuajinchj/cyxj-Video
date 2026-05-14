# 参考工程索引 (REFERENCE_INDEX)

> **入口文件**。做新视频前先扫这里：找参考工程、找零件。
>
> 📅 最后更新：2026-05-06 · 19 个完整工程 + 46 个 catalog 零件 + 78 页官方文档镜像

---

## 一、完整工程（19 个，可直接打开）

> 路径都是软链或本地真目录。直接 `cd 进去 npx hyperframes preview` 就能跑。

### 🎯 想做横屏教程片头（核心场景）

| 工程 | 比例 | 时长 | 看点 |
|---|---|---|---|
| `hyperframes-student-kit/video-projects/claude-edit-intro/` | 16:9 | 23s | 屏幕录制 → PiP 缩小，**教程片头标杆** |
| `hyperframes-student-kit/video-projects/clickup-demo/` | 16:9 | 60s | 工具云 + Logo + 功能展示 + CTA，**4 幕标准结构** |
| `videos/2026-05-02-codex-claude-intro/` | 16:9 | 52s | 透视网格 + 中文字幕，**你做过的中文教程片头底版** |
| `videos/2026-05-02-claude-demo-v2/` | 16:9 | 26s | 录屏铺底 + 4 个 overlay |

### 🎬 想做整片演示（30-60s）

| 工程 | 比例 | 时长 | 看点 |
|---|---|---|---|
| `hyperframes-student-kit/video-projects/linear-promo-30s/` | 16:9 | 30s | Infinite 风格 + 流程图变色，**品牌片金标准** |
| `hyperframes-student-kit/video-projects/aisoc-app-release/` | 16:9 | 30s | 9 comp 节奏紧凑，闪白 + whip-streak |
| `hyperframes-launches/hyperframes-launch/` | 16:9 | 49.77s | 玻璃态 UI + 多技术堆栈，**HeyGen 官方标杆** |

### 📊 想做数据 / 数学动画 / 长视频教学

| 工程 | 比例 | 时长 | 看点 |
|---|---|---|---|
| `hyperframes-student-kit/video-projects/golden-ratio-demo/` | 16:9 | 37.67s | 黄金螺旋 SVG + 3 色分割，**数学动画范例** |
| `hyperframes-student-kit/video-projects/aisoc-lesson-5-1/` | 16:9 | 112s | 全屏讲者 + 信息卡堆栈，**长视频教学结构** |
| `videos/2026-05-04-claude-19-tips-hf/` | 16:9 | ~7 分钟 | 21 章一招一节，cc-window 终端 UI 体系，**你的长教程基线**（DNA + MY_MOTION_NOTES 沉淀源） |

### 🏢 想做品牌 / Logo 演绎 / 产品发布

| 工程 | 比例 | 时长 | 看点 |
|---|---|---|---|
| `hyperframes-student-kit/video-projects/first-agent-promo/` | 16:9 | 32s | React 组件 + 终端 UI，产品发布节奏 |
| `hyperframes-launches/timeline-launch/` | 16:9 | 33.53s | 互动 UI + 反转点笑点，故事弧 |

### 🎨 复杂多镜头（学习用）

| 工程 | 比例 | 时长 | 看点 |
|---|---|---|---|
| `hyperframes-student-kit/video-projects/hyperframes-sizzle/` | 16:9 | ~40s | 30 comp，**技法集大成** |
| `hyperframes-launches/website-to-hyperframes/` | 16:9 | ~61s | 网站截图变身视频，多色彩面板 |
| `videos/2026-05-02-claude-overlays-only/` | 16:9 | 26s | 仅 overlay（达芬奇精修用），alpha 通道 |

### 📱 9:16 竖屏短视频（暂留种）

| 工程 | 比例 | 时长 | 看点 |
|---|---|---|---|
| `hyperframes-student-kit/video-projects/may-shorts-18/` | 9:16 | ~17s | TikTok 风格 + 卡拉 OK 字幕 |
| `hyperframes-student-kit/video-projects/may-shorts-19/` | 9:16 | 18.84s | 同上的 v2 迭代 |
| `hyperframes-student-kit/video-projects/may-shorts-6/` | 16:9 | ~25s | 横屏讲座短视频，3 种面部模式 |
| `hyperframes-student-kit/video-projects/aisoc-hype/` | 16:9 | ~30s | 颗粒覆盖 + 运动字体 |

---

## 二、Catalog 零件（46 个：43 blocks + 3 components）

> 用 `npx hyperframes add <name>` 装到工程的 `compositions/components/`。
> 完整 metadata 看 `templates/catalog.json`。月度刷新跑 `bash scripts/refresh-catalog.sh`。

### 🌟 转场效果（最高频，27 个）

**单效果转场（shader 类，14 个）**——独立装一个用一种效果：

- `whip-pan` — 运动模糊摇移（最适合教程节奏切换）
- `flash-through-white` — 闪白炸场
- `cinematic-zoom` — 推近过渡
- `sdf-iris` — 光圈收缩
- `glitch` — 故障特效
- `light-leak` — 漏光
- `chromatic-radial-split` — 色差径向分裂
- `swirl-vortex` — 漩涡
- `ripple-waves` — 涟漪
- `domain-warp-dissolve` — 域扭曲溶解
- `ridged-burn` — 灼烧边缘
- `gravitational-lens` — 引力透镜
- `thermal-distortion` — 热扭曲
- `cross-warp-morph` — 交叉变形

**整套转场包（13 个）**——一次装一整个风格的多种转场：

- `transitions-3d` — 3D 转场套装
- `transitions-blur` — 模糊系列
- `transitions-cover` — 遮盖系列
- `transitions-destruction` — 破坏系列
- `transitions-dissolve` — 溶解系列
- `transitions-distortion` — 扭曲系列
- `transitions-grid` — 网格系列
- `transitions-light` — 光效系列
- `transitions-mechanical` — 机械系列
- `transitions-other` — 杂项系列
- `transitions-push` — 推移系列
- `transitions-radial` — 径向系列
- `transitions-scale` — 缩放系列

### 📱 社交媒体 UI 卡片（7 个）

教程视频里出现"在 Instagram 关注我"或者"看下这条评论"时直接装：

- `instagram-follow` — Instagram 关注卡
- `tiktok-follow` — TikTok 关注卡
- `yt-lower-third` — YouTube 下三分之一字条
- `x-post` — X (Twitter) 帖子卡
- `reddit-post` — Reddit 帖子卡
- `spotify-card` — Spotify 正在播放
- `macos-notification` — macOS 通知

### 🎬 落版 / 品牌（1 个）

- `logo-outro` — Logo 落版（任何片尾必备）

### 📊 数据可视化（2 个）

- `data-chart` — 动画柱状 + 折线图（NYT 风格 + 数值标签）
- `flowchart` — 流程图（SVG 连线 + 决策树）

### 📦 应用 / 产品展示（6 个）

- `app-showcase` — App 3D 展示
- `ui-3d-reveal` — UI 3D 揭示
- `goonvpn-youtube-spot` — VPN 产品 YouTube 广告样式
- `north-korea-locked-down` — 地图标注秀场（YouTube 风）
- `apple-money-count` — 数字滚动金钱秀（YouTube 风）
- `nyc-paris-flight` — 旅行/航线地图秀场（YouTube 风）

### 🎨 视觉装饰 components（3 个）

components 跟 blocks 不同：components 是"叠加层"，全局生效；blocks 是"场景片段"。

- `grain-overlay` — 颗粒覆盖（**MOTION_PHILOSOPHY 必备**，每个工程都该加）
- `shimmer-sweep` — 闪烁扫光（强调文字时用）
- `grid-pixelate-wipe` — 像素网格擦除转场

### 真实工程里用过哪些零件（自动扫描）

<!-- AUTO:zero-usage:start -->
> 由 `scripts/refresh-zero-usage.sh` 自动扫描 `videos/` 下所有工程的 `compositions/*.html` 和 `compositions/components/*.html` 文件名 vs catalog.json 反查得出。重跑：`bash scripts/refresh-zero-usage.sh --write`。手动编辑会被下次重跑覆盖。

**hyperframes-student-kit/video-projects/**

- `hyperframes-student-kit/video-projects/aisoc-app-release/` 用了：`instagram-follow`、`x-post`、`grain-overlay`、`shimmer-sweep`
- `hyperframes-student-kit/video-projects/aisoc-hype/` 用了：`grain-overlay`、`shimmer-sweep`
- `hyperframes-student-kit/video-projects/aisoc-lesson-5-1/` 用了：_（未引用 catalog 零件，全部自制）_
- `hyperframes-student-kit/video-projects/claude-edit-intro/` 用了：`grain-overlay`、`shimmer-sweep`
- `hyperframes-student-kit/video-projects/clickup-demo/` 用了：_（无 compositions/ 目录，单文件 index.html）_
- `hyperframes-student-kit/video-projects/first-agent-promo/` 用了：_（无 compositions/ 目录，单文件 index.html）_
- `hyperframes-student-kit/video-projects/golden-ratio-demo/` 用了：`grain-overlay`
- `hyperframes-student-kit/video-projects/hyperframes-sizzle/` 用了：`app-showcase`、`chromatic-radial-split`、`cinematic-zoom`、`cross-warp-morph`、`data-chart`、`domain-warp-dissolve`、`flash-through-white`、`glitch`、`gravitational-lens`、`instagram-follow`、`light-leak`、`logo-outro`、`ridged-burn`、`sdf-iris`、`swirl-vortex`、`thermal-distortion`、`tiktok-follow`、`whip-pan`、`x-post`、`yt-lower-third`、`grain-overlay`、`grid-pixelate-wipe`、`shimmer-sweep`
- `hyperframes-student-kit/video-projects/linear-promo-30s/` 用了：_（未引用 catalog 零件，全部自制）_
- `hyperframes-student-kit/video-projects/may-shorts-18/` 用了：_（未引用 catalog 零件，全部自制）_
- `hyperframes-student-kit/video-projects/may-shorts-19/` 用了：_（未引用 catalog 零件，全部自制）_
- `hyperframes-student-kit/video-projects/may-shorts-6/` 用了：_（未引用 catalog 零件，全部自制）_

**hyperframes-launches/**

- `hyperframes-launches/hyperframes-launch/` 用了：_（未引用 catalog 零件，全部自制）_
- `hyperframes-launches/timeline-launch/` 用了：_（未引用 catalog 零件，全部自制）_
- `hyperframes-launches/website-to-hyperframes/` 用了：_（未引用 catalog 零件，全部自制）_

**videos/**

- `videos/2026-05-02-claude-demo-v2/` 用了：`grain-overlay`、`shimmer-sweep`
- `videos/2026-05-02-claude-overlays-only/` 用了：`grain-overlay`、`shimmer-sweep`
- `videos/2026-05-02-codex-claude-intro/` 用了：_（未引用 catalog 零件，全部自制）_
- `videos/2026-05-04-claude-19-tips-hf/` 用了：`cinematic-zoom`、`flash-through-white`、`flowchart`、`logo-outro`、`macos-notification`、`whip-pan`、`grain-overlay`、`shimmer-sweep`

<!-- AUTO:zero-usage:end -->

---

## 三、Skill 索引（Claude / Codex 分入口）

Claude Code 读 `CLAUDE.md` + `.claude/skills/`；Codex 读 `AGENTS.md` + `.agents/skills/`。两边的自写 wrapper skill 应保持同一套视频生产语义，但内部引用分别指向自己的指令文件。

### 上游 skill（软链跟随更新，7 个）

| Skill | 用途 |
|---|---|
| `gsap` | GSAP 动画 API 速查 |
| `hyperframes` | 框架规则（data-* 属性、timeline 注册） |
| `hyperframes-cli` | CLI 命令清单 |
| `hyperframes-registry` | registry 安装用法 |
| `website-to-hyperframes` | 网页转视频管线 |
| `make-a-video` | 从 0 到成片的 8 步引导 |
| `short-form-video` | 9:16 竖屏 SOP（10 条质量铁律） |

### 自写 wrapper skill（2 个，两边都应存在）

| Skill | 触发词 | 干啥 |
|---|---|---|
| `cyxj-new-video` | 「新视频」「做视频」「片头」「new video」「做完了」「归档」 | 全生命周期：建工程 → 推参考 → 渲染 → 归档 → 询问抽模板 |
| `cyxj-add-block` | 「加个零件」「装个 X」「加个转场」「加 macos 通知」 | 从 catalog 推荐 1-3 个 block 并 add，告知怎么引用 |

### 边界规则

- Claude 专属措辞留在 `.claude/skills/`，Codex 专属措辞留在 `.agents/skills/`
- 共享层是 `templates/`、`videos/`、`docs/`、`skills/`、`.gitignore`
- 另一个 AI 做审查或修共享层时，先排除正在制作的 `2026-MM-DD/<slug>/` 施工目录

---

## 四、官方文档本地镜像（`docs/hyperframes-official/`）

> 78 页全量镜像 mintlify `.md` 原文，每 1-2 月跑 `bash scripts/refresh-docs.sh` 刷新。
> 优先 grep 这里而不是开浏览器查官网。

| 子目录 | 内容 |
|---|---|
| `getting-started/` | introduction、quickstart |
| `concepts/` | compositions、data-attributes、determinism、frame-adapters |
| `guides/` | gsap-animation、rendering、common-mistakes（**必读**）、performance、prompting…（13 篇） |
| `packages/` | cli、core、engine、producer、studio、player（API 速查） |
| `reference/html-schema.md` | HTML schema 完整参考 |
| `catalog/blocks/` | 43 个 block 的官方说明（社交叠层、shader 转场、案例展示…） |
| `catalog/components/` | grain-overlay、shimmer-sweep、grid-pixelate-wipe |
| `community/adopters.md` | 谁在用 hyperframes |

完整索引看 `docs/hyperframes-official/README.md`。

---

## 五、模板（仓库根 `templates/`，1 个真模板）

跟 videos/ 不同：模板是抽过的精简骨架，**直接 cp 起步**用。当前**只有 1 个**从 0 设计的真模板。

| 模板 | 拓扑 | 输出 | 适用场景 | 对应 DNA 形态 |
|---|---|---|---|---|
| `templates/tutorial-8beat/` | 8 beat 教程（hook → pain-list → verdict → punchline → promise → concept → flow → outro），含 face FULL→PiP→FULL 时序 + kicker + 终端 + 卡片栈 + 执行计划列表 + 章节切换卡 | 整片 MP4 | 中文教程视频 ≥30s ≥6 beat（口播 + 多组件） | 教程类 → 暖米色 `#F7F2EA`（19-tips 实战验证） |

详见 `TEMPLATE_USAGE.md`。

### 旧形态拓扑回查（看 videos/，不要 cp）

> 这些形态没有抽过真模板。想做这些形态的视频请**从 0 写**，可看下面工程的拓扑作参考，但不要 cp 起步（id / 文案 / DNA 老色都绑死了）。

| 形态 | 看哪个工程 |
|---|---|
| 录屏铺底 + overlay（host-overlay）| `videos/2026-05-02-claude-demo-v2/` |
| 仅 overlay alpha 输出（host-overlay-alpha）| `videos/2026-05-02-claude-overlays-only/` |
| 7 beat 串联无录屏（demo-fullscreen）| `videos/2026-05-02-codex-claude-intro/` |

**⭐ tutorial-8beat 配套资产**：
- 风格借鉴方法论：`docs/STYLE_BORROW_PLAYBOOK.md`
- 用户视觉 DNA 基线：`MY_VISUAL_DNA.md`（仓库根，与 `MOTION_PHILOSOPHY.md` 同级）

用此模板时建议走 `/cyxj-new-video` 阶段 D（风格借鉴），自动接入 DNA + playbook。

---

## 持续积累循环

```
做新视频  (2026-MM-DD/<slug>/)
   ↓ /新视频 阶段 A：建工程 + 推参考
   ↓ 提供文案 + 迭代 + 渲染
   ↓ 说「做完了」
   ↓ /新视频 阶段 B：归档
归档到  videos/<日期>-<slug>/  （含 final.mp4）
   ↓ /新视频 主动问：要抽成新模板吗？
   ├─ 不要 → 完成
   └─ 要 → /新视频 阶段 C
         抽掉具体内容 → templates/<新模板名>/
         TEMPLATE_USAGE.md 加一节
   ↓
本 INDEX.md 加一行
   ↓
未来 Claude 在做新视频时会推荐这个工程作参考
```

---

## 维护节奏

| 周期 | 动作 |
|---|---|
| 每月 | `bash scripts/refresh-catalog.sh` 刷新 catalog 索引（看是否有新增 block） |
| 每 1-2 月 | `bash scripts/refresh-docs.sh` 刷新 `docs/hyperframes-official/` 官方文档镜像（78 页，动态读 llms.txt） |
| 每 1-2 月 | `cd hyperframes-student-kit && git pull && cd ../hyperframes-launches && git pull` 更新上游 |
| 每条新视频做完 | 归档到 `videos/`，本 INDEX 加一行 |
| 每 3-6 月 | 盘点 INDEX，把高频参考工程抽成新 templates/ 模板 |
