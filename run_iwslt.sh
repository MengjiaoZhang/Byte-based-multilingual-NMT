bash prepare_multilingual_data.sh ar-en_de-en_fa-en_sl-en_tr-en_zh-en iwslt 14
python build_dict.py --langpairs ar-en_de-en_fa-en_sl-en_tr-en_zh-en --dataset iwslt --year 14
bash preprocess_multi.sh ar-en_de-en_fa-en_sl-en_tr-en_zh-en 14
bash train_multilingual.sh ar-en_de-en_fa-en_sl-en_tr-en_zh-en 14 0.2 4000
bash evaluate_multi.sh multilingual ar-en_de-en_fa-en_sl-en_tr-en_zh-en 14 0.2 test avg_50k
bash score_multi.sh multilingual ar-en_de-en_fa-en_sl-en_tr-en_zh-en 14 0.2 test avg_50k