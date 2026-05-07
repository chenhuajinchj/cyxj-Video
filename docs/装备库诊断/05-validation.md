---
name: 装备库验证 — codex-claude-combo 复用证据
description: 2026-05-07 跑 codex-claude-combo 视频流程，记录 5 层级零件复用都真发生，证明 5/6-5/7 装备库整改路子是对的
type: project
date: 2026-05-07
based_on: 04-2026-05-07-recap.md 之后；commit 33e2a9b（Level 1 token）+ ee9333b（P1.1 移伪模板）
---

# 05 · 装备库验证 — codex-claude-combo 复用证据

> 用一条新视频反向证明装备库到底有没有"经验复用"价值。
> 这条视频不是作品，是验证产物。git 留着，不 render，不进 `参考库/我的作品/`。

## 怎么验证的

2026-05-07 启动 `codex-claude-combo`（60s 钩子片头，主题 Codex 插件 + Claude Code，6 beat），用 cyxj-new-video skill 形态 E（横屏 + 无录屏 + 单段演示）从 0 写。

跑完 lint pass + preview 通后回看：哪些零件是"复用了过去沉淀"的，哪些是"这次重写"的。

## 5 个层级都发生了复用

| 层级 | 复用了什么 | 来源 |
|---|---|---|
| **token** | `assets/xcyj-tokens.css`（颜色/字体/字号/halo） | `templates/components/xcyj-tokens/`（Level 1 单源 + mirror 机制） |
| **组件** | Beat 4 用 `cc-window` 终端窗口 | `templates/components/cc-window/`（19-tips 第 12 章抽离） |
| **资产** | Beat 1 / 3 用 `claude-code-logo.png` + `codex-logo.png` | `参考库/我的作品/2026-05-04-claude-19-tips-hf/assets/` |
| **骨架** | `index.html` / `meta.json` / `hyperframes.json` 起步 | `npx hyperframes init --example blank`（官方最小骨架） |
| **流程** | 形态 E 决策 → 建工作区 → token 接入 → 6 beat 拆 → lint | `cyxj-new-video` skill A0.5 决策树 + A3 从 0 写步骤 |

## 结论：路子对

5/6 装备库整改的整套主线"经验复用到下次视频"——这次跑通了。

- ✅ token 抽离的 mirror 机制可用（`bash scripts/sync-tokens.sh` 自动认到新工程）
- ✅ cc-window 组件 cp 到工程 assets/ + link 引用工作正常
- ✅ logo 资产作为通用层（不是某一条视频独有内容）可在新工程直接 cp
- ✅ `hyperframes init --example blank` 是"从 0 写"的最佳起步（不是手抄 quickstart）—— **这条建议可回填进 cyxj-new-video skill A3**
- ✅ cyxj-new-video skill 形态 E 路径可执行（决策 → 建 → token → beat → lint）

## 视频本身效果一般，但这不是验证目标

视频本身的视觉设计（6 beat 节奏、Beat 4 终端命令的静态感、Beat 5 9 格 grid 信息密度）有不少可调点。但这条视频的**功能是"复用证据"**，不是"作品"——打磨它会违反"修工具不做内容"的反模式。

后续真做选题时，这条工程留作"形态 E 同形态参考"（recap §3 设想的"等同形态做到 3-5 次再抽真模板"贡献第 1 次）。

## 一条可回填的细节

cyxj-new-video skill A3 节当前写"从 0 写时照 quickstart.md 一步步建"。这次跑下来发现 **`npx hyperframes init --example blank` 比手抄更快更稳**（自动生成 meta.json + hyperframes.json + index.html + package.json + 工程 CLAUDE.md，并自带最小 GSAP timeline 骨架）。

下轮 skill 升级时建议把"从 0 写"步骤改成：
```bash
cd $DATE
npx hyperframes init <slug> --non-interactive --example blank
cd <slug>
# 然后改 data-composition-id="main" → data-composition-id="<slug>"，接 token，写 beat
```

不本次改，因为这是"修工具"动作，留下次真做选题时一并验证后再回填。
