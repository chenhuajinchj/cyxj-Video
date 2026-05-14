# Tutorial 8-Beat Template

## 适用场景

**教程类视频 ≥30s，结构清晰的多段讲解**（推荐 6–8 beat，总时长 45–75s）。

典型场景：
- AI 工具教程（"X 是什么 / 为什么用 / 怎么用"）
- 软件功能演示（hook + 痛点 + 解决方案 + 流程）
- 概念拆解（先建悬念，再拆原理，最后给执行计划）

不适合：纯录屏剪辑覆盖（从 0 写工程，可参考 `videos/2026-05-02-claude-demo-v2/` 拓扑）、纯 logo/品牌片（用单 beat outro 结构）。

---

## 8 个 Beat 的核心比喻

| Beat | 名称 | 核心比喻 | 默认时长 |
|------|------|----------|---------|
| 01 | HOOK | 删除线对话气泡——颠覆预设认知，引出真正耗时的事 | 6.5s |
| 02 | PAIN LIST | 三痛点卡片栈——把问题具象化为三个并排卡片 | 6.5s |
| 03 | PAIN VERDICT | 左右双栏对比（✓ vs ✗）——视觉反差制造判决感 | 6.0s |
| 04 | PUNCHLINE | 大字 headline + 终端 + 弧线箭头指向 face PiP（hero beat） | 6.0s |
| 05 | PROMISE | 章节切换卡——数字徽章 + 标签 + 大标题，告诉观众接下来学什么 | 6.5s |
| 06 | CONCEPT | 三步流程卡（输入→处理→输出），箭头连接，halo 循环高亮 | 11.0s |
| 07 | FLOW | 可勾选执行计划——5 步 checkbox 列表逐步亮起打勾 | 14.0s |
| 08 | OUTRO | 品牌 hero hold + 粒子爆发收尾（face 在 60s 回归全屏） | 8.1s |

---

## 怎么用

### 1. 复制到日期工作区

```bash
cp -R ~/项目/参考仓库/hyperframes/templates/tutorial-8beat \
       ~/项目/参考仓库/hyperframes/2026-MM-DD/your-topic
cd ~/项目/参考仓库/hyperframes/2026-MM-DD/your-topic
```

### 2. 修改 meta.json

把 `id` 和 `name` 从 `xcyj-tutorial-8beat-PLACEHOLDER` 改成你的工程 id（全局唯一）。

### 3. 替换 index.html 占位符

- `{{VIDEO_TITLE}}` → 视频标题
- `data-composition-id="xcyj-tutorial-8beat-PLACEHOLDER"` → 改成与 meta.json 相同的 id（共 2 处）
- `data-duration="64.6"` → 按实际总时长调整（同步修改 GSAP 锚点和 PiP 时序秒数）
- `--c-hot: #d97757` → 可改为其他主题色（全局 hot 色）

### 4. 逐 beat 替换文案占位符

每个 `compositions/0X-*.html` 顶部有注释说明需替换哪些 `{{...}}`，参见下方占位符清单。

**注意**：beat 4 的 headline 需要把每个字拆成 `<span class="b4-char">字</span>`，关键词改 `.b4-keyword` class。

### 5. Lint + Preview

```bash
# 必须在工程目录跑
npx hyperframes lint       # 必须 0 errors
npx hyperframes preview    # 浏览器验收
```

**硬约束**：GSAP querySelector 不能用 template literal，永远硬编码 selector 字符串。完整 8 条详见 [`../../docs/HARD_CONSTRAINTS.md`](../../docs/HARD_CONSTRAINTS.md)。

---

## 占位符清单

| 占位符 | 位置 | 说明 |
|--------|------|------|
| `{{VIDEO_TITLE}}` | index.html `<title>` | 页面标题 |
| `{{HOOK_METAPHOR}}` | index.html beat-1 注释 | beat 比喻备注（不影响渲染） |
| `{{KICKER_NUM}}` | 01/02/06/07 各 beat | 顶部章节编号（如 EP·01 / META） |
| `{{KICKER_LABEL}}` | 01/02/06/07 各 beat | 顶部章节标签（如 时间陷阱） |
| `{{BUBBLE_TEXT}}` | 01-hook | 对话气泡文字 |
| `{{HEADLINE_LINE_1_CHARS}}` | 01-hook | 大字第1行（每字用 span.b1-char 包裹） |
| `{{HEADLINE_LINE_2_PREFIX}}` | 01-hook | 大字第2行前缀（chrome 色） |
| `{{HOT_WORD}}` | 01-hook | 大字第2行 hot 词（红色） |
| `{{SUBTITLE}}` | 02-pain-list | 卡片上方副标题 |
| `{{CARD_ICON_1~3}}` | 02-pain-list | 三卡 emoji/图标 |
| `{{CARD_TITLE_1~3}}` | 02-pain-list | 三卡标题（红色大字） |
| `{{CARD_DESC_1~3}}` | 02-pain-list | 三卡描述（dim 小字） |
| `{{CARD_TAG_1~3}}` | 02-pain-list | 三卡英文标签（mono 字体） |
| `{{LEFT_TITLE}}` | 03-pain-verdict | 左侧（✓ 绿色）面板标题 |
| `{{LEFT_SUB}}` | 03-pain-verdict | 左侧副标 |
| `{{RIGHT_TITLE}}` | 03-pain-verdict | 右侧（✗ 红色）面板标题 |
| `{{RIGHT_SUB}}` | 03-pain-verdict | 右侧副标 |
| `{{VERDICT_PREFIX}}` | 03-pain-verdict | 底部大字前缀（chrome） |
| `{{VERDICT_HOT}}` | 03-pain-verdict | 底部大字 hot 词（红色） |
| `{{HEADLINE_CHARS}}` | 04-punchline | 大字（每字 span.b4-char，关键词加 .b4-keyword） |
| `{{TERMINAL_CMD}}` | 04-punchline | 终端命令（如 /context） |
| `{{TERMINAL_SECTION_HEADER}}` | 04-punchline | 终端章节标题（蓝色） |
| `{{TERMINAL_ROW_1~4_KEY/VAL/STATUS}}` | 04-punchline | 终端数据行 |
| `{{TERMINAL_TOTAL_VAL/LIMIT}}` | 04-punchline | 终端合计行 |
| `{{NOTIF_ICON_CHAR}}` | 04-punchline | 通知图标单字符 |
| `{{NOTIF_APP/TITLE/SUB}}` | 04-punchline | macOS 通知内容 |
| `{{TAG_TEXT_1~3}}` | 04-punchline | 3 个 evidence tag 文字 |
| `{{CHAPTER_NUM}}` | 05-promise | 章节数字（如 02） |
| `{{CHAPTER_TAG}}` | 05-promise | 章节标签（全大写） |
| `{{CHAPTER_TITLE}}` | 05-promise | 主标题大字 |
| `{{CARD_1~3_ICON/TITLE/SUB/TAG}}` | 06-concept | 三步流程卡内容 |
| `{{CARD_3_CAP_1~3}}` | 06-concept | 卡3 能力标签 |
| `{{KICKER_ICON}}` | 07-flow | kicker emoji |
| `{{PANEL_TITLE}}` | 07-flow | 面板标题（mono） |
| `{{LIST_ITEM_1~5}}` | 07-flow | 5 步骤文案 |
| `{{STATUS_TAG_1~5}}` | 07-flow | 5 步状态标签 |
| `{{BRAND_NAME}}` | 08-outro | 品牌/频道名（如 XCYJ） |
| `{{BRAND_TAGLINE}}` | 08-outro | 副标题（如 Claude Code × HyperFrames） |
| `{{CTA_URL}}` | 08-outro | CTA 链接（如 youtube.com/@XCYJ） |
