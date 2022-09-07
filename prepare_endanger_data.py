import argparse
import os
from shutil import copyfile as cp
from collections import defaultdict
from string import ascii_lowercase
import math
import copy
from random import shuffle


prefixmap = {
    'utf-8':'',
    'iso-8859-1':'i',
    'GBK':'g',
    'euc-jp':'e',
}


parser = argparse.ArgumentParser(description='Process some integers.')
parser.add_argument('--langpairs', '-lp', metavar='language pairs', type=str, help='language pairs')
parser.add_argument('--dataset', '-d', metavar='dataset', type=str, default='endanger_data', help='dataset type, [iwslt]')
parser.add_argument('--files', '-f', metavar='file-names', type=str, default='train,dev', help='Comma separated filenames')

args = parser.parse_args()
lang_pairs = args.langpairs
lang_pairs_s = lang_pairs.split('_')

l_pairs = []

for pair in lang_pairs_s:
    l_pairs.append(pair.split('-'))

input_path = args.dataset

filenames = args.files.split(',')

# src_dir = '_'.join(srcs)
# tgt_dir = '_'.join(tgts)

output_path = args.dataset+'.'

path_output = output_path+lang_pairs+'/'
if not os.path.exists(path_output):
    os.makedirs(path_output)


for pair in l_pairs:
    # print(pair);exit()
    for filename in filenames:
            print(pair[0]+": "+filename)
            with open(input_path+'/'+pair[0]+'-'+pair[1]+'/'+filename+'.'+pair[0],'r', encoding="utf-8") as input:
                result = list()
                for i, line in enumerate(input):
                    str_encoding = list(map(str, line.strip().encode('utf-8')))
                    str_ = ' '.join(str_encoding)+'\n'
                    # print(str_);exit()
                    result.append(str_)

            with open(path_output+filename+'.'+pair[0]+'-'+pair[1]+'.'+pair[0],'w') as encoding_file:
                encoding_file.writelines(result)

            print(pair[1]+": "+filename)
            with open(input_path+'/'+pair[0]+'-'+pair[1]+'/'+filename+'.'+pair[1],'r', encoding="utf-8") as input:
                result = list()
                for i, line in enumerate(input):
                    str_encoding = list(map(str, line.strip().encode('utf-8')))
                    str_ = ' '.join(str_encoding)+'\n'
                    # print(str_);exit()
                    result.append(str_)

            with open(path_output+filename+'.'+pair[0]+'-'+pair[1]+'.'+pair[1],'w') as encoding_file:
                encoding_file.writelines(result)
            
print("DONE!")