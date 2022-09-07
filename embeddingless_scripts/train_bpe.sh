python train.py data-bin/moses-bpe-iwslt$3.$1-$2 \
--save-dir checkpoints/bpe_$1_$2_$3_$4 \
--tensorboard-logdir tensorboard/bpe_$1_$2_$3_$4 \
--arch transformer_iwslt_de_en \
--share-all-embeddings   \
--optimizer adam \
--adam-betas '(0.9, 0.98)' \
--clip-norm 0.0 \
--lr 5e-4 \
--lr-scheduler inverse_sqrt \
--warmup-updates 4000 \
--min-lr '1e-09' \
--warmup-init-lr '1e-07' \
--label-smoothing 0.1 \
--dropout $4 \
--weight-decay 0.0001  \
--criterion label_smoothed_cross_entropy \
--max-tokens $5 \
--max-update 50000 \
--no-epoch-checkpoints \
--update-freq 8 \
--keep-best-checkpoints 5