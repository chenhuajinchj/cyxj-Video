# 灵感库（inspirations/）

把 5 大开源 React 组件库（Aceternity / Magic UI / Eldora UI / React Bits / Motion-Primitives）里值得参考的组件**转译为 vanilla HTML + GSAP** 的本地预览版。

## 为什么有这一层

5 大库的原版都是 **React + Tailwind + Framer Motion / Motion**，hyperframes 是 **vanilla HTML + GSAP**——直接 copy-paste 不行。这一层做的事：

1. 抓原版 `.tsx` 源码（存在每个组件目录 `original.tsx` 里）
2. 转译成独立可双击的 `index.html`（GSAP 走 CDN）
3. 用户**双击预览**判断效果对不对
4. 满意了**手动晋级**到 `templates/components/<name>/`

## 显微切割友好

每个 `index.html` 内部用 `START / END` 注释明确标出**三段可摘组件**：

```
/* ============ CSS START · 晋级时整段切到 <name>.css ============ */
...
/* ============ CSS END ============ */

<!-- ============ HTML 片段 START · 晋级时整段切到 <name>.html ============ -->
...
<!-- ============ HTML 片段 END ============ -->

// ============ GSAP timeline START · 晋级时摘到 composition JS ============
...
// ============ GSAP timeline END ============
```

晋级 SOP 见每个组件目录里 `README.md` §5。

## 当前清单（Batch 1, 2026-05-12）

| 目录 | 来源 | 类型 | 原 URL |
|---|---|---|---|
| `eldora-terminal/` | Eldora UI | 终端 | https://www.eldoraui.site/docs/components/terminal |
| `magic-terminal/` | Magic UI | 终端 | https://magicui.design/docs/components/terminal |
| `aceternity-typewriter/` | Aceternity UI | 文字 | https://ui.aceternity.com/components/typewriter-effect |
| `magic-hyper-text/` | Magic UI | 文字 | https://magicui.design/docs/components/hyper-text |
| `magic-retro-grid/` | Magic UI | 背景 | https://magicui.design/docs/components/retro-grid |

## 怎么验收

```bash
open ~/项目/参考仓库/hyperframes/参考库/assets/inspirations/<目录>/index.html
```

每个判断：动起来对不对？README 翻译说明清不清？想不想晋级到 templates/components/？

## 不要碰

- `templates/components/`（用户手动晋级）
- `参考库/catalog.json`（用户手动加条目）
- `参考库/INDEX.md`（用户晋级后再补）

## 后续抓取池

完整 132 个组件 URL 菜单见 [`.claude/plans/hy-hy-curious-whistle.md`](../../../.claude/plans/hy-hy-curious-whistle.md) 附录。

## 协议提醒

5 大库均 MIT 或类似开源协议，复制源码到本地参考没问题。商业用途各自判断。
