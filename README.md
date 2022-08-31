<u>Preparing regressors</u>

- `prepare_regressors/cn/compute_chinese_regressors_github.ipynb` is used to prepare the Chinese regressors.
- `prepare_regressors/en/compute_english_regressors_github.ipynb` is used to prepare the English regressors.


<u>Bayesian ROI analysis</u>
- `bayesian_ROI_analyses/create_en_cn_targets.ipynb` uses the volumetric HCP-MMP1 parcelation mask (`bayesian_ROI_analyses/HCP-MMP_1mm.nii.gz`) and its labels (`bayesian_ROI_analyses/[l|r]h.hcp-mmp-b_colortab.txt`) to extract the English and Chinese parcellation time series.
- `bayesian_ROI_analyses/joint_model_prepare_data.R` is an R script for combining the regressors and brain data so that it is ready for modeling.
