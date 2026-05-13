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

### b4-b6 metaphor 候选（Stage M 批次 1，等用户拍板）

按 b1-b3 同一格式展开。每句给 2-3 个 metaphor 候选 + 每 beat 末给整 beat 主线候选（贯穿整段的核心物体）+ 推荐项 + 理由。**拍板之前不动 HTML**。

---

#### b4 s1-flow (23.0–43.0s, 20s) — "即梦风格 → 截屏 → 反推规范 → 写 HTML → 出图"

**当前病灶**：3 个 step 卡 + connector + token chip + code 卡 — 完整字幕翻译。每句话都对应一个 HTML 元素，没有承载概念的物体。

| 句（SRT 相对起点） | 核心概念 | 当前做法 | metaphor 候选 |
|---|---|---|---|
| 0.066–2.266 "因为我最近在做即梦 Agent 的拆解" | 背景：我在拆一个 AI 工具的设计语言 | 即梦 chip + AGENT pulse | A) **解剖台**：即梦 logo 平躺在工作台上，旁边浮放大镜 / 镊子 / 笔记本 SVG —"拆"是动作不是 chip<br>B) **抽屉拉开 reveal**：即梦 logo 当 hero，从 logo 内部"拉出"一个 schematic 抽屉（设计 token 排列） —"拆"= 从里面拿东西出来<br>C) **桌面工作流场景**：浏览器开着 jimeng.com tab + 旁边一个 markdown 编辑器，画面切到"拆解中" cursor —场景化 |
| 2.300–3.900 "所以我想要这篇文章" | 起点：我有一篇待发的文章 | article chip "想配图" | A) **空白文章稿浮起**：衬线大标题 + 占位段落 + 占位图框，**图框是问号**（缺图的痛）<br>B) **文章稿 + 一只手按住**：手按在标题"AI Agent 拆解"上 —"我的"占有感<br>C) **思考气泡里只有一张空 article**：从无脸创作者轮廓冒出 —"想做"的状态 |
| 4.000–5.633 "以即梦的风格去配图" | 要换皮肤：用某个视觉风格 | "即梦 风格" lime 划线 | A) **风格 swatch 拼贴**：4 块颜色 swatch + 3 个字号 sample + 2 个排版片段聚拢，**拼成一张 palette 贴上稿子** —风格 = palette 物体<br>B) **皮肤换色**：article 稿底色 fade 成"即梦"暖色基调（#FF6B6B → #FF8E53） —风格 = 视觉表皮被换<br>C) **印章砸下**：橡皮印章 "JIMENG STYLE" 砸盖在稿子上，墨迹晕开 —贴风格 = 盖章 |
| 5.633–7.733 "所以我就截了即梦的一张界面" | 截屏 = 拿样本 | 浏览器 chrome + 占位 block 的 capture 卡 | A) **截屏框 + lime 闪光**：浏览器 viewport 里出现虚线选择框 + 4 角控制点 → 瞬间一个 lime 闪 —"咔嚓"物理感<br>B) **拍立得吐出**：屏幕侧面"吐"出一张 Polaroid 大小的截图卡，落到桌面 —截图 = 实物<br>C) **iPhone 截图浮起**：jimeng 界面 mock 从底部滑出，带 iOS 截图缩略图投影 —产物感 |
| 7.733–10.666 "它直接能够反推出整套的设计规范" | **逆向工程**：从视觉拆出系统 token | connector draw + token 卡浮出 | A) **扫描光束 → 散开为 token**：截图卡上扫过一道 CT 扫描光，光从右侧散开变成 4-6 颗 token 节点漂出 —解码过程可视化<br>B) **截图被打散 grid → 重组为 token list (Flip)**：截图的 block 元素**飞散** → 重新排列成右侧 spec 4 行 —同物体状态 morph<br>C) **截图变 X-ray**：截图半透明，露出底层 spec annotation（颜色标签 / 字号标尺 / 间距尺） —像 Figma inspect |
| 10.700–12.933 "颜色字号排版留白全部都到位" | 4 维度全覆盖 | 4 token chip 依次填入 | A) **4 个 spec 样本卡 grid**：颜色卡（色块）+ 字号卡（A-A-A 三层）+ 排版卡（grid 线）+ 留白卡（空白方框 + 标尺） —每张都是 metaphor 不是 chip<br>B) **承句 5 续做**：句 5 飞散出的 token 节点继续"长大"成 4 个可视化 spec 卡<br>C) **checklist 打勾**（**降级**：还是太 PPT，不推荐） |
| 13.100–14.933 "接着让他用写代码的形式" | 从 spec 到 code 的形式转换 | code 卡入场 + connector draw | A) **spec 卡 → code 卡 morph (Flip)**：spec 4 行（颜色 / 字号 / ...） morph 成 code 4 行 `<section>` HTML —同物体形态变化<br>B) **打字机 SplitText**：IDE 窗口浮起，code lines 用 SplitText.chars 逐字 typewriter —写的动作<br>C) **键盘 + 飞出的字符**：键盘 SVG + 字符像火花从键面飞起堆成 code —"敲"的动作 |
| 14.933–17.133 "把 html 就是网页啊" | HTML = 网页骨架 | code 卡显 `<html>` snippet | A) **HTML tag 浮出 → 自动拼成 wireframe**：`<section>` `<h1>` `<img>` 这些 tag 漂浮 → 自动堆叠成一个 wireframe —HTML = 网页骨骼<br>B) **从 code 块"长出"网页**：code 字符流向右侧 → 实时拼成 mockup 网页 —compile 过程可视化<br>C) **括号炸裂**：`<>` 形状从中间打开，绽放出网页 mock —playful |
| 17.133–18.466 "把图给写出来" | 网页 → 图片 | mock 网页渲出 | A) **截屏框压扁网页 → 静态图**：wireframe 网页被截屏框框住 → "啪"压扁成一张静态图卡 → 落入"outputs" 文件夹 —完整产品流<br>B) **导出动作**：网页 mock 上方浮出 "EXPORT → png" 按钮，按下后 mock 缩成一张图浮起 —导出可视化<br>C) **网页 → 图 morph (Flip)**：wireframe morph 成 IG post 比例图卡 |
| 18.533–19.933 "那效果是真的好" | 评价 = 满意 | lime ✓ + "效果真的好" 大字 | A) **3 张成品图 cascade**：导出图卡复制成 3 张，cascade 从画面侧浮起 —"output 真的好"可见<br>B) **lime "PASSED" 印章砸下**：盖在导出图卡上 —物理 success 标记<br>C) **图卡放大占据中央 + 柔光 halo**：成品放大后画面外围 vignette 收暗 —"成品级"质感 |

**整 beat 主线候选**：

- **A) 解构 → 重组（Flip morph 链）**：截图 → 飞散 → spec → morph code → morph 网页 → 压扁成图。**同一份信息**沿时间线连续变换形态，承载"反推 / 写代码 / 出图"的转化叙事。
- **B) 桌面工作流场景（desktop scene）**：所有元素活在一个虚拟设计师桌面 — 浏览器 / IDE / 文件夹 / 截图卡 / 网页 mock 都是真实工作流物体。场景沉浸感强但 20s 内调度复杂。
- **C) 传送带流水线（conveyor belt）**：截图 → spec → code → image 沿带子横向移动，每站一个"加工"动作。工业风但跟 DNA（静谧米色）冲突。

**推荐 A — 解构 → 重组**：
- 用 GSAP Flip plugin 跑 morph 链，正是 PLAN.md Tier 2 已识别的招式
- 每次形态变化都对应一句 SRT 重音瞬间 — SRT 对齐天然
- callback 强：句 9 出来的"图卡"可在 b10/b13 复用作"成品"物体
- 风险：Flip 在 hyperframes wrapper 里做大量 layout shift 需要测内存（memory `feedback_hf_composition_count_memory`）— 但 20s 内 < 8 次 morph 应该 OK

---

#### b5 s1-pain (43.0–57.5s, 14.5s) — "限额墙：1 小时用完 / 冷却一周 / Pro 救不了 / 推上吐槽 / 等不了"

**当前病灶**：usage bar + 3 列 facts（1H / 7DAYS / Pro×）+ X bubble 墙 + Anthropic 回应 + "等不了" 大字。pain 段被翻译成"仪表 + 数据卡 + bubble"，**痛点没有身体感**。

| 句 | 核心 | 当前 | metaphor 候选 |
|---|---|---|---|
| 0.033–1.066 "但有个大坑啊" | 警告 / 故事转折 | ⚠ + "但有个大坑" 大字 stagger | A) **断崖出现**：续接 b4 末的成品图卡 — 镜头下 pan 露出图卡下方是一个**深黑色裂缝 / 坑**（SVG 不规则形）<br>B) **成品图卡掉进坑**：图卡向下掉，镜头下移露出深坑 —物理续接 b4<br>C) **路标 ⚠ 从地面插起**：带 motion blur 拍打感 —但仍是 icon-driven，**不推荐** |
| 1.266–3.033 "Claude 一旦它的周限额特别低" | 限额低 / 资源在快速消耗 | usage bar 升到 95% | A) **沙漏 (hourglass)**：上半已空大半，沙子快速漏 —时间 / 资源消耗的经典物理 metaphor<br>B) **lime 金币堆掉光**：一堆 lime 金币从上往下一颗颗消失 —callback Infinite Payments 的 "coin" 物体（Law #6）<br>C) **电量条 / 油表指针偏左红区**：但仍是仪表卡，**不推荐** |
| 3.066–4.566 "我当时跑了一个小时" | 1 小时 = 时间花费 | "1 H" 数字 fact | A) **沙漏 callback**：沙漏翻转过一次（标记"1 个周期"）—同物体延续<br>B) **时钟 sweep**：钟面指针 1 小时 sweep 一周 —时间感<br>C) **沙漏底部沙堆字样"1H"**：沙子堆出 "1H" 字形 —物体衍生字形 |
| 4.600–6.000 "它冷却就要冷却一周" | 锁死整周 | "7 DAYS" 大字 | A) **沙漏结冰 / 冰封**：沙漏被一层霜 / 冰**覆盖**，沙子在冰里冻住 —"冷却"= 物理冷冻<br>B) **日历 7 格阴影覆盖**：周视图日历的 7 个格子被冷调阴影笼罩 —整周失效<br>C) **巨大冰块包住 Claude logo**：冷藏舱 metaphor —但与 b1 已用的"撕毁/被抓"不同物体系，OK |
| 6.066–7.733 "而且 Pro 的会员也救不了" | 花钱也没用 | Pro pill + ❌ 划掉 | A) **会员卡塞进读卡器 → REJECTED**：塑料 Pro 卡 hover 进 slot，slot 闪灰 → 卡片弹出来 —物理 reject 动作<br>B) **lime 金币撞冰墙**：lime 金币飞向 (句 4 那块) 冰，**撞上去弹回**而不是融化 —"钱不破冰" 的物理 metaphor，**与 b5-A 主线绑定**<br>C) **Pro chip + ❌**：static，**不推荐** |
| 7.733–9.066 "那限额就是限死的" | 硬上限 / 锁死 | lock + usage 撞顶 + shake | A) **天花板砸下**：粗黑板从画面上方"啪"砸下来，落在 usage / 沙漏顶部 —"撞顶"物理动作<br>B) **挂锁 + 链条**：挂锁 + 锁链缠住沙漏 —"锁死"<br>C) **沙漏中段裂开**：沙漏破裂 —但语义偏"坏"不是"锁"，**不推荐** |
| 9.133–11.400 "嗯那推上也是一堆人在吐槽啊" | 全网怨气 / 密度感 | 3 X bubble 静态排列 | A) **X 通知洪流**：X icon 从右上角弹出，**铺天盖地的通知卡片**（用户名 + 短句）雨点式从顶部下落，stagger 高密度 —量级感<br>B) **X 黑形 logo 星空背景**：背景密布黑色 X 形 logo，间断"亮起"小红点 —抽象的"全网都在抱怨"<br>C) **手机屏幕震动 + badge 跳到 99+**：iPhone 大幅震动，X icon 红 badge 从 1 → 99+ —物理设备感 |
| 11.400–12.966 "Anthropic 团队说在优化" | 官方回应 / 安抚但没用 | 蓝色 ink chip "在优化" | A) **官方 verified 推文卡**：Anthropic 头像 + 蓝勾 + "we're optimizing..." 推文卡 —**在洪流中孤立的一条**（与句 7 的密度对比）<br>B) **维护胶带斜跨冰墙**：警戒胶带 "UNDER MAINTENANCE" 斜挂过冰墙 —物理"维修中"标记<br>C) **顶部 banner**："TEAM IS OPTIMIZING" 公告条，**不推荐** |
| 13.000–14.466 "但我当时是等不了了" | 放弃 / 转身 | "等 不 了" 衬线大字 stagger | A) **沙漏被推倒**：沙漏被推翻，沙子洒满地 —"放弃"物理动作<br>B) **背身离开冰墙**：作者 cursor / 头像从冰墙前转身，远去 motion blur trail —准备过渡 b6<br>C) **关闭浏览器 tab × 被按下**：Claude tab 被关闭 —数字动作 |

**整 beat 主线候选**：

- **A) 沙漏 + 冰墙双物体**：沙漏 = 限额耗尽 / 冰墙 = 冷却锁死 / lime 金币 = 钱（撞冰墙弹回）。两个核心物体贯穿，省字幕翻译。
- **B) 仪表盘 + 锁链**：升级当前 usage bar 为更工业的仪表盘 + 锁链。但仍是"卡片化"，不彻底反 PPT。
- **C) X 社交风暴主导**：整 beat 都做成 X 风暴 cold and crowded — pain = 群体焦虑。但 "1H / 7DAYS / Pro" 这种**数据 fact** 塞不进 X 风格。

**推荐 A — 沙漏 + 冰墙**：
- Law #6 object metaphor 两个物体 carry 整 beat：沙漏（句 2-3-7-9）+ 冰墙（句 4-5-6）
- 物体状态变化（沙漏漏 → 翻 → 结冰 → 裂；金币撞冰墙弹回）承载"故事性"，不是 5 张卡并排
- 与 b6 解法（"换思路 / 双脑"）的转身衔接自然 — 沙漏倒地 → 镜头转 → 新画面
- 沙漏 + 金币是 Infinite Payments / Stripe 视频经典符号，DNA 内（米 / 墨 / lime）可实现，不需新色

---

#### b6 s2-intro (57.5–67.0s, 9.5s) — "换思路 → phase 2 → Claude 做大脑出规范 → 丢给 Codex 执行"

**当前病灶**：switch chip + "第二阶段" 大字 + horizontal pipeline（Brain disc → spec doc 4 行 → Codex disc）—**角色分工没物体感**，"大脑"只是个 label 不是大脑。

| 句 | 核心 | 当前 | metaphor 候选 |
|---|---|---|---|
| 0.033–1.266 "所以我就换了一个思路啊" | 切换 / 打开新路 | switch icon + "换思路" chip | A) **toggle 开关弹响 + 画面色调微调**：switch SVG 被"按"一下，背景米色基调微微 pulse —物理"换"<br>B) **路口分叉**：路从一条 SVG line 分成两条，光标走向右边那条 —路径 metaphor<br>C) **续接 b5**：作者 cursor / 头像从倒下的沙漏前**转身**走向画面右侧 —续物体续故事 |
| 1.266–2.666 "就到了我们的第二阶段" | phase 2 标记 | "第 二 阶 段" 衬线大字 stagger | A) **章节翻页**：纸张从右翻向左，露出 "PHASE 02" 衬线大字 —物理书页感<br>B) **callback b2 teaser 的 3 节点时间线**：第 2 个节点亮起 / pulse —**强 callback**串起 b2 ↔ b6 ↔ b10<br>C) **stage 序号大字 "02" lime fill**：直接大数字 02，背后衬线 + lime —视觉重量但纯文字 |
| 2.700–4.433 "让 Claude Design 做大脑" | Claude = 思考者 / 出脑力 | Claude disc（橙渐变） + "BRAIN" label | A) **大脑 SVG (lobe-icons brain.svg) + Claude logo 内嵌**：脑形物体本身就是"thinking"，Claude logo 嵌入脑里中央 —**物体即概念**<br>B) **思考者剪影 (Rodin)**：罗丹"思考者"姿态剪影 + Claude logo 标识在头部 —classical 拟人<br>C) **建筑师持蓝图**：Claude 一侧站着剪影持卷轴蓝图 —预示句 4 的"出规范"= 出蓝图 |
| 4.433–5.500 "出设计规范" | 产出 spec | spec doc 4 行 emit | A) **蓝图卷轴 unroll**：从 brain / 思考者那里"吐出"一张卷轴，**展开**露出 spec 行（颜色 / 字号 / 间距 / 圆角） —物理 emit<br>B) **A4 spec doc 从 brain disc 侧面"打印"出来**：纸张抖一下 —printer 物理感<br>C) **思考气泡破裂 spec 行掉出**：cartoon 风，**不推荐**（与 DNA 风格冲突） |
| 5.500–7.400 "那把设计规范我怎么呢" | 交接 / 准备递出 | connector 1 → 2 draw | A) **卷轴 hand-off (MotionPath)**：卷轴卷起 → 沿 SVG 曲线轨迹从 Brain 那侧飞向 Codex 那侧 —真"交"动作<br>B) **传送带物体**：spec doc 放上微型传送带被传走 —工业感<br>C) **手递手**：一只手把 spec doc 递出 —拟人但 SVG 复杂 |
| 7.400–8.500 "丢给 Codex" | 抛出 / 不管了 | spec → Codex 流向 | A) **续接句 5**：卷轴飞到 Codex 手上 / 接口处 —同物体延续<br>B) **toss 弧线**：spec doc 被"抛"出 motion blur 弧线落到 Codex —物理 toss 力度<br>C) **USB / 卡片插入 Codex 接口**：spec 像卡片插入 Codex 一侧 slot —数字 metaphor |
| 8.500–9.466 "让他去执行" | 行动 / 工人开干 | Codex disc pulse | A) **Codex + 一对工人手臂 SVG + 速度线**：Codex 旁出现忙碌的手臂（卡通手套）+ 短促速度线 —**双手**与"大脑"对比 (Law #6 paired metaphor)<br>B) **进度条启动**：Codex 下方进度条从 0 跑起 —工程感<br>C) **机械臂 robotic arm**：spec 卷轴插入后机械臂工作 —但 SVG 制作成本高，**降级** |

**整 beat 主线候选**：

- **A) 大脑 + 双手 (Brain + Hands)**：Claude = brain SVG（lobe-icons brain）/ Codex = 工人手臂 SVG（heroicons hand 或 phosphor）—角色对比极清晰；spec = 中间传递的"卷轴"。
- **B) 建筑师 + 施工队 (Architect + Construction)**：Claude = 持蓝图的建筑师剪影 / Codex = 拿工具的施工工人 —叙事感更强但 SVG 资产量大。
- **C) 思考者 + 打字员 (Thinker + Typist)**：Claude = 罗丹"思考者"剪影 / Codex = 键盘上的手 —classical 但与现代 SaaS 视觉风格 mismatch。

**推荐 A — 大脑 + 双手**：
- 最简洁 — 2 个物体 carry 整 beat（脑 + 手）
- callback 强：b7 "两个工具各司其职 / 天选打工"还能复用脑 + 手对比（强化"分工"主线）
- SVG 资产：lobe-icons 有 brain.svg / heroicons 或 phosphor 有 hand 形 SVG，DNA 米墨配色直接套
- spec 卷轴是中间的"信物" — MotionPath 飞越 = Tier 2 已识别招式

---

### Stage M 批次 1 总结 + 下步

**b4-b6 三条主线建议（待用户拍板）**：
- b4 → **解构重组 Flip 链**（截图飞散 → spec → code → 网页 → 图）
- b5 → **沙漏 + 冰墙**（限额耗尽 / 锁死冷却 / 钱撞冰墙）
- b6 → **大脑 + 双手**（Claude brain / spec 卷轴 / Codex 工人手臂）

**callback 串接**（Law #6 强化）：
- b4 末 "成品图卡" → b5 头**掉进坑** → 续 b5 沙漏
- b5 末 沙漏倒下 → b6 头 cursor **转身**走向新画面
- b6 brain/hands → b7 "各司其职 / 天选打工" 复用同一对物体

**用户拍板后**：
- 锁定 b4-b6 主线（A / B / C 任选）
- 进 Stage M 批次 2 — 展开 b7 (s2-tools) / b8 (s2-result) / b9 (s2-reflect)
- 13 beat metaphor 全锁定后才进 Stage 0（GSAP 升级）

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
