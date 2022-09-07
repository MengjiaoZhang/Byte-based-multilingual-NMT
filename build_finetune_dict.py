from fairseq.data import data_utils, FairseqDataset, iterators, Dictionary
from fairseq.tokenizer import Tokenizer
import re
import argparse

parser = argparse.ArgumentParser(description='Process some integers.')
parser.add_argument('--langpairs', '-lp', metavar='language-pairs', type=str, help='language pairs')
parser.add_argument('--dataset', '-d', metavar='dataset', type=str, default='endanger_data', help='dataset type, [iwslt]')
parser.add_argument('--year', '-y', metavar='year', type=str, default='', help='year')

args = parser.parse_args()
lang_pairs = args.langpairs
lang_pairs_p = lang_pairs.split('_')

l_pairs = []

for pair in lang_pairs_p:
    l_pairs.append(pair.split('-'))

    

def train_path(lang, trainpref):
        return "{}{}".format(trainpref, ("." + lang))

class Tokenizer:
    def __init__(self):
        self.space_normalizer = re.compile(r"\s+")
        self.tokenize_line = self.tokenize_words

    def tokenize_words(self, line):
        line = self.space_normalizer.sub(" ", line)
        line = line.strip()
        return line.split()

    @classmethod
    def build_tokenizer(cls):
        cls.tokenizer = cls()

def tokenize_line(line):
    return Tokenizer.tokenizer.tokenize_line(line)

tokenizer = Tokenizer.build_tokenizer()

# print(l_pairs)
# exit()
filenames = set()
for pair in l_pairs:
    data_path = args.dataset+'.'+lang_pairs
    trainpref = data_path+'/train.'+pair[0]+'-'+pair[1]
    filenames.add(train_path(pair[0], trainpref))
    filenames.add(train_path(pair[1], trainpref))

# data_path_1 = 'examples/translation/'+args.dataset+args.year+'.'+'moses.bpe.'+src1+'-'+tgt
# data_path_2 = 'examples/translation/'+args.dataset+args.year+'.'+'moses.bpe.'+src2+'-'+tgt

# trainpref_1 = data_path_1+'/train.'+src1+'-'+tgt
# trainpref_2 = data_path_2+'/train.'+src2+'-'+tgt



# print(srcs+tgts)

# def tokenize_line(self, line):
#     line = self.space_normalizer.sub(" ", line)
#     line = line.strip()
#     return line.split()

# d = Dictionary()
d_old = Dictionary.load('./dict/dict.txt')
d_endanger = Dictionary()
# print(d)
workers = 1
for filename in filenames:
    Dictionary.add_file_to_dictionary(
        filename, d_endanger, tokenize_line, workers
    )
d_endanger.finalize(threshold=-1, nwords=-1, padding_factor=8)

tgt_dict = d_endanger

d_endanger.save('./dict/dict_endanger.txt')





# with codecs.open(infile,'r',encoding='utf-8') as in_data:
# 	for line in in_data:
# 		line = line.strip().split()
# 		for word in line:
# 			vocab[word] += 1
			
# target = codecs.open(outpath+'/vocab.txt','w',encoding='utf-8')
# for key in vocab.keys():
# 	target.write(key+" : "+str(vocab[key])+"\n")
# target.close()