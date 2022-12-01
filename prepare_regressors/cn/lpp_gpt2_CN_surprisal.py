##### directories need to be changed if use #####

import numpy as np
import pandas as pd
import io
import torch
from transformers import GPT2Tokenizer, GPT2LMHeadModel
import random
import string
from string import punctuation
import re
from torch import nn
import numpy as np

from transformers import BertTokenizer

tokenizer = BertTokenizer.from_pretrained("uer/gpt2-chinese-cluecorpussmall")
model = GPT2LMHeadModel.from_pretrained("uer/gpt2-chinese-cluecorpussmall")

# get model parameter size: which should be 102068736
print(sum(p.numel() for p in model.parameters()))
print(model.num_parameters())

# read in CN text
lines = []
file = open('/users/irisz/downloads/lpp_rc_wh/lpp_CN_new_sentence.csv','r')
for line in file:
    lines.append(line.strip())
file.close()

# calculate surprisal values
df = pd.DataFrame(data = {'surprisal_word':[] , 'surprisal':[] })

#for sentence in range(2):
for sentence in range(len(lines)):
    start = ['[SEP]']
    split_test_sent = list(lines[sentence].replace(' ',''))[:-1] # remove puncs
    split_test_sent = start + split_test_sent
    print (split_test_sent)

    
    for i in range(len(split_test_sent)-1):
        
        surprisal = 0

        encoded = tokenizer.encode(split_test_sent[:i+1],return_tensors="pt")
        #print (encoded)
        #print (split_test_sent[:i+1])
        out = model(encoded)
        
        probs = nn.functional.softmax(out.logits[0][-1],dim=-1)
        #print (probs)
        
        desired_index = tokenizer.encode(split_test_sent[i+1],return_tensors="pt")
        #print (desired_index[0][1])
        surprisal += -np.log10(probs[desired_index[0][1]].item())
        
       
    
        df = df.append(pd.DataFrame(data = {'surprisal_word': [split_test_sent[i+1]], 
                                                 'surprisal':[surprisal] }),ignore_index=True)
   #     print(f"The surprisal of which is : {surprisal}\n")
        #print("\n")

# save df to file
df.to_csv('/Users/irisz/Downloads/lpp_rc_wh/lpp_surprisal_char.csv', index=False, sep=',')

# read file
df_surp = pd.read_csv('/Users/irisz/Downloads/lpp_rc_wh/lpp_surprisal_char.csv')
df_surp

# read sentence and word sgmentation info
df_reg_1 = pd.read_csv('/Users/irisz/Downloads/lpp_rc_wh/lppCN_word_information_sent_info.csv')
df_reg_1.head()

# get start and end position for words
reg_word = df_reg['word'].tolist()
df_reg['word_len'] = df_reg['word'].apply(lambda x: len(x))
sent_len = df_reg['word_len'].tolist()
id_start = 0
id_end = 0
starts = []
ends = []
for i in range(len(sent_len)):
#for i in range(3):
    id_start = id_end
    id_end = id_start + sent_len[i]
    #print (id_start, id_end)
    starts.append(id_start)
    ends.append(id_end)
df_reg['starts'] = starts
df_reg['ends'] = ends
df_reg.head()


# combine word surprisal from character surprisal
all_surp = []
for i in range(len(df_reg)):
#for i in range(5):
    start = df_reg['starts'].iloc[i]
    end = df_reg['ends'].iloc[i]
    print(start, end)
    if end - start == 1:
        surp_word = surp[start]
    else:
        surp_con = surp[start:end]
        surp_word = sum(surp_con)
    #print (i, surp_word)
    all_surp.append(surp_word)
#all_surp


# add surprisal value to word info dataframe
df_reg_1['surprisal'] = all_surp

# save wanted columns
df_reg_save = df_reg_1[['word', 'lemma', 'onset', 'offset', 'logfreq', 'pos',
       'section', 'top_down', 'bottom_up', 'left_corner','sentence_id', 'surprisal']]
df_reg_save.to_csv('/Users/irisz/Downloads/lpp_rc_wh/lpp_CN_word_surprisal_gpt2.csv', index=False, sep=',')

