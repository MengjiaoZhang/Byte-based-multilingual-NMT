import numpy as np
import torch
import torch.nn.functional as F

import pandas as pd

seed = 8
np.random.seed(seed)


def generate_random_dict(num_embeddings, padding_idx, embed_dim):
    one_hot_matrix = F.one_hot(torch.arange(num_embeddings)).float()
    idx = np.arange(4, num_embeddings)
    np.random.shuffle(idx)
    one_hot_matrix[np.arange(4, num_embeddings)] = one_hot_matrix[idx]
    one_hot_embed = torch.cat((one_hot_matrix, torch.zeros((num_embeddings, embed_dim - num_embeddings))), dim=1)
    one_hot_embed[padding_idx] = torch.zeros(embed_dim).unsqueeze(0)


    return one_hot_embed

if __name__ == '__main__':
    # idx = np.arange(1, 10)
    # np.random.shuffle(idx)

    num_embeddings = 176
    padding_idx = 0
    embed_dim = 512

    dict = pd.read_csv('dict.txt', sep=' ', header=None)
    dict.drop(1, inplace=True, axis=1)
    # dict2 = {'<s>', '</pad>', '</s>', '<unk>'}
    dict2 = pd.DataFrame(['<s>', '<pad>', '</s>', '<unk>'])
    dict3 = dict2.append(dict, ignore_index=True)

    one_hot_embed = generate_random_dict(num_embeddings, padding_idx, embed_dim).numpy().tolist()
    # torch.save(one_hot_embed, 'random_assign1.pt')
    dict_new = pd.concat([dict3, pd.DataFrame(one_hot_embed)], axis=1)

    dict_new.columns = [str(num_embeddings), str(embed_dim)] + [''] * (embed_dim-1)

    # create NumPy array for 'blocks'
    # blocks = np.array([2, 3, 1, 0, 2, 7, 8, 2])

    # add 'blocks' array as new column in DataFrame
    # dict3. = blocks.tolist()
    assign_name = 'assign'
    # line1 = str(num_embeddings) + " " + str(embed_dim)
    #
    #
    # with open(assign_name, 'w') as f:
    #     f.writelines(line1 + '\n')
    #     # for i in range()

    dict_new.to_csv(assign_name + str(seed) + '.txt', sep=' ', index=False)