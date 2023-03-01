<u>Preparing regressors</u>

- `cn/compute_chinese_regressors_github.ipynb` uses the prosody (`cn/annotaion_CN_lppCN_prosody.csv`), word-by-word Chinese GPT2 surprisal value (`cn/lpp_CN_word_surprisal_gpt2.csv`), and word-by-word syntactic complexity and long-distance dependency annotation (`cn/COMPLEXITIES__ch_9apr2022.csv`) source materials to prepare the Chinese regressors.
  - `cn/annotation_CN_lppCN_prosody.csv`comes from the <a href="https://openneuro.org/datasets/ds003643/versions/2.0.1">Le Petit Prince OpenNEURO repository</a>.
  - `cn/lpp_CN_word_surprisal_gpt2.csv` comes from the `cn/lpp_gpt2_CN_surprisal.py` script which uses `cn/lpp_CN_new_sentence.csv` as the input chinese text and `cn/lppCN_word_information_sent_info.csv` for word segmentation.
  - The word-by-word syntactic complexity metric and long-distance dependency annotations from `cn/COMPLEXITIES__ch_9apr2022.csv` were created via Deepmind-internal code which cannot be released. The process, however, is described in the paper.

- `en/compute_english_regressors_github.ipynb` uses the F0 (`en/*_f0.csv`), word-by-word log lexical frequency (`en/*_freq.csv`), root mean squared amplitude of the spoken narration (`en/*_RMS.csv`), word-by-word GPT2 surprisal value (`en/Prince_gpt2.tsv`), word-by-word syntactic complexity metric (`en/disc_proj_en_10jan2022.csv`), and word-by-word long-distance dependency annotation (`en/COMPLEXITIES__en_9apr2022.csv`) source materials to prepare the English regressors.
  - `en/*_f0.csv`, `en/*_freq.csv`, and `en/*_RMS.csv` are chopped up spreadsheets from the annotations provided in the <a href="https://openneuro.org/datasets/ds003643/versions/2.0.1">Le Petit Prince OpenNEURO repository</a>.
  - `en/Prince_gpt2.tsv` comes from feeding `en/Prince.txt` into <a href="https://cpllab.github.io/lm-zoo/">lm-zoo</a> and getting the GPT2 surprisal values.
  - The word-by-word syntactic complexity metric from `en/disc_proj_en_10jan2022.csv` and the long-distance dependency annotations from `en/COMPLEXITIES__en_9apr2022.csv` were created via Deepmind-internal code which cannot be released. The process, however, is described in the paper.

