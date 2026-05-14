#!/usr/bin/env bash
# refresh-zero-usage.sh
#
# 扫 videos/ 下所有工程，反查每个工程用过哪些 catalog block / component。
# 输出格式与 docs/REFERENCE_INDEX.md "真实工程里用过哪些零件" 节一致。
#
# 检测规则：
#   block      → compositions/<name>.html 文件存在
#   component  → compositions/components/<name>.html 文件存在
# name 列表来自 templates/catalog.json
#
# 用法：
#   bash scripts/refresh-zero-usage.sh                      # 打印到 stdout
#   bash scripts/refresh-zero-usage.sh --write              # 替换 INDEX.md
#                                                            <!-- AUTO:zero-usage --> 标记之间的内容
#
# 维护：catalog 增删时无需改本脚本，只需 bash scripts/refresh-catalog.sh 后重跑本脚本。

set -euo pipefail
shopt -s nullglob

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CATALOG="$ROOT/templates/catalog.json"
INDEX="$ROOT/docs/REFERENCE_INDEX.md"

if [ ! -f "$CATALOG" ]; then
    echo "ERROR: catalog.json 不存在，先跑 bash scripts/refresh-catalog.sh" >&2
    exit 1
fi

# 提取 block / component 名单
mapfile -t BLOCK_NAMES < <(jq -r '.[] | select(.type=="block") | .name' "$CATALOG" | sort)
mapfile -t COMPONENT_NAMES < <(jq -r '.[] | select(.type=="component") | .name' "$CATALOG" | sort)

# 扫描函数：输入工程目录，输出 "- `parent/name/` 用了：`x`、`y`、`z`" 行（无引用则空行）
scan_project() {
    local project_dir="$1"
    local project_name
    project_name=$(basename "$project_dir")
    local parent_name="videos"

    if [ ! -d "$project_dir/compositions" ]; then
        echo "- \`$parent_name/$project_name/\` 用了：_（无 compositions/ 目录，单文件 index.html）_"
        return 0
    fi

    local -a found=()

    for name in "${BLOCK_NAMES[@]}"; do
        if [ -f "$project_dir/compositions/$name.html" ]; then
            found+=("$name")
        fi
    done

    for name in "${COMPONENT_NAMES[@]}"; do
        if [ -f "$project_dir/compositions/components/$name.html" ]; then
            found+=("$name")
        fi
    done

    if [ ${#found[@]} -gt 0 ]; then
        local joined=""
        for n in "${found[@]}"; do
            joined+="\`$n\`、"
        done
        joined="${joined%、}"
        echo "- \`$parent_name/$project_name/\` 用了：$joined"
    else
        echo "- \`$parent_name/$project_name/\` 用了：_（未引用 catalog 零件，全部自制）_"
    fi
}

# 生成 body（不含 marker），由调用方决定要不要包 marker
generate_body() {
    echo "> 由 \`scripts/refresh-zero-usage.sh\` 自动扫描 \`videos/\` 下所有工程的 \`compositions/*.html\` 和 \`compositions/components/*.html\` 文件名 vs catalog.json 反查得出。重跑：\`bash scripts/refresh-zero-usage.sh --write\`。手动编辑会被下次重跑覆盖。"
    echo ""

    local has_any=false
    for project_dir in "$ROOT"/videos/*/; do
        [ -d "$project_dir" ] || continue
        if ! $has_any; then
            echo "**videos/**"
            echo ""
            has_any=true
        fi
        scan_project "$project_dir"
    done
    $has_any && echo ""
}

if [ "${1:-}" = "--write" ]; then
    if ! grep -q "<!-- AUTO:zero-usage:start" "$INDEX"; then
        echo "ERROR: INDEX.md 里找不到 <!-- AUTO:zero-usage:start --> 标记。" >&2
        echo "请先在 INDEX.md 的'真实工程里用过哪些零件'节插入标记对：" >&2
        echo "  <!-- AUTO:zero-usage:start -->" >&2
        echo "  <!-- AUTO:zero-usage:end -->" >&2
        exit 1
    fi

    body_file=$(mktemp)
    trap 'rm -f "$body_file"' EXIT
    generate_body > "$body_file"

    awk -v content_file="$body_file" '
        /<!-- AUTO:zero-usage:start/ {
            print
            while ((getline line < content_file) > 0) print line
            in_block=1
            next
        }
        /<!-- AUTO:zero-usage:end/ { print; in_block=0; next }
        !in_block { print }
    ' "$INDEX" > "$INDEX.tmp" && mv "$INDEX.tmp" "$INDEX"

    echo "✅ 已更新 $INDEX 中 <!-- AUTO:zero-usage --> 标记之间的内容。"
else
    echo "<!-- AUTO:zero-usage:start - 由 scripts/refresh-zero-usage.sh 生成，勿手动编辑 -->"
    generate_body
    echo "<!-- AUTO:zero-usage:end -->"
fi
