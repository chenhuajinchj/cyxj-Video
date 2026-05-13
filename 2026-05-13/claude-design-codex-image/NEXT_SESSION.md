# NEXT_SESSION · AI 生图工作流复盘视频 · 2026-05-13

> 新对话接手这条视频时**先读这个文件**，再读相应 beat html。

## 快速重启

```bash
cd "/Users/chenhuajin/项目/参考仓库/hyperframes/.claude/worktrees/ai-image-workflow-video/2026-05-13/claude-design-codex-image"
npx hyperframes preview    # http://localhost:3002
```

- worktree branch：`worktree-ai-image-workflow-video`
- 不要 merge main 进 worktree — 保持隔离；最后一次性 merge worktree branch → main

## 项目状态（2026-05-13 第二次会话后）

- **总时长**：193.5s（3 分 13 秒），SRT 在 `../AI生图(1).srt`
- **13 个 beat 全部 code-complete**，0 error 通过 lint
- **下一步**：用户在 preview 浏览器里反复看，挑出需要打磨的 beat 局部 → 回来一条一条迭代

## Beat 完成清单（全部 ✓ lint 通过）

| # | 时间 (绝对) | 时长 | 内容 | 文件 |
|---|---|---|---|---|
| 1 hook | 0 → 8.3 | 8.3s | 设计师 / 零容忍 scramble / 3 卡 / chip | `01-hook.html` |
| 2 teaser | 8.3 → 11.19 | 2.89s | "AI 生图三阶段" hero + 3 圆 01/02/03 | `02-teaser.html` |
| 3 s1-intro | 11.2 → 23.0 | 11.8s | PHASE 01 / Claude Design 卡 / Figma 挖角 / 股价 sparkline | `03-s1-intro.html` |
| 4 s1-flow | 23.0 → 43.0 | 20.0s | 即梦 chip → 3 step（截图 → token 4 chip → HTML code → 网页 mock）→ ✓ | `04-s1-flow.html` |
| 5 s1-pain | 43.0 → 57.5 | 14.5s | warning / usage 撞顶 / 7 days / Pro ❌ / X 气泡墙 / Anthropic 回应 / "等不了" | `05-s1-pain.html` |
| 6 s2-intro | 57.5 → 67.0 | 9.5s | 换思路 → 第二阶段 → Claude(BRAIN) → SPEC → Codex(EXEC) pipeline | `06-s2-intro.html` |
| 7 s2-detail | 67.0 → 80.0 | 13.0s | 两列对比（Codex speed/$ vs Claude code/$）+ 各司其职 + lime "天选打工" | `07-s2-detail.html` |
| 8 s2-result | 80.0 → 90.0 | 10.0s | Lovart chip + 文章封面 + 3 衍生 thumb + 设计 chip + ❤ | `08-s2-result.html` ⚠ |
| 9 reflection | 90.0 → 115.0 | 25.0s | 💡思考 → 流程 → "HTML = 中间产物" lime 删除线 → Anthropic 文章 + 10M lime counter → Markdown/HTML 二元 | `09-reflection.html` |
| 10 s3-intro | 115.0 → 137.0 | 22.0s | 角色卡 "AI+IP 流量操盘" + 4 平台 chip → "一张图" → "为什么不直接 gpt-image" + 中文 chip → 旧流程划掉/新流程 | `10-s3-intro.html` |
| 11 s3-key | 137.0 → 161.0 | 24.0s | KEY 警示 → "先规范 → 再生图" hero → 3 ✗ 卡（样式/间距/状态）→ "Codex 自己想" 警告 → lime "最重要" pill | `11-s3-key.html` |
| 12 s3-result | 161.0 → 173.0 | 12.0s | 4 stat 卡（时间↓ 5-6分钟 / 丰富↑ ×3 / 美↑ ★★★★★ / TOKEN↓ −70%） + ❤ | `12-s3-result.html` |
| 13 outro | 173.0 → 193.5 | 20.5s | AI 进化 chip → SOP 文档卡（4 步 + lime "完整提示词"）→ "AI 做视频" 下集预告 + lime 横划 → CTA button-primary | `13-outro.html` |

## 视觉风格（用户当面给的 tokens，全 13 beat 严格执行）

- **底色**：极浅米 `--bg: #fafaf8`
- **墨黑**：`--ink: #0b0b08`
- **跳色**：荧光柠檬 `--lime: #dcff45`（替代 Claude 橙的角色，稀缺使用）
- **字体**：`--sans` SF Pro / PingFang SC（正文）+ `--serif` Songti SC（hero）
- **卡片**：白底 + 28/22/12px 圆角 + 极淡阴影 + `featured` 顶部 lime inset 横条

tokens 文件：`assets/tokens.css`

**lime 使用规则**：仅用于「关键肯定/强调/数字 stat/CTA」；
**不用于** beat 5 pain（语义冲突 — pain 段用 ink 实色高对比表达）。

## 已用 main 最近组件（来自 commit a0d1545 + 7ad93ef）

- **aceternity-typewriter 思路** → beat 1 字符 stagger fade+y 入场
- **magic-hyper-text scramble** → beat 1 "零容忍" 中文字符解密（确定性 PRNG + GSAP onUpdate）
- **shake-error** → beat 1 "零容忍" 抖动 + beat 5 usage 撞顶卡 shake

## Logo 资产（已内联到 01-hook.html / 04-s1-flow.html / 10-s3-intro.html）

工程内 `assets/logos/`：
- `jimeng.svg`（lobe-icons jimeng）
- `lovart.svg`（lobe-icons lovart）
- `openai.svg`（lobe-icons openai → gpt-image）

### ⚠ TODO（worktree merge 回 main 后再做）

把 3 个 SVG 加进总库 `参考库/assets/logos/`，在 `LOGOS.md` 加一节"AI 图像生成"：

```bash
# merge 后
cp 2026-05-13/claude-design-codex-image/assets/logos/{jimeng,lovart,openai}.svg \
   参考库/assets/logos/
# 编辑 参考库/assets/logos/LOGOS.md：加"### AI 图像生成"小节
```

## 已知未定项 / 等真素材

- **beat 8 lovart 拆解成品图**：当前是 mock 卡片，等用户提供真截图替换 → 文件标 `⚠`
- **beat 9 Anthropic 千万浏览文章**：只用文字引用 + 占位 line（避免侵权）
- **beat 3 Figma 股价**：示意 sparkline，−14.2% 是虚拟数字
- **beat 12 TOKEN −70%**：示意，等用户给真实对比数字
- **静音输出**：本工程不挂音频，最终在达芬奇里合配音 + 加字幕

## 硬约束遵守情况

| # | 约束 | 检查 |
|---|---|---|
| 1 | GSAP querySelector 不用 template literal | ✓ 全 13 beat 通过 lint |
| 2 | beat html 全局换 id | ✓ b1-* / b2-* / .../ b13-* 全部隔离 |
| 3 | DaVinci 21 不渲染含中文文字的手写 Lottie | ✓ 本工程没用 Lottie |
| 4 | 中文 Whisper transcribe 绕 hyperframes CLI | ✓ SRT 已有，未用 transcribe |
| 5 | `npx hyperframes` 在工程目录跑 | ✓ |

## 节奏纪律（用户 memory 已强调）

- **绝不主动 render**，除非用户明确说"渲一版"
- **lint 0 error 后唯一动作**：保持 preview 跑着 + 等用户在浏览器里反馈 + 局部迭代
- **每个 SRT 关键词必须对应一个视觉变化**（13 beat 都按 SRT 句切分，timeline 注释逐句标注）

## 接手后第一步

```bash
cd "/Users/chenhuajin/项目/参考仓库/hyperframes/.claude/worktrees/ai-image-workflow-video/2026-05-13/claude-design-codex-image"
# preview 仍在 3002 端口跑（PID 70580 检查）；不在的话：
npx hyperframes preview
# 然后用户在浏览器里看：
# - 从头到尾扫一遍 0:00 → 3:13
# - 标出哪些 beat / 哪个时间点要打磨
# - 回来告诉 AI 具体改哪里
```

`.thumbnails/` 已清空。下次 preview 启动会重新生成。

## File-size warning

`04-s1-flow.html` 是 688 行（lint warning，非 error）。这是因为它要承载完整 3 step workflow（截图卡 / token 4 chip / code 卡 / 网页 mock）。如果未来想拆分，可以把 capture/token/code 三个 step 各自抽成独立 sub-composition，但目前不必。
