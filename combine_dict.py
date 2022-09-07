import codecs
import os


dict1 = './dict/dict.txt'
dict2 = './dict/dict_endanger.txt'

vocab1 = {}
vocab2 = {}


with codecs.open(dict1,'r',encoding='utf-8') as in_data:
    for line in in_data:
        line = line.strip().split()
        vocab1[line[0]] = int(line[1])

if os.path.exists(dict2):
    with codecs.open(dict2,'r',encoding='utf-8') as in_data:
        for line in in_data:
            line = line.strip().split()
            vocab2[line[0]] = int(line[1])


# print('vocab 1', vocab1)
# print('vocab 2', vocab2)

overlap = {}

for k in vocab2:
    if k in vocab1:
        vocab1[k] += vocab2[k]
        overlap[k] = vocab2[k]

        
        
for k in overlap:     
    vocab2.pop(k)
        

            
target = codecs.open('./dict/dict_combined.txt','w',encoding='utf-8')
for key in vocab1.keys():
    target.write(key+" "+str(vocab1[key])+"\n")
for key in vocab2.keys():
    target.write(key+" "+str(vocab2[key])+"\n")
target.close()