#!/usr/bin/env python3 -u
# Copyright (c) Facebook, Inc. and its affiliates.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
"""
Train a new model on one or across multiple GPUs.
"""

import logging
import math
from operator import mod
import sys

import numpy as np
import torch

from fairseq import (
    checkpoint_utils,
    distributed_utils,
    options,
    quantization_utils,
    tasks,
    utils,
)
from fairseq.data import iterators
from fairseq.logging import meters, metrics, progress_bar
from fairseq.model_parallel.megatron_trainer import MegatronTrainer
from fairseq.trainer import Trainer

logging.basicConfig(
    format="%(asctime)s | %(levelname)s | %(name)s | %(message)s",
    datefmt="%Y-%m-%d %H:%M:%S",
    level=logging.INFO,
    stream=sys.stdout,
)
logger = logging.getLogger("fairseq_cli.train")


def main(args):
    utils.import_user_module(args)

    assert (
            args.max_tokens is not None or args.max_sentences is not None
    ), "Must specify batch size either with --max-tokens or --max-sentences"
    metrics.reset()

    np.random.seed(args.seed)
    utils.set_torch_seed(args.seed)

    if distributed_utils.is_master(args):
        checkpoint_utils.verify_checkpoint_directory(args.save_dir)

    # Print args
    logger.info(args)

    # Setup task, e.g., translation, language modeling, etc.
    task = tasks.setup_task(args)

    # Load valid dataset (we load training data below, based on the latest checkpoint)
    for valid_sub_split in args.valid_subset.split(","):
        task.load_dataset(valid_sub_split, combine=False, epoch=1)

    # Build model and criterion

    model = task.build_model(args)

    path_suffix = '/checkpoint_avg_50k.pt'
    save_path_pretrain_suffix = '/multi_pretrain.pt'

    PATH = args.para_path + path_suffix
    PATH_save = args.para_path_save + save_path_pretrain_suffix

    checkpoint = torch.load(PATH)
    model.load_state_dict(checkpoint['model'])

    dict_ar = model.models[args.lang_pairs[0]].state_dict()

    torch.save(dict_ar, PATH_save)

    # model.models[args.lang_pairs[0]].load_state_dict(dict_ar)
    #
    # dict_fa = model.models['fa-en'].state_dict()
    #
    # dict_de = model.models['de-en'].state_dict()

    # dict_ar['encoder.layers.0.self_attn.k_proj.weight'][0,0]= 23.764

    # dict_111 = model.models[args.lang_pairs[-1]].state_dict()

    # for k in model_multi_dict.keys():
    #     print(k)


def get_pretrain_main(modify_parser=None):
    parser = options.get_training_parser()

    parser.add_argument('--para-path', help='pretrained model parameters of multilingual')
    parser.add_argument('--para-path-save', help='pretrained model parameters for finetune')

    args = options.parse_args_and_arch(parser, modify_parser=modify_parser)
    if args.profile:
        with torch.cuda.profiler.profile():
            with torch.autograd.profiler.emit_nvtx():
                distributed_utils.call_main(args, main)
    else:
        distributed_utils.call_main(args, main)


if __name__ == "__main__":
    get_pretrain_main()
