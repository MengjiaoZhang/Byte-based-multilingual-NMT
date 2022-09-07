

bash prepare_endanger_data.sh gn-es_quy-es_nah-es_shp-es
python build_dict.py --langpairs gn-es_quy-es_nah-es_shp-es --dataset endanger_data
python combine_dict.py
bash preprocess_endanger.sh gn-es_quy-es_nah-es_shp-es
bash train_multilingual.sh gn-es_quy-es_nah-es_shp-es 0.2 3000
bash evaluate_multi.sh endanger_data gn-es_quy-es_nah-es_shp-es 0.2 valid avg_50k 3000
bash score_multi.sh endanger_data gn-es_quy-es_nah-es_shp-es 0.2 valid avg_50k 3000

# bash prepare_endanger_data.sh gn-es
# # python build_dict.py --langpairs bzd-es --dataset endanger_data
# bash preprocess_endanger.sh gn-es
# bash train_multilingual.sh gn-es 0.2 3000
# bash evaluate_multi.sh endanger_data gn-es 0.2 valid avg_50k 3000
# bash score_multi.sh endanger_data gn-es 0.2 valid avg_50k 3000

# bash prepare_endanger_data.sh quy-es
# # python build_dict.py --langpairs aym-es --dataset endanger_data
# bash preprocess_endanger.sh quy-es
# bash train_multilingual.sh quy-es 0.2 3000
# bash evaluate_multi.sh endanger_data quy-es 0.2 valid avg_50k 3000
# bash score_multi.sh endanger_data quy-es 0.2 valid avg_50k 3000

# bash prepare_endanger_data.sh nah-es
# # python build_dict.py --langpairs gn-es --dataset endanger_data
# bash preprocess_endanger.sh nah-es
# bash train_multilingual.sh nah-es 0.2 3000
# bash evaluate_multi.sh endanger_data nah-es 0.2 valid avg_50k 3000
# bash score_multi.sh endanger_data nah-es 0.2 valid avg_50k 3000

# bash prepare_endanger_data.sh shp-es
# # python build_dict.py --langpairs oto-es --dataset endanger_data
# bash preprocess_endanger.sh shp-es
# bash train_multilingual.sh shp-es 0.2 3000
# bash evaluate_multi.sh endanger_data shp-es 0.2 valid avg_50k 3000
# bash score_multi.sh endanger_data shp-es 0.2 valid avg_50k 3000

# bash prepare_endanger_data.sh tar-es
# # python build_dict.py --langpairs oto-es --dataset endanger_data
# bash preprocess_endanger.sh tar-es
# bash train_multilingual.sh tar-es 0.2 3000
# bash evaluate_multi.sh endanger_data tar-es 0.2 valid avg_50k 3000
# bash score_multi.sh endanger_data tar-es 0.2 valid avg_50k 3000

# # "--------------------------------------------------------------"

# bash prepare_endanger_data.sh bzd-es
# # python build_dict.py --langpairs bzd-es --dataset endanger_data
# bash preprocess_endanger.sh bzd-es
# bash train_multilingual.sh bzd-es 0.2 3000
# bash evaluate_multi.sh endanger_data bzd-es 0.2 valid avg_50k 3000
# bash score_multi.sh endanger_data bzd-es 0.2 valid avg_50k 3000

# bash prepare_endanger_data.sh aym-es
# # python build_dict.py --langpairs aym-es --dataset endanger_data
# bash preprocess_endanger.sh aym-es
# bash train_multilingual.sh aym-es 0.2 3000
# bash evaluate_multi.sh endanger_data aym-es 0.2 valid avg_50k 3000
# bash score_multi.sh endanger_data aym-es 0.2 valid avg_50k 3000

# bash prepare_endanger_data.sh oto-es
# # python build_dict.py --langpairs oto-es --dataset endanger_data
# bash preprocess_endanger.sh oto-es
# bash train_multilingual.sh oto-es 0.2 3000
# bash evaluate_multi.sh endanger_data oto-es 0.2 valid avg_50k 3000
# bash score_multi.sh endanger_data oto-es 0.2 valid avg_50k 3000

# bash prepare_endanger_data.sh cni-es
# # python build_dict.py --langpairs bzd-es --dataset endanger_data
# bash preprocess_endanger.sh cni-es
# bash train_multilingual.sh cni-es 0.2 3000
# bash evaluate_multi.sh endanger_data cni-es 0.2 valid avg_50k 3000
# bash score_multi.sh endanger_data cni-es 0.2 valid avg_50k 3000

# bash prepare_endanger_data.sh hch-es
# # python build_dict.py --langpairs aym-es --dataset endanger_data
# bash preprocess_endanger.sh hch-es
# bash train_multilingual.sh hch-es 0.2 3000
# bash evaluate_multi.sh endanger_data hch-es 0.2 valid avg_50k 3000
# bash score_multi.sh endanger_data hch-es 0.2 valid avg_50k 3000