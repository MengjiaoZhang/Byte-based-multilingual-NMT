#!/usr/bin/env bash
bash embeddingless_scripts/train_char.sh en zh 14 0.2 7344
bash embeddingless_scripts/evaluate.sh char en zh 14 0.2 valid
bash embeddingless_scripts/score.sh char en zh 14 0.2 valid
