<u>Preparing regressors</u>

- `prepare_regressors/cn/compute_chinese_regressors_github.ipynb` uses the prosody (`prepare_regressors/cn/annotaion_CN_lppCN_prosody.csv`), word-by-word Chinese GPT2 surprisal value (`prepare_regressors/cn/lpp_CN_word_surprisal_gpt.csv`), and word-by-word syntactic complexity and long-distance dependency annotation (`prepare_regressors/cn/COMPLEXITIES__ch_9apr2022.csv`) source materials to prepare the Chinese regressors.
- `prepare_regressors/en/compute_english_regressors_github.ipynb` uses the F0 (`prepare_regressors/en/*_f0.csv`), word-by-word log lexical frequency (`prepare_regressors/en/*_freq.csv`), root mean squared amplitude of the spoken narration (`prepare_regressors/en/*_RMS.csv`), word-by-word GPT2 surprisal value (`prepare_regressors/en/Prince_gpt2.tsv`), word-by-word syntactic complexity metric (`prepare_regressors/en/disc_proj_en_10jan2022.csv`), and word-by-word long-distance dependency annotation (`prepare_regressors/en/COMPLEXITIES__en_9apr2022.csv`) source materials to prepare the English regressors.


<u>Bayesian ROI analysis</u>
- `bayesian_ROI_analyses/create_en_cn_targets.ipynb` uses the volumetric HCP-MMP1 parcelation mask (`bayesian_ROI_analyses/HCP-MMP_1mm.nii.gz`) and its labels (`bayesian_ROI_analyses/[l|r]h.hcp-mmp-b_colortab.txt`) to extract the English and Chinese parcellation time series.
- `bayesian_ROI_analyses/joint_model_prepare_data.R` is an R script for combining the regressors and brain data so that it is ready for modeling.
- `bayesian_ROI_analyses/models/roi-CN-EN_gpt2_bottomup_objRel_WH*.R` are the R scripts for fitting the by-ROI models.
- `bayesian_ROI_analyses/models/joint_model_analysis.R` loads the fitted models and extracts and compares the coefficient estimates.
