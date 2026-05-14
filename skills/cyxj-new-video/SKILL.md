---
name: cyxj-new-video
description: 中文 YouTube 教程视频的全生命周期助手（基于 HyperFrames / HF）——建工程、推参考、协助渲染、归档、判断是否抽模板。当用户说「新视频」「做视频」「做个视频」「做新视频」「做 HF 视频」「做 HyperFrames 视频」「做 HF 教程」「片头」「new video」「做完了」「归档」「这条做好了」「抽成模板」时触发。覆盖从「有想法」到「成品归档进 videos/」+「可选抽模板」的全流程。本仓库做 HyperFrames 中文教程优先用此 skill，不要用上游 make-a-video（缺归档/抽模板/参考推荐工作流）。
---

# /新视频 — 视频全生命周期 SOP

这是陈与小金（XCYJ）频道的视频生产 wrapper。它把"复制模板 + 改 meta + 推参考 + 渲染 + 归档 + 抽模板"这一连串琐事自动化成一句话触发。

## 工作目录默认为仓库根

`~/项目/参考仓库/hyperframes/`。新工程建在 `2026-MM-DD/<slug>/` 下。归档到 `videos/<日期>-<slug>/`。模板源在 `templates/`。

## 触发分流

根据用户的话识别在哪个阶段：

| 用户说 | 进入 |
|---|---|
| 「新视频」「做视频」「做个视频」「片头」 | 阶段 A |
| 「做完了」「归档」「这条做好了」「渲染完成了归档吧」 | 阶段 B |
| 「抽成模板」「这个结构挺好抽个模板吧」 | 阶段 C |

不确定时主动问用户："你是要建新工程，还是把现有工程归档？"

---

## 阶段 A：建工程

### A0. URL 输入早分流（必做）

**进入阶段 A 之前先看用户输入是不是 URL**（如「基于 anthropic.com 做个视频」「把这个网站做成片头 https://...」）：

- ✅ 是 URL → 立即移交 `/website-to-hyperframes` 跑前 5 步（capture / DESIGN / SCRIPT / STORYBOARD / VO），收到 capture 结果（截图 + 设计 token + 文案大纲）后再回到本 skill 的 A1
- ❌ 不是 URL（用户给的是文字主题、参考截图、口播文案）→ 直接跳到 A1

**不要自己手动 Read 网页**——/website-to-hyperframes 有专门的浏览器抓取 + 设计提取流程，跳过会丢失关键的字体、配色、品牌信息。

### A0.5 模板选择决策树（先看这个，再用 A1 问用户确认）

真模板只有一个（`templates/tutorial-8beat/`）。其他形态请**从 0 写**——`videos/` 下 9 条已发布工程可作拓扑参考，**不要 cp 起步**（id / 文案绑死旧内容）。

```
1. 是不是 9:16 竖屏？
   ├─ 是 → 移交 /short-form-video，本 skill 退出
   └─ 否 → 继续

2. 有没有录屏（主播口播 + 屏幕操作）？
   ├─ 有 → 从 0 写工程（参考 docs/hyperframes-official/getting-started/quickstart.md 最小骨架）
   │       拓扑回查：videos/2026-05-02-claude-demo-v2/（直出 mp4）或 /host-overlay-alpha/（达芬奇精修 alpha）
   └─ 没有 → 继续

3. 是不是结构化教程（≥30s，含「hook + 痛点 + 解决方案 + 流程」完整段落，≥6 beat）？
   ├─ 是 → templates/tutorial-8beat/   （8 beat 教程骨架，含 face FULL→PiP→FULL 时序、kicker、终端、卡片栈、执行计划列表、章节切换卡）
   └─ 否（单段演示 / 概念片 / 品牌片中段 / 纯视觉叙事 ≤30s）→ 从 0 写工程
       拓扑回查：videos/2026-05-02-codex-claude-intro/（7 beat 串联无录屏）
```

**对应 DNA 形态**（docs/REFERENCE_INDEX.md 第 5 节模板表已标注）：
- 录屏教程类 / tutorial-8beat → 教程类，底色用暖米色 `#F7F2EA`（19-tips 实战验证）
- 单段演示 / 概念片 → 自由，按片子主题选底色（DNA 第 1 条"其他形态"分支）

**多段混用**：一条视频可以用多个段落，达芬奇里串联（如开头 demo 钩子 → 中段录屏讲解 → 收尾品牌 hold）。每段单独建 `2026-MM-DD/<slug>-<segment>/` 工作区分别 render。

> ⚠️ **模板状态**：当前唯一从 0 设计的真模板是 `templates/tutorial-8beat/`。其他形态从 0 写——等同形态做到 3-5 次重复后，从最近几条工程里抽真模板。可参考 `videos/2026-05-02-claude-demo-v2/` (host-overlay 形态)、`videos/2026-05-02-claude-overlays-only/` (alpha 输出)、`videos/2026-05-02-codex-claude-intro/` (无录屏 demo-fullscreen) 的拓扑。

### A1. 问清四件事（一次性，用 AskUserQuestion 多选）

1. **视频形态**（影响选哪个模板，按 A0.5 决策树排序）：
   - A. 9:16 竖屏 → 调用 `/short-form-video` skill 接管，本 skill 退出
   - B. 横屏 + 有录屏 + 直接出成品 → **从 0 写**（拓扑回查：`videos/2026-05-02-claude-demo-v2/`）
   - C. 横屏 + 有录屏 + 达芬奇精修 → **从 0 写**（拓扑回查：`videos/2026-05-02-claude-overlays-only/`，alpha 输出）
   - D. 横屏 + 无录屏 + 结构化教程（≥30s ≥6 beat 含口播） → `templates/tutorial-8beat/`
   - E. 横屏 + 无录屏 + 单段演示 / 概念片 → **从 0 写**（拓扑回查：`videos/2026-05-02-codex-claude-intro/`）
2. **主题** —— 自由文本，转 kebab-case 当 slug（去除中文，保留拼音/英文/数字/`-`）
3. **大致时长** —— 5-30s / 30-60s / 60-120s / 自定义
4. **是否有参考素材**（决定要不要走阶段 D 风格借鉴）：
   - A. 我有参考图/参考视频 → **必走阶段 D**，让用户先把截图存到 `参考图/<topic-slug>/`
   - B. 没有参考，按 DNA 默认风格做 → 跳过阶段 D 直接 A5
5. **特别想参考的工程**（可选）—— 用户可指名，否则下一步自动推荐

### A2. 读 INDEX 推荐参考工程

`Read docs/REFERENCE_INDEX.md`，根据形态匹配 2-3 个工程，列给用户：

```
我从 videos/ 挑了 2 个比较贴的工程：
- nate-demos/claude-edit-intro/ — 23s 教程片头标杆
- 我的作品/2026-05-02-codex-claude-intro/ — 你之前做过的中文片头

要不要先 npx hyperframes preview 看一眼？还是直接开干？
```

让用户决定是先看还是直接建。

### A3. 建工作区

```bash
DATE=$(date +%Y-%m-%d)
mkdir -p $DATE
```

- **形态 D（tutorial-8beat）**：`cp -R templates/tutorial-8beat $DATE/<slug>/`（DNA token mirror `assets/xcyj-tokens.css` 自动带过去）
- **形态 B/C/E（从 0 写）**：`mkdir -p $DATE/<slug>/assets && cd $DATE/<slug>/`，照 `docs/hyperframes-official/getting-started/quickstart.md` 的最小骨架（meta.json + hyperframes.json + index.html + compositions/*.html + assets/）一步步建。可参考 `videos/2026-05-02-claude-demo-v2/`（host-overlay）/ `videos/2026-05-02-claude-overlays-only/`（host-overlay-alpha）/ `videos/2026-05-02-codex-claude-intro/`（demo-fullscreen）看旧形态怎么拼，但**不要直接 cp**——id 和文案是绑死那一条视频的。
  - DNA token 接入：`cp templates/components/xcyj-tokens/xcyj-tokens.css $DATE/<slug>/assets/xcyj-tokens.css`，然后 `index.html` 顶部加 `<link rel="stylesheet" href="assets/xcyj-tokens.css" />`，所有 beat 直接 `var(--c-bg)` / `var(--c-hot)` 等。详见 `templates/components/xcyj-tokens/README.md`。

### A4. 改 meta.json 和 index.html

```bash
cd $DATE/<slug>/
```

- 改 `meta.json` 的 `id` 和 `name`：把模板里的占位符替换成 `xcyj-<slug>`、可读中文 name（从 0 写时直接填正确值）
- 改 `index.html`：
  - `<title>` 标签
  - `<div id="root" data-composition-id="...">` 改 id
  - 文件末尾 `window.__timelines["..."]` 同步改 id（见 docs/HARD_CONSTRAINTS.md 第 4 条）
  - 总 `data-duration` 按用户给的时长调整（同时按比例调各 beat 的 `data-start`/`data-duration`）
  - 字幕 `<div class="caption clip">` 占位文案

### A5. 告知用户开始干活

```
✅ 工程建好了：~/项目/参考仓库/hyperframes/2026-MM-DD/<slug>/

下一步等你提供：
1. 文案（每个 beat 的字幕、标题）
2. 录屏文件（如果是有录屏的形态）
3. 配音文件（可选）

提供后我会改各个 beat 的 html，跑 lint，preview。
```

### A6. DNA 自检 + 扫笔记 + 接收文案后改各 beat

> ⚠️ **如果 A1 第 4 题答 "我有参考素材"，先走阶段 D 再回到 A6**（D2 已含 DNA 自检，可跳过本步第 1 项）。

**前置 1：DNA 自检 5 题（跳过阶段 D 时强制跑）**：
1. 读 `MY_VISUAL_DNA.md` 末尾 "## 自检清单" 5 题
2. 对照本工程 `index.html` / theme.css / 各 beat HTML 逐题答 yes/no
3. **5/5 yes 才能继续**；任何一条 no 必须先修复 brief 或 theme

**前置 2：扫 MY_MOTION_NOTES.md 看本视频会触发哪些条目**：
- 撞击 / 爆炸 / 闪现戏 → § 3（同帧合成模板）
- 视觉风格全局变更（改主色、加新效果） → § 7（sample → broadcast → cleanup）
- 涉及 2025-Q4 之后的最新产品功能 → § 8（联网双源审核）
- 用 SVG filter（feTurbulence 等） → § 5（命名空间）
- 用 cc-window 终端 UI → 直接 link `templates/components/cc-window/cc-window.css`

**前置 3：复用零件**——优先 `templates/components/` 已有零件（当前：cc-window）+ catalog 已装零件，不要重写。

用户提供文案后，改 `compositions/*.html`：每个 beat 的 headline、card name、列表项等。
**严格遵守 [`docs/HARD_CONSTRAINTS.md`](../../../docs/HARD_CONSTRAINTS.md)（仓库单源，8 条）**：核心是 GSAP querySelector 硬编码 / 复制 beat 全局换 id / 中文 Whisper 用 `whisper-cli` / `npx hyperframes` 必须在工程目录 / 不 commit 上游目录 / 大视频不进 git。**改 compositions/*.html 前必读全文。**

### A7. lint → preview → render

```bash
npx hyperframes lint                                                    # 必须 0 errors
npx hyperframes preview                                                 # 在浏览器看
npx hyperframes render --quality draft --output renders/draft.mp4       # 草稿
npx hyperframes render --quality standard --output renders/final.mp4    # 成片
```

每一步出错都暂停问用户，不要硬跑。

---

## 阶段 D：风格借鉴（A1 第 4 题答 "我有参考素材" 时触发）

**触发时机**：A4 改完 meta 之后，A6 改 beat 之前。即"工程已建好，但还没动 beat 文案"。

**目的**：让参考素材（截图/视频）影响视觉风格，但**强制保留小陈自己的视觉 DNA**——避免被参考完全带跑。

### D1. 必读 4 个文件
1. `MY_VISUAL_DNA.md`（仓库根）—— 个人美学宪法
2. `MY_MOTION_NOTES.md`（仓库根）—— 19 招实战沉淀的动效与工程笔记（10 节实操陷阱 + 工程方法论 + 可复用范式索引）
3. `docs/STYLE_BORROW_PLAYBOOK.md`（仓库 docs/）—— 借鉴方法论 + brief 骨架
4. 用户参考图：`参考图/<topic-slug>/` 下所有 PNG/JPG（≤10 张全 Read，≥10 张挑代表性的 8-12 张）

### D2. 写本工程的 STYLE_BRIEF.md
按 PLAYBOOK 步骤 2-3 走：
1. **强制做 DNA 对照表**——三栏：参考有但 DNA 拒绝 / DNA 必须但参考没有 / 参考有且 DNA 允许（借鉴重点）
2. 套 PLAYBOOK 步骤 3 的 brief 骨架填空（≤200 行）
3. 每 beat 写"核心比喻 + 用什么组件 + 引用第几张参考图 + hot 词"
4. 写完后过 DNA 自检清单 5 个 yes/no——5/5 才进 D3

### D3. 派 4 个 sonnet agent 并行改 beat
按 PLAYBOOK 步骤 4：
- 8 beat → 4 个 agent 配对：hook+pain / verdict+promise / concept+flow / punchline+outro
- 每个 agent 必读：本工程 STYLE_BRIEF.md + index.html + 现状 composition + MY_VISUAL_DNA.md + 1-2 张相关参考图
- 4 个 Agent 调用放在**同一条消息里**并行启动（`run_in_background: true`）

### D4. main 跑 lint 后转 preview gate
按 PLAYBOOK 步骤 5：
1. `npx hyperframes lint` 必须 0 errors
2. preview 已在跑（默认 localhost:3002）→ 把 URL（含 `?comp=<beat-id>` 单 beat 调试）告诉用户
3. **不要主动 render**——等用户在浏览器看完反馈
4. 用户认可某个 beat → 留着；要改 → 派对应 agent 修
5. 用户**明确说**"渲一版" → 才跑 `--quality draft` → 满意 → `--quality standard`

### D5. 完成后回到 A6
当用户对 preview 满意 → 视为 D 阶段完成 → 进入 A6 接收文案后改其他细节，或直接到 A7 跑 render。

---

## 阶段 B：归档

用户说「做完了」「归档」时触发。

### B1. 检查工程状态

```bash
ls $WORKDIR/renders/ | grep final
```

如果没有 `renders/final.mp4`：先问用户"要不要现在渲染 standard 版？还是已经在别的地方有成片了？"

### B2. 拿日期前缀

按以下优先级：

1. `git log --reverse --format=%cs -- 2026-MM-DD/<slug>/ | head -1`
2. 不行就用工作区文件夹日期（`2026-MM-DD`）
3. 不行就用今天 `date +%Y-%m-%d`

### B3. 移动到我的作品

```bash
mv 2026-MM-DD/<slug>  videos/<日期>-<slug>
```

完整工程含 `renders/final.mp4` 一并移动（mp4 本地保留，gitignored）。

### B4. 在 INDEX 加一行

`Edit docs/REFERENCE_INDEX.md`，找到「你的旧作品」相关板块（横屏教程片头 / 整片演示等），加一行：

```markdown
| `我的作品/<日期>-<slug>/` | 16:9 | XXs | 主题/亮点一句话 |
```

### B5. 在 catalog 用例补一行（如果用了 block）

如果工程里 `compositions/components/` 下有装过的 block，在 INDEX 的「真实工程里用过哪些零件」板块加一行：

```markdown
- `我的作品/<日期>-<slug>/` 用了：`block-name-1`、`block-name-2`
```

### B6. 必做：主动问"要抽成模板吗？"

**这一步永远要问，不要跳过**。即使用户没说要抽，也主动问：

```
归档完成了。最后一个问题：

这条工程的结构（XX beat、XX 拓扑、XX 时长公式）你以后可能反复用吗？
- 「会，抽成模板」→ 我进入阶段 C，把这条抽成 templates/ 里的新模板
- 「不会，留着这一份当参考就够」→ 完成

要抽吗？
```

用户答案：
- 要 → 进入阶段 C
- 不要 → 输出"✅ 归档完成。`docs/REFERENCE_INDEX.md` 已更新"，结束

---

## 阶段 C：抽模板

用户说要抽时触发。

### C1. 起模板名

询问用户："这个新模板叫什么？建议 kebab-case，比如 `tutorial-7beat-product` 或 `concept-card-stack`"

### C2. 复制 + 抽空具体内容

```bash
cp -R videos/<日期>-<slug>  templates/<新模板名>
cd templates/<新模板名>
```

抽空动作（用 Edit/MultiEdit）：
- 改 `meta.json` 的 `id` → `xcyj-NEW-TOPIC`，`name` → 模板说明
- 改 `index.html` 的 `<title>` → 占位
- 各 beat html 把具体文案/数据替换为占位符 `{{...}}`：
  - headline → `{{HEADLINE}}`
  - 字幕 → `{{CAPTION}}`
  - 终端 prompt → `{{TERMINAL_PROMPT}}`
  - list items → `{{ITEM_1}}` 等
- 删 `assets/` 里的具体素材（保留通用结构资源如品牌字体、CSS token）
- 删 `renders/`
- 顶部加注释 `<!-- Template: <名称> · 拓扑：XXX · 用法见 TEMPLATE_USAGE.md -->`

### C3. 在 TEMPLATE_USAGE.md 加一节

```markdown
## <新模板名>

**拓扑**：XX
**输出**：MP4 / ProRes 4444 alpha
**适用场景**：XX
**改什么**：
- meta.json: id, name
- index.html: title, data-composition-id (×2), data-duration, 字幕
- compositions/<beat>.html: headline、列表项等
**时长公式**：总时长 = beat 1 (Xs) + beat 2 (Xs) + ... = XXs
```

### C4. 通知用户

```
✅ 新模板已抽好：templates/<新模板名>/

以后用：
  cp -R templates/<新模板名> 2026-MM-DD/<新主题>/

你的归档版仍在 videos/<日期>-<slug>/，作为完整成品保留。
```

### C5. 必做：问"DNA 有要更新的条目吗？"

抽完模板后**永远问一次**这个问题：

```
最后一个问题：
这次视频里，有没有视觉决策你想沉淀进 MY_VISUAL_DNA.md？
比如某个新色、新组件、新节奏，**连续 2-3 条视频都用了**就值得加进 DNA。
- 「有，加 XXX 进 DNA」→ 我 Edit MY_VISUAL_DNA.md 加进去
- 「没有，DNA 现在的就够了」→ 完成
```

DNA 频繁改 = 没 DNA。只有**反复确认有用**的偏好才升级进 DNA。

---

## 协作惯例（19 招实战沉淀）

> 来自 retrospective `03-skills.md §3` 的 12 个 Claude Code 协作开窍点凝练。
> 这是本 skill 默认的协作风格，跳过会被用户感觉不专业。

### 1. 视觉跟语义走，每段口播必须对应一个视觉变化

不要先想"32 秒可以塞多少效果"再反推视觉。先把 SRT 切成"段·语义·秒数"三列表，每段口播对应一个视觉 cue。空窗段用过程视觉（grid pulse / particles drift）填，不准 spoiler 下一句。

详见 `MY_MOTION_NOTES.md § 4`。出处：commit `a4c5843` Tip 1 V3→V4 教训。

### 2. commit body 写"原因 + 修法"双段，不只 what 还要 why

不只描述改了什么，还要描述为什么之前错了。示例：

> "top:50% + translate(-50%) 居中失效，因为 cc-window grid layout 实际渲染高度比预期高 ~50px → 改用 flexbox inset:0"

同 chapter 的多版本迭代（如 hook V8a/V9/V10）写在**单个 commit body 内**，不要每个版本一个 commit。

### 3. Callback 历史 chapter 视觉作为叙事手法

如果某个 chapter 用过的视觉（如 mode-toggle-bar、cc-window）在后续 chapter 又出现，**刻意保持视觉同步**（用同一个 CSS 类，不重写一份）。这不是偷懒，是叙事手法——让用户感受到"这个东西又出现了"的呼应感。

19 招里 mode-toggle-bar 在 Tip 4/6/7 三处共用，cc-window 在 12 章共用。

### 4. 一个 commit 一个主题，不是一个 chapter

"Tip 1 视觉重做对齐口播 + Tip 2 polaroid 溢出修复" 是合理 commit（主题 = 视觉口播对齐），跨多个 chapter 一起改没问题。

但 "改 Tip 1 字号 + 改 Tip 2 颜色 + 改 Tip 3 时长" 是 3 个不同主题，应拆 3 个 commit。

出处：commit `f2f0de1`。

### 5. 推全前必单点 sample，不是 commit 全局改完再说

视觉风格全局变更（改主色、改字体、加 wavy filter 等）**必须先选一个代表 chapter 做 sample → preview 截图给用户看 → 用户确认 → 才能 broadcast 到其他 chapter**。

反模式：直接改 `index.html` + `theme.css` 全局 token 推全所有 chapter（19-tips 9 分钟内 3 commit + 1 Revert 教训）。

详见 `MY_MOTION_NOTES.md § 7`。

### 6. 教程涉及最新产品功能必跑联网双源审核

agent 凭训练数据出稿可能错配（训练数据滞后）。涉及 **2025-Q4 之后**的产品功能（Agent Teams / Skills / Plan Mode / Thinking Budget 等）必跑 grok-search `web_search` (extra_sources=2) + Tavily 2 源交叉验证。

commit body 标注："联网核实（Tavily 2 源交叉验证 X.com / Y.com）"。

详见 `MY_MOTION_NOTES.md § 8`。出处：commit `6f81556` Tip 18 教训。

---

## 注意事项

- **不要在仓库根直接建工程**：必须在 `2026-MM-DD/` 子目录下
- **不要把 mp4 提交进 git**：`.gitignore` 已配置，但要 verify
- **每次 npx 命令必须在工程目录里跑**（cd 进去）
- **遇到 lint 报错**：参照 [`docs/HARD_CONSTRAINTS.md`](../../../docs/HARD_CONSTRAINTS.md)（约束 1 / 2 是 lint 高频触发）自查
- **中文转写绕开 hyperframes**：用 `whisper-cli`（见 docs/HARD_CONSTRAINTS.md 第 4 条）
