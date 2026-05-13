# NEXT_SESSION · AI 生图工作流复盘视频 · 2026-05-13

> 新对话接手这条视频时**先读这个文件**，再读 `compositions/01-hook.html` 看当前实现。

## 快速重启

```bash
cd "/Users/chenhuajin/项目/参考仓库/hyperframes/.claude/worktrees/ai-image-workflow-video/2026-05-13/claude-design-codex-image"
npx hyperframes preview    # http://localhost:3002
```

- worktree branch：`worktree-ai-image-workflow-video`（基于 `402f050`，比 main 落后 9 个 commit）
- 不要 merge main 进 worktree——保持隔离；最后一次性 merge worktree branch → main 即可

## 项目状态（截至 commit 当下）

- **总时长**：193.5s（3 分 13 秒），SRT 在 `../AI生图(1).srt`
- **已完成**：仅 **beat 1 (hook, 8.3s)**
- **未做**：beat 2-13（见下方"beat 切分表"）
- **`index.html` 当前 `data-duration` = 8.3s**——加新 beat 时要同步改成新总时长

## 视觉风格（用户当面给的 tokens）

- **底色**：极浅米 `--bg: #fafaf8`（不是旧 DNA 的暖米 `#F7F2EA`）
- **墨黑**：`--ink: #0b0b08`
- **跳色**：荧光柠檬 `--lime: #dcff45`（替代 Claude 橙的角色，稀缺使用）
- **字体**：`--sans` SF Pro / PingFang SC（正文）+ `--serif` Songti SC（hero）
- **卡片**：白底 + 28/22/12px 圆角 + 极淡阴影 + `featured` 顶部 lime inset 横条
- **规则**：用户明确说**只参考方向不严格照搬**——可灵活调

tokens 文件：`assets/tokens.css`

## Beat 1 现状（v3）

- 字号：hero 88px / 副 hero 56px / chip 24px（用户反馈 144 太大，已降）
- 句 3 `y: -260` 上移到画布上半，跟下半 3 张卡片完全分离
- "零容忍"：scramble 解密（中文 14 字池）+ lime 横划线 + shake-error 抖动 0.6s
- 3 卡：参考一 即梦 / 参考二 Lovart / 参考三 gpt-image，底部都是 52×52 圆角 app icon + 应用名

## 已用 main 最近组件（commit a0d1545 + 7ad93ef，8 个里的 3 个）

- **aceternity-typewriter** 思路 → 字符 stagger fade+y 入场（去掉光标和打字感）
- **magic-hyper-text** scramble → "零容忍" 中文字符解密（charset 改成中文，`Math.random` → mulberry32 PRNG，`requestAnimationFrame` → GSAP onUpdate，满足确定性渲染）
- **shake-error** 抖动 → "零容忍" 强调情绪（CSS @keyframes 33 步随机帧，幅度压低）

剩余 5 个组件给后续 beat 用：`eldora-terminal` / `magic-terminal`（Codex / Claude Code 阶段）/ `magic-retro-grid`（不太适配新风格，跳过）/ `pulse-bars` / `orbit-dots`（loading / 活力指示）

## Logo 资产（lobe-icons 拉取）

工程内 `assets/logos/`：
- `jimeng.svg` — 即梦（lobe-icons `packages/static-svg/icons/jimeng.svg`）
- `lovart.svg` — Lovart（同上）
- `openai.svg` — OpenAI gpt-image（同上）—— 用户确认 SRT 里"image-2"= OpenAI gpt-image

3 个都是 mono SVG（`fill="currentColor"`），**已内联到 `01-hook.html`**，CSS 染白色叠在品牌色圆角方块上。

### ⚠️ TODO（worktree merge 回 main 后再做）

把 3 个 SVG 也加进总库 `参考库/assets/logos/`，并在 `LOGOS.md` 加一节"AI 图像生成"，避免下次别的视频重复拉：

```bash
# merge 后
cp 2026-05-13/claude-design-codex-image/assets/logos/{jimeng,lovart,openai}.svg \
   参考库/assets/logos/
# 然后编辑 参考库/assets/logos/LOGOS.md：
#   - 清单从"33 个"改"36 个"（openai 可能已存在，先 ls 一下）
#   - 在"### 工具 / 协议"后加"### AI 图像生成"小节
# 或者跑 bash scripts/refresh-catalog.sh 同款方式
```

## Beat 切分表（13 beat，时间码硬编码）

| # | 时间 | 时长 | 内容 | 视觉锚点 |
|---|---|---|---|---|
| 1 hook | 0.0–8.3 | 8.3s | "设计师出身/默认审美零容忍/工作流跑出来的/一个比一个简单/好看" | **已完成** |
| 2 teaser | 8.3–11.2 | 2.9s | "复盘 AI 生图三阶段" | 三个圆 stage chip 横排 01/02/03 |
| 3 s1-intro | 11.2–23.0 | 11.8s | Claude Design / Anthropic 上月发 / 挖 Figma 副总裁 / Figma 股价下跌 | Claude 橙 logo + 产品 hero + Figma 下落 sparkline |
| 4 s1-flow | 23.0–43.0 | 20.0s | 即梦 Agent 拆解 / 截界面 / 反推设计规范 / 写 HTML 出图 / 效果真好 | 三步流程卡：截图 → token 板（颜色/字号/排版/留白 4 chip）→ HTML 出图 |
| 5 s1-pain | 43.0–57.5 | 14.5s | 大坑：周限额 / 冷却一周 / Pro 救不了 / 推上吐槽 / 等不了 | warning 卡：限额条触顶变红 + 倒计时 + Twitter 气泡 |
| 6 s2-intro | 57.5–67.0 | 9.5s | 第二阶段：Claude Design 做大脑 + Codex 执行 | Claude logo "大脑" + 箭头 → Codex logo "执行" |
| 7 s2-detail | 67.0–80.0 | 13.0s | Codex 便宜按系统快 / Claude 代码能力强 / 各司其职 / 天选打工 | 两列能力对比卡（★/价格） |
| 8 s2-result | 80.0–90.0 | 10.0s | 拆 lovart 的文章配图就是这么做 | Lovart 拆解成品图（mock，等真截图） |
| 9 reflection | 90.0–115.0 | 25.0s | HTML 是中间产物 / Anthropic 千万浏览文章 / Markdown 给 AI / HTML 给人 | hero "HTML = 中间产物" + 文章卡 + 千万浏览 lime stat |
| 10 s3-intro | 115.0–137.0 | 22.0s | AI+IP 操盘 / 要一张图 / 为何不直接 Codex 调 image2 / 中文能力 / 跳过 HTML | 新工作流图：参考图 → Codex → gpt-image → 成品；旧"HTML"划掉 |
| 11 s3-key | 137.0–161.0 | 24.0s | 关键：先规范再生图 / 不框死 Codex 自己想 / 非设计师最易省 / 最重要 | hero "先规范 → 再生图" + 三 ✗ 卡（卡片样式/间距/状态）+ lime "最重要" pill |
| 12 s3-result | 161.0–173.0 | 12.0s | 5-6 分钟出一套 / 比 HTML 快丰富好看 / TOKEN 还少 | 四 stat 卡：时间↓ / 丰富↑ / 美↑ / TOKEN↓（lime 数字） |
| 13 outro | 173.0–193.5 | 20.5s | AI 还会进化 / SOP 文档已整理 / 想要可以尝试 / 下集 AI 做视频 / 感兴趣聊聊 | SOP 文档卡 + button-primary "下集预告" + lime 提示 chip |

## 节奏纪律（用户 memory 已强调）

- **绝不主动 render**，除非用户明确说"渲一版"（memory: `feedback_workflow_polish_in_browser`）
- **lint 0 error 后唯一动作**：保持 preview 跑着 + 等用户在浏览器里反馈
- **每个 SRT 关键词必须对应一个视觉变化**，不能空窗（memory: `feedback_visual_sync_to_srt`）

## 已知未定项

- **beat 8 lovart 拆解成品图**：当前会用 mock 卡片，等用户提供真截图替换
- **beat 9 Anthropic 千万浏览文章**：只用文字引用不放截图（避免侵权）
- **beat 3 Figma 股价**：示意性虚拟 sparkline，不用真实数据
- **静音输出**：本工程不挂音频，最终在达芬奇里合配音 + 加字幕
