# MY_VISUAL_DNA —— 小陈个人视觉 DNA 档案

> XCYJ 视频的"个人美学宪法"。每次写新 STYLE_BRIEF 时**先读这个**，再读参考素材。
>
> **与 `MOTION_PHILOSOPHY.md` 的区别**：
> - `MOTION_PHILOSOPHY.md` = Nate 的 Infinite Payments 商业 promo 美学（普适纪律：≤5 色、不硬切、三段式）
> - `MY_VISUAL_DNA.md` = 小陈个人色彩+字体+纹理+节奏的具体选择（只属于自己的取舍）
>
> 两者**互补不重叠**。普适纪律在 MOTION_PHILOSOPHY，个人偏好在这里。

---

## 来源

从以下 4 个工程实证提炼：
- `参考库/我的作品/2026-05-02-claude-demo-v2/`
- `参考库/我的作品/2026-05-02-claude-overlays-only/`
- `参考库/我的作品/2026-05-02-codex-claude-intro/`
- `2026-05-03/claude-code-tutorial-overlays/`（升级后版本）

下面的每条规则都至少在 2 个工程中重复出现，才被收为 DNA。

---

## 不可妥协（Must Keep）

每条都是**强制项**。新视频必须满足，否则不算"小陈的视频"。

### 1. 底色：午夜深蓝（**永远不是纯黑**）
```css
--c-bg: #0a1124;   /* 推荐 */
/* 容许范围：#050810 ~ #0a1124 */
```
纯黑 `#000000` 不允许；亮一档的灰 `#1a1a1a` 也不允许。微微的蓝调是关键——让画面有"科技感+夜晚感"，而不是廉价的黑。

### 2. Claude 橙必现：`#d97757`
```css
--c-orange: #d97757;
--c-orange-glow: rgba(217, 119, 87, 0.55);
```
**至少在一处**用作 hot 色 / 强调 / halo / logo。位置不强求，但必须有。这是"小陈的标志"。
- PiP 真人头默认配 Claude 橙 halo（不用蓝、绿、紫）
- 终端窗口 prompt 符号或关键命令行通常用橙
- 标题大字至少有一个 hot 词用橙渐变

### 3. 全屏纹理三件套
**全程**铺这三层（贯穿整片，不仅是某段）：

| 层 | 实现 | 效果 |
|---|---|---|
| 透视网格 | `linear-gradient(rgba(91,180,255,.08) 1px, transparent 1px)` 80px×80px | 科技感底座 |
| 暗角 vignette | `radial-gradient(ellipse 70% 70% at 50% 50%, transparent 30%, rgba(5,8,20,.55) 100%)` | 中心聚焦 |
| 颗粒 grain | 引用 `compositions/components/grain-overlay.html` opacity 0.10-0.12 mix-blend overlay | 质感+减少塑料感 |

三件套缺一不可。在 `index.html` 顶层一次画完，beat 内部不再画。

### 4. 字体三件套
```css
--f-zh: "Noto Sans SC", "Inter", sans-serif;     /* 中文 */
--f-en: "Inter", system-ui, sans-serif;          /* 英文 */
--f-mono: "JetBrains Mono", ui-monospace, monospace; /* 代码/等宽 */
```
不允许换：不要 Roboto、不要 Source Han、不要 Google Sans。

### 5. Chrome 渐变大字（hero 标题）
```css
background: linear-gradient(180deg, #ffffff 0%, #c8d3e0 62%, #e8ecf2 100%);
-webkit-background-clip: text;
color: transparent;
```
hot 词单独覆盖一层"白→橙"渐变：
```css
background: linear-gradient(180deg, #ffffff 0%, #f5b39a 50%, #d97757 100%);
filter: drop-shadow(0 0 20px rgba(217,119,87,.55));
```
这是已经写过 4 次的固定招式。

### 6. 入场节奏：字符 stagger 0.06-0.08s，卡片 0.12-0.15s
```js
ease: "back.out(1.4)"   // 卡片
ease: "expo.out"        // 光线/线条
ease: "power3.out"      // 一般文字
filter: "blur(14px) → blur(0)"  // 营造焦点感
```
不允许全屏一次性蹦出来——必须分批、有 stagger。

### 7. PiP 配 Claude 橙 halo（不用别的色）
真人头缩小成 PiP 时：
- 圆角 36px
- 1-2px 内描边 `rgba(255,255,255,.06)`
- 外发光 box-shadow 用 Claude 橙：`0 0 60px rgba(217,119,87,.45), 0 0 0 2px rgba(217,119,87,.6)`

蓝色 / 绿色 halo 不允许——它们会破坏品牌一致性。

---

## 可调整（Tunable）

下面这些**每条视频可以不同**，按主题决定：

| 项 | 默认 | 可改成 |
|---|---|---|
| Hot 色（除 Claude 橙之外的高亮色） | `#5BA9FF` 蓝 | 红 `#F05F6E` / 绿 `#8DD891` / 紫 `#B891E4` / 黄 `#F0C75E` |
| Hero 字号 | 88-120px | 60-160px |
| PiP 位置 / 大小 | 右上 1380,60 / 480×320 | 任意角落，比例 3:2 ~ 9:16 |
| Beat 数量 | 8 | 5-12 |
| 章节 kicker 文案 | `EP·N / 主题` | 自由（保持 mono 字体 + 0.32em letter-spacing） |
| 配色辅助色（除 Claude 橙之外的） | 从 5 色教程语义系统选 | 按品牌定 |
| 转场类型 | flash-through-white / blur-zoom | catalog 里其他 shader 转场 |

---

## 反例（Don't）

下面这些做了就不像"小陈的视频"：

1. ❌ 纯黑底 `#000000` —— 太老、太工业，丢失夜晚感
2. ❌ 没有透视网格 —— 画面会"飘"、缺底座
3. ❌ 没有暗角 vignette —— 注意力散，没有"中心舞台"感
4. ❌ 字体换成 Roboto / Helvetica —— 失去中文气质
5. ❌ 整片没有 Claude 橙露出 —— 失去品牌锚点
6. ❌ PiP halo 用蓝/绿/紫 —— 破坏品牌一致性
7. ❌ 全屏一次性入场（无 stagger） —— 节奏粗糙
8. ❌ 硬切转场（无 fade / blur / shader） —— 廉价感
9. ❌ Hero 大字纯白色（不用 chrome 渐变） —— 太平、缺质感
10. ❌ 单 beat 用 ≥3 个 hot 色 —— 注意力分散，违反 MOTION_PHILOSOPHY

---

## 自检清单（写完 brief 后过一遍）

每条视频的 STYLE_BRIEF 写完后，main agent 必须照这 5 个 yes/no 问题逐条核：

- [ ] **Q1**：底色是否在 `#050810 ~ #0a1124` 范围内（午夜深蓝，非纯黑）？
- [ ] **Q2**：至少有一个 beat 用了 Claude 橙 `#d97757`（hot / halo / logo / 终端 prompt）？
- [ ] **Q3**：index.html 顶层画了透视网格 + 暗角 + 颗粒三件套？
- [ ] **Q4**：字体栈用 Noto Sans SC + Inter + JetBrains Mono？
- [ ] **Q5**：所有 hero 大字用了 chrome 渐变（不是纯白），所有 PiP halo 用 Claude 橙？

**5 个全 yes 才算 DNA 通过**。任何一条 no 必须修改 brief，不能进派 agent 阶段。

---

## 维护节奏

- 每做完一条新视频，问一下"DNA 有要更新的条目吗"——如果连续 2 条视频都用了某个新偏好（比如固定加某个 catalog 零件），再加进 DNA
- 不要每次都改 DNA——这个文档稳定性是关键，DNA 频繁改 = 没 DNA
- 与 `MOTION_PHILOSOPHY.md` 不重叠：那边是普适纪律，这边是个人偏好
