#!/bin/bash
# 刷新 hyperframes 官方文档本地镜像
# 用法：bash scripts/refresh-docs.sh
#
# 数据源：https://hyperframes.mintlify.app/llms.txt（mintlify 自动暴露的 AI 友好索引）
# 目标：docs/hyperframes-official/
#
# 工作方式：动态读 llms.txt，所以官网新增页面会自动跟进，不用手维护清单。

set -e
cd "$(dirname "$0")/.."

LLMS_URL="https://hyperframes.mintlify.app/llms.txt"
BASE_URL="https://hyperframes.mintlify.app"
TARGET_DIR="docs/hyperframes-official"

echo "🔄 拉取 llms.txt 索引..."
LLMS=$(curl -fsSL "$LLMS_URL")
URLS=$(echo "$LLMS" | grep -oE 'https://hyperframes\.mintlify\.app/[^)]+\.md' | sort -u)
TOTAL=$(echo "$URLS" | wc -l | tr -d ' ')
echo "✅ 发现 $TOTAL 个页面"
echo ""

mkdir -p "$TARGET_DIR"/{getting-started,concepts,guides,packages,reference,contributing,catalog/blocks,catalog/components}

OK=0
FAIL=0
FAILED_URLS=""
i=0

while IFS= read -r url; do
  i=$((i+1))
  path="${url#$BASE_URL/}"

  # URL → 本地路径映射
  case "$path" in
    introduction.md|quickstart.md)
      local_path="$TARGET_DIR/getting-started/$path"
      ;;
    contributing.md)
      local_path="$TARGET_DIR/contributing/contributing.md"
      ;;
    examples.md)
      local_path="$TARGET_DIR/examples.md"
      ;;
    *)
      # concepts/, guides/, packages/, reference/, contributing/X, catalog/blocks/, catalog/components/
      local_path="$TARGET_DIR/$path"
      ;;
  esac

  mkdir -p "$(dirname "$local_path")"

  printf "  [%2d/%d] %-50s " "$i" "$TOTAL" "$path"
  if curl -fsSL "$url" -o "$local_path.tmp" 2>/dev/null; then
    mv "$local_path.tmp" "$local_path"
    OK=$((OK+1))
    echo "✅"
  else
    rm -f "$local_path.tmp"
    FAIL=$((FAIL+1))
    FAILED_URLS="${FAILED_URLS}  - ${url}"$'\n'
    echo "❌"
  fi
done <<< "$URLS"

echo ""
echo "📊 完成：成功 $OK / 失败 $FAIL"
if [ "$FAIL" -gt 0 ]; then
  echo ""
  echo "失败列表："
  printf "%s" "$FAILED_URLS"
fi

SIZE=$(du -sh "$TARGET_DIR" | cut -f1)
echo ""
echo "📦 本地镜像总大小：$SIZE（$TARGET_DIR）"
echo ""
echo "💡 建议每 1-2 月跑一次，可与 refresh-catalog.sh 一起执行"
