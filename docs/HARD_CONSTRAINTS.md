# 必须遵守的硬约束（单源）

> **这是仓库的单源真相**。CLAUDE.md / AGENTS.md / README.md / TEMPLATE_USAGE.md / 各模板 README / cyxj-new-video skill 都不再重复完整规则，全部指向本文件。
> 修改任何一条，**只改这一处**。

每条都来自实战翻车记录，不是理论建议。

---

## 1. GSAP querySelector 不能用 template literal

```js
// ❌ 会让 npx hyperframes lint 报 template_literal_selector error
gsap.from(`${root} .b1-card`, { ... });

// ✅ 永远硬编码 selector 字符串
gsap.from('[data-composition-id="beat-1-hook"] .b1-card', { ... });
```

**为什么**：lint 静态扫描，模板字符串里的变量它解析不出来，宁错杀也不放过。

---

## 2. 复制 beat html 时全局换 beat id

CSS class 和 GSAP selector 两处都引用了 beat id（如 `beat-3-terminal`）。复制了不换 id，新 beat 静默失效——动画不跑、不报错、preview 看上去就少一段。

```bash
# 进新 beat 文件，全局替换
sed -i '' 's/beat-3-terminal/beat-NEW-id/g' compositions/03-terminal.html
```

**为什么**：HyperFrames 用 `data-composition-id` 隔离命名空间，但你忘了改时 selector 拿不到节点，GSAP 静默 noop。

---

## 3. DaVinci 21 不能渲染含中文文字的手写 Lottie

含中文文字的手写 Lottie 在 DaVinci 21 渲染会乱码或丢字。**含文字必须走 hyperframes → ProRes 4444 alpha 路径**，由 hyperframes 的无头 Chromium 渲文字。

详见 [`lottie-davinci-experiment/`](lottie-davinci-experiment/)。手写 Lottie 仅适合纯图形装饰（光圈、icon、装饰线）。

---

## 4. 中文 Whisper transcribe 要绕开 hyperframes CLI

`npx hyperframes transcribe` 给 whisper-cli 传的 DTW preset 写死成 `large-v3`（破折号），但 whisper-cpp 期望 `large.v3`（点号）。中文长视频会直接 abort。

**正确做法**：直接用 `whisper-cli`，绕开 hyperframes CLI。

```bash
whisper-cli -m models/ggml-large-v3.bin -l zh -osrt -of out audio.wav
```

---

## 5. `npx hyperframes` 必须在工程目录里跑

仓库根**没有** `package.json`。CLI 读当前 cwd 的 `hyperframes.json` / `meta.json`，在仓库根跑会找不到。

```bash
cd 2026-MM-DD/<slug>/   # 必须先 cd 进工程
npx hyperframes lint
```

`/cyxj-new-video` skill 会自动 cd 到正确位置。

---

## 6. 不要 commit `hyperframes-student-kit/` 或 `hyperframes-launches/`

这两个目录是上游 git 仓库（Nate Herk / HeyGen 各自维护），整目录被 `.gitignore` 排除。

跨机器 clone 仓库后需要重新 `git clone` 拉这两个上游，让 `参考库/nate-demos/` 和 `.claude/skills/` 的软链生效。

---

## 7. 大视频/音频不进 git

`.gitignore` 已排除：

```
*.mp4 *.mov *.mp3 *.wav *.m4a
录屏/
```

最终成片 `final.mp4` 要保留时，不进 git 仓库——放本地或上传 OSS / R2，commit 里只放链接。

---

## 8. 中文字体在无头 Chromium 渲染时偶发回退

Google Fonts CDN 偶尔超时，`Noto Sans SC` 加载失败会回退系统默认字体（视觉廉价）。

**修法**（任选其一）：
- 重渲一次（CDN 命中后正常）
- 把字体本地化到 `assets/fonts/`，CSS 里 `@font-face` 指本地 path
- 在 GSAP 动画起点前加 `await document.fonts.ready` 门

---

## 9. hyperframes bundler 会吃掉 sub-composition 的内层 wrapper

`<template>` 里 `<div id="X" data-composition-id="X">` 这个内层 wrapper 在 bundle 时**会被 strip**，content 直接 inline 进父级 `.scene-layer`。

**结果**：CSS / JS 里写 `#X .child` 永远 match 不到（那个元素不存在）。

```css
/* ❌ bundler strip 后没有 #beat-1-hook 元素 */
#beat-1-hook .b1-kicker { ... }

/* ✅ 父级 scene-layer 自己带 data-composition-id 属性 */
[data-composition-id="beat-1-hook"] .b1-kicker { ... }
```

```js
// ❌ 字符串选择器同理
tl.fromTo("#beat-1-hook .b1-kicker", ...)

// ✅ 注意外层切单引号避免和内层属性双引号冲突
tl.fromTo('[data-composition-id="beat-1-hook"] .b1-kicker', ...)
```

**为什么**：bundler 给 CSS 自动加 `[data-composition-id="..."]` scope 前缀；inline 时认这个属性，不认 `id`。
**lint 警告**：`composition_self_attribute_selector` 推荐用 `#X` 是误报（在多 beat 主合成里），480 个 warning 可忽略。
**首次踩坑**：2026-05-13 AI 生图工作流复盘视频 13 beat，新加 beat 2-13 后全部不渲染，逐个 inspect bundle 才看出 wrapper 被 strip。

---

## 10. 关闭 hyperframes preview ≠ 只 kill server，必须同时关浏览器 tab

`npx hyperframes preview` 开了两个独立东西：
- **node server**（监听 3002 端口，处理 API 和 bundle）
- **浏览器 tab**（localhost:3002，跑 React studio + 加载 bundle + 渲缩略图 + 抓帧 scrub cache）

只 `kill <node pid>` 把 server 关掉了，**浏览器 tab 还在内存里跑**：
- 13 个 GSAP timeline 仍 paused 持有所有 DOM/tween 引用
- Studio 的渲染管线仍在跑（scrub cache、frame thumbnail）
- 没有 server 它也会持续重试、不会自动释放

**实测翻车**：2026-05-13 一个 193.5s × 13 sub-composition 的工程，server 关了之后 Chrome renderer 进程一度涨到 **12.64 GB**（单进程！PID 77521）。

**正确关闭顺序**：
1. 浏览器 tab `Cmd+W` 先关（释放抓帧缓存 + JS 引用，几秒后内存归还）
2. 再 `kill <node pid>` 关 server
3. 顺序反过来也行，但**两步都要做**

**Claude / Codex 关闭 preview 的指令模板**：
> "kill 了 PID X 的 preview server。**请同时在浏览器里关掉 localhost:3002 那个 tab**——不然 renderer 进程会继续吃几 GB 内存。"

---

## 11. 8+ sub-composition 的大工程要预防 preview 内存膨胀

hyperframes preview studio 给**每个 sub-composition** 注入了 3 个 Proxy（window / document / gsap）+ 一套 `__hf*` 运行时 helper（约 25 个局部变量）+ tween method shim。**13 个 beat 就是 39 个 Proxy + ~325 个 `__hf` 变量**。

叠加 studio 的逐帧 thumbnail / scrub cache（193.5s × 30fps × 1920×1080 ≈ 5800 帧），renderer 进程能轻松吃几 GB。**composition 越多放大越狠**，比单大 composition + 长时长更费内存。

**预防**：
- 长时间挂着 preview tab（>30 min）时偶尔 `Cmd+R` 刷新一次清缓存
- 看完一段就 `Cmd+W` 关 tab，不要常驻
- 不要用 `onUpdate` 在每帧里搞重活：
  - ❌ `onUpdate() { document.getElementById("x").textContent = ... }`（30fps × 几秒 = 几十次 lookup）
  - ✅ `const el = document.getElementById("x"); tl.to({...}, { onUpdate() { el.textContent = ... } });`（外面 cache 引用）
- 不要在 `onUpdate` 里每帧 new closure：
  - ❌ `onUpdate() { const rng = mulberry32(seed); ... }`
  - ✅ 外面 `const rng = mulberry32(seed)`，`onUpdate` 里复用
- **超过 8 个 sub-composition 时**：渲染前先 stop preview，render 完再 preview 看（render 走另一条路，不走 studio scrub cache）

**首次踩坑**：2026-05-13 13 beat × 193.5s 工程触发 12.64 GB renderer 进程。

---

## 维护

新增/修改硬约束时：
1. 改本文件
2. 不需要同步任何其他文件——它们都指向本文件
3. 如果是给 cyxj-new-video skill 用，确认 SKILL.md 末尾还指向本文件

新增的判定标准：**至少有 1 次实战翻车记录**。理论上的"最佳实践"不算硬约束。
