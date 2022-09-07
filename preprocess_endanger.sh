#!/bin/sh
lang_pairs=$1
echo "Train "$lang_pairs

# python --version
# which python
# python -m site

BASE_PATH=endanger_data.$1/
TEXT=$BASE_PATH

DATA_BIN=$BASE_PATH/data_bin/$lang_pairs/
LOG_DIR=$BASE_PATH/log/$lang_pairs/
CPKT_DIR=$BASE_PATH/checkpoint/$lang_pairs/
RESULT_DIR=$BASE_PATH/result/$lang_pairs/
mkdir -p $CPKT_DIR $DATA_BIN $LOG_DIR $RESULT_DIR $TEXT

cp dict/* $DATA_BIN

IFS='_' read -ra l_pairs <<< $lang_pairs

for element in "${l_pairs[@]}"
    do
        echo $element
        IFS='-' read -r -a l_pair <<< $element

        PARAM="--source-lang ${l_pair[0]} \
        --target-lang ${l_pair[1]} \
        --tgtdict $DATA_BIN/dict_combined.txt \
        --srcdict $DATA_BIN/dict_combined.txt \
        --trainpref $TEXT/train.${l_pair[0]}-${l_pair[1]} \
        --validpref $TEXT/dev.${l_pair[0]}-${l_pair[1]} \
        --destdir $DATA_BIN \
        --workers 20"

        # echo $PARAM
        # exit

        mkdir -p $LOG_DIR/${l_pair[0]}-${l_pair[1]}/

        python fairseq_cli/preprocess.py $PARAM | tee $LOG_DIR/${l_pair[0]}-${l_pair[1]}/prepro.out
    done

# echo "Preprocess "$SRC1\_$TRG
# PARAM1="--source-lang $SRC1 \
# --target-lang $TRG \
# --tgtdict $DATA_BIN/dict.txt \
# --srcdict $DATA_BIN/dict.txt \
# --trainpref $TEXT/train.$SRC1-$TRG \
# --validpref $TEXT/valid.$SRC1-$TRG \
# --testpref $TEXT/test.$SRC1-$TRG \
# --destdir $DATA_BIN \
# --workers 20"

# echo $PARAM1

# python fairseq_cli/preprocess.py $PARAM1 | tee $LOG_DIR/prepro.out

# echo "Preprocess "$SRC2\_$TRG
# PARAM2="--source-lang $SRC2 \
# --target-lang $TRG \
# --tgtdict $DATA_BIN/dict.txt \
# --srcdict $DATA_BIN/dict.txt \
# --trainpref $TEXT2/train.$SRC2-$TRG \
# --validpref $TEXT2/valid.$SRC2-$TRG \
# --testpref $TEXT2/test.$SRC2-$TRG \
# --destdir $DATA_BIN \
# --workers 20"

# python fairseq_cli/preprocess.py $PARAM2 | tee -a $LOG_DIR/prepro.out