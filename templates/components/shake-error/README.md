# shake-error — 错误/拒绝/失败抖动

> 视频里需要表达"出错 / 提交失败 / token 校验不通过 / Claude 反对"瞬间时使用。
> 比 GSAP 自己写 33 帧随机 jitter 更省事，且原版 csshake 的随机数列已经过设计，看起来更"自然抖"。

---

## 来源 / 许可

- **上游仓库**：[elrumordelaluz/csshake](https://github.com/elrumordelaluz/csshake)
- **commit**：`4b9caede44bc93ac83de3ee795fe044832ceb484`
- **原文件**：`dist/csshake-default.css`（中等强度变体）
- **LICENSE**：MIT（Copyright © 2015 Lionel T / @elrumordelaluz）
- **改动**：
  1. 命名空间从 `.shake` → `.shake-error`（避免和未来其他 shake 类冲突）
  2. 触发方式从 `:hover` → `.is-shaking` class（HyperFrames 渲染管线没有 hover）
  3. 默认时长 100ms → **820ms**（原版太快，渲染到视频里看不出抖动）
  4. 删除 `.shake-trigger`、`.shake-constant`、`.shake-freeze` 等用不到的辅助 class
  5. 加 `.se-flash` 配套染 danger 色
  6. @keyframes 33 步随机帧 **1:1 移植**，未篡改原作者的随机数列
- **抓取日期**：2026-05-12

---

## 最小用法

```html
<!-- 1. composition <head> 里 link CSS -->
<link rel="stylesheet" href="../components/shake-error/shake-error.css" />

<!-- 2. body 里粘变体 A（错误卡片） -->
<div class="shake-error se-flash" id="err-card"
     style="display:inline-block; padding:18px 24px; border:2px solid currentColor;
            border-radius:8px; font:600 22px var(--f-mono, monospace);
            background:rgba(184,81,56,0.06);">
  ✕ ERROR · API call failed (401)
</div>

<!-- 3. GSAP timeline 在 2.0s 时 add class，2.85s 移除 -->
<script>
  const root = '[data-composition-id="beat-4-error"]';
  const tl = gsap.timeline();

  // 入场
  tl.fromTo(root + ' #err-card',
    { opacity: 0, y: 20, filter: 'blur(14px)' },
    { opacity: 1, y: 0,  filter: 'blur(0px)', duration: 0.5, ease: 'power3.out' }, 0);

  // 在 2.0s 触发抖动（恰好与口播 "API 调用失败" 关键词对齐）
  tl.call(() => {
    document.querySelector(root + ' #err-card').classList.add('is-shaking');
  }, null, 2.0);

  // 抖完移除 class，让元素回到静止（CSS animation `both` 模式会停在 100% 帧）
  tl.call(() => {
    document.querySelector(root + ' #err-card').classList.remove('is-shaking');
  }, null, 2.0 + 0.82);
</script>
```

---

## 可调 CSS 变量

| Token | 默认 | 说明 |
|---|---|---|
| `--se-duration` | `0.82s` | 整段抖动总时长。要更急可调到 `0.4s`，更绵长 `1.5s` |
| `--c-danger` | `#B85138`（来自 brand-tokens） | `.se-flash` 染色，未定义时用 fallback |

inline override：

```html
<div class="shake-error se-flash" style="--se-duration: 0.5s;">…</div>
```

---

## 3 种变体

| 变体 | 锚点 | 适用 |
|---|---|---|
| A · 错误卡片 + flash | shake-error.html L15 | "✕ ERROR · ..." 整块标志性失败提示 |
| B · 按钮抖动 | shake-error.html L28 | "提交按钮被点但失败"瞬间 |
| C · 行内 token | shake-error.html L40 | 一行文字中某个 token 单独抖（"invalid_token"） |

---

## GSAP 节奏参考

| 节奏 | --se-duration | 适用 |
|---|---|---|
| 急促 | 0.4s | 短 beat（口播"啊！"瞬间） |
| 标准（推荐） | 0.82s | 普通"错误提示"，能听清且看清抖 |
| 绵长 | 1.4s | 长 beat（口播"系统持续失败" 描述） |

**对齐口播关键词**：抖动 timestamp 应**恰好压在**口播"错误 / 失败 / 不行"等否定词的辅音上（memory `feedback_visual_sync_to_srt`：每个口播关键词瞬间必须对应一个视觉变化）。

---

## 已知约束

- **必须 `display:inline-block` 或 `block`**：行内 inline 元素 transform 不生效。变体 C 已显式写了 `display:inline-block`。
- **不要用 GSAP 同时 tween 同元素的 transform**：CSS animation 在跑时会和 GSAP transform 互斥。如果需要 GSAP 控制位置，套一层外层 wrapper：wrapper 让 GSAP 管位移，内层 `.shake-error` 只管抖。
- **`animation-fill-mode: both`**：CSS 已设。class 移除后元素停在 100% 帧（也就是原点）—— 不会"卡在抖动中"。
- **selector 硬编码**：HARD_CONSTRAINTS 第 1 条。

---

## 与其他组件关系

| 关联 | 关系 |
|---|---|
| `cc-window` `.cc-info`（绿色 ✓） | cc-info 是"成功回显"；shake-error 是"失败"。两者配对：成功用 cc-info 静态显示、失败用 shake-error 抖一下 |
| `pulse-bars` / `orbit-dots` | 都是"过程中"指示；shake-error 是"瞬时结果"。组合用法：pulse-bars 持续 → 突然 shake-error → 显示错误 |
