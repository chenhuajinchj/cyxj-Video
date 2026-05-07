#!/usr/bin/env bash
# 同步 DNA token 单源到所有 mirror。
#
# 单源：templates/components/xcyj-tokens/xcyj-tokens.css
# Mirror：每个 hyperframes 工程的 assets/xcyj-tokens.css
#
# 用法（仓库根跑）：
#   bash scripts/sync-tokens.sh        # dry-run 看会改哪些
#   bash scripts/sync-tokens.sh apply  # 真正覆盖
#
# 何时跑：
#   - DNA 修订后（如 2026-05-06 深蓝→暖米）
#   - 用 cp 复制模板起新工程，发现 assets/xcyj-tokens.css 内容滞后单源时

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SOURCE="$REPO_ROOT/templates/components/xcyj-tokens/xcyj-tokens.css"
MODE="${1:-dry-run}"

if [[ ! -f "$SOURCE" ]]; then
  echo "❌ 单源不存在：$SOURCE"
  exit 1
fi

# 找所有 mirror（模板 + 工作区 + 历史模板，归档不动）
MIRRORS=()
while IFS= read -r f; do
  [[ "$f" == "$SOURCE" ]] && continue
  # 跳过 node_modules 和上游 gitignored 目录
  [[ "$f" == *"/node_modules/"* ]] && continue
  [[ "$f" == *"/hyperframes-student-kit/"* ]] && continue
  [[ "$f" == *"/hyperframes-launches/"* ]] && continue
  MIRRORS+=("$f")
done < <(find "$REPO_ROOT" -name "xcyj-tokens.css" -type f 2>/dev/null)

if [[ ${#MIRRORS[@]} -eq 0 ]]; then
  echo "ℹ️  没找到 mirror。仅有单源：$SOURCE"
  exit 0
fi

echo "单源：$SOURCE"
echo "找到 ${#MIRRORS[@]} 个 mirror："
for m in "${MIRRORS[@]}"; do
  rel="${m#$REPO_ROOT/}"
  if cmp -s "$SOURCE" "$m"; then
    echo "  ✓ $rel  （已同步）"
  else
    echo "  ✗ $rel  （内容不一致）"
    if [[ "$MODE" == "apply" ]]; then
      cp "$SOURCE" "$m"
      echo "      → 已覆盖"
    fi
  fi
done

if [[ "$MODE" != "apply" ]]; then
  echo ""
  echo "（dry-run）跑 'bash scripts/sync-tokens.sh apply' 真正覆盖。"
fi
