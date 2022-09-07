#!/bin/sh
lang_pairs=$1

DROPOUT=$2
MAXTONKENs=$3
echo "Train "$lang_pairs

# IFS='_' read -ra l_pairs <<< $lang_pairs

lang_pairs_c="${lang_pairs//_/,}"

# echo $lang_pairs
# exit

BASE_PATH=endanger_data.$lang_pairs/

DATA_BIN=$BASE_PATH/data_bin/$lang_pairs/
LOG_DIR=results/$BASE_PATH/$lang_pairs/logs

mkdir -p $LOG_DIR


# --share-decoders \
# --share-decoder-input-output-embed \

# --share-encoder-embeddings \
# --share-decoder-embeddings \

python fairseq_cli/train.py $DATA_BIN \
--save-dir checkpoints/endanger_data_$1_$2_$3 \
--arch multilingual_transformer_iwslt_de_en \
--encoder-layers 2 --decoder-layers 2 \
--encoder-attention-heads 4 --decoder-attention-heads 4 \
--encoder-ffn-embed-dim 1024 --decoder-ffn-embed-dim 1024 \
--task multilingual_translation \
--share-encoders \
--share-decoders \
--lang-pairs $lang_pairs_c \
--share-all-embeddings \
--optimizer adam \
--adam-betas '(0.9, 0.98)' \
--clip-norm 0.01 \
--lr 0.0005 \
--lr-scheduler inverse_sqrt \
--encoder-normalize-before --decoder-normalize-before \
--attention-dropout 0.2 --relu-dropout 0.2 \
--min-lr '1e-09' \
--warmup-updates 4000 \
--warmup-init-lr '1e-07' \
--label-smoothing 0.1 \
--criterion label_smoothed_cross_entropy \
--dropout $DROPOUT \
--weight-decay 0.0001 \
--max-tokens $MAXTONKENs \
--update-freq 4 \
--max-epoch 50 \
--no-epoch-checkpoints \
--skip-invalid-size-inputs-valid-test \
--max-source-positions 4096 \
--max-target-positions 4096 \
--encoder-embed-path dict/assign8.txt \
--decoder-embed-path dict/assign8.txt \
--no-embed \
--keep-best-checkpoints 5 | tee $LOG_DIR/train.out


# # ${FAIRSEQ_TRAIN} \
#     $DATA_OUT \
#     --source-lang $SRC_FILE --target-lang $TGT_FILE \
#     --arch transformer --share-all-embeddings \
#     --encoder-layers 5 --decoder-layers 5 \
#     --encoder-embed-dim 512 --decoder-embed-dim 512 \
#     --encoder-ffn-embed-dim 2048 --decoder-ffn-embed-dim 2048 \
#     --encoder-attention-heads 2 --decoder-attention-heads 2 \
#     --encoder-normalize-before --decoder-normalize-before \
#     --dropout 0.4 --attention-dropout 0.2 --relu-dropout 0.2 \
#     --weight-decay 0.0001 \
#     --label-smoothing 0.2 --criterion label_smoothed_cross_entropy \
#     --optimizer adam --adam-betas '(0.9, 0.98)' --clip-norm 0 \
#     --lr-scheduler inverse_sqrt --warmup-updates 4000 --warmup-init-lr 1e-7 \
#     --lr 1e-3 --stop-min-lr 1e-9 \
#     --max-tokens 1000 \
#     --update-freq 4 \
#     --max-epoch $EPOCHS --save-interval 1 \
#     --tensorboard-logdir $LOGS \
#     --save-dir $CHECKPOINTS \
#     --skip-invalid-size-inputs-valid-test