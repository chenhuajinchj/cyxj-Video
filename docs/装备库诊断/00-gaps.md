---
name: 装备库缺口清单
description: 16 个具体缺口（用户关心的"经验复用到下次视频"主线 + 周边支撑）
type: project
date: 2026-05-06
based_on: 00-diagnosis.md 各维度发现 + 19-tips retrospective + Step 1 核实
---

# 00 · 装备库缺口清单

> 接续 [`00-diagnosis.md`](./00-diagnosis.md)。每个缺口给"事实 / 影响 / 已知解法方向"，**不在本文件落具体动作**（动作清单留给 02-actions.md）。

按"用户原话目标"分组：用户说 **"想把 19 招制作过程中积累的经验复用到下一次视频制作中"**。

---

## A 组 · 经验沉淀链路（最痛点，直接对应用户目标）

### G1 · cyxj-new-video 缺 URL 输入移交规则

**事实**：cyxj-new-video skill 在形态为 9:16 时主动 delegate 到 `/short-form-video`，但**没有** "用户给 URL 时移交 `/website-to-hyperframes`" 的规则。
**影响**：用户说"基于 anthropic.com 做个视频"时，cyxj-new-video 会接但跳过 website-to-hyperframes 的捕获 + DESIGN.md 流程。
**解法方向**：cyxj-new-video SKILL.md 阶段 A 加 1 行 delegate 规则。
**优先级**：🟧 P1

---

### G2 · cc-window 完整体系未沉淀（最高价值缺口）

**事实**：retrospective `01-components.md §C.4` 显示 cc-window 用在 19 招的 12/21 章，含 5 种 body 变体（prompt-line / agent-call / question / bullets / typing）+ 5 种 statusline 段（model / ctx / cost / tokens / rate）。catalog 里**无对应 block**。
**影响**：下次做任何 Claude Code 教程视频，又要从零写 cc-window CSS 700 行。
**解法方向**：抽成 `templates/components/cc-window/` 或贡献给 catalog（`catalog/blocks/claude-code-window`）。
**优先级**：🔥 P0

---

### G3 · 12 个高价值教训 0/12 完全沉淀

**事实**：retrospective `02-pitfalls.md` 末尾列了 12 个高价值贡献候选（按可移植性排序）。当前沉淀状态：0/12 完整、2/12 部分（见 [00-diagnosis.md 维度 G](./00-diagnosis.md#维度-g--19-tips-复盘的资产沉淀状态)）。
**影响**：下次做新视频会重新踩 P10（GSAP transform 接管）/ P13（chrome-text 与字符 stagger 互斥）/ P14（推全→撤销链）/ P15（撞击合成）等坑。
**解法方向**：
- GSAP / 居中 / 同帧合成 / immediateRender 等技术教训 → MOTION_PHILOSOPHY.md GSAP 章节（但 MOTION 是软链上游，不能直接改 → 需要本仓库自写一份扩展，如 `MY_MOTION_NOTES.md`）
- chrome-text 中文 hero / spoiler 准则 → MY_VISUAL_DNA.md
- sample-first 方法论 / 内容真实性审核 → cyxj-new-video skill 阶段 D
**优先级**：🔥 P0

---

### G4 · 12 个 Claude Code 协作开窍点未沉淀

**事实**：retrospective `03-skills.md §3` 列了 12 个按时间序的协作开窍点（commit body 写"原因+修法" / callback 历史 chapter 视觉作叙事手法 / 跨章节批量打磨 / 推全前单点 sample / 内容审核）。当前 cyxj-new-video skill 0 处提及。
**影响**：下次开新视频，agent 还是按通用 prompt 模板写 commit message、不主动做 callback、推全不 sample。
**解法方向**：cyxj-new-video skill 加一节 "协作惯例（来自 19-tips 沉淀）"。
**优先级**：🟧 P1

---

### G5 · 19-tips 完工后归档 + INDEX 回填没做

**事实**：cyxj-new-video skill 阶段 B 规定归档动作；19 招仍在 `2026-05-04/claude-19-tips-hf/` 工作区；INDEX.md "我的作品" 节未追加；INDEX.md "真实工程里用过哪些零件" 节实质未补。
**影响**：未来 cyxj-add-block 推荐零件时，无法用"19-tips 用过 X 零件"作论据。
**解法方向**：等 19 招 final render 完 → 走完整阶段 B 流程。**当前不是漏洞，是待办**（视频未 final）。
**优先级**：🟦 P3（视频完工后触发）

---

## B 组 · 准则冲突（影响每次新视频的视觉判断）

### G6 · DNA ↔ MOTION 3 个直接冲突无优先级声明

**事实**（详见 [00-diagnosis.md 维度 B](./00-diagnosis.md#维度-b--准则冲突清单)）：底色 / 字体栈 / stagger 粒度 3 项 DNA 明文反对 MOTION 强约束，但**两份文档都没声明"项目层 DNA 优先于 MOTION"**。
**影响**：调用 make-a-video skill 时（Gate 4 默认读 MOTION_PHILOSOPHY.md），agent 会按 MOTION 执行（每 beat 换字体、单词级 stagger）→ 出来的视频违反 DNA。当前规避方式是用户每次主动说"用 DNA 优先"，agent 才知道。
**解法方向**：
- MY_VISUAL_DNA.md 顶部加一节 "优先级声明"（明文："本仓库自有项目以 DNA 为准；DNA 未涉及的项继承 MOTION"）
- 或者改 cyxj-new-video skill 阶段 D：**强制 DNA 检查在 MOTION 之后跑**
**优先级**：🔥 P0

---

### G7 · 3/4 模板违反 DNA（AIS 品牌色未去化）

**事实**（详见 [00-diagnosis.md 维度 C.1](./00-diagnosis.md#c1-模板与-dna-对齐度)）：
- demo-fullscreen / host-overlay / host-overlay-alpha 都用 `--ais-bg: #07121c` + Roboto Mono + Montserrat
- DNA 明文禁用 Roboto，要求 Noto Sans SC + Inter + JetBrains Mono
- 唯一对齐 DNA 的是 tutorial-8beat（用 `--c-hot: #d97757`）
**影响**：用 demo-fullscreen 起手做新视频，会自动继承 AIS 品牌色 → 19-tips 视频用米色背景就是这个根因（从 demo-fullscreen 派生）。
**解法方向**：
- 把 3 个模板的 `assets/brand-tokens.css` 改成 DNA 三件套 + 深蓝底
- 或者把 AIS 品牌色版本另存为 `templates/_legacy/codex-ais-brand/`，主线模板都对齐 DNA
**优先级**：🟧 P1

---

### G8 · 19-tips 视觉违反 DNA 但视频成立 — DNA 缺"教程例外条款"

**事实**：19-tips 整片用米色 `#F7F2EA`（继承自 AIS / demo-fullscreen），不是 DNA 推荐的 `#0a1124` 深蓝。复盘里 0 处指出"违反 DNA"，因为视频本身视觉成立，没人觉得不对。
**影响**：DNA 当前的"不可妥协"清单可能太严格 — 教程类需要白底/米底来减轻视觉负担，dnA "纯黑/亮灰不允许" 没把"米色教程类"列为合法例外。
**解法方向**：DNA 加一节 "形态分支"（短视频 9:16 / 商业 promo / 教程类长视频 各自的底色清单）。
**优先级**：🟨 P2

---

## C 组 · 模板和文档基础设施

### G9 · 3 个模板缺 README

**事实**：tutorial-8beat 有 113 行 README；demo-fullscreen / host-overlay / host-overlay-alpha **全无 README**。
**影响**：cyxj-new-video skill 阶段 A 推荐参考工程时，AI 不知道 demo-fullscreen 的 7 beat 是什么节奏、host-overlay 的 4 个挂载 beat 时序怎么定。
**解法方向**：每个模板 README 用同一个骨架（用途 / beat 表 / 复用 checklist / 已知坑）写 60-100 行。
**优先级**：🟧 P1

---

### G10 · README.md（仓库根）数量声明过时

**事实**：仓库根 README.md 标题写"三个模板"，表格只列 3 个（漏 tutorial-8beat）。INDEX.md 已正确写 4 个。
**影响**：新人扫 README 会以为只有 3 个模板，错过 tutorial-8beat。
**解法方向**：README.md 改"四个模板"，加一行表格。
**优先级**：🟦 P3（小修）

---

### G11 · CLAUDE.md 缺 "Claude/Codex 边界" 节

**事实**（同 Step 1 ❓4）：AGENTS.md 有 `## Claude / Codex 边界` 节，CLAUDE.md 缺。该节明确"Claude 不读 AGENTS.md，不改 .agents/skills/"等规则。
**影响**：Claude Code 不知道这条规则，可能跨边界改文件。
**解法方向**：把这一节同步到 CLAUDE.md（手工改 / 或者 Step 1 候选方案 B 的 generator 脚本一次解决）。
**优先级**：🟧 P1

---

### G12 · 硬约束散落 5-6 个文件，更新时漂移风险高

**事实**（详见 [00-diagnosis.md 维度 F](./00-diagnosis.md#维度-f--硬约束散落)）：6 条硬约束分布在 CLAUDE.md / AGENTS.md / TEMPLATE_USAGE.md / README.md / tutorial-8beat/README.md / cyxj-new-video skill —— 同一约束最多被复述 6 次。
**影响**：改一条规则要扫 6 个文件，必然漂移；约束更新慢半拍 → AI 按旧约束写代码出错。
**解法方向**：
- 单源化到 `docs/HARD_CONSTRAINTS.md`，所有文件用 `@docs/HARD_CONSTRAINTS.md` 引用
- 或者按 Step 1 ❓4 候选方案 B：写 generator 脚本从单源生成多个目标文件
**优先级**：🟨 P2

---

## D 组 · 索引和文档覆盖

### G13 · INDEX "真实工程里用过哪些零件" 节实质未补

**事实**：INDEX.md 第 143 节标题占位，第 148 行写"持续补充"，但**当前 0 条记录**。
**影响**：cyxj-add-block 推荐零件时，无法用"X 工程用过 Y 零件"作论据 → 推荐质量降级到只看 catalog 描述。
**解法方向**：扫 18 个工程的 `compositions/`，grep `data-composition-src` + 自制零件命名 → 自动生成"工程 → 零件" 反查表，写入 INDEX 这一节。可写 `scripts/refresh-zero-usage.sh`。
**优先级**：🟨 P2

---

### G14 · OFFICIAL_DOCS_VALUE_INDEX 还有 41 页 catalog 未扫（覆盖率 47%）

**事实**：当前扫了 37/78 页。未扫的 41 页主要是 catalog block 详情（13 个 transitions 套装、7 个社交媒体卡片、6 个应用展示）。
**影响**：未来做 9:16 短视频时，instagram-follow / tiktok-follow / yt-lower-third 等高频零件没评估过 → 选型盲。
**解法方向**：再派 1-2 个 sonnet agent 扫剩下 41 页 catalog。
**优先级**：🟨 P2（与下次做短视频选题挂钩）

---

## E 组 · 工程清理

### G15 · tutorial-8beat 0 次实际使用，定位待验证

**事实**：tutorial-8beat 是 4 个模板里文档最完整、最对齐 DNA 的（Claude 橙 + 8 beat 教程结构），但 19-tips 没用它（用了 demo-fullscreen），其他工程也未用。
**影响**：可能是 19-tips 当时不知道有 tutorial-8beat（INDEX 排序靠后）；也可能是 8 beat 时长（45-75s）不适合 19-tips 这种 7:33 长视频；也可能是 tutorial-8beat 的 beat 名（hook / pain-list / verdict / punchline / promise / concept / flow / outro）不适合"列举 19 招"型内容。
**解法方向**：等下次有"5-10 分钟教程"再决定真用还是删；本次只标记"待验证"。
**优先级**：🟦 P3（不强求）

---

### G16 · 19 招视频从 demo-fullscreen 起手而非 tutorial-8beat —— skill 推荐逻辑回溯

**事实**：cyxj-new-video skill 阶段 A 应该推参考工程 + 选模板。19 招实际操作时选了 demo-fullscreen，错过了更合适的 tutorial-8beat。
**影响**：未来 AI 推模板时同样可能错过最合适的（如果 INDEX.md 里没明确标"教程类用 tutorial-8beat"）。
**解法方向**：
- INDEX.md 模板节加"主用场景"列（INDEX 已有，但模板间的"如何选"决策树缺）
- cyxj-new-video skill 阶段 A 增加 "模板选择决策树"（按形态 + 时长 + 内容类型）
**优先级**：🟨 P2

---

## 优先级汇总（16 个缺口）

| 优先级 | 数量 | 缺口 # |
|---|---|---|
| 🔥 P0（直接卡用户主线） | 3 | G2 cc-window 沉淀 / G3 12 教训 / G6 DNA-MOTION 优先级 |
| 🟧 P1（影响下次视频质量） | 4 | G1 URL 移交 / G4 协作开窍点 / G7 模板违反 DNA / G9 模板缺 README / G11 CLAUDE 缺边界节 |
| 🟨 P2（中长期价值） | 5 | G8 DNA 教程例外 / G12 硬约束单源化 / G13 INDEX 零件回填 / G14 docs 扫剩 41 页 / G16 模板选择决策树 |
| 🟦 P3（小修 / 待触发） | 3 | G5 19-tips 归档（待 final）/ G10 README 数量 / G15 tutorial-8beat 待验证 |

---

## 一张图看主链

```
用户目标："19 招经验复用到下次视频"
          │
          ▼
   Step 0 诊断（本文件 + 00-diagnosis.md）：找出 16 个缺口
          │
          ▼
   Step 2 处置（待写 02-actions.md）：每个缺口对应 1+ 个 commit
          │
          ▼
   Step 3 验收：开"假新视频"试跑 cyxj-new-video skill，看新装备是否自然命中
```

---

> 装备库缺口清单 Step 0 落盘完成。下一步是 Step 2 写处置清单 `02-actions.md`。
