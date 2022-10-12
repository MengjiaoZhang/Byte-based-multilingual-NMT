# BMNMT: Byte-based Multilingual Neural Machine Translation

Byte-based Multilingual Neural Machine Translation (BMNMT) is trained wilth multilple language pairs with byte-based tokenization.
This repo can be used to reproduce the experiments in the [BMNMT paper][paper].

## Table of Contents

* [Languages covered](#languages-covered)
* [Results](#results)
* [Usage](#usage)
  * [Training](#training)
  * [Fine-Tuning](#fine-tuning)
<!-- * [How to Cite](#how-to-cite) -->

## Languages covered

BMNMT uses two main datasets, IWSLT14 and IndCorpus.
The language pairs considered in IWSLT14:
High resource language pairs: Chinese, Arabic, German, Farsi, Turkish to English
Low-resource language pair: Slovenian to English.

The language pairs considered in IndCorpus:
Asháninka, Aymara, Bribri, Guarani, Nahuatl, Otomí, Quechua, Rarámuri, Shipibo-Konibo, Wixarika to Spanish.

## Results

We only list a part of the results here. Please refer to our paper for detailed experimental results.

B-N: byte-based NMT
BMNMT: byte-based Multilingual NMT
W-N: subword-based NMT
W-M: subword-based Multilingual NMT

Results on IWSLT14



|       | Byte (BLEU) |              | Subword (BLEU) |              |
|-------|-------------|--------------|----------------|--------------|
|       | B-N         | BMNMT (Ours) | W-N            | W-M          |
| ar-en | 30.8        | 30.4 (-0.4)  | 30.5           | 28.8 (-1.7)  |
| de-en | 34.4        | 34.2 (-0.2)  | 34.1           | 33.1 (-1.0)  |
| fa-en | 22.7        | 24.2 (+1.5)  | 21.6           | 23.0 (+1.4)  |
| tr-en | 22.8        | 22.5 (-0.3)  | 22.2           | 21.9 (-0.3)  |
| zh-en | 15.8        | 15.8 (+0.0)  | 15.9           | 15.8 (-0.1)  |
| sl-en | 2.2         | 20.7 (+18.5) | 8.9            | 20.2 (+11.3) |
| Avg.  | 21.4        | 24.6 (+3.2)  | 22.2           | 23.8 (+1.6)  |

Results on IndCorpus

|        | Byte (BLEU) |                | Subword (BLEU) |            |
|--------|-------------|----------------|----------------|------------|
|        | B-N         | BMNMT (Ours)   | W-N            | W-M        |
| quy-es | 2.4         | **3.5 (+0.9)** | 3.3            | 2.7 (-0.6) |
| gn-es  | 3.6         | **4.4 (+0.8)** | 2.1            | 3.0 (+0.9) |
| nah-es | 0.2         | **2.6 (+2.4)** | 0.8            | 2.1 (+1.3) |
| shp-es | 0.0         | **3.9 (+3.9)** | 0.3            | 2.8 (+2.5) |
| Avg.   | 1.6         | **3.6 (+2.0)** | 1.6            | 2.7 (+1.1) |

## Install requirments

```
pip install --editable ./
git clone https://github.com/moses-smt/mosesdecoder.git
git clone https://github.com/rsennrich/subword-nmt.git
```

### Training

#### IWSLT 14

IWSLT14 dataset download:
https://wit3.fbk.eu/2014-01

put the datasets in orig/

```text
.
└── byte_based_multilingual_NMT/
    └── orig/
        ├── ar-en
        ├── de-en
        ├── fa-en
        ├── sl-en
        ├── tr-en
        └── zh-en
```

```bash
bash run_iwslt.sh
```


#### IndCorpus
IndCorpus dataset download
https://github.com/AmericasNLP/americasnlp2021/tree/main/data

put the datasets in endanger_data/

```text
.
└── byte_based_multilingual_NMT/
    └── endanger_data/
        ├── aym-es
        ├── bzd-es
        ├── cni-es
        ├── gn-es
        ├── hch-es
        ├── nah-es
        ├── oto-es
        ├── quy-es
        ├── shp-es
        └── tar-es

```
```bash
bash run.sh
```

### Fine-Tuning

The example below shows how to finetune the `mT5-Large` model on the XNLI
zeroshot task. See `finetune_mt5_tasks.sh` for hyperparameter settings for
other tasks.

```bash
bash run_finetune_endanger.sh
```


# How to Cite

If you extend or use this work, please cite the [paper][paper] where it was
introduced:

@inproceedings{zhang-xu-2022-byte,
    title = "Byte-based Multilingual {NMT} for Endangered Languages",
    author = "Zhang, Mengjiao  and
      Xu, Jia",
    booktitle = "Proceedings of the 29th International Conference on Computational Linguistics",
    month = oct,
    year = "2022",
    address = "Gyeongju, Republic of Korea",
    publisher = "International Committee on Computational Linguistics",
    url = "https://aclanthology.org/2022.coling-1.388",
    pages = "4407--4417",
    abstract = "Multilingual neural machine translation (MNMT) jointly trains a shared model for translation with multiple language pairs. However, traditional subword-based MNMT approaches suffer from out-of-vocabulary (OOV) issues and representation bottleneck, which often degrades translation performance on certain language pairs. While byte tokenization is used to tackle the OOV problems in neural machine translation (NMT), until now its capability has not been validated in MNMT. Additionally, existing work has not studied how byte encoding can benefit endangered language translation to our knowledge. We propose a byte-based multilingual neural machine translation system (BMNMT) to alleviate the representation bottleneck and improve translation performance in endangered languages. Furthermore, we design a random byte mapping method with an ensemble prediction to enhance our model robustness. Experimental results show that our BMNMT consistently and significantly outperforms subword/word-based baselines on twelve language pairs up to +18.5 BLEU points, an 840{\%} relative improvement.",
}

[paper]: https://aclanthology.org/2022.coling-1.388.pdf