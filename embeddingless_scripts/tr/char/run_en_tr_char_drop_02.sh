#!/usr/bin/env bash
bash embeddingless_scripts/train_char.sh en tr 14 0.2 7556
bash embeddingless_scripts/evaluate.sh char en tr 14 0.2 valid
bash embeddingless_scripts/score.sh char en tr 14 0.2 valid
