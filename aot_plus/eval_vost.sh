exp="aotplus"
# exp="debug"
exp="sn_aotl_prevost2_eval_2025.3.30.3"

gpu_num="1"
devices="0"

# model="aott"
# model="aots"
# model="aotb"
# model="aotl"

model="r50_aotl"
# model="r50_deaotl"
	
stage="pre_vost_2"
# stage="pre_vost"


result_path=$(python -c "from tools.get_config import get_config ;cfg = get_config('$stage', '$exp', '$model') ;print(cfg.DIR_RESULT)")
echo "result_path=$result_path"


dataset="vost"


split="val"
eval_name="debug"

CUDA_VISIBLE_DEVICES=${devices} python tools/eval.py --result_path ${result_path} \
	--exp_name ${exp} \
	--stage ${stage} \
	--model ${model} \
	--dataset ${dataset} --split ${split} --gpu_num ${gpu_num} --ms 1.0 \
	--ckpt_path pretrain_models/AOT_EMFS.pth \
	--eval_name ${eval_name} \
	--latter_mem_len 8 \
	--fix_random \
	# --debug_fix_random



result_path="${result_path}/eval/${dataset}/${eval_name}/"
echo "result_path=$result_path"


model_name=$(python -c "from configs.models.$model import ModelConfig ;print(ModelConfig().MODEL_NAME)")
cd ../evaluation
python ./evaluation_method.py --results_path "../aot_plus/${result_path}" --dataset_path ${dataset} --re