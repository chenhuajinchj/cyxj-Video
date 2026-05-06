---
name: 装备库现状诊断
description: 仓库根所有装备（9 skill / 4 模板 / 4 准则 / 2 agent 指令 / 索引 / 文档镜像）的全景诊断 — 找重叠、冲突、不一致
type: project
date: 2026-05-06
based_on: Step 0 三 sonnet subagent 并行扫描（skills/templates+准则/索引+文档）+ retrospective/ 5 文件 + 01-uncertainties-resolved.md
---

# 00 · 装备库诊断

> 接续 19-tips retrospective + 01-uncertainties-resolved。本文件是 Step 0（首次落盘的诊断）。
> 范围：仓库根所有装备的现状评估。
> 方法：3 sonnet subagent 并行扫事实 → opus 跨文件交叉判断。
> 状态：仅诊断，未动任何文件。

---

## 装备清册（59 项）

| 类别 | 数量 | 位置 | 自写/上游 |
|---|---|---|---|
| skill | 9 | `.claude/skills/` | 2 自写 + 7 软链 |
| 模板 | 4 | `templates/` | 全自写 |
| 视觉/动效准则 | 4 | 仓库根 | 1 软链上游 + 3 自写 |
| agent 指令 | 2 | 仓库根（CLAUDE.md / AGENTS.md） | 自写 |
| 参考库索引 | 1 | `参考库/INDEX.md` | 自写 |
| catalog metadata | 1 | `参考库/catalog.json`（46 entry） | 自写 |
| 文档（含镜像） | ~38 | `docs/`（含 `hyperframes-official/` 78 页镜像，未单独计数） | 自写 + 镜像 |
| **合计装备项** | **59 +** | | |

**整体规模**：39 KB MOTION_PHILOSOPHY + 11.5 KB cyxj-new-video + 20 KB short-form-video + 26 KB OFFICIAL_DOCS_VALUE_INDEX = 装备文档总量 ~250 KB。

---

## 维度 A · Skill 重叠图

### 9 skill 完整 delegate 关系

```
                          [用户输入]
                              │
        ┌─────────────────────┼──────────────────────┐
        │                     │                      │
   "新视频"中文           "make a video"英文       URL 输入
   「做视频」              "create a video"        「这个网站做个视频」
        │                     │                      │
        ▼                     ▼                      ▼
  cyxj-new-video        make-a-video        website-to-hyperframes
  (自写, 11.5 KB)        (软链, 12.6 KB)      (软链, 6.1 KB)
        │                     │                      │
   形态=9:16?            形态=9:16?            Step 6 必调
        ↓                     ↓                      ↓
  short-form-video ◄── short-form-video       /hyperframes
  (软链, 20.5 KB)
                              │ Gate 6 必调
                              ▼
                        /hyperframes  ──── 必先调 ────► short-form-video
                        (软链, 20.2 KB)
                              │
                       /gsap ◄┴► /hyperframes-cli ◄► /hyperframes-registry
                                                            ▲
                                                            │
                                                  cyxj-add-block
                                                  (自写, 5.2 KB, 中文场景包装)
```

### 触发词重叠矩阵

| skill 对 | 重叠程度 | 已消歧？ |
|---|---|---|
| cyxj-new-video ↔ make-a-video | **强重叠**：`"new video"`/`"make a video"` 与「新视频」「做视频」语义直接对应 | ⚠️ cyxj description 里加了 "本仓库做 HF 中文教程优先用此 skill，不要用上游 make-a-video"（已 e325481），但 make-a-video 仍在软链可见 → CC 自动选择仍有概率走 make |
| cyxj-add-block ↔ hyperframes-registry | **弱重叠**：cyxj 中文短句驱动 / registry 英文 CLI 术语驱动 | ✅ 已天然分流 |
| short-form-video ↔ cyxj-new-video | 不重叠（cyxj 在 9:16 时 delegate） | ✅ |
| website-to-hyperframes ↔ make-a-video | 不重叠（make 在 URL 时 delegate） | ✅ |
| website-to-hyperframes ↔ cyxj-new-video | **隐性缺口**：cyxj 描述里**没说** URL 输入时移交 | ❌ 详见 [缺口 G1](./00-gaps.md#g1) |

### Skill 自写包装层增量价值

| 自写 skill | 上游对应 | 增加的价值 | 必要性 |
|---|---|---|---|
| cyxj-new-video | make-a-video | 5 项：中文触发词 / 阶段 D 风格借鉴 / 阶段 B 归档到参考库 / 阶段 C 抽模板 / 6 条本仓库硬约束贯穿 | **必需**（make 无归档/抽模板） |
| cyxj-add-block | hyperframes-registry | 5 项：中文场景识别 / 读本地 catalog.json / 引用 INDEX.md 找用例 / 给 beat 引用代码 / 4 条避坑 | **必需**（已 01 核实） |

---

## 维度 B · 准则冲突清单

> MY_VISUAL_DNA.md 自己声明"与 MOTION_PHILOSOPHY.md 不重叠"。**实测：3 个直接冲突 + 1 处反向 + 4 处补充**。

### B.1 直接冲突 3 个（必须项目级声明优先级）

| 项 | MOTION_PHILOSOPHY 说 | MY_VISUAL_DNA 说 | 冲突性质 |
|---|---|---|---|
| **底色** | `#000` / `#0a0a0a`（黑是 canvas，~90% 帧黑或近黑） | `#0a1124`（午夜深蓝）；纯黑 `#000000` **不允许**；`#1a1a1a` 也不允许 | DNA 明文禁用 MOTION 主推方案 |
| **字体栈** | "Per-beat font discipline. Every beat uses a DIFFERENT Google-Fonts family" | 固定 `Noto Sans SC + Inter + JetBrains Mono`，**全程不换**；不允许 Roboto / Source Han / Google Sans | DNA 明文禁用 MOTION 强制规则 |
| **入场 stagger 粒度** | 单词级 0.35s/word（明确写 "NOT character-by-character"）| 字符级 0.06-0.08s/char（快 5-6 倍） | DNA 用 MOTION 明文反对的方案 |

### B.2 反向数值 1 处

| 项 | MOTION 说 | DNA 说 |
|---|---|---|
| **Grain opacity** | "super faint"，未给具体数值 | `0.10-0.12` + mix-blend-mode: overlay（明显更高）|

### B.3 互补补充 4 处（不冲突，DNA 填空）

- **PiP halo**：MOTION 不规定 → DNA 强制 Claude 橙 `rgba(217,119,87,.45/.55)`，明文禁蓝/绿/紫
- **Hero 渐变色**：MOTION 偏暖（`#5a3215 → #c84f1c → #e2b53f → #2a8a7c`） / DNA 偏冷（`#fff → #c8d3e0 → #e8ecf2`）
- **节奏密度**：MOTION 详细规定（scene 1-2s / CTA 4-6s hold / 每 7-8s 给 1s rest） / DNA 主动让位（写"普适纪律在 MOTION"）
- **Hot 色定义**：MOTION 用红/青/紫/蓝/橙黄象征 5 色 / DNA Claude 橙必现 + Hot 色默认 `#5BA9FF` 蓝（可调红/绿/紫/黄）

### B.4 实质判定

DNA 在 3 个核心维度（底色/字体/stagger 粒度）**事实上覆盖了** MOTION 的强约束。这不是"互补"，是 **"个人项目里 DNA 优先于 MOTION"**。但当前文档没明文声明这个优先级，外部 agent（如 make-a-video Gate 4 默认读 MOTION_PHILOSOPHY.md）不会看到 DNA → 风险：在自己仓库做项目时被 MOTION 的"每 beat 换字体"带跑。

---

## 维度 C · 模板一致性

### C.1 模板与 DNA 对齐度

| 模板 | 底色 | 字体栈 | DNA 对齐？ |
|---|---|---|---|
| `demo-fullscreen` | `--ais-bg: #07121c`（AIS 品牌深蓝）| Roboto Mono + Montserrat（**DNA 明文禁用 Roboto**）| ❌ **违反 DNA** |
| `host-overlay` | 同上 AIS 品牌色 | 同上 | ❌ **违反 DNA** |
| `host-overlay-alpha` | 同上 AIS 品牌色 | 同上 | ❌ **违反 DNA** |
| `tutorial-8beat` | 用 `--c-hot: #d97757`（Claude 橙）| 8 beat HTML 内嵌字体（未集中定义到 brand-tokens）| ⚠️ Claude 橙 ✅ / 字体三件套未声明 |

**根因**：前 3 个模板是从 `2026-05-02-codex-claude-intro` 项目派生的，那个项目用 AIS 品牌色（Codex × Claude 联合品牌）。模板抽出来后没"去品牌化"。

### C.2 模板文档一致性

| 模板 | README.md | INDEX 声明 | 实际使用 |
|---|---|---|---|
| demo-fullscreen | ❌ 无 | ✅ 列出 | 19 招视频起手用了它 |
| host-overlay | ❌ 无 | ✅ 列出 | — |
| host-overlay-alpha | ❌ 无 | ✅ 列出 | — |
| tutorial-8beat | ✅ 113 行 | ✅ 列出 | **0 次实际使用**（19 招应该是它的目标场景却没用）|

**反讽**：仓库根 `README.md` 标题写"三个模板"（过时，实际 4 个），但表格只列 3 个 → 漏了 tutorial-8beat。tutorial-8beat 反而是文档最完整、定位最清晰的那个。

### C.3 19-tips retrospective 与 tutorial-8beat 的关系

retrospective `01-components.md §A.2` 提到 "已有 `templates/demo-fullscreen/`"，但 19 招实际是从 demo-fullscreen 派生的（而不是 tutorial-8beat），所以 19-tips 沿用了 AIS 品牌色 → 整片用米色 `#F7F2EA` 而不是深蓝 → **这本身违反 DNA**（DNA 要求午夜深蓝）。

→ 19 招视频是不是真的"违反 DNA 但视觉成立"？还是 DNA 本身需要"教程类例外条款"？这是个 [缺口 G16](./00-gaps.md#g16) 待答。

---

## 维度 D · CLAUDE.md ↔ AGENTS.md

| 指标 | 值 |
|---|---|
| 章节数对比 | CLAUDE.md 9 / AGENTS.md 10 |
| 重复章节 | 9 个完全或近似重复（含 7 条硬约束逐字相同） |
| 仅 AGENTS.md 有 | `## Claude / Codex 边界` 节（CLAUDE.md 缺）|
| 文件开头 | "针对 Claude Code" vs "针对 Codex" |
| 顶层架构 | AGENTS.md 多 `.agents/skills/` 注释行 |
| 软链表 | AGENTS.md 多 `.agents/skills/{...} (×7, 可选)` 一行 |

**结论同 01-uncertainties-resolved Step 1**：AGENTS.md 是 CLAUDE.md 的超集（不是镜像），CLAUDE.md 实际**漏了** "Claude/Codex 边界" 这节内容（Claude 也需要知道"不要改 .agents/skills/"）。

**维护代价**：每改一处硬约束（已 7 条）要同步两份；没有 generator 脚本，靠手工保持一致 → 漂移风险高。

---

## 维度 E · 索引和文档同步度

### E.1 数量声明一致性

| 文档 | 声明 | 实际 | 一致？ |
|---|---|---|---|
| INDEX.md 头部 | 18 工程 + 46 catalog 零件 + 78 页文档镜像 | 全对 | ✅ |
| INDEX.md "五、模板" | 4 个 | 4 个 | ✅ |
| 仓库根 README.md | "3 个模板" | 4 个 | ❌ 漏 tutorial-8beat |
| catalog.json | 46 entry | 46 entry | ✅ |
| OFFICIAL_DOCS_VALUE_INDEX | 扫读 37/78 页 | — | ⚠️ 47% 覆盖率，41 页 catalog 未扫 |

### E.2 引用链完整性

抽样 6 条交叉引用，01 已验证 6/6 全对得上。**INDEX 与 docs/hyperframes-official/ 镜像同步零漂移**。

### E.3 INDEX.md 内的实质待补

INDEX.md 第 143 节 "### 真实工程里用过哪些零件（持续补充）" → 第 148 行 `_（做完后续工程时持续补充）_` → **实质未补**。19 招项目用过 6 个 catalog snippet（虽然都没用）和大量自制零件，应该回填到这一节。

---

## 维度 F · 硬约束散落

**6 条硬约束当前散落在 5 个文件**：

| 约束 | CLAUDE.md | AGENTS.md | TEMPLATE_USAGE.md | README.md | tutorial-8beat/README.md | cyxj-new-video |
|---|---|---|---|---|---|---|
| GSAP 不用 template literal | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| 复制 beat 全局换 id | ✅ | ✅ | — | — | — | ✅ |
| DaVinci 21 不渲中文 Lottie | ✅ | ✅ | ✅ | ✅ | — | — |
| 中文 whisper 用 whisper-cli | ✅ | ✅ | — | — | — | ✅ |
| `npx hyperframes` 在工程目录跑 | ✅ | ✅ | ✅ | — | ✅ | ✅ |
| 不 commit upstream / 大 mp4 不进 git | ✅ | ✅ | — | — | — | — |

**问题**：同一约束最多被复述 6 次。改一处规则要扫 6 个文件 → 必然漂移。

---

## 维度 G · 19-tips 复盘的资产沉淀状态

retrospective 找出 12 个"高价值贡献候选"。当前沉淀状态：

| # | 候选 | 应去的位置 | 现状 |
|---|---|---|---|
| 1 | GSAP transform 接管陷阱（xPercent/yPercent）| MOTION_PHILOSOPHY.md GSAP 章节 | ❌ 未沉淀 |
| 2 | chrome-text + 字符 stagger 互斥 | MY_VISUAL_DNA.md 中文 hero 章节 | ❌ 未沉淀 |
| 3 | **cc-window 完整体系** | catalog block / 至少进 templates/ | ❌ **12 章复用未沉淀**（最高价值缺口）|
| 4 | 撞击同帧合成模板 | MOTION_PHILOSOPHY.md "动作戏" | ❌ 未沉淀 |
| 5 | sample → broadcast → cleanup 方法论 | cyxj-new-video skill 阶段 D | ❌ 未沉淀 |
| 6 | `immediateRender: false` 规则 | MOTION_PHILOSOPHY.md GSAP 注记 | ❌ 未沉淀 |
| 7 | 内容真实性 grok-search 双源审核 | cyxj-new-video skill | ⚠️ 已部分有（阶段 D），需明确 |
| 8 | 居中规范（flexbox / xPercent） | MOTION_PHILOSOPHY.md 居中准则 | ❌ 未沉淀 |
| 9 | CSS dead code 检测脚本 | `scripts/lint-dead-css.sh` | ❌ 未写 |
| 10 | 视觉 teaser 不能 spoiler | MOTION_PHILOSOPHY.md 叙事节奏 | ⚠️ memory 已记，文档未落 |
| 11 | 渲染参数决策树（draft/standard/docker）| `package.json` + cyxj-new-video skill | ❌ 未做 |
| 12 | SVG filter id 命名空间规则 | MOTION_PHILOSOPHY.md 注记 | ❌ 未沉淀 |

**沉淀率：0/12 完全沉淀；2/12 部分沉淀。**

更别提 retrospective `03-skills.md` 列的 **12 个 Claude Code 协作开窍点**（commit body 写"原因+修法"、跨章节批量打磨意识、推全前必单点 sample 等）—— 全没进 cyxj-new-video skill。

---

## 维度 H · 19-tips 工程归档状态

cyxj-new-video skill 阶段 B 规定："归档到 `参考库/我的作品/<日期>-<slug>/` + INDEX 加一行"。

**现状**：19-tips 工程**仍在 `2026-05-04/claude-19-tips-hf/`**，**未归档到 `参考库/我的作品/`**。INDEX.md 中也没这一行。

→ 是因为视频还没 final render（renders/ 目录只有 work 子目录，无 mp4），按 skill 规则不能归档。**OK**。但完工后必走的归档动作是个待办，不是漏洞。

---

## 维度 I · OFFICIAL_DOCS_VALUE_INDEX 覆盖度

- 已扫：37 页（guides 全 13 + concepts 4 + getting-started 2 + reference 1 + packages 6 + catalog 抽样 11）
- 跳过：41 页（41 个 catalog block 详情未扫）
- 覆盖率：47%
- 主要漏的：transitions 套装系列（13 个）+ 社交媒体卡片（7 个）+ 应用展示（6 个）+ 其他单效果转场

如果下次做"竖屏 talking-head 短视频"，这 41 页里有 transitions/instagram/tiktok 等高度相关的内容没扫过 → 选型会盲。

---

## 维度 J · 总体健康度评分

| 维度 | 健康度 | 说明 |
|---|---|---|
| Skill 设计 | 🟢 良好 | 9 skill 分工清晰，2 自写有明确增量价值 |
| Skill 触发词消歧 | 🟡 1 个待修 | cyxj-new-video 缺 URL 移交规则 |
| 准则一致性 | 🔴 严重 | DNA 与 MOTION 3 个直接冲突无优先级声明，4 / 4 模板里 3 个违反 DNA |
| 模板文档完整度 | 🟡 25% | 1/4 有 README，3/4 缺；README.md 漏列 tutorial-8beat |
| Agent 指令同步 | 🟡 漂移风险 | CLAUDE/AGENTS 96% 重复手工同步；硬约束散 5 处 |
| 索引一致性 | 🟢 良好 | INDEX 数量声明全对，引用零漂移 |
| 文档覆盖度 | 🟡 47% | OFFICIAL_DOCS_VALUE_INDEX 还有 41 页 catalog 未扫 |
| 19-tips 经验沉淀 | 🔴 严重 | 0/12 候选完全沉淀，2/12 部分沉淀 |

---

## 一句话诊断

**装备库整体规划清晰（skill 分工 + 索引体系成立），但"经验回流到装备"这条链路完全断开** —— 19 招踩的坑、定的方法论、抽出的视觉资产（cc-window）都没回到 skill / 准则 / 模板 / catalog。**用户最大的痛点（"复用到下次视频"）正是这条断链直接导致的。**

次级问题：DNA ↔ MOTION 冲突无声明优先级；3/4 模板违反 DNA；硬约束散落 5 处。

---

## 接续步骤

- [`00-gaps.md`](./00-gaps.md) —— 16 个缺口的逐项诊断
- `02-actions.md`（待写）—— 基于 diagnosis + gaps 的处置清单（每条缺口 → 具体动作 → commit）
- `01-uncertainties-resolved.md` —— Step 1 已完成（4 个不确定项核实）

---

> 装备库诊断 Step 0 落盘完成。本文件 + 00-gaps.md + 01-uncertainties-resolved.md 共同构成完整的"诊断阶段"输出。
