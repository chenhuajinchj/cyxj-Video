---
name: cyxj-new-video
description: 中文 YouTube 教程视频的全生命周期助手（基于 HyperFrames / HF）——建工程、推参考、协助渲染、归档、判断是否抽模板。当用户说「新视频」「做视频」「做个视频」「做新视频」「做 HF 视频」「做 HyperFrames 视频」「做 HF 教程」「片头」「new video」「做完了」「归档」「这条做好了」「抽成模板」时触发。覆盖从「有想法」到「成品归档进参考库」+「可选抽模板」的全流程。本仓库做 HyperFrames 中文教程优先用此 skill，不要用上游 make-a-video（缺归档/抽模板/参考推荐工作流）。
---

# /新视频 — 视频全生命周期 SOP

这是陈与小金（XCYJ）频道的视频生产 wrapper。它把"复制模板 + 改 meta + 推参考 + 渲染 + 归档 + 抽模板"这一连串琐事自动化成一句话触发。

## 工作目录默认为仓库根

`~/项目/参考仓库/hyperframes/`。新工程建在 `2026-MM-DD/<slug>/` 下。归档到 `参考库/我的作品/<日期>-<slug>/`。模板源在 `templates/`。

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

### A1. 问清四件事（一次性，用 AskUserQuestion 多选）

1. **视频形态**（影响选哪个模板）：
   - A. 录屏出镜 → `templates/host-overlay/`
   - B. 录屏要在达芬奇精修 → `templates/host-overlay-alpha/`
   - C. 纯演示无录屏 → `templates/demo-fullscreen/`
   - D. 9:16 竖屏 → 调用 `/short-form-video` skill 接管，本 skill 退出
   - **E. 教程多 beat（≥30s，≥6 beat，含口播）→ `templates/tutorial-8beat/`**（含 face FULL→PiP→FULL 时序、kicker、终端、卡片栈、执行计划列表、章节切换卡等组件）
2. **主题** —— 自由文本，转 kebab-case 当 slug（去除中文，保留拼音/英文/数字/`-`）
3. **大致时长** —— 5-30s / 30-60s / 60-120s / 自定义
4. **是否有参考素材**（决定要不要走阶段 D 风格借鉴）：
   - A. 我有参考图/参考视频 → **必走阶段 D**，让用户先把截图存到 `参考图/<topic-slug>/`
   - B. 没有参考，按 DNA 默认风格做 → 跳过阶段 D 直接 A5
5. **特别想参考的工程**（可选）—— 用户可指名，否则下一步自动推荐

### A2. 读 INDEX 推荐参考工程

`Read 参考库/INDEX.md`，根据形态匹配 2-3 个工程，列给用户：

```
我从参考库挑了 2 个比较贴的工程：
- nate-demos/claude-edit-intro/ — 23s 教程片头标杆
- 我的作品/2026-05-02-codex-claude-intro/ — 你之前做过的中文片头

要不要先 npx hyperframes preview 看一眼？还是直接开干？
```

让用户决定是先看还是直接建。

### A3. 复制模板，建工作区

```bash
DATE=$(date +%Y-%m-%d)
mkdir -p $DATE
cp -R templates/<选中模板> $DATE/<slug>/
```

### A4. 改 meta.json 和 index.html

```bash
cd $DATE/<slug>/
```

- 改 `meta.json` 的 `id` 和 `name`：把模板里的 `xcyj-host-overlay-template` 之类替换成 `xcyj-<slug>`、可读中文 name
- 改 `index.html`：
  - `<title>` 标签
  - `<div id="root" data-composition-id="...">` 改 id
  - 文件末尾 `window.__timelines["..."]` 同步改 id（CLAUDE.md 第 4 条硬约束）
  - 总 `data-duration` 按用户给的时长调整（同时按比例调各 beat 的 `data-start`/`data-duration`）
  - 字幕 `<div class="caption clip">` 占位文案

### A5. 告知用户开始干活

```
✅ 工程建好了：~/项目/参考仓库/hyperframes/2026-MM-DD/<slug>/

下一步等你提供：
1. 文案（每个 beat 的字幕、标题）
2. 录屏文件（如果是 host-overlay 模式）
3. 配音文件（可选）

提供后我会改各个 beat 的 html，跑 lint，preview。
```

### A6. 接收文案后改各 beat

> ⚠️ **如果 A1 第 4 题答 "我有参考素材"，先走阶段 D 再回到 A6**。

用户提供文案后，改 `compositions/*.html`：每个 beat 的 headline、card name、列表项等。
**严格遵守仓库根 CLAUDE.md 的 6 条硬约束**：
1. GSAP querySelector 不能用 template literal
2. 复制 beat html 时全局换 beat id（CSS class 和 GSAP selector 两处）
3. 中文 Whisper 用 `whisper-cli`，不走 hyperframes transcribe
4. 不在仓库根放 hyperframes 文件
5. 不 commit student-kit 或 launches 内容
6. 大视频/音频不进 git

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

### D1. 必读 3 个文件
1. `MY_VISUAL_DNA.md`（仓库根）—— 个人美学宪法
2. `docs/STYLE_BORROW_PLAYBOOK.md`（仓库 docs/）—— 借鉴方法论 + brief 骨架
3. 用户参考图：`参考图/<topic-slug>/` 下所有 PNG/JPG（≤10 张全 Read，≥10 张挑代表性的 8-12 张）

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
mv 2026-MM-DD/<slug>  参考库/我的作品/<日期>-<slug>
```

完整工程含 `renders/final.mp4` 一并移动（mp4 本地保留，gitignored）。

### B4. 在 INDEX 加一行

`Edit 参考库/INDEX.md`，找到「你的旧作品」相关板块（横屏教程片头 / 整片演示等），加一行：

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
- 不要 → 输出"✅ 归档完成。`参考库/INDEX.md` 已更新"，结束

---

## 阶段 C：抽模板

用户说要抽时触发。

### C1. 起模板名

询问用户："这个新模板叫什么？建议 kebab-case，比如 `host-overlay-tech-grid` 或 `demo-fullscreen-7beat`"

### C2. 复制 + 抽空具体内容

```bash
cp -R 参考库/我的作品/<日期>-<slug>  templates/<新模板名>
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

你的归档版仍在 参考库/我的作品/<日期>-<slug>/，作为完整成品保留。
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

## 注意事项

- **不要在仓库根直接建工程**：必须在 `2026-MM-DD/` 子目录下
- **不要把 mp4 提交进 git**：`.gitignore` 已配置，但要 verify
- **每次 npx 命令必须在工程目录里跑**（cd 进去）
- **遇到 lint 报错**：参照仓库根 CLAUDE.md "6 条硬约束"自查
- **中文转写绕开 hyperframes**：用 `whisper-cli`（CLAUDE.md 已说明）
