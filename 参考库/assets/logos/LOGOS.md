# 通用 Logo 库

视频里出现 AI 厂商 / 工具时，从这里取 SVG，不要再用 emoji，也不要每次去搜图。

## 来源

[`@lobehub/icons`](https://github.com/lobehub/lobe-icons) 的静态 SVG 包，通过 npmmirror 镜像拉取。本目录是**固化快照**，离线可用，不依赖外网 CDN（避免无头 Chromium 渲染时 CDN 超时——CLAUDE.md 硬约束第 8 条）。

## 在 hyperframes beat 里怎么用

每个文件都是 24×24 viewBox 的 SVG，`width="1em" height="1em"`，**继承 CSS `color`**（mono 变体可以一键染色）。

### 1. 当 `<img>` 用（最简单）
```html
<img src="../../参考库/assets/logos/claude.svg" class="brand-logo" />
```
```css
.brand-logo { width: 64px; height: 64px; }
```
> 路径根据工程在 `2026-MM-DD/<slug>/` 下的相对位置调。如果嫌深，复制到工程自己的 `assets/` 里更稳。

### 2. 内联 SVG（GSAP 可控）
直接把 svg 文件内容贴进 html，给个 id：
```html
<svg id="claude-logo" ...>...</svg>
```
```js
gsap.from('#claude-logo', { scale: 0, rotate: -90, ease: 'back.out' });
```

### 3. mono 染色
mono SVG 用 `fill="currentColor"`，CSS 设 `color` 就染色：
```html
<svg style="color: #f43f5e">...</svg>
```
当 `<img>` 用时无法染色（SVG sprite 被 sandbox 隔离），需要染色就走内联。

## 当前清单（33 个）

### Anthropic 家族
| 文件 | 变体 | 用途 |
|---|---|---|
| `claude.svg` | color | Claude 模型本体 |
| `claudecode.svg` | mono | Claude Code 官方 mark |
| `anthropic.svg` | mono | Anthropic 公司层 |

### OpenAI 家族
| 文件 | 变体 | 用途 |
|---|---|---|
| `openai.svg` | mono | OpenAI / ChatGPT 通用 |
| `codex.svg` | mono | Codex CLI |

### Code AI 工具
| 文件 | 变体 | 用途 |
|---|---|---|
| `cursor.svg` | mono | Cursor IDE |
| `github.svg` | mono | GitHub |
| `githubcopilot.svg` | mono | GitHub Copilot |
| `copilot.svg` | color | Copilot 通用彩色版 |
| `v0.svg` | mono | Vercel v0 |
| `vercel.svg` | mono | Vercel |
| `trae.svg` | color | Trae IDE（字节） |
| `junie.svg` | color | JetBrains Junie |
| `windsurf.svg` | mono | Windsurf IDE |
| `replit.svg` | color | Replit |
| `geminicli.svg` | color | Gemini CLI |

### 模型对比
| 文件 | 变体 | 用途 |
|---|---|---|
| `gemini.svg` | color | Google Gemini |
| `deepseek.svg` | color | DeepSeek |
| `grok.svg` | mono | Grok |
| `xai.svg` | mono | xAI |
| `meta.svg` | color | Meta / Llama |
| `mistral.svg` | color | Mistral |
| `perplexity.svg` | color | Perplexity |
| `huggingface.svg` | color | Hugging Face |
| `google.svg` | color | Google |
| `microsoft.svg` | color | Microsoft |
| `apple.svg` | mono | Apple |
| `nvidia.svg` | color | NVIDIA |
| `ollama.svg` | mono | Ollama 本地推理 |

### 工具 / 协议
| 文件 | 变体 | 用途 |
|---|---|---|
| `mcp.svg` | mono | Model Context Protocol |
| `langchain.svg` | color | LangChain |
| `notion.svg` | mono | Notion |
| `obsidian.svg` | color | Obsidian |

## 添加新 logo

lobehub 总共有 200+ 厂商，本清单只是常用子集。

1. 探测是否存在：
   ```bash
   curl -sI "https://registry.npmmirror.com/@lobehub/icons-static-svg/latest/files/icons/<id>-color.svg" | head -1
   ```
   302 = 存在，404 = 不存在或 id 写错。
2. **id 规则**：全小写、无分隔符。`ClaudeCode` → `claudecode`，`GeminiCLI` → `geminicli`。
3. 拉下来：
   ```bash
   cd ~/项目/参考仓库/hyperframes/参考库/assets/logos
   curl -sfLO "https://registry.npmmirror.com/@lobehub/icons-static-svg/latest/files/icons/<id>-color.svg"
   ```
   然后更新本表。
4. 完整 id 名单见 `~/项目/参考仓库/icons/demo/node_modules/@lobehub/icons/es/` 目录下所有子目录名（200+ 个）。

## 重要边界

- **`claude-code-logo.png`（像素拟人头像）不在这里**，由各视频工程自己保存。本库的 `claudecode.svg` 是官方品牌 mark，**两个不是同一张图**：
  - 拟人形象 / "Claude 在说话" → 用工程里的 `claude-code-logo.png`（memory: feedback_use_claude_logo）
  - 品牌标识 / 工具栏 / 横向 logo 列 → 用本库的 `claudecode.svg`
- 商业使用前请遵守各品牌视觉规范。Anthropic / OpenAI / Google 等对 logo 用法有官方约束。
