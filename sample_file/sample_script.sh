#!/bin/bash
# Bash サンプルスクリプト

# 外部ファイルの読み込み
echo "Reading config.json..."
CONFIG=$(cat sample_external/config.json)
echo "Config: $CONFIG"

# ループ処理
for i in {1..5}; do
  echo "Loop iteration: $i"
done

# 関数定義
function greet() {
  echo "Hello, $1!"
}

greet "Alice"
