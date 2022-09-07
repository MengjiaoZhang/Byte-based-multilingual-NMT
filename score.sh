#!/usr/bin/env bash
data=$1
src1=$2
src2=$3
tgt=$4
year=$5
dropout=$6
gen_subset=$7
checkpoint=$8
trans_src=$9
model=${data}_${src1}_${src2}_${tgt}_${year}


# checkpoint="avg_50k"
checkpoint=$checkpoint

# baseline="byte_${src}_${tgt}_${year}_${dropout}"
ref_file="results/${model}/${gen_subset}/$trans_src/${checkpoint}.ref"
detok_hyp_file="results/${model}/${gen_subset}/$trans_src/${checkpoint}.detok_hyp"
scores_file="results/${model}/${gen_subset}/$trans_src/${checkpoint}.scores"


# echo "model is ${model}"
# echo "gen_subset ${gen_subset}"
# echo "checkpoint ${checkpoint}"
# echo "ref_file is ${ref_file}"
# echo "hyp_file is ${hyp_file}""
# echo "scores_file is ${scores_file}"

# rm ${scores_file}
sacrebleu ${ref_file} --metrics bleu --tokenize 13a < ${detok_hyp_file} >> ${scores_file}
# sacrebleu ${ref_file} --metrics bleu --tokenize intl < ${hyp_file} >> ${scores_file}
# sacrebleu ${ref_file} --metrics bleu --tokenize zh < ${hyp_file} >> ${scores_file}
# sacrebleu ${ref_file} --metrics bleu --tokenize none < ${hyp_file} >> ${scores_file}
# sacrebleu ${ref_file} --metrics chrf --tokenize none --chrf-word-order 6 < ${hyp_file} >> ${scores_file}
# sacrebleu ${ref_file} --metrics chrf --tokenize none --chrf-whitespace --chrf-word-order 6 < ${hyp_file} >> ${scores_file}
# sacrebleu ${ref_file} --metrics chrf --tokenize none --chrf-word-order 9 < ${hyp_file} >> ${scores_file}
# sacrebleu ${ref_file} --metrics chrf --tokenize none --chrf-whitespace --chrf-word-order 9 < ${hyp_file} >> ${scores_file}
# sacrebleu ${ref_file} --metrics chrf --tokenize none --chrf-word-order 12 < ${hyp_file} >> ${scores_file}
# sacrebleu ${ref_file} --metrics chrf --tokenize none --chrf-whitespace --chrf-word-order 12 < ${hyp_file} >> ${scores_file}

# cat ${scores_file}

# sacrebleu ref_file -i hyp_file --tokenize 13a