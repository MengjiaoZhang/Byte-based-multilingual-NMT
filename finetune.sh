#!/bin/sh
finetune_lang_pairs=$1
YEAR=$2
DROPOUT=$3
MAXTONKENs=$4
UPDATE=$5

# BASE_PATH=iwslt$YEAR.$lang_pairs/

# DATA_BIN=$BASE_PATH/data_bin/$lang_pairs/
# LOG_DIR=results/$BASE_PATH/$lang_pairs/logs

# mkdir -p $LOG_DIR


finetune_lang_pairs_c="${finetune_lang_pairs//_/,}"

echo "finetune on "$finetune_lang_pairs

FINETUNE_BASE_PATH=endanger_data.$finetune_lang_pairs/

FINETUNE_DATA_BIN=$FINETUNE_BASE_PATH/data_bin/$finetune_lang_pairs/
LOG_DIR=results/$FINETUNE_BASE_PATH/$finetune_lang_pairs/logs
echo $LOG_DIR

mkdir -p $LOG_DIR


pretrained_lang_pairs=$6
echo "pretrained on "$pretrained_lang_pairs

pretrained_lang_pairs_c="${pretrained_lang_pairs//_/,}"

# IFS=',' read -ra pretrained_l_pairs <<< $pretrained_lang_pairs

PRETRAINED_BASE_PATH=iwslt$YEAR.$pretrained_lang_pairs/

PRETRAINED_DATA_BIN=$PRETRAINED_BASE_PATH/data_bin/$pretrained_lang_pairs/


# param="$PRETRAINED_DATA_BIN \
# --save-dir checkpoints/multilingual_$6_$2_$3 \
# --arch multilingual_transformer_iwslt_de_en \
# --task multilingual_translation \
# --share-decoders \
# --share-encoders \
# --lang-pairs $pretrained_lang_pairs_c \
# --share-all-embeddings \
# --optimizer adam \
# --adam-betas '(0.9, 0.98)' \
# --clip-norm 0.01 \
# --lr 0.0005 \
# --lr-scheduler inverse_sqrt \
# --min-lr '1e-09' \
# --warmup-updates 4000 \
# --warmup-init-lr '1e-07' \
# --label-smoothing 0.1 \
# --criterion label_smoothed_cross_entropy \
# --dropout $3 \
# --weight-decay 0.0001 \
# --max-tokens $4 \
# --update-freq $5 \
# --max-epoch 200 --patience 5 \
# --no-epoch-checkpoints \
# --max-source-positions 4096 \
# --max-target-positions 4096 \
# --keep-best-checkpoints 5 \
# --no-embed \
# --para-path checkpoints/multilingual_$pretrained_lang_pairs\_14_0.2 \
# --para-path-save checkpoints/multilingual_$pretrained_lang_pairs\_14_0.2"

# echo $param

python fairseq_cli/get_pretrained_multilingual_model.py $PRETRAINED_DATA_BIN \
--save-dir checkpoints/multilingual_$6_$2_$3 \
--arch multilingual_transformer_iwslt_de_en \
--task multilingual_translation \
--share-decoders \
--share-encoders \
--lang-pairs $pretrained_lang_pairs_c \
--share-all-embeddings \
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
--dropout $3 \
--weight-decay 0.0001 \
--max-tokens $4 \
--update-freq $5 \
--max-epoch 200 \
--no-epoch-checkpoints \
--max-source-positions 4096 \
--max-target-positions 4096 \
--keep-best-checkpoints 5 \
--no-embed \
--para-path checkpoints/multilingual_$pretrained_lang_pairs\_14_0.2 \
--para-path-save checkpoints/multilingual_$pretrained_lang_pairs\_14_0.2 | tee -a $LOG_DIR/get_pretrained_multilingual_model.out


params="$FINETUNE_DATA_BIN \
--save-dir checkpoints/endanger_$1_$3 \
--arch multilingual_transformer_iwslt_de_en \
--task multilingual_translation \
--share-decoders \
--share-encoders \
--lang-pairs $finetune_lang_pairs_c \
--share-all-embeddings \
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
--dropout $3 \
--weight-decay 0.0001 \
--max-tokens $4 \
--update-freq $5 \
--max-epoch 200 --patience 5 \
--no-epoch-checkpoints \
--max-source-positions 4096 \
--max-target-positions 4096 \
--keep-best-checkpoints 5 \
--no-embed \
--pretrained-lang-pairs $pretrained_lang_pairs \
--para-path checkpoints/multilingual_$pretrained_lang_pairs\_14_0.2"

# echo "parameters are" $params

python fairseq_cli/finetune_multi.py $FINETUNE_DATA_BIN \
--save-dir checkpoints/endanger_data_$1_$3_$4 \
--arch multilingual_transformer_iwslt_de_en \
--task multilingual_translation \
--share-decoders \
--share-encoders \
--lang-pairs $finetune_lang_pairs_c \
--share-all-embeddings \
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
--para-path checkpoints/multilingual_$pretrained_lang_pairs\_14_0.2 | tee -a $LOG_DIR/finetune.out


