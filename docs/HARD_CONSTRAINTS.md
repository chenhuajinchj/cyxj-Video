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

跨机器 clone 仓库后需要重新 `git clone` 拉这两个上游，让 `MOTION_PHILOSOPHY.md` 和 `.claude/skills/{gsap,hyperframes,...}` 等软链生效。

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

## 维护

新增/修改硬约束时：
1. 改本文件
2. 不需要同步任何其他文件——它们都指向本文件
3. 如果是给 cyxj-new-video skill 用，确认 SKILL.md 末尾还指向本文件

新增的判定标准：**至少有 1 次实战翻车记录**。理论上的"最佳实践"不算硬约束。
