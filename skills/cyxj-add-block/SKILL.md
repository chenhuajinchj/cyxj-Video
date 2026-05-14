---
name: cyxj-add-block
description: 从 hyperframes catalog 装可复用零件到当前工程。当用户在某个 hyperframes 工程目录下说「加个零件」「装个 X」「加个转场」「加 macos 通知」「来个 logo 落版」「加个数据可视化」「有什么转场推荐」「我想要一个像 Y 那样的效果」时触发。读 templates/catalog.json 推荐 1-3 个匹配 block，征求确认后跑 npx hyperframes add，告诉用户在 index.html 怎么引用。
---

# /加零件 — 从 catalog 选装零件

帮你在做视频时快速从 46 个 catalog 零件（43 blocks + 3 components）里挑一个或几个装进工程，不用记零件名，不用查文档。

## 工作目录前置检查

zlib 必须在一个 hyperframes 工程目录里运行（不是仓库根）。

```bash
# 检查
[ -f meta.json ] && [ -d compositions ] || echo "❌ 不是 hyperframes 工程目录"
```

如果不是工程目录，提醒用户：「请先 cd 进具体工程，比如 `cd 2026-05-03/<slug>/`」。然后退出。

## 核心流程

### 1. 理解用户的场景

听用户描述，归类到这些场景之一：

| 用户说 | 场景标签 |
|---|---|
| 「加个转场」「场景之间要个过渡」「炸场点」 | transition |
| 「加 instagram 关注卡」「macos 通知」「评论卡」「社交 UI」 | social-overlay |
| 「Logo 落版」「片尾」「品牌结束」 | outro |
| 「数据图」「柱状图」「流程图」「图表」 | data-viz |
| 「app 展示」「产品 3D」「UI 揭示」 | showcase |
| 「颗粒效果」「闪光」「滤镜」 | decoration |
| 「像 X 那样的」 | (按 X 推断) |

不确定就反问："你想要的是【转场效果】、【社交 UI 卡片】、【Logo 落版】还是【数据可视化】之类的？"

### 2. 读 catalog.json 找匹配

```bash
jq -r '.[] | select(.tags | tostring | test("transition|shader")) | "\(.name) — \(.title)"' \
  ~/项目/参考仓库/hyperframes/templates/catalog.json
```

按 `tags` 过滤：
- transition → tags 含 "transition" / "shader"
- social-overlay → tags 含 "social" / "overlay"
- outro → tags 含 "outro" / "branding"
- data-viz → tags 含 "data" / "diagram" / "chart"
- showcase → tags 含 "showcase"
- decoration → name 在 components 列表（grain-overlay / shimmer-sweep / grid-pixelate-wipe）

### 3. 推荐 1-3 个 + 标注谁用过

参照 `docs/REFERENCE_INDEX.md` 的「真实工程里用过哪些零件」板块，告诉用户每个 block 在哪个参考工程里用过，可以去看效果。

格式：

```
我推荐这 3 个：

1. **whip-pan** — 运动模糊摇移，最适合教程节奏切换
   👀 在 `hyperframes-student-kit/video-projects/linear-promo-30s/` 里用过

2. **flash-through-white** — 闪白炸场，适合"咔的一下"这种节奏
   👀 在 `hyperframes-student-kit/video-projects/aisoc-app-release/` 里用过

3. **cinematic-zoom** — 推近过渡，比 whip-pan 平和

要装哪个？多选也行（用空格分隔）。
```

### 4. 安装

```bash
npx hyperframes add <name>
```

如果用户选多个，逐个跑。每个跑完报安装位置：

```
✅ whip-pan 已装到 compositions/components/whip-pan/
   - whip-pan.html （模板）
   - whip-pan.css （样式）
```

### 5. 给最小引用示例

读装好的 `compositions/components/<name>/<name>.html`，提取它的 root id 和 props，给用户一段可粘贴的引用代码：

```html
<!-- 在 index.html 里某个 beat 的 data-start 时间点，加一段： -->
<div class="clip"
     data-start="b3-end"
     data-duration="0.5"
     data-track-index="9">
  <template data-composition-src="compositions/components/whip-pan/whip-pan.html"
            data-composition-id="whip-pan-instance-1"></template>
</div>
```

### 6. 提示用户在哪个 beat 引用

```
装好了。现在你需要决定：在哪个 beat 之间用这个转场？

我看到你的 index.html 有这些 beat：b1-headline, b2-card, b3-terminal, ...

告诉我"在 b2 和 b3 之间"，我帮你插进去。
或者你自己改也行，引用代码已经在上面了。
```

### 7. 可选：在 INDEX 补一行用例

工程归档时（`/新视频` 阶段 B 会调用），在 `docs/REFERENCE_INDEX.md` 的「真实工程里用过哪些零件」板块加一行：

```markdown
- `videos/<日期>-<slug>/` 用了：`whip-pan`、`flash-through-white`
```

但本 skill 自己**不主动**改 INDEX——交给归档阶段做。

---

## 注意事项

- **components 跟 blocks 用法不同**：components（grain-overlay / shimmer-sweep / grid-pixelate-wipe）是全局叠加层，应该在 index.html 顶层 `<div id="root">` 之后引用，不嵌入 beat 里
- **transitions-XXX 是套装**：装一个 `transitions-blur` 等于装多个模糊转场，不是单独一个效果。如果用户只要一个效果，建议装具体的（如 `whip-pan`）而不是套装
- **不要重复安装**：检查 `compositions/components/<name>/` 是否已存在，已存在就跳过 npx add
- **catalog 远程更新**：如果用户问的零件名称在 catalog.json 里没有（如 catalog 没刷新过），提醒用户跑 `bash scripts/refresh-catalog.sh`
