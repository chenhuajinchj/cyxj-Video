# codex-claude-combo · 装备库复用验证产物

> ⚠️ **这不是作品，是 SOP 测试产物**。git 留着，但不 render，不归档进 `参考库/我的作品/`。

## 它是什么

2026-05-07 跑 cyxj-new-video skill 形态 E（横屏 + 无录屏 + 单段演示）从 0 写的一条 60s 视频，用来**验证 5/6-5/7 装备库整改的零件复用机制是否真 work**。

视觉设计本身不是验证目标——视频效果一般。验证的是 token / 组件 / 资产 / 骨架 / 流程**这 5 个层级是否真复用了过去的沉淀**。

## 验证结论

✅ 全部 5 层都复用了。详见 [`docs/装备库诊断/05-validation.md`](../../docs/装备库诊断/05-validation.md)。

## 工程组成

```
codex-claude-combo/
  meta.json / hyperframes.json / package.json   ← npx hyperframes init --example blank 生成
  CLAUDE.md / AGENTS.md                          ← init 自带的工程级指令文件
  index.html                                     ← 60s 主框架，6 beat mount + 8 段字幕
  assets/
    xcyj-tokens.css                              ← Level 1 单源 mirror（颜色/字体/halo）
    cc-window.css                                ← 19-tips 抽离的终端窗口组件 mirror
    codex-logo.png                               ← 19-tips 收集的通用 logo 资产
    claude-code-logo.png                         ← 同上
  compositions/
    01-hook.html              ← Codex × Claude Code 双 logo hero
    02-vs-debate.html         ← GPT 5.5 vs Opus 4.7 + 争论碎片
    03-pivot.html             ← "为什么不结合？" + 插件徽章
    04-terminal-demo.html     ← cc-window 演示 /codex:review 真实命令
    05-roadmap.html           ← 3×3 grid 9 大主题 stagger
    06-outro.html             ← 1+1>2 等式（蓝1 + 橙1 = 橙2）
```

## 不要拿这个工程当模板 cp 起步

理由跟伪模板（`参考库/历史模板/`）一样——这是一次性具体内容，id 没抽净、视觉是 codex-claude-combo 主题特定产物。

下次做新视频请按 cyxj-new-video skill 走完整决策流程。

## 文案源

`examples/codex-intro/script.md`（280 字中文，60s 钩子片头）。
