#!/usr/bin/env bash
data=$1
lang_pairs=$2
dropout=$3
gen_subset=$4
checkpoint=$5
tokens=$6
model=${data}_${lang_pairs}_${dropout}_${tokens}

IFS='_' read -ra l_pairs <<< $lang_pairs

BASE_PATH=$data.$lang_pairs
lang_pairs_c="${lang_pairs//_/,}"
# DATA_BIN=data-bin/moses-bpe-iwslt$YEAR.$lang_pairs/

data_bin=$BASE_PATH/data_bin/$lang_pairs
bsz=16
echo "model is ${model}"
echo "gen_subset ${gen_subset}"

# action="detok_moses"

# bash embeddingless_scripts/avg_checkpoints.sh $model 50k
# checkpoint="last"
bash embeddingless_scripts/avg_checkpoints.sh $model 50k
# checkpoint="avg_50k"
checkpoint=$checkpoint

for element in "${l_pairs[@]}"
    do
        echo $element
        IFS='-' read -r -a l_pair <<< $element
        echo "======= generate data for ${l_pair[0]}-${l_pair[1]} ======="
        gen_file="results/${model}/${gen_subset}/${l_pair[0]}-${l_pair[1]}/${checkpoint}.gen"
        ref_file="results/${model}/${gen_subset}/${l_pair[0]}-${l_pair[1]}/${checkpoint}.ref"
        hyp_file="results/${model}/${gen_subset}/${l_pair[0]}-${l_pair[1]}/${checkpoint}.hyp"
        detok_hyp_file="results/${model}/${gen_subset}/${l_pair[0]}-${l_pair[1]}/${checkpoint}.detok_hyp"
        echo "gen_file ${gen_file}"
        echo "ref_file ${ref_file}"
        echo "hyp_file ${hyp_file}"
        echo "detok_hyp_file ${detok_hyp_file}"


        # D:\mengjiao\workspace\python2021\EmbeddinglessNMT_ensemble\iwslt17.fr-en\data_bin\fr_utf-8_en\ensemble

        mkdir -p results/${model}/${gen_subset}/${l_pair[0]}-${l_pair[1]}

        python fairseq_cli/generate.py $data_bin/ \
        --task multilingual_translation \
        --lang-pairs $lang_pairs_c \
        --source-lang ${l_pair[0]} --target-lang ${l_pair[1]} \
        --path checkpoints/${model}/checkpoint_${checkpoint}.pt \
        --batch-size ${bsz} \
        --beam 5 \
        --sacrebleu \
        --gen-subset ${gen_subset} \
        --max-len-a 0 --max-len-b 500 --max-source-positions 10000 \
        --remove-bpe \
        --max-target-positions 10000 > ${gen_file} 

        cat ${gen_file} | grep -P "^T" | sort -k 1,1 | cut -f 2 > ${ref_file}
        cat ${gen_file} | grep -P "^H" | sort -k 1,1 | cut -f 3 > ${hyp_file}
        cat ${gen_file} | grep -P "^D" | sort -k 1,1 | cut -f 3 > ${detok_hyp_file}


        if [[ ${action} == *"detok_moses"* ]] ; then
            echo "detokenizing moses.."
            moses_detokenizer="perl mosesdecoder/scripts/tokenizer/detokenizer.perl"
            $moses_detokenizer < ${ref_file} > ${ref_file}.detok ;
            mv ${ref_file}.detok ${ref_file}
            $moses_detokenizer < ${hyp_file} > ${hyp_file}.detok ;
            mv ${hyp_file}.detok ${hyp_file}
            $moses_detokenizer < ${detok_hyp_file} > ${detok_hyp_file}.detok ;
            mv ${detok_hyp_file}.detok ${detok_hyp_file}
        fi
    done
    echo "======= Done generating data for ${l_pair[0]}-${l_pair[1]} ======="


