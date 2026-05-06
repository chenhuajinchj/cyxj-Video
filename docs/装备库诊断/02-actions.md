---
name: 装备库盘点 处置清单
description: 15 个真实缺口对应的具体执行动作（每条 1+ commit），按优先级分批
type: project
date: 2026-05-06
based_on: 00-diagnosis.md + 00-gaps.md + DNA 重写后（commit 96eeb45）的优先级重判
---

# 02 · 装备库盘点 处置清单

> 接续 [`00-diagnosis.md`](./00-diagnosis.md) + [`00-gaps.md`](./00-gaps.md)。
> DNA 重写后（commit 96eeb45）的缺口数变化：原 16 → **15**（G8 消失，G6/G7 降级）。
> 每个 Action 给"具体动作 / 完成判定 / 时间 / 依赖 / commit message 草稿"。

---

## 优先级总表

| Action | 缺口 | 优先级 | 时间 | 依赖 | 可派 sonnet？ | 状态 |
|---|---|---|---|---|---|---|
| A1 cc-window 沉淀到 templates/components/ | G2 | 🔥 P0 | 1-1.5h | 无 | 部分（提取阶段）| ✅ 7ff7111 |
| A2 11 个教训沉淀到 MY_MOTION_NOTES.md | G3 | 🔥 P0 | 1-2h | 无 | 否（需判断）| ✅ d118862 |
| A3 cyxj-new-video 加 URL 移交规则 | G1 | 🟧 P1 | 5min | 无 | 否 | ✅ 6396cdb |
| A4 12 协作开窍点写进 cyxj-new-video | G4 | 🟧 P1 | 30-45min | 无 | 否 | ✅ d4ab82b |
| A5 cyxj-new-video 阶段 D 显式 enforce DNA | G6 | 🟧 P1 | 10min | A4 | 否 | ✅ d4ab82b |
| A6 3 模板补 README | G9 | 🟧 P1 | 1.5-2h | 无 | ✅ 派 3 个 | ✅ 5edf40e |
| A7 CLAUDE.md 加 Claude/Codex 边界节 | G11 | 🟧 P1 | 5min | 无 | 否 | ✅ 0ee2ac3 |
| A8 硬约束单源化到 HARD_CONSTRAINTS.md | G12 | 🟨 P2 | 1h | 无 | 否 | ✅ 0793253 |
| A9 INDEX 零件用例回填脚本 | G13 | 🟨 P2 | 1-1.5h | 无 | 否 | ✅ 71cf183 |
| A10 docs 扫剩 41 页 catalog | G14 | 🟨 P2 | 1h | ✅ 派 1-2 个 | de03980（实扫 35 页，72/78）| ✅ |
| A11 cyxj-new-video 加模板选择决策树 | G16 | 🟨 P2 | 30-45min | A6 | 否 | ✅ 479d737 |
| A12 19-tips 归档（自动）| G5 | 🟦 P3 | 5min | 视频 final | 否 | ⏳ 等 final render |
| A13 INDEX 模板节加"对应形态"列 | G7 | 🟦 P3 | 10min | 无 | 否 | ✅ 3852e45 |
| A14 README.md 改"四个模板" | G10 | 🟦 P3 | 5min | 无 | 否 | ✅ 3989cb9 |
| A15 tutorial-8beat 待下次教程验证 | G15 | 🟦 P3 | N/A | 用户下次主题 | 否 | ⏳ 等下次教程主题 |

**总执行时间**：8.5-12.5 小时纯写代码。**实际执行**：13/15 done（仅 A12 / A15 被动等待触发）。
**完成时间**：2026-05-06，3 批 13 commit，5 个 sonnet agent 平行调度。

---

## 🔥 P0 必做（开新视频前必须完成）

### A1 · cc-window 完整体系沉淀到 templates/components/

**对应缺口**：[G2](./00-gaps.md#g2) — cc-window 12/21 章复用但未沉淀到 catalog/templates。
**具体动作**：
1. 从 `2026-05-04/claude-19-tips-hf/assets/theme.css` 提取所有 `.cc-*` CSS 类（行 466-674 共 ~209 行）
2. 抽 5 种 cc-body 变体的 HTML 模板（prompt-line / agent-call / question / bullets / typing）
3. 抽 5 种 cc-statusline 段的 HTML 模板（model / ctx / cost / tokens / rate）
4. 写到 `templates/components/cc-window/`：
   - `cc-window.css`（CSS）
   - `cc-window.html`（HTML 骨架 + 5 种 body 变体注释）
   - `README.md`（用法 + 5 变体示例 + 已知约束）

**完成判定**：下次新视频里能 `<link rel="stylesheet" href=".../templates/components/cc-window/cc-window.css">` + 复制 HTML 骨架立即用上，不再写一行 CSS。
**时间**：1-1.5 小时（提取 30min + 写 README 30-60min）
**依赖**：无
**可派 sonnet**：是 — sonnet 提取 CSS class 给 opus 看，opus 决定怎么组织。或者 opus 全程做。
**Commit message 草稿**：
```
feat(templates): 抽 cc-window 完整体系到 templates/components/

19-tips 12/21 章复用的 Claude Code 终端 UI 体系沉淀。包含：
- cc-window + cc-titlebar + cc-body + cc-statusline 完整 CSS（209 行）
- 5 种 cc-body 变体 HTML 模板：prompt-line / agent-call / question / bullets / typing
- 5 种 cc-statusline 段：model / ctx / cost / tokens / rate
- README 含用法 + 已知约束（GSAP transform 接管陷阱用 xPercent/yPercent 等）

下次任何 Claude Code 教程视频可直接 link CSS + 复制 HTML 骨架，
无需重写 700 行 CSS。

来源：2026-05-04/claude-19-tips-hf/assets/theme.css:466-674
对应缺口：00-gaps.md G2
```

---

### A2 · 11 个教训沉淀到 MY_MOTION_NOTES.md

**对应缺口**：[G3](./00-gaps.md#g3) — 12 个高价值教训 0/12 完整沉淀（chrome-text 互斥已写进 DNA，剩 11 项）。
**为什么不改 MOTION_PHILOSOPHY.md**：那是软链上游 student-kit，不能改。本仓库写自己的扩展 `MY_MOTION_NOTES.md`，cyxj-new-video skill 阶段 D 同时引用 MOTION + MY_MOTION_NOTES + DNA。

**具体动作**：
1. 创建 `MY_MOTION_NOTES.md`（仓库根，与 MY_VISUAL_DNA 同级）
2. 11 节，每节按 `retrospective/02-pitfalls.md` 末尾候选清单写：
   - GSAP transform 接管陷阱（P10，xPercent/yPercent 标准用法）
   - 撞击同帧合成模板（P15，5-7 元素同帧 ±0.05s 内）
   - sample → broadcast → cleanup 视觉风格推全方法论（P14）
   - immediateRender:false 项目规则（P9）
   - 教程内容真实性 grok-search 双源审核（P16）
   - 居中规范：flexbox/inset 0 vs xPercent（P10+P11）
   - CSS dead code 检测脚本（P17）
   - 视觉 teaser 不能 spoiler（P8 + memory）
   - 渲染参数决策树（draft / standard / docker）（P12）
   - SVG filter id 命名空间规则（P18）
   - cc-window 项目自创范式（P19，引用 A1 的 templates/components/cc-window/）

**完成判定**：MY_MOTION_NOTES.md 存在，11 节，每节有"现象 / 修法 / 出处 commit"。cyxj-new-video skill 阶段 D 列入必读。
**时间**：1-2 小时
**依赖**：无（A1 完成后第 11 节可引用）
**Commit message 草稿**：
```
feat(motion-notes): 新增 MY_MOTION_NOTES.md — 11 个 19-tips 实战教训

不改上游 MOTION_PHILOSOPHY.md（软链 student-kit），本仓库写自己的
扩展笔记。11 节覆盖 retrospective 02-pitfalls.md 末尾 12 高价值
候选中除"chrome-text 互斥"（已进 DNA）外的全部。

每节格式：现象 + 修法 + 出处 commit hash + 适用场景。

依赖：retrospective/02-pitfalls.md
对应缺口：00-gaps.md G3
```

---

## 🟧 P1 高价值（强烈建议在做下一条视频前完成）

### A3 · cyxj-new-video 加 URL 输入移交规则

**对应缺口**：[G1](./00-gaps.md#g1)
**动作**：cyxj-new-video SKILL.md 阶段 A 顶部加 1 段：
> 如果用户输入是 URL（"基于 anthropic.com 做个视频"），先移交 `/website-to-hyperframes` 跑前 5 步（capture/DESIGN/SCRIPT/STORYBOARD/VO），收到 capture 结果后回到本 skill 阶段 A 选模板复制工程。

**完成判定**：grep "URL" 在 SKILL.md 阶段 A 能找到这段。
**时间**：5 分钟
**Commit**：`feat(skill): cyxj-new-video 阶段 A 加 URL 输入移交规则 (G1)`

---

### A4 · 12 协作开窍点写进 cyxj-new-video

**对应缺口**：[G4](./00-gaps.md#g4)
**动作**：把 retrospective `03-skills.md §3` 的 12 个开窍点凝练成 5-8 条加入 cyxj-new-video SKILL.md 末尾："## 协作惯例（19-tips 实战沉淀）"
- commit body 写"原因 + 修法"双段（不只 what 还要 why）
- callback 历史 chapter 视觉是叙事手法（mode-toggle-bar 在 Tip 4/6/7 三处）
- 跨章节批量打磨意识（一个 commit 一个主题，不是一个 commit 一个 chapter）
- 推全前必单点 sample（避免 wavy 推全→撤销链事故）
- 联网 2 源交叉验证内容真实性（与 CLAUDE.md 证据协议对齐）
- 同 chapter 多版本写在 commit body 内迭代（hook V8a/V9/V10 在 1 commit）

**完成判定**：cyxj-new-video skill 末尾有此节，5-8 条规则，每条有 commit 出处。
**时间**：30-45 分钟
**Commit**：`feat(skill): cyxj-new-video 加协作惯例节 — 19-tips 12 开窍点凝练 (G4)`

---

### A5 · cyxj-new-video 阶段 D 显式 enforce DNA 自检 5 题

**对应缺口**：[G6](./00-gaps.md#g6)（DNA 修订后已自带"按形态选 / 教程例外"，但 skill 还没 enforce）
**动作**：cyxj-new-video SKILL.md 阶段 D 末尾加："**派 agent 前必跑 MY_VISUAL_DNA.md 自检 5 题，5/5 yes 才能进派 agent 阶段；任何一条 no 必须修改 brief**"
**完成判定**：grep "自检 5 题" 在 SKILL.md 阶段 D 能找到。
**时间**：10 分钟
**依赖**：A4（同时改 cyxj-new-video skill 顺便做）
**Commit**：`feat(skill): cyxj-new-video 阶段 D 加 DNA 自检 enforce (G6)`

---

### A6 · 3 模板补 README

**对应缺口**：[G9](./00-gaps.md#g9)
**动作**：派 3 个 sonnet Explore 平行写 3 份 README，每份 60-100 行，骨架同 tutorial-8beat README：
1. 用途 / 适用场景
2. beat 时间表（从 index.html 解析）
3. 复用 checklist（改 meta.json / 改文案 / 调时长 / lint+preview+render）
4. 已知约束（GSAP template literal、复制 beat 换 id 等）
5. 与其他模板的关系

**完成判定**：4/4 模板都有 README。
**时间**：1.5-2 小时（派 sonnet）
**Commit**：`docs(templates): demo-fullscreen / host-overlay / host-overlay-alpha 补 README (G9)`

---

### A7 · CLAUDE.md 加 Claude/Codex 边界节

**对应缺口**：[G11](./00-gaps.md#g11)
**动作**：把 AGENTS.md 第 62-75 行 `## Claude / Codex 边界` 节复制到 CLAUDE.md 同位置（在"必须遵守的硬约束"前）。文字略调（视角从 Codex 改 Claude），但表格内容不变。
**完成判定**：CLAUDE.md 有 `## Claude / Codex 边界` 节。
**时间**：5 分钟
**Commit**：`fix(docs): CLAUDE.md 补全 Claude/Codex 边界节（与 AGENTS.md 对齐, G11）`

---

## 🟨 P2 中长期（按节奏推进）

### A8 · 硬约束单源化到 HARD_CONSTRAINTS.md

**对应缺口**：[G12](./00-gaps.md#g12) — 6 条硬约束散落 5-6 个文件，更新时漂移高
**动作**：
1. 创建 `docs/HARD_CONSTRAINTS.md`，6 条硬约束作为单源
2. 改 6 个文件（CLAUDE.md / AGENTS.md / TEMPLATE_USAGE.md / README.md / tutorial-8beat/README.md / cyxj-new-video SKILL.md），把约束章节改成"详见 [`docs/HARD_CONSTRAINTS.md`](docs/HARD_CONSTRAINTS.md)"加 6 条标题列表

**完成判定**：6 处文件指向同一源，改任何一条只改一处。
**时间**：1 小时
**Commit**：`refactor(docs): 6 条硬约束单源化到 docs/HARD_CONSTRAINTS.md (G12)`

---

### A9 · INDEX 零件用例回填脚本

**对应缺口**：[G13](./00-gaps.md#g13)
**动作**：写 `scripts/refresh-zero-usage.sh`：
1. 扫 `参考库/` 下 18 个工程的 `compositions/` 目录
2. grep `data-composition-src` 提取每个工程引用的 catalog block 文件
3. 同时统计每个工程自制零件（CSS class 出现次数）
4. 输出"工程 → 零件"反查表，写入 `参考库/INDEX.md` 第 143 节

**完成判定**：脚本可跑，INDEX 第 143 节"真实工程里用过哪些零件"有内容。
**时间**：1-1.5 小时
**Commit**：
- 1: `feat(scripts): 添加 refresh-zero-usage.sh — 自动反查工程↔零件关系 (G13)`
- 2: `docs(index): 回填"真实工程里用过哪些零件"节 (G13)`

---

### A10 · docs 扫剩 41 页 catalog

**对应缺口**：[G14](./00-gaps.md#g14) — 当前覆盖率 47%
**动作**：派 1-2 个 sonnet agent 平行扫 `docs/hyperframes-official/catalog/` 下未扫的 41 页（13 transitions 套装 + 7 社交媒体 + 6 应用展示 + 其他）。每页输出"一句话价值 + 是否对应本仓库已用零件"，追加到 OFFICIAL_DOCS_VALUE_INDEX.md。

**完成判定**：OFFICIAL_DOCS_VALUE_INDEX.md 文件头声明从"扫读 37/78 页"改"78/78 页"。
**时间**：1 小时（agent 跑 30min + opus 整合 30min）
**Commit**：`docs(value-index): 完成扫读剩 41 页 catalog（覆盖率 47% → 100%, G14）`

---

### A11 · cyxj-new-video 加模板选择决策树

**对应缺口**：[G16](./00-gaps.md#g16) — 19-tips 错过 tutorial-8beat 选了 demo-fullscreen
**动作**：cyxj-new-video SKILL.md 阶段 A 加"模板选择决策树"：
- 形态 9:16 短视频 → 移交 /short-form-video（无需选模板）
- 形态 16:9 含录屏：
  - 后期想在达芬奇精修录屏 → host-overlay-alpha
  - 直接出整片 → host-overlay
- 形态 16:9 无录屏（教程类）：
  - 时长 ≥30s 且结构清晰（hook→pain→...→outro 8 beat）→ tutorial-8beat
  - 时长长（>5min）或自由结构（如 19 招的 21 段） → demo-fullscreen 派生

同步在 INDEX.md 第 5 节"模板"表加"何时用"列。

**完成判定**：cyxj-new-video skill 阶段 A 有决策树；INDEX.md 模板表有"何时用"列。
**时间**：30-45 分钟
**依赖**：A6（有 README 后决策树更准）
**Commit**：`feat(skill): cyxj-new-video 阶段 A 加模板选择决策树 + INDEX 同步 (G16)`

---

## 🟦 P3 小修 / 待触发

### A12 · 19-tips 视频归档（待 final render）

**对应缺口**：[G5](./00-gaps.md#g5) — 视频未 final，cyxj-new-video skill 阶段 B 自动跑
**动作（需用户先 final render）**：
1. 验证 `2026-05-04/claude-19-tips-hf/renders/final.mp4` 存在
2. 移工程到 `参考库/我的作品/2026-05-04-claude-19-tips-hf/`
3. INDEX.md "我的作品" 节加 1 行
4. 主动问"要抽成模板吗？"

**完成判定**：参考库/我的作品/ 下有 19-tips；INDEX 有行。
**时间**：5 分钟（手动；自动化由 cyxj-new-video skill 阶段 B 跑）
**依赖**：用户先 final render 19-tips
**Commit**：由 skill 触发时生成

---

### A13 · INDEX 模板节加"对应形态"列

**对应缺口**：[G7](./00-gaps.md#g7) — 降级（DNA 改"按形态选"后，3 个模板用 AIS 品牌色不算违反）
**动作**：INDEX.md 第 5 节模板表加 1 列"对应 DNA 形态"：
- demo-fullscreen → 米色教程长视频
- host-overlay → 录屏教程
- host-overlay-alpha → 录屏精修
- tutorial-8beat → 短教程（30-75s）

**完成判定**：INDEX.md 模板表有此列。
**时间**：10 分钟
**Commit**：`docs(index): 模板节加"对应 DNA 形态"列 (G7 降级版)`

---

### A14 · README.md 数量改"四个模板"

**对应缺口**：[G10](./00-gaps.md#g10)
**动作**：仓库根 `README.md` 把"## 三个模板"改"## 四个模板"，表格加 tutorial-8beat 一行。
**完成判定**：README.md 表 4 行。
**时间**：5 分钟
**Commit**：`fix(readme): 模板数量从 3 改 4，加 tutorial-8beat (G10)`

---

### A15 · tutorial-8beat 待下次教程视频验证

**对应缺口**：[G15](./00-gaps.md#g15) — 0 次实际使用
**动作**：暂不动。下次有"5-10 分钟教程"主题时优先选它，对照"教程类长视频"形态校验。如果 8 beat 结构不适合，考虑：
- 抽成"教程通用 8 beat"骨架但用 tutorial-8beat 自己的命名（hook/pain-list/verdict/punchline/promise/concept/flow/outro）
- 或者标记"这条命名仅适合特定教程类型，其他教程从 demo-fullscreen 起手"

**完成判定**：N/A（被动触发）
**时间**：N/A
**依赖**：用户下次有合适主题

---

## 推荐执行路线图

### 第 1 批 · 开新视频前必须（4-5 小时）
做完这批，下次开新视频时所有装备到位、不再"边做边试"。

| 顺序 | Action | 时间 |
|---|---|---|
| 1 | A14 README 数量改 4（5min 暖身）| 5min |
| 2 | A7 CLAUDE.md 加边界节（5min）| 5min |
| 3 | A3 cyxj-new-video 加 URL 移交（5min）| 5min |
| 4 | A1 cc-window 沉淀 | 1-1.5h |
| 5 | A2 11 教训写 MY_MOTION_NOTES.md | 1-2h |
| 6 | A4+A5 cyxj-new-video 加协作惯例 + DNA enforce | 40-55min |

### 第 2 批 · 装备库基础设施（3-4 小时）
增加"装备的可发现性"。

| 顺序 | Action | 时间 |
|---|---|---|
| 7 | A6 3 模板补 README（派 sonnet） | 1.5-2h |
| 8 | A11 模板选择决策树（依赖 A6 完成）| 30-45min |
| 9 | A13 INDEX 模板节加形态列 | 10min |

### 第 3 批 · 中长期减负（3.5-5 小时）
**这批每个 action 独立，可分多天做**。

| 顺序 | Action | 时间 |
|---|---|---|
| 10 | A8 硬约束单源化 | 1h |
| 11 | A9 INDEX 零件回填脚本 | 1-1.5h |
| 12 | A10 docs 扫剩 41 页 catalog（派 sonnet）| 1h |

### 第 4 批 · 被动触发（不主动安排）
| Action | 触发条件 |
|---|---|
| A12 19-tips 归档 | 视频 final render 完 |
| A15 tutorial-8beat 验证 | 下次有 5-10min 教程主题 |

---

## Step 3 验收方法

第 1 批做完后，开"假新视频"试跑 cyxj-new-video skill：
- 题目随便选（如"做个 60s 的 Codex CLI 教程"）
- 让 skill 跑完阶段 A 全流程
- **检查**：
  - 它有没有引用 MY_MOTION_NOTES.md（A2）？
  - 阶段 A 有没有走模板选择决策树（A11）？
  - 推荐用 templates/components/cc-window/ 没有（A1）？
  - 派 agent 前有没有跑 DNA 自检 5 题（A5）？
  - 形态识别后有没有路由到对应模板（A11+A13）？
- 全部命中 = Step 3 通过 = 装备库盘点收官

---

## 缺口总结（最终状态）

| 状态 | 数量 | 缺口 |
|---|---|---|
| ✅ 已消失（DNA 修订消化）| 1 | G8 19-tips 违反 DNA |
| 🔥 P0 待做 | 2 | G2 / G3 |
| 🟧 P1 待做 | 5 | G1 / G4 / G6 / G9 / G11 |
| 🟨 P2 待做 | 4 | G12 / G13 / G14 / G16 |
| 🟦 P3 待做 / 被动 | 4 | G5 / G7 / G10 / G15 |
| **合计原始缺口** | **16** | — |
| **本清单覆盖动作** | **15** | A1-A15 |

---

> 装备库盘点 Step 2 落盘完成。3 步全部完工：
> - Step 0 诊断：[`00-diagnosis.md`](./00-diagnosis.md) + [`00-gaps.md`](./00-gaps.md)
> - Step 1 不确定项核实：[`01-uncertainties-resolved.md`](./01-uncertainties-resolved.md)
> - Step 2 处置清单：本文件
>
> Step 3 验收方法已在末尾说明，等第 1 批 6 个 action 做完触发。
