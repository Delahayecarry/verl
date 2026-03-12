#!/bin/bash
# 预处理 GSM8K 数据 (tool-calling 格式)
# 用法:
#   bash preprocess_gsm8k.sh                          # 在线从 HuggingFace 下载
#   bash preprocess_gsm8k.sh ~/data/gsm8k_raw         # 使用本地已下载的数据集

set -x

PROJECT_DIR="$(cd "$(dirname "$0")/../.." && pwd)"
echo "[DEBUG] PROJECT_DIR=$PROJECT_DIR"
cd "$PROJECT_DIR"
echo "[DEBUG] pwd=$(pwd)"

LOCAL_DATASET_PATH="${1:-}"
echo "[DEBUG] LOCAL_DATASET_PATH=$LOCAL_DATASET_PATH"

if [ -n "$LOCAL_DATASET_PATH" ]; then
    # 检查路径是否存在
    if [ ! -d "$LOCAL_DATASET_PATH" ]; then
        echo "[ERROR] 路径不存在: $LOCAL_DATASET_PATH"
        exit 1
    fi
    echo "[DEBUG] 目录内容:"
    ls -la "$LOCAL_DATASET_PATH"
    echo "[DEBUG] 使用本地数据集, HF_DATASETS_OFFLINE=1"
    HF_DATASETS_OFFLINE=1 uv run python examples/data_preprocess/gsm8k_multiturn_w_tool.py \
        --local_dataset_path "$LOCAL_DATASET_PATH" \
        --local_save_dir ~/data/gsm8k
else
    echo "[DEBUG] 在线下载模式"
    uv run python examples/data_preprocess/gsm8k_multiturn_w_tool.py \
        --local_save_dir ~/data/gsm8k
fi

echo "[DEBUG] 退出码: $?"
