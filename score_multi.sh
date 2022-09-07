#!/usr/bin/env bash
#!/usr/bin/env bash
data=$1
lang_pairs=$2
dropout=$3
gen_subset=$4
checkpoint=$5
tokens=$6
model=${data}_${lang_pairs}_${dropout}_${tokens}

IFS='_' read -ra l_pairs <<< $lang_pairs
lang_pairs_c="${lang_pairs//_/,}"

# BASE_PATH=iwslt$year.$lang_pairs/

# # DATA_BIN=data-bin/moses-bpe-iwslt$YEAR.$lang_pairs/

# data_bin=$BASE_PATH/data_bin/$lang_pairs/
bsz=32


# checkpoint="avg_50k"
checkpoint=$checkpoint


for element in "${l_pairs[@]}"
    do
        echo $element
        IFS='-' read -r -a l_pair <<< $element
        echo "======= calculate bleu score for ${l_pair[0]}-${l_pair[1]} ======="
        ref_file="results/${model}/${gen_subset}/${l_pair[0]}-${l_pair[1]}/${checkpoint}.ref"
        detok_hyp_file="results/${model}/${gen_subset}/${l_pair[0]}-${l_pair[1]}/${checkpoint}.detok_hyp"
        scores_file="results/${model}/${gen_subset}/${l_pair[0]}-${l_pair[1]}/${checkpoint}.scores"
        # rm ${scores_file}
        if [[ ${l_pair[0]} == 'ja' ]]
        then
            echo ${l_pair[0]}
            echo "tokeize is ja-mecab"
            sacrebleu ${ref_file} --metrics bleu --tokenize ja-mecab < ${detok_hyp_file} >> ${scores_file}
        elif [[ ${l_pair[0]} == 'zh' ]]
        then
            echo ${l_pair[0]}
            echo "tokeize is zh"
            sacrebleu ${ref_file} --metrics bleu --tokenize zh < ${detok_hyp_file} >> ${scores_file}
        else
            echo ${l_pair[0]}
            echo "tokeize is 13a"
            sacrebleu ${ref_file} --metrics bleu --tokenize 13a < ${detok_hyp_file} >> ${scores_file}
        fi
        # sacrebleu ${ref_file} --metrics chrf --tokenize none --chrf-word-order 1 < ${detok_hyp_file} >> ${scores_file}
        # sacrebleu ${ref_file} --metrics chrf --tokenize none --chrf-whitespace --chrf-word-order 1 < ${detok_hyp_file} >> ${scores_file}
        # sacrebleu ${ref_file} --metrics chrf --tokenize none --chrf-word-order 6 < ${detok_hyp_file} >> ${scores_file}
        # sacrebleu ${ref_file} --metrics chrf --tokenize none --chrf-whitespace --chrf-word-order 6 < ${detok_hyp_file} >> ${scores_file}
        # sacrebleu ${ref_file} --metrics chrf --tokenize none --chrf-word-order 9 < ${detok_hyp_file} >> ${scores_file}
        # sacrebleu ${ref_file} --metrics chrf --tokenize none --chrf-whitespace --chrf-word-order 9 < ${detok_hyp_file} >> ${scores_file}
        # sacrebleu ${ref_file} --metrics chrf --tokenize none --chrf-word-order 12 < ${detok_hyp_file} >> ${scores_file}
        # sacrebleu ${ref_file} --metrics chrf --tokenize none --chrf-whitespace --chrf-word-order 12 < ${detok_hyp_file}>> ${scores_file}
        sacrebleu ${ref_file} --metrics chrf --tokenize none < ${detok_hyp_file} >> ${scores_file}
        sacrebleu ${ref_file} --metrics chrf --tokenize none --chrf-whitespace < ${detok_hyp_file} >> ${scores_file}

    done
    echo "======= Done calculating bleu score for ${l_pair[0]}-${l_pair[1]} ======="
