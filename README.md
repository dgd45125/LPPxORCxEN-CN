<u>Preparing regressors</u>

- `prepare_regressors/cn/compute_chinese_regressors_github.ipynb` uses the prosody (`prepare_regressors/cn/annotaion_CN_lppCN_prosody.csv`), word-by-word Chinese GPT2 surprisal value (`prepare_regressors/cn/lpp_CN_word_surprisal_gpt2.csv`), and word-by-word syntactic complexity and long-distance dependency annotation (`prepare_regressors/cn/COMPLEXITIES__ch_9apr2022.csv`) source materials to prepare the Chinese regressors.
  - `prepare_regressors/cn/annotaion_CN_lppCN_prosody.csv`comes from the <a href="https://openneuro.org/datasets/ds003643/versions/2.0.1">Le Petit Prince OpenNEURO repository</a>.
  - `prepare_regressors/cn/lpp_CN_word_surprisal_gpt2.csv` comes from the `prepare_regressors/cn/lpp_gpt2_CN_surprisal.py` script which uses `prepare_regressors/cn/lpp_CN_new_sentence.csv` as the input chinese text and `prepare_regressors/cn/lppCN_word_information_sent_info.csv` for word segmentation.
  - The word-by-word syntactic complexity metric and long-distance dependency annotations from `prepare_regressors/cn/COMPLEXITIES__ch_9apr2022.csv` were created via Deepmind-internal code which cannot be released. The process, however, is described in the paper.

- `prepare_regressors/en/compute_english_regressors_github.ipynb` uses the F0 (`prepare_regressors/en/*_f0.csv`), word-by-word log lexical frequency (`prepare_regressors/en/*_freq.csv`), root mean squared amplitude of the spoken narration (`prepare_regressors/en/*_RMS.csv`), word-by-word GPT2 surprisal value (`prepare_regressors/en/Prince_gpt2.tsv`), word-by-word syntactic complexity metric (`prepare_regressors/en/disc_proj_en_10jan2022.csv`), and word-by-word long-distance dependency annotation (`prepare_regressors/en/COMPLEXITIES__en_9apr2022.csv`) source materials to prepare the English regressors.
  - `prepare_regressors/en/Prince_gpt2.tsv` comes from feeding `prepare_regressors/en/Prince.txt` into <a href="https://cpllab.github.io/lm-zoo/">lm-zoo</a> and getting the surprisals for GPT2.
  - `prepare_regressors/en/*_f0.csv`, `prepare_regressors/en/*_freq.csv`, and `prepare_regressors/en/*_RMS.csv` are chopped up spreadsheets from the annotations provided in the <a href="https://openneuro.org/datasets/ds003643/versions/2.0.1">Le Petit Prince OpenNEURO repository</a>.
  - The word-by-word syntactic complexity metric from `prepare_regressors/en/disc_proj_en_10jan2022.csv` and the long-distance dependency annotations from `prepare_regressors/en/COMPLEXITIES__en_9apr2022.csv` were created via Deepmind-internal code which cannot be released. The process, however, is described in the paper.


<u>Bayesian ROI analysis</u>
- `bayesian_ROI_analyses/create_en_cn_targets.ipynb` uses the volumetric HCP-MMP1 parcelation mask (`bayesian_ROI_analyses/HCP-MMP_1mm.nii.gz`) and its labels (`bayesian_ROI_analyses/[l|r]h.hcp-mmp-b_colortab.txt`) to extract the English and Chinese parcellation time series.
- `bayesian_ROI_analyses/joint_model_prepare_data.R` is an R script for combining the regressors and brain data so that it is ready for modeling.
- `bayesian_ROI_analyses/models/roi-CN-EN_gpt2_bottomup_objRel_WH*.R` are the R scripts for fitting the by-ROI models.
- `bayesian_ROI_analyses/models/joint_model_analysis.R` loads the fitted models and extracts and compares the coefficient estimates.

<u>GLM analyses</u>
- `GLM_analyses/Yeo2011_7Networks_MNI152_FreeSurferConformed1mm_LiberalMask.nii.gz` is a liberal, volumetric cortical mask based on Yeo et al. 2011. It is used to create a binary cortical mask which is used throughout the GLM analyses.
- `univariate_analyses_first_level.ipynb` performs the first level analyses. 
- `univariate_analyses_second_level.ipynb` performs the second level analyses.
