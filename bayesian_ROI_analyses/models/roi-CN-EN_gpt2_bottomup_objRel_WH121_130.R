## Script for fitting brms
## fits a series of GPT2 surprisal and bottomup and object relative and WH
#ROI-level models

###########
## Setup ##
###########

# Load libraries
library(tidyverse)
library(brms)

# Settings
Nchains   <- 4    # = number of chains
Nthreads  <- 8
Ncores    <- 32   # Nchains * Nthreads; = number of cores allocated

options(mc.cores = Ncores) 

my_priors <- c(prior(normal(0, 1), class='Intercept'),
               prior(normal(0, 2.5), class='b'),
	       prior(student_t(3, 0, 2.5), class='sigma') 
               ,prior(exponential(1), class='sd')
               )


######################
## Load data as "d" ##
######################

load('../CN-EN-roi-regressor-timeseries_7Aug2022.rData')


combined$subject <- as.factor(combined$subject)


##############################################
## Fit models in ROIS for comparison        ## 
##############################################
# - YES slope covariances to improve fit quality
# - No random intercept by-subjects/section/lang
#   b/c all ROI datasets are z-scored by subject/section/lang 




#create a 'list' to store all of the fitted models in
fits <- list()

#make separate list of models inside model list for each roi
#for (roi in areas_of_interest){
#  fits[[roi]] <- list()
#}


#create a list for all of our 'effects'
efx <- c('word_rate + rms + freq + f0 + gpt2_surprisal + projective_bottomup + obj_relatives + WH')

#give short names to all of the 'effects'
efx_names <- c('gpt2_bottomup_objRel_WH')


areas_of_interest =c('L_STSdp_ROI','L_STSda_ROI','L_STSvp_ROI','L_STSva_ROI','L_STGa_ROI','L_TGd_ROI','L_TE1a_ROI','L_TE1m_ROI','L_TE1p_ROI','L_PHT_ROI','L_TPOJ1_ROI','L_TPOJ2_ROI','L_44_ROI','L_45_ROI','L_47l_ROI','L_47s_ROI','L_47m_ROI','L_a47r_ROI','L_p47r_ROI','L_TE2a_ROI','L_TGv_ROI','L_PGi_ROI','L_PGs_ROI','L_PFm_ROI','L_IFJa_ROI','L_IFJp_ROI','L_8C_ROI','L_PEF_ROI','L_55b_ROI','L_FEF_ROI','L_6a_ROI','L_p9-46v_ROI',
'L_6ma_ROI','L_i6-8_ROI','L_8Av_ROI','L_s6-8_ROI','L_8Ad_ROI','L_46_ROI','L_9p_ROI','L_9-46d_ROI','L_IFSp_ROI','L_IFSa_ROI','L_a9-46v_ROI','L_9a_ROI','L_p10p_ROI','L_10d_ROI','L_a10p_ROI','L_10pp_ROI','L_11l_ROI','L_10v_ROI','L_OFC_ROI','L_13l_ROI','L_A5_ROI','L_A4_ROI','L_STV_ROI','L_LIPv_ROI','L_LIPd_ROI','L_IP2_ROI','L_IP1_ROI','L_PSL_ROI','L_6r_ROI','L_MIP_ROI','L_pOFC_ROI','L_6mp_ROI','L_p24_ROI',
'L_25_ROI','L_s32_ROI','L_10r_ROI','L_10v_ROI','L_a24_ROI','L_p32_ROI','L_10d_ROI','L_d32_ROI','L_9m_ROI','L_a32pr_ROI','L_8BM_ROI','L_8BL_ROI','L_a24pr_ROI','L_33pr_ROI','L_p24pr_ROI','L_p32pr_ROI','L_SFL_ROI','L_24dv_ROI','L_SCEF_ROI','L_23d_ROI','L_31a_ROI','L_d23ab_ROI','L_31pv_ROI','L_31pd_ROI','L_PCV_ROI','L_7Am_ROI','L_7Pm_ROI','L_POS2_ROI','L_7m_ROI','L_v23ab_ROI','L_RSC_ROI','L_7PL_ROI','L_VIP_ROI',
   
'R_STSdp_ROI','R_STSda_ROI','R_STSvp_ROI','R_STSva_ROI','R_STGa_ROI','R_TGd_ROI','R_TE1a_ROI','R_TE1m_ROI','R_TE1p_ROI','R_PHT_ROI','R_TPOJ1_ROI','R_TPOJ2_ROI','R_44_ROI','R_45_ROI','R_47l_ROI','R_47s_ROI','R_47m_ROI','R_a47r_ROI','R_p47r_ROI','R_TE2a_ROI','R_TGv_ROI','R_PGi_ROI','R_PGs_ROI','R_PFm_ROI','R_IFJa_ROI','R_IFJp_ROI','R_8C_ROI','R_PEF_ROI','R_55b_ROI','R_FEF_ROI','R_6a_ROI','R_p9-46v_ROI','R_6ma_ROI',
'R_i6-8_ROI','R_8Av_ROI','R_s6-8_ROI','R_8Ad_ROI','R_46_ROI','R_9p_ROI','R_9-46d_ROI','R_IFSp_ROI','R_IFSa_ROI','R_a9-46v_ROI','R_9a_ROI','R_p10p_ROI','R_10d_ROI','R_a10p_ROI','R_10pp_ROI','R_11l_ROI','R_10v_ROI','R_OFC_ROI','R_13l_ROI','R_A5_ROI','R_A4_ROI','R_STV_ROI','R_LIPv_ROI','R_LIPd_ROI','R_IP2_ROI','R_IP1_ROI','R_PSL_ROI','R_6r_ROI','R_MIP_ROI','R_pOFC_ROI','R_6mp_ROI','R_p24_ROI','R_25_ROI','R_s32_ROI',
'R_10r_ROI','R_10v_ROI','R_a24_ROI','R_p32_ROI','R_10d_ROI','R_d32_ROI','R_9m_ROI','R_a32pr_ROI','R_8BM_ROI','R_8BL_ROI','R_a24pr_ROI','R_33pr_ROI','R_p24pr_ROI','R_p32pr_ROI','R_SFL_ROI','R_24dv_ROI','R_SCEF_ROI','R_23d_ROI','R_31a_ROI','R_d23ab_ROI','R_31pv_ROI','R_31pd_ROI','R_PCV_ROI','R_7Am_ROI','R_7Pm_ROI','R_POS2_ROI','R_7m_ROI','R_v23ab_ROI','R_RSC_ROI','R_7PL_ROI','R_VIP_ROI'
)



for (current_roi in areas_of_interest[121:130]){

 
  print(paste("Starting on new ROI: ",current_roi))
  #subset the data here
  sb <- combined %>%
    filter( roi == current_roi) %>%
    droplevels()
  print(paste("Unique ROI values in the 'sb' subset: ", unique(sb$roi)))
  
  #index into our list of effects formulas/names
  for (i in 1:length(efx)){
    
    print(paste("About to model with ROI: ",current_roi))
    print(paste("The name for the next efx: ",efx_names[i]))
    
    #make a new list inside of our current roi to store the model,
    #leaving room to later add LOO
    fits[[current_roi]][[efx_names[i]]] <- list()
    
    # model formula
    form <- bf(
      paste('bold ~ ',
            paste(efx[i], collapse=' + '),
            ' + language ', 
            '+ WH:language + obj_relatives:language + (0 + word_rate + rms + freq + f0 + gpt2_surprisal + projective_bottomup  + WH + obj_relatives | subject)',
            sep='')
      #,decomp="QR"
    )
    
    print(form)
    
    #fit the model and place it into the list of fitted models
    fits[[current_roi]][[efx_names[i]]][['model']] <-  brm(form,
                                                           data=sb,
							   sample_prior = TRUE,
                                                           prior = my_priors,
                                                           chains = Nchains,
                                                           cores = Nchains, # set to number of chains
                                                           threads = threading(Nthreads),
                                                           control = list(adapt_delta = 0.8,  # default is 0.8
                                                                          max_treedepth=10) ,   # default is 10
                                                           backend = 'cmdstanr',
    )
    
    print(summary(fits[[current_roi]][[efx_names[i]]][['model']]))
    

    #save out
    save(fits, file='CN-EN_roi_gpt2_bottomup_objRelWH121_130.rData')

    
  }
}





   

sessionInfo()