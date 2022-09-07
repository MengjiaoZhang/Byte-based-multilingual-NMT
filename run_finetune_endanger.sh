# ===============                        finetuen on the pretrained model                ==================
# ===============   The languages for the pretrained model: gn-es_quy-es_nah-es_shp-es   ==================



# bash prepare_endanger_data.sh gn-es_quy-es_nah-es_shp-es
# python build_dict.py --langpairs gn-es_quy-es_nah-es_shp-es --dataset endanger_data

# # python build_finetune_dict.py --langpairs aym-es --dataset endanger_data
# # python combine_dict.py
# # bash preprocess_endanger.sh aym-es
# bash finetune_endanger.sh aym-es 14 0.2 3000 8 gn-es_quy-es_nah-es_shp-es
# bash evaluate_multi.sh endanger_data aym-es 0.2 valid avg_50k 3000
# bash score_multi.sh endanger_data aym-es 0.2 valid avg_50k 3000

# python build_finetune_dict.py --langpairs bzd-es --dataset endanger_data
# python combine_dict.py
# bash preprocess_endanger.sh bzd-es
# bash finetune_endanger.sh bzd-es 14 0.2 3000 8 gn-es_quy-es_nah-es_shp-es
# bash evaluate_multi.sh endanger_data bzd-es 0.2 valid avg_50k 3000
# bash score_multi.sh endanger_data bzd-es 0.2 valid avg_50k 3000

# python build_finetune_dict.py --langpairs cni-es --dataset endanger_data
# python combine_dict.py
# bash preprocess_endanger.sh cni-es
# bash finetune_endanger.sh cni-es 14 0.2 3000 8 gn-es_quy-es_nah-es_shp-es
# bash evaluate_multi.sh endanger_data cni-es 0.2 valid avg_50k 3000
# bash score_multi.sh endanger_data cni-es 0.2 valid avg_50k 3000

# python build_finetune_dict.py --langpairs hch-es --dataset endanger_data
# python combine_dict.py
# bash preprocess_endanger.sh hch-es
# bash finetune_endanger.sh hch-es 14 0.2 3000 8 gn-es_quy-es_nah-es_shp-es
# bash evaluate_multi.sh endanger_data hch-es 0.2 valid avg_50k 3000
# bash score_multi.sh endanger_data hch-es 0.2 valid avg_50k 3000

# python build_finetune_dict.py --langpairs oto-es --dataset endanger_data
# python combine_dict.py
# bash preprocess_endanger.sh oto-es
# bash finetune_endanger.sh oto-es 14 0.2 3000 8 gn-es_quy-es_nah-es_shp-es
# bash evaluate_multi.sh endanger_data oto-es 0.2 valid avg_50k 3000
# bash score_multi.sh endanger_data oto-es 0.2 valid avg_50k 3000

# # =====================================================================

# python build_finetune_dict.py --langpairs tar-es --dataset endanger_data
# python combine_dict.py
# bash preprocess_endanger.sh tar-es
# bash finetune_endanger.sh tar-es 14 0.2 3000 8 gn-es_quy-es_nah-es_shp-es
# bash evaluate_multi.sh endanger_data tar-es 0.2 valid avg_50k 3000
# bash score_multi.sh endanger_data tar-es 0.2 valid avg_50k 3000

# python build_finetune_dict.py --langpairs gn-es --dataset endanger_data
# python combine_dict.py
# bash preprocess_endanger.sh gn-es
# bash finetune_endanger.sh gn-es 14 0.2 3000 8 gn-es_quy-es_nah-es_shp-es
# bash evaluate_multi.sh endanger_data gn-es 0.2 valid avg_50k 3000
# bash score_multi.sh endanger_data gn-es 0.2 valid avg_50k 3000

# python build_finetune_dict.py --langpairs quy-es --dataset endanger_data
# python combine_dict.py
# bash preprocess_endanger.sh quy-es
# bash finetune_endanger.sh quy-es 14 0.2 3000 8 gn-es_quy-es_nah-es_shp-es
# bash evaluate_multi.sh endanger_data quy-es 0.2 valid avg_50k 3000
# bash score_multi.sh endanger_data quy-es 0.2 valid avg_50k 3000

# python build_finetune_dict.py --langpairs nah-es --dataset endanger_data
# python combine_dict.py
# bash preprocess_endanger.sh nah-es
# bash finetune_endanger.sh nah-es 14 0.2 3000 8 gn-es_quy-es_nah-es_shp-es
# bash evaluate_multi.sh endanger_data nah-es 0.2 valid avg_50k 3000
# bash score_multi.sh endanger_data nah-es 0.2 valid avg_50k 3000

# python build_finetune_dict.py --langpairs shp-es --dataset endanger_data
# python combine_dict.py
# bash preprocess_endanger.sh shp-es
# bash finetune_endanger.sh shp-es 14 0.2 3000 8 gn-es_quy-es_nah-es_shp-es
# bash evaluate_multi.sh endanger_data shp-es 0.2 valid avg_50k 3000
# bash score_multi.sh endanger_data shp-es 0.2 valid avg_50k 3000


# python build_finetune_dict.py --langpairs cni-es --dataset endanger_data
# python combine_dict.py
# bash preprocess_endanger.sh cni-es
# bash finetune_endanger.sh cni-es 14 0.2 3000 8 gn-es_quy-es_nah-es_shp-es
# bash evaluate_multi.sh endanger_data cni-es 0.2 valid avg_50k 3000
# bash score_multi.sh endanger_data cni-es 0.2 valid avg_50k 3000
# ------------------------------------------------------------------------------------

# bash prepare_endanger_data.sh bzd-es
# python build_finetune_dict.py --langpairs bzd-es --dataset endanger_data
# python combine_dict.py
# bash preprocess_endanger.sh bzd-es
# bash finetune.sh bzd-es 14 0.2 4000 8 ar-en_de-en_fa-en_tr-en_zh-en
# bash evaluate_multi.sh endanger_data bzd-es 0.2 valid avg_50k
# bash score_multi.sh endanger_data bzd-es 0.2 valid avg_50k


# ===============                        finetuen on the pretrained model                  ==================
# ===============   The languages for the pretrained model: ar-en_de-en_fa-en_tr-en_zh-en  ==================
python build_finetune_dict.py --langpairs aym-es --dataset endanger_data
python combine_dict.py
bash preprocess_endanger.sh aym-es
bash finetune.sh aym-es 14 0.2 3000 8 de-en
bash evaluate_multi.sh endanger_data aym-es 0.2 valid avg_50k 3000
bash score_multi.sh endanger_data aym-es 0.2 valid avg_50k 3000

python build_finetune_dict.py --langpairs bzd-es --dataset endanger_data
python combine_dict.py
bash preprocess_endanger.sh bzd-es
bash finetune.sh bzd-es 14 0.2 3000 8 de-en
bash evaluate_multi.sh endanger_data bzd-es 0.2 valid avg_50k 3000
bash score_multi.sh endanger_data bzd-es 0.2 valid avg_50k 3000

python build_finetune_dict.py --langpairs cni-es --dataset endanger_data
python combine_dict.py
bash preprocess_endanger.sh cni-es
bash finetune.sh cni-es 14 0.2 3000 8 de-en
bash evaluate_multi.sh endanger_data cni-es 0.2 valid avg_50k 3000
bash score_multi.sh endanger_data cni-es 0.2 valid avg_50k 3000

python build_finetune_dict.py --langpairs hch-es --dataset endanger_data
python combine_dict.py
bash preprocess_endanger.sh hch-es
bash finetune.sh hch-es 14 0.2 3000 8 de-en
bash evaluate_multi.sh endanger_data hch-es 0.2 valid avg_50k 3000
bash score_multi.sh endanger_data hch-es 0.2 valid avg_50k 3000

python build_finetune_dict.py --langpairs oto-es --dataset endanger_data
python combine_dict.py
bash preprocess_endanger.sh oto-es
bash finetune.sh oto-es 14 0.2 3000 8 de-en
bash evaluate_multi.sh endanger_data oto-es 0.2 valid avg_50k 3000
bash score_multi.sh endanger_data oto-es 0.2 valid avg_50k 3000

=====================================================================

python build_finetune_dict.py --langpairs tar-es --dataset endanger_data
python combine_dict.py
bash preprocess_endanger.sh tar-es
bash finetune.sh tar-es 14 0.2 3000 8 de-en
bash evaluate_multi.sh endanger_data tar-es 0.2 valid avg_50k 3000
bash score_multi.sh endanger_data tar-es 0.2 valid avg_50k 3000

python build_finetune_dict.py --langpairs gn-es --dataset endanger_data
python combine_dict.py
bash preprocess_endanger.sh gn-es
bash finetune.sh gn-es 14 0.2 3000 8 de-en
bash evaluate_multi.sh endanger_data gn-es 0.2 valid avg_50k 3000
bash score_multi.sh endanger_data gn-es 0.2 valid avg_50k 3000

python build_finetune_dict.py --langpairs quy-es --dataset endanger_data
python combine_dict.py
bash preprocess_endanger.sh quy-es
bash finetune.sh quy-es 14 0.2 3000 8 de-en
bash evaluate_multi.sh endanger_data quy-es 0.2 valid avg_50k 3000
bash score_multi.sh endanger_data quy-es 0.2 valid avg_50k 3000

python build_finetune_dict.py --langpairs nah-es --dataset endanger_data
python combine_dict.py
bash preprocess_endanger.sh nah-es
bash finetune.sh nah-es 14 0.2 3000 8 de-en
bash evaluate_multi.sh endanger_data nah-es 0.2 valid avg_50k 3000
bash score_multi.sh endanger_data nah-es 0.2 valid avg_50k 3000

python build_finetune_dict.py --langpairs shp-es --dataset endanger_data
python combine_dict.py
bash preprocess_endanger.sh shp-es
bash finetune.sh shp-es 14 0.2 3000 8 de-en
bash evaluate_multi.sh endanger_data shp-es 0.2 valid avg_50k 3000
bash score_multi.sh endanger_data shp-es 0.2 valid avg_50k 3000

