#!/bin/bash
# 预处理 GSM8K 数据 (tool-calling 格式)
cd "$(cd "$(dirname "$0")/../.." && pwd)"
python3 examples/data_preprocess/gsm8k_multiturn_w_tool.py --local_save_dir ~/data/gsm8k
