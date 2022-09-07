#!/bin/sh
finetune_lang_pairs=$1
YEAR=$2
DROPOUT=$3
MAXTONKENs=$4
UPDATE=$5
echo "finetune on "$finetune_lang_pairs

BASE_PATH=endanger_data.$1/
TEXT=$BASE_PATH

FINETUNE_DATA_BIN=$BASE_PATH/data_bin/$finetune_lang_pairs/

FINETUNE_BASE_PATH=$BASE_PATH/data_bin/$finetune_lang_pairs/

# FINETUNE_DATA_BIN=data-bin/moses-bpe-endanger.$finetune_lang_pairs/
LOG_DIR=results/$FINETUNE_BASE_PATH/$finetune_lang_pairs/logs
echo $LOG_DIR

mkdir -p $LOG_DIR


pretrained_lang_pairs=$6
echo "pretrained on "$pretrained_lang_pairs

IFS='_' read -ra pretrained_l_pairs <<< $pretrained_lang_pairs

pretrained_lang_pairs_c="${pretrained_lang_pairs//_/,}"

# PRETRAINED_BASE_PATH=iwslt$YEAR.$pretrained_lang_pairs/

# PRETRAINED_DATA_BIN=data-bin/moses-bpe-iwslt$YEAR.$pretrained_lang_pairs/
PRETRAINED_DATA_BIN=endanger_data.$pretrained_lang_pairs/data_bin/$pretrained_lang_pairs

# echo $endanger_data_$6_$3_$4
# exit

python fairseq_cli/get_pretrained_multilingual_model.py $PRETRAINED_DATA_BIN \
--save-dir checkpoints/endanger_data_$6_$3_$4 \
--arch multilingual_transformer_iwslt_de_en \
--task multilingual_translation \
--share-decoders \
--share-encoders \
--encoder-layers 2 --decoder-layers 2 \
--encoder-attention-heads 4 --decoder-attention-heads 4 \
--encoder-ffn-embed-dim 1024 --decoder-ffn-embed-dim 1024 \
--lang-pairs $pretrained_lang_pairs_c \
--share-decoder-input-output-embed \
--optimizer adam \
--adam-betas '(0.9, 0.98)' \
--clip-norm 0.01 \
--lr 0.0005 \
--lr-scheduler inverse_sqrt \
--min-lr '1e-09' \
--warmup-updates 4000 \
--warmup-init-lr '1e-07' \
--label-smoothing 0.1 \
--criterion label_smoothed_cross_entropy \
--encoder-normalize-before --decoder-normalize-before \
--attention-dropout 0.2 --relu-dropout 0.2 \
--dropout $3 \
--weight-decay 0.0001 \
--max-tokens $4 \
--update-freq $5 \
--max-epoch 50 \
--no-epoch-checkpoints \
--max-source-positions 4096 \
--max-target-positions 4096 \
--keep-best-checkpoints 5 \
--no-embed \
--para-path checkpoints/endanger_data_$pretrained_lang_pairs\_0.2_$4 \
--para-path-save checkpoints/endanger_data_$pretrained_lang_pairs\_0.2_$4 | tee -a $LOG_DIR/get_pretrained_multilingual_model.out


python fairseq_cli/finetune_multi.py $FINETUNE_DATA_BIN \
--save-dir checkpoints/endanger_data_$1_$3_$4 \
--arch multilingual_transformer_iwslt_de_en \
--task multilingual_translation \
--share-decoders \
--share-encoders \
--encoder-layers 2 --decoder-layers 2 \
--encoder-attention-heads 4 --decoder-attention-heads 4 \
--encoder-ffn-embed-dim 1024 --decoder-ffn-embed-dim 1024 \
--lang-pairs $finetune_lang_pairs \
--share-decoder-input-output-embed \
--optimizer adam \
--adam-betas '(0.9, 0.98)' \
--clip-norm 0.01 \
--lr 0.0005 \
--lr-scheduler inverse_sqrt \
--min-lr '1e-09' \
--warmup-updates 4000 \
--warmup-init-lr '1e-07' \
--label-smoothing 0.1 \
--criterion label_smoothed_cross_entropy \
--encoder-normalize-before --decoder-normalize-before \
--attention-dropout 0.2 --relu-dropout 0.2 \
--dropout $3 \
--weight-decay 0.0001 \
--max-tokens $4 \
--update-freq $5 \
--max-epoch 50 \
--no-epoch-checkpoints \
--max-source-positions 4096 \
--max-target-positions 4096 \
--keep-best-checkpoints 5 \
--no-embed \
--pretrained-lang-pairs $pretrained_lang_pairs \
--para-path checkpoints/endanger_data_$pretrained_lang_pairs\_0.2_$4 | tee -a $LOG_DIR/finetune.out


