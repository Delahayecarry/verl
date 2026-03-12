# GSM8K Tool-Calling Agent RL

## 目标
跑通 verl 多轮 agent loop 强化学习 pipeline，理解数据流和训练流程。

## 配置概要
- 模型: Qwen2.5-0.5B-Instruct (小模型，单卡可跑)
- 算法: GRPO (无需 Critic)
- 工具: calc_gsm8k_reward (数学答案验证)
- 硬件: 单卡 RTX 4090 24GB

## 运行步骤

### 1. 预处理数据
```bash
cd /home/carry/myprj/verl
python3 examples/data_preprocess/gsm8k_multiturn_w_tool.py --local_save_dir ~/data/gsm8k
```

### 2. 启动训练
```bash
cd /home/carry/myprj/verl
bash my_experiments/gsm8k_tool/run.sh
```

## 单卡适配要点
- param_offload=True, optimizer_offload=True (优化器状态卸载到 CPU)
- gpu_memory_utilization=0.4 (给训练阶段留显存)
- micro_batch_size=4, rollout.n=4 (降低并发)
- max_prompt/response_length=512 (缩短序列)

## OOM 应急
如果还 OOM，按顺序尝试:
1. gpu_memory_utilization=0.3
2. ppo_micro_batch_size_per_gpu=2
3. rollout.n=2
4. max_response_length=256

## 实验记录

| 日期 | 改动 | reward 趋势 | 备注 |
|------|------|-------------|------|
| | | | |
