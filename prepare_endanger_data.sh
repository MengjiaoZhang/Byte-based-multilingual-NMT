#!/bin/sh
lang_pairs=$1
echo "Prepare endangered data "$lang_pairs



# echo "Prepare ensemble data "$SRC\_$ENCODINGS\_$TRG
# PARAM="--source $SRC \
# --target $TGT \
# --encodings_src ${ENCODINGS_SRC} \
# --encodings_tgt ${ENCODINGS_TGT} \
# --input $INPUT_PATH \
# --output $OUTPUT_PATH"

# echo $PARAM

# python fairseq_cli/preprocess.py $PARAM
# python --version
# which python
python prepare_endanger_data.py \
--langpairs $lang_pairs \