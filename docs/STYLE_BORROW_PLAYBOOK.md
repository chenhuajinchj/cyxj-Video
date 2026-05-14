# STYLE_BORROW_PLAYBOOK —— 风格借鉴方法论

> 当用户准备好参考素材想做新视频时，main agent 走这套流程。
>
> **核心防御**：步骤 2 强制做 DNA 对照表——这是防止"被参考带跑"的唯一机械保险。没填这一栏不允许进入步骤 3。

---

## 何时启用

| 场景 | 用此 playbook | 不用 |
|---|---|---|
| 教程视频，≥30s，≥6 beat | ✅ | |
| 品牌片 / 演示片，多 beat 多场景 | ✅ | |
| 用户提供了参考截图 / 参考视频 | ✅ | |
| 短社交视频 ≤15s | | ❌ 用 `short-form-video` skill |
| 单镜头无 beat 切换 | | ❌ 从 0 写录屏 + overlay 工程（拓扑回查 `videos/2026-05-02-claude-demo-v2/`） |
| 已有清晰主题但**没有参考素材** | | ❌ 跳过步骤 1-2，直接走 `/cyxj-new-video` |

---

## 步骤 1：找参考

### 1.1 收集参考素材
- 用户提供参考视频 → 用户自己截图（推荐每 5-10s 截一张，覆盖关键 beat）
- 用户提供截图 / 设计稿 → 直接用
- 没有参考但用户描述了风格 → 让用户先去找几张截图再开始

### 1.2 存放位置（约定）
```
/Users/chenhuajin/项目/参考仓库/hyperframes/参考图/<topic-slug>/
```
- `<topic-slug>` 用 kebab-case，如 `claude-code-tricks` / `ai-agent-promo`
- 截图命名保留原文件名（屏幕截图时间戳即可）
- 一个主题 5-25 张为佳

### 1.3 截图阅读规则
main agent 至少 Read 这些张数：
- ≤10 张参考图 → **全部** Read
- 10-25 张 → 挑 8-12 张代表性的（覆盖：开头 hook / 中间几个 beat / 结尾 outro / 至少 2 张数据可视化或卡片栈 / 至少 1 张终端模拟）

---

## 步骤 2：DNA 对照（强制产出物）

### 2.1 必读
按顺序 Read：
1. `/Users/chenhuajin/项目/参考仓库/hyperframes/MY_VISUAL_DNA.md`（小陈个人美学）
2. `/Users/chenhuajin/项目/参考仓库/hyperframes/MOTION_PHILOSOPHY.md`（普适纪律，可只读 §0 十大法则）

### 2.2 强制产出：DNA 对照表

写到本工程的 `STYLE_BRIEF.md` 顶部（步骤 3 写的那个文件）。**没填这一节不允许进入步骤 3**。

格式：

```markdown
## DNA 对照表（强制产出物）

### 参考素材里**有**但 DNA **拒绝**的元素
| 元素 | 出现在 | 为什么拒绝 |
|---|---|---|
| 纯黑底 #000 | 截图 7.39.28 | DNA 第 1 条：教程类底色用暖米 #F7F2EA（其他形态自定，但禁纯黑/亮灰） |
| 字体 Roboto | 截图 7.42.18 | DNA 第 4 条：字体栈固定 Inter+Noto+JetBrainsMono |
| ... | ... | ... |

### DNA **必须**有但参考素材**没有**的元素
| 元素 | DNA 来源 | 怎么补 |
|---|---|---|
| Claude 橙必现 | DNA 第 2 条 | 在 PiP halo + 至少 1 个 beat 的 hot 词用 |
| 透视网格 | DNA 第 3 条 | index.html 顶层加 grid 层（参考 templates/tutorial-8beat/） |
| ... | ... | ... |

### 参考素材里**有且 DNA 允许**的元素（这是借鉴的重点）
| 元素 | 出现在 | 怎么借鉴 |
|---|---|---|
| 多色教程语义化（蓝/绿/红/紫） | 截图 7.42.32 | 借！按 DNA 可调整项加进 brief |
| 终端窗口 ANSI 高亮 | 截图 7.41.39 | 借！直接复用模板的终端组件 |
| Execution Plan checkbox 列表 | 截图 7.43.04 | 借！这是 Beat 7 的核心招式 |
| ... | ... | ... |
```

### 2.3 防带跑红线（写到 brief）

把这 3 条**直接复制**到 brief：

1. **Hot 色每 beat 只一个** —— 不允许一段画面里 ≥2 个饱和色（除 Claude 橙之外）。违反就改。
2. **DNA 自检 5/5 通过** —— `MY_VISUAL_DNA.md` 自检清单 5 个 yes/no 问题必须全 yes 才能派 agent。
3. **截图 ≠ 模板** —— 借鉴是借**结构和语义色**，不是抄具体内容。每个 beat 的文案必须按主题重写，不能直接抄参考。

---

## 步骤 3：写 brief

### 3.1 起手式
```
路径：本工程目录下 STYLE_BRIEF.md
长度：≤200 行（套骨架填空）
```

### 3.2 brief 骨架（H2 占位模板）

直接复制下面这个骨架，把 `{{...}}` 换成具体内容：

```markdown
# STYLE_BRIEF —— {{视频主题}}

## DNA 对照表（强制）
（按步骤 2.2 填）

## 防带跑红线
（按步骤 2.3 复制）

## 一、参考来源
1. **{{参考视频名 / 截图主题}}** —— `参考图/<topic>/`，N 张
2. **DNA 基线**：`MY_VISUAL_DNA.md`
3. **普适纪律**：`MOTION_PHILOSOPHY.md`（§0 十大法则）

## 二、底层视觉系统
（直接抄 DNA 的"不可妥协"7 条到 :root CSS 变量；额外的 hot 色按主题选）

```css
:root {
  --c-bg: #F7F2EA;        /* DNA 教程类默认；其他形态按主题选 */
  --c-orange: #d97757;    /* DNA 强制 */
  --c-grid: rgba(91,180,255,.08);
  /* hot 色（按主题选）*/
  --c-hot: {{选一个：#5BA9FF / #F05F6E / #8DD891 / #B891E4 / #F0C75E}};
  /* 字体（DNA 强制）*/
  --f-zh: "Noto Sans SC", "Inter", sans-serif;
  --f-en: "Inter", system-ui, sans-serif;
  --f-mono: "JetBrains Mono", ui-monospace, monospace;
}
```

## 三、组件库（按需启用，从模板里挑）
- [ ] Kicker（顶部章节标签）—— 模板 1
- [ ] Hero 大字（chrome 渐变）—— 模板 2
- [ ] 卡片栈（圆角描边）—— 模板 3
- [ ] 终端模拟（ANSI 配色）—— 模板 4
- [ ] 对话气泡（删除线 / 高亮）—— 模板 5
- [ ] 流程图三联卡 / 竖向 —— 模板 6
- [ ] 执行计划列表（checkbox + QA）—— 模板 7
- [ ] 进度条 / 章节进度 —— 模板 8
- [ ] 章节切换卡（数字徽章 + 大标题）—— 模板 9

（具体 CSS 在 `templates/tutorial-8beat/` 现成，引用即可）

## 四、动效规范
直接引用 DNA 第 6 条（字符 stagger 0.06-0.08，卡片 0.12-0.15，ease 三档）。

## 五、每个 beat 的"核心比喻 + 构图"指令
（用户提供的逐字稿/录屏 → 切成 N 段 → 每段写：核心比喻 / 用什么组件 / 引用第几张参考图 / hot 词是哪个）

### Beat 1 {{标题}} [0–{{X}}s]
- 核心比喻：{{...}}
- 组件：{{kicker / hero / 卡片栈 / 终端 ...}}
- 参考：{{截图 7.40.04 风格}}
- hot 词：{{"录制" 用红色}}

（重复 N 个 beat）

## 六、硬约束
（直接复制 STYLE_BRIEF.md 第 6 节 9 条，包括 GSAP 不用 template literal 等）

## 七、agent 工作流（每个 agent 必读）
（按步骤 4 的 prompt 范式抄一遍）
```

### 3.3 写 brief 时的关键检查
- DNA 5 条自检清单逐条过——5/5 全 yes 才往下
- 每个 beat 都有"核心比喻"——没有比喻的 beat 重新设计
- 总长度 ≤200 行——超了就精简

---

## 步骤 4：派并行 agent

### 4.1 拆分原则
- 8 beat → 4 个 agent，每个负责 2 个 beat
- 拆分时按"相似度"配对：
  - hook + pain-list（开场）
  - verdict + promise（对比/章节切换）
  - concept + flow（流程图）
  - punchline + outro（hero + 落版）
- 时长不超过 200 字 prompt 单体

### 4.2 Agent prompt 范式

每个 agent 的 prompt 必须包含：

1. **任务 ID** —— 对应 TaskCreate 的 ID，便于 mark completed
2. **必读文件**（按顺序）：
   - 本工程 STYLE_BRIEF.md
   - 本工程 index.html（看 timing 和 PiP 逻辑，不要改）
   - 现状 composition 文件
   - `MY_VISUAL_DNA.md`（强制）
   - 1-2 张相关参考图（不要让 agent 看全部 21 张）
3. **硬约束**（DNA 关键 + GSAP 关键）：
   - 底色 `var(--c-bg)`，不在 beat 内画 grid/vignette
   - GSAP selector 硬编码字符串，不能 template literal
   - timeline 末尾 pad 到 data-duration
   - CSS class 前缀对应 beat id
   - 不跑 lint/render/preview——main 统一跑
4. **每个 beat 的具体招式**（核心比喻 + 组件清单 + 参考 + hot 词）
5. **完成后**：Write 覆盖文件 + TaskUpdate mark completed + 200 字总结

### 4.3 启动方式
4 个 Agent 调用**放在同一条消息里**，并行启动：
```
Agent({description: "Beat 1+2 改造", subagent_type: "general-purpose", model: "sonnet", run_in_background: true, prompt: "..."})
Agent({...})
Agent({...})
Agent({...})
```

---

## 步骤 5：preview gate

### 5.1 main 自己跑这几步
1. **Lint**（必过）：
   ```bash
   cd <工程目录>
   npx hyperframes lint
   ```
   0 errors 才往下；warnings 可忽略。

2. **Preview 启动**（如果还没跑）：
   ```bash
   npx hyperframes preview &
   ```
   告知用户 URL（默认 `http://localhost:3002/`）和单 beat 调试 URL（`?comp=<beat-id>`）。

3. **截图自检**（在 render 之前）：
   - 用 Playwright 或在 preview 里手动 screenshot 8 个 beat 关键时刻
   - main agent Read 每张图 → 跟 DNA 对照表过一遍
   - 发现问题 → 派 agent 修，**不直接 render**

### 5.2 用户 gate（关键）

**main agent 绝不主动 render**。流程：

1. main 跑 lint 通过 → 告诉用户"preview 在 localhost:3002，去浏览器看 / 给反馈"
2. 用户在浏览器扫一遍 → 告诉 main 哪些 beat OK / 哪些要改
3. main 派 agent 修 → 重新 lint → 再让用户看
4. 用户**明确说**"渲一版" → main 才跑 `npx hyperframes render --quality draft`
5. 用户看 draft mp4 满意 → main 跑 `--quality standard` 出 final

**违反此 gate 浪费用户时间**。这是最重要的纪律。

---

## 防带跑红线（再强调一遍）

写在每个 brief 的最顶部：

1. **DNA 对照表是强制产出物**——没填这一栏不允许进入下一步
2. **Hot 色每 beat 只一个**——画面里 ≥2 个饱和色就要改（Claude 橙不算，它是品牌色一直在）
3. **截图 ≠ 模板**——借鉴是借结构和语义色，不是抄具体内容；每个 beat 文案必须按主题重写

---

## 维护

- 这个 playbook 用过 2-3 次后，把"实测有效的 prompt 范式"补充到步骤 4
- DNA 对照表的"参考有但 DNA 拒绝"清单可以累积——下次同类参考直接抄
- brief 骨架可以加更多组件（如果某个 catalog 零件被反复用，加进步骤 3 组件库列表）

不要：
- ❌ 把这个 playbook 拆成更多文件——它是单一入口
- ❌ 让步骤 2 变成可选——这是核心保险
- ❌ 把 DNA 写在 brief 里——DNA 在 `MY_VISUAL_DNA.md`，brief 引用它即可
