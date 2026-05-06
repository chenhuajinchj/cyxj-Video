# Demo-Fullscreen Template

## 适用场景

**全屏画面叙事，无录屏，7 个 beat 串联，总时长约 52s。**

典型场景：
- 含中文文字的虚构 UI 演示（比如演示 AI 工具的使用流程）
- 概念动画、产品逻辑拆解
- 视频开篇钩子 / 品牌片中段

不适合：
- 主播口播为主 → 用 `host-overlay` 模板（有 PiP 录屏轨道）
- 结构化多段教程讲解 → 用 `tutorial-8beat` 模板（章节切换 + 流程卡）

---

## 7 个 Beat 的核心比喻

| Beat | 名称 | 核心比喻 | 默认时长 |
|------|------|----------|---------|
| 01 | HOOK | frosted-glass 居中卡——品牌名/主题名大字冲屏，whip 出场 | 6s |
| 02 | DEBATE | 左右双卡 + VS 对决——两个选项争论，合并出"第三选项" | 7s |
| 03 | TERMINAL | Mac 终端 typewriter——命令输入 + 工具日志 + 右侧 HUD 状态卡 | 10s |
| 04 | TOPICS | 纵向 stagger 列表——N 个主题逐一入场，焦点 cycling 高亮 | 14s |
| 05 | THESIS | kinetic type 冲屏——单句论点大字，dolly 穿字收尾 | 6s |
| 06 | CTA | 订阅引导卡——行动号召 + 按钮呼吸动效 | 5s |
| 07 | OUTRO | 品牌 ID hold——频道名 + handle 锁定，网格缓退 | 4s |

---

## 怎么用

### 1. 复制到日期工作区

```bash
cp -R ~/项目/参考仓库/hyperframes/templates/demo-fullscreen \
       ~/项目/参考仓库/hyperframes/2026-MM-DD/your-topic
cd ~/项目/参考仓库/hyperframes/2026-MM-DD/your-topic
```

### 2. 修改 meta.json

把 `id` 和 `name` 从 `xcyj-codex-claude-intro` 改成你的工程 id（全局唯一，建议格式 `xcyj-主题-日期`）。

### 3. 替换 index.html 占位符

- `<title>` 标签 → 改成视频标题
- `data-composition-id="xcyj-codex-claude-intro"` → 改成与 meta.json 相同的 id（共 2 处：`#root` 属性 + JS 末尾的 `window.__timelines["..."]`）
- `data-duration="52"` → 按实际 7 个 beat 总时长调整
- 字幕层（`.caption.clip` 各节点）→ 替换为你的配音文案 + 时码（`data-start` / `data-duration`）

### 4. 逐 beat 替换文案

每个 `compositions/0X-*.html` 里的中文文案都是本次具体内容。直接在 HTML 标签内替换文字，注意 beat id（如 `beat-3-terminal`）全局唯一，复用时必须全量替换：

```bash
# 示例：把 beat-3-terminal 改为新 id
sed -i '' 's/beat-3-terminal/beat-3-YOUR-ID/g' compositions/03-terminal.html
```

### 5. Lint + Preview

```bash
# 必须在工程目录（非仓库根）跑
npx hyperframes lint       # 必须 0 errors
npx hyperframes preview    # 浏览器验收
```

**硬约束**：GSAP querySelector 不能用 template literal。永远硬编码 selector 字符串，否则 lint 报 `template_literal_selector` error。

---

## 占位符清单

模板不使用 `{{...}}` 占位符格式，文案直接写在 HTML 标签内容里。以下是需要替换的关键位置：

| 位置 | 需替换内容 |
|------|-----------|
| `index.html` `<title>` | 视频标题 |
| `index.html` `data-composition-id`（#root + JS，共 2 处）| 工程唯一 id |
| `index.html` `data-duration="52"` | 实际总时长（秒） |
| `index.html` `.caption.clip` 各节点 | 配音字幕文案 + `data-start` / `data-duration` |
| `01-hook.html` `.b1-eyebrow` | 顶部标签文字（如频道名/主题类型）|
| `01-hook.html` `.b1-codex` / `.b1-cross` / `.b1-cc` | headline 三段 |
| `01-hook.html` `.b1-tagline` | 副标题 |
| `02-debate.html` `.b2-card-*` 内各字段 | 两个对比选项的名称/标签/副标 |
| `02-debate.html` `.b2-merge-*` 内各字段 | 合并后的结论文案 |
| `03-terminal.html` 终端内容 | 命令、工具日志行、done 文字 |
| `03-terminal.html` `.b3-hud-*` 内各字段 | 右侧 HUD 状态数据 |
| `04-topics.html` `.b4-item` 各列表项 | 主题编号 + 中文 + 英文副标 |
| `05-thesis.html` `.b5-row` / `.b5-tagline` | 核心论点大字 + 副标 |
| `06-cta.html` `.b6-*` 内各字段 | 引导语 + 频道名 |
| `07-outro.html` `.b7-*` 内各字段 | 频道名 + handle + 下期预告 |

---

## 已知约束

**（a）GSAP selector 不能用 template literal**
所有 `gsap.from / gsap.to / gsap.fromTo / document.querySelector` 的 selector 字符串必须硬编码，不能用反引号拼接变量。违反会导致 `npx hyperframes lint` 报 `template_literal_selector` error，渲染失败。

**（b）含中文文字的段落不能抽 Lottie 给达芬奇 21 使用**
demo-fullscreen 的 beat 内容通常包含大量中文文字（字幕、标签、标题）。如果你想把某个 beat 单独导出为 Lottie 在达芬奇 21 里叠加使用，含中文文字的部分会渲染失败（字形丢失或乱码）。必须走 hyperframes → ProRes 4444 alpha 路径，或在达芬奇里用字幕轨道单独处理中文文字。详见 `docs/lottie-davinci-experiment/`。

**（c）配音后期在 NLE 加，模板内不带音频时间轴**
`.caption.clip` 字幕层只是占位文案，按 beat 整段时码粗排。精确逐字对齐需要在达芬奇（或 Premiere）里用字幕轨道完成，不要在 HTML 里逐字拆分时码。
