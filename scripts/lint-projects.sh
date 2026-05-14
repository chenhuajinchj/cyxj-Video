#!/bin/bash
# lint-projects.sh
#
# 检查所有视频工程目录的 meta.json 是否存在、state 字段是否合规。
# 标志为"视频工程"的条件：目录内含 hyperframes.json 文件。
#
# 用法：
#   bash scripts/lint-projects.sh           # 只检查不修
#
# 排除：hyperframes-student-kit/、hyperframes-launches/、node_modules/
#
# 当前阶段（阶段 1）：所有工程都还没有 meta.json，输出会是一长串 "缺 meta.json"。
# 这是正常的——阶段 2 才开始批量补。

set -e
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
VALID_STATES="draft in-progress done archived superseded"

# 扫所有含 hyperframes.json 的目录（=视频工程标志）
find "$ROOT" \
  \( \
    -type d -name '.git' -o \
    -type d -name 'node_modules' -o \
    -type d -name 'hyperframes-student-kit' -o \
    -type d -name 'hyperframes-launches' -o \
    -type d -name '.thumbnails' -o \
    -type d -name '.claude' \
  \) -prune -o \
  -type f -name 'hyperframes.json' -print 2>/dev/null | while read -r hf; do
    project_dir=$(dirname "$hf")
    slug=$(basename "$project_dir")
    meta="$project_dir/meta.json"

    if [ ! -f "$meta" ]; then
      echo "❌ $slug — 缺 meta.json"
      continue
    fi

    state=$(python3 -c "
import json, sys
try:
  print(json.load(open('$meta')).get('state', ''))
except Exception as e:
  print('', file=sys.stderr)
  print('')
" 2>/dev/null || echo "")

    if [ -z "$state" ]; then
      echo "⚠️  $slug — meta.json 没有 state 字段"
    elif ! echo " $VALID_STATES " | grep -q " $state "; then
      echo "❌ $slug — state='$state' 不在合法值 [$VALID_STATES] 内"
    else
      echo "✅ $slug — state=$state"
    fi
done

