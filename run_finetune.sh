bash create_iwslt_data.sh sl-en 14
bash prepare_multilingual_data.sh sl-en iwslt 14
bash preprocess_multi.sh sl-en 14
bash finetune.sh sl-en 14 0.2 4000 8 ar-en_de-en_fa-en_tr-en_zh-en
bash evaluate_multi.sh multilingual sl-en 14 0.2 test avg_50k
bash score_multi.sh multilingual sl-en 14 0.2 test avg_50k