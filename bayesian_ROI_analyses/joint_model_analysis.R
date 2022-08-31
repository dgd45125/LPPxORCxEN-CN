setwd('/scratch/dgd45125/joint_roi/models6_aug/')


# Load libraries
library(tidyverse)
library(brms)
library(cmdstanr)
library(tidybayes)
library(bayesplot)
library(lme4)
library(tidyverse)
library(overlapping)






areas_of_interest = c('L_STSdp_ROI','L_STSda_ROI','L_STSvp_ROI','L_STSva_ROI','L_STGa_ROI','L_TGd_ROI','L_TE1a_ROI','L_TE1m_ROI','L_TE1p_ROI','L_PHT_ROI','L_TPOJ1_ROI','L_TPOJ2_ROI','L_44_ROI','L_45_ROI','L_47l_ROI','L_47s_ROI','L_47m_ROI','L_a47r_ROI','L_p47r_ROI','L_TE2a_ROI','L_TGv_ROI','L_PGi_ROI','L_PGs_ROI','L_PFm_ROI','L_IFJa_ROI','L_IFJp_ROI','L_8C_ROI','L_PEF_ROI','L_55b_ROI','L_FEF_ROI','L_6a_ROI','L_p9-46v_ROI',
'L_6ma_ROI','L_i6-8_ROI','L_8Av_ROI','L_s6-8_ROI','L_8Ad_ROI','L_46_ROI','L_9p_ROI','L_9-46d_ROI','L_IFSp_ROI','L_IFSa_ROI','L_a9-46v_ROI','L_9a_ROI','L_p10p_ROI','L_10d_ROI','L_a10p_ROI','L_10pp_ROI','L_11l_ROI','L_10v_ROI','L_OFC_ROI','L_13l_ROI','L_A5_ROI','L_A4_ROI','L_STV_ROI','L_LIPv_ROI','L_LIPd_ROI','L_IP2_ROI','L_IP1_ROI','L_PSL_ROI','L_6r_ROI','L_MIP_ROI','L_pOFC_ROI','L_6mp_ROI','L_p24_ROI',
'L_25_ROI','L_s32_ROI','L_10r_ROI','L_10v_ROI','L_a24_ROI','L_p32_ROI','L_10d_ROI','L_d32_ROI','L_9m_ROI','L_a32pr_ROI','L_8BM_ROI','L_8BL_ROI','L_a24pr_ROI','L_33pr_ROI','L_p24pr_ROI','L_p32pr_ROI','L_SFL_ROI','L_24dv_ROI','L_SCEF_ROI','L_23d_ROI','L_31a_ROI','L_d23ab_ROI','L_31pv_ROI','L_31pd_ROI','L_PCV_ROI','L_7Am_ROI','L_7Pm_ROI','L_POS2_ROI','L_7m_ROI','L_v23ab_ROI','L_RSC_ROI','L_7PL_ROI','L_VIP_ROI',

'R_STSdp_ROI','R_STSda_ROI','R_STSvp_ROI','R_STSva_ROI','R_STGa_ROI','R_TGd_ROI','R_TE1a_ROI','R_TE1m_ROI','R_TE1p_ROI','R_PHT_ROI','R_TPOJ1_ROI','R_TPOJ2_ROI','R_44_ROI','R_45_ROI','R_47l_ROI','R_47s_ROI','R_47m_ROI','R_a47r_ROI','R_p47r_ROI','R_TE2a_ROI','R_TGv_ROI','R_PGi_ROI','R_PGs_ROI','R_PFm_ROI','R_IFJa_ROI','R_IFJp_ROI','R_8C_ROI','R_PEF_ROI','R_55b_ROI','R_FEF_ROI','R_6a_ROI','R_p9-46v_ROI','R_6ma_ROI',
'R_i6-8_ROI','R_8Av_ROI','R_s6-8_ROI','R_8Ad_ROI','R_46_ROI','R_9p_ROI','R_9-46d_ROI','R_IFSp_ROI','R_IFSa_ROI','R_a9-46v_ROI','R_9a_ROI','R_p10p_ROI','R_10d_ROI','R_a10p_ROI','R_10pp_ROI','R_11l_ROI','R_10v_ROI','R_OFC_ROI','R_13l_ROI','R_A5_ROI','R_A4_ROI','R_STV_ROI','R_LIPv_ROI','R_LIPd_ROI','R_IP2_ROI','R_IP1_ROI','R_PSL_ROI','R_6r_ROI','R_MIP_ROI','R_pOFC_ROI','R_6mp_ROI','R_p24_ROI','R_25_ROI','R_s32_ROI',
'R_10r_ROI','R_10v_ROI','R_a24_ROI','R_p32_ROI','R_10d_ROI','R_d32_ROI','R_9m_ROI','R_a32pr_ROI','R_8BM_ROI','R_8BL_ROI','R_a24pr_ROI','R_33pr_ROI','R_p24pr_ROI','R_p32pr_ROI','R_SFL_ROI','R_24dv_ROI','R_SCEF_ROI','R_23d_ROI','R_31a_ROI','R_d23ab_ROI','R_31pv_ROI','R_31pd_ROI','R_PCV_ROI','R_7Am_ROI','R_7Pm_ROI','R_POS2_ROI','R_7m_ROI','R_v23ab_ROI','R_RSC_ROI','R_7PL_ROI','R_VIP_ROI')




load('CN-EN_roi_gpt2_bottomup_objRelWH1_10.rData')
fixed_interactions_fits <- fits
rm(fits)
load('CN-EN_roi_gpt2_bottomup_objRelWH11_20.rData')
fixed_interactions_fits <- c(fixed_interactions_fits,fits)
rm(fits)
load('CN-EN_roi_gpt2_bottomup_objRelWH21_30.rData')
fixed_interactions_fits <- c(fixed_interactions_fits,fits)
rm(fits)
load('CN-EN_roi_gpt2_bottomup_objRelWH31_40.rData')
fixed_interactions_fits <- c(fixed_interactions_fits,fits)
rm(fits)
load('CN-EN_roi_gpt2_bottomup_objRelWH41_50.rData')
fixed_interactions_fits <- c(fixed_interactions_fits,fits)
rm(fits)
load('CN-EN_roi_gpt2_bottomup_objRelWH51_60.rData')
fixed_interactions_fits <- c(fixed_interactions_fits,fits)
rm(fits)
load('CN-EN_roi_gpt2_bottomup_objRelWH61_70.rData')
fixed_interactions_fits <- c(fixed_interactions_fits,fits)
rm(fits)
load('CN-EN_roi_gpt2_bottomup_objRelWH71_80.rData')
fixed_interactions_fits <- c(fixed_interactions_fits,fits)
rm(fits)
load('CN-EN_roi_gpt2_bottomup_objRelWH81_90.rData')
fixed_interactions_fits <- c(fixed_interactions_fits,fits)
rm(fits)
load('CN-EN_roi_gpt2_bottomup_objRelWH91_100.rData')
fixed_interactions_fits <- c(fixed_interactions_fits,fits)
rm(fits)
load('CN-EN_roi_gpt2_bottomup_objRelWH101_110.rData')
fixed_interactions_fits <- c(fixed_interactions_fits,fits)
rm(fits)
load('CN-EN_roi_gpt2_bottomup_objRelWH111_120.rData')
fixed_interactions_fits <- c(fixed_interactions_fits,fits)
rm(fits)
load('CN-EN_roi_gpt2_bottomup_objRelWH121_130.rData')
fixed_interactions_fits <- c(fixed_interactions_fits,fits)
rm(fits)
load('CN-EN_roi_gpt2_bottomup_objRelWH131_140.rData')
fixed_interactions_fits <- c(fixed_interactions_fits,fits)
rm(fits)
load('CN-EN_roi_gpt2_bottomup_objRelWH141_150.rData')
fixed_interactions_fits <- c(fixed_interactions_fits,fits)
rm(fits)
load('CN-EN_roi_gpt2_bottomup_objRelWH151_160.rData')
fixed_interactions_fits <- c(fixed_interactions_fits,fits)
rm(fits)
load('CN-EN_roi_gpt2_bottomup_objRelWH161_170.rData')
fixed_interactions_fits <- c(fixed_interactions_fits,fits)
rm(fits)
load('CN-EN_roi_gpt2_bottomup_objRelWH171_180.rData')
fixed_interactions_fits <- c(fixed_interactions_fits,fits)
rm(fits)
load('CN-EN_roi_gpt2_bottomup_objRelWH181_190.rData')
fixed_interactions_fits <- c(fixed_interactions_fits,fits)
rm(fits)
load('CN-EN_roi_gpt2_bottomup_objRelWH191_196.rData')
fixed_interactions_fits <- c(fixed_interactions_fits,fits)
rm(fits)




#get the values of interest out

df <- setNames(data.frame(matrix(ncol=21,nrow=0)), 
                 c('roi',
                   
                   'chinese_WH_coef',
                   'chinese_WH_coef_lower',
                   'chinese_WH_coef_upper',
                   
                   'english_WH_coef',
                   'english_WH_coef_lower',
                   'english_WH_coef_upper',
                  
                   'EN-0_WH_BR',
                   
                   'chineseWH_greater_chineseObjRel_coef', 
                   'chineseWH_greater_chineseObjRel_coef_lower', 
                   'chineseWH_greater_chineseObjRel_coef_upper',
                   
                   'englishWH_greater_englishObjRel_coef', 
                   'englishWH_greater_englishObjRel_coef_lower', 
                   'englishWH_greater_englishObjRel_coef_upper', 

                   
                   'chinese_obj_relatives_coef',
                   'chinese_obj_relatives_coef_lower',
                   'chinese_obj_relatives_coef_upper',
                   
                   'english_obj_relatives_coef',
                   'english_obj_relatives_coef_lower',
                   'english_obj_relatives_coef_upper',
             
                   'EN-0_obj_relatives_BR'
                   ))


max_rhat <-  0

i <- 1



for (i in 1:196){
  print(i)
  if (max(rhat(fixed_interactions_fits[[areas_of_interest[i]]]$gpt2_bottomup_objRel_WH$model),na.rm=TRUE) > max_rhat){
    max_rhat <- max(rhat(fixed_interactions_fits[[areas_of_interest[i]]]$gpt2_bottomup_objRel_WH$model),na.rm=TRUE)
  }
  
  posterior <- as_tibble(as.matrix(fixed_interactions_fits[[areas_of_interest[i]]]$gpt2_bottomup_objRel_WH$model))
  CI=0.95
  #CI=0.99
  #CI=0.89
  #CI=0.9999
  
  
  new_row <- c(areas_of_interest[i],
               
               (posterior$b_WH %>% mean_qi(.width=CI))$y, 
               (posterior$b_WH %>% mean_qi(.width=CI))$ymin,
               (posterior$b_WH %>% mean_qi(.width=CI))$ymax,
               
              
               
               ((posterior$b_WH + posterior$`b_WH:languageenglish`) %>% mean_qi(.width=CI))$y,
               ((posterior$b_WH + posterior$`b_WH:languageenglish`) %>% mean_qi(.width=CI))$ymin,
               ((posterior$b_WH + posterior$`b_WH:languageenglish`) %>% mean_qi(.width=CI))$ymax,

               (hypothesis(fixed_interactions_fits[[areas_of_interest[i]]]$gpt2_bottomup_objRel_WH$model,'WH:languageenglish = 0'))$hypothesis$Evid.Ratio,
               
               
               
               ((posterior$b_WH-posterior$b_obj_relatives)%>% mean_qi(.width=CI))$y,
               ((posterior$b_WH-posterior$b_obj_relatives)%>% mean_qi(.width=CI))$ymin, 
               ((posterior$b_WH-posterior$b_obj_relatives)%>% mean_qi(.width=CI))$ymax,
               
               (((posterior$b_WH+ posterior$`b_WH:languageenglish`)-(posterior$b_obj_relatives+ posterior$`b_obj_relatives:languageenglish`))%>% mean_qi(.width=CI))$y,
               (((posterior$b_WH+posterior$`b_WH:languageenglish`)-(posterior$b_obj_relatives+posterior$`b_obj_relatives:languageenglish`))%>% mean_qi(.width=CI))$ymin, 
               (((posterior$b_WH+ posterior$`b_WH:languageenglish`)-(posterior$b_obj_relatives+posterior$`b_obj_relatives:languageenglish`))%>% mean_qi(.width=CI))$ymax,
        
               
                      
               (posterior$b_obj_relatives %>% mean_qi(.width=CI))$y, 
               (posterior$b_obj_relatives %>% mean_qi(.width=CI))$ymin,
               (posterior$b_obj_relatives %>% mean_qi(.width=CI))$ymax,
               
               ((posterior$b_obj_relatives + posterior$`b_obj_relatives:languageenglish`) %>% mean_qi(.width=CI))$y,
               ((posterior$b_obj_relatives + posterior$`b_obj_relatives:languageenglish`) %>% mean_qi(.width=CI))$ymin,
               ((posterior$b_obj_relatives + posterior$`b_obj_relatives:languageenglish`) %>% mean_qi(.width=CI))$ymax,

               
               (hypothesis(fixed_interactions_fits[[areas_of_interest[i]]]$gpt2_bottomup_objRel_WH$model,'obj_relatives:languageenglish = 0'))$hypothesis$Evid.Ratio
               
              )

  
  df[nrow(df)+1,] <- new_row
}  
############################################







thresh <-  0.00
neg_thresh <-  (-0.00)


##### WH
#get the fitted coefficients if the credible interval excludes 0
chinese_WH <- c()
for (i in 1:196){
  
  if (      (as.double(df[i,]$chinese_WH_coef_lower)>thresh && as.double(df[i,]$chinese_WH_coef_upper)>thresh) || (as.double(df[i,]$chinese_WH_coef_lower)<neg_thresh && as.double(df[i,]$chinese_WH_coef_upper)<neg_thresh)   ){

    chinese_WH <- append(chinese_WH, df[i,]$chinese_WH_coef)
  } else{

    chinese_WH <- append(chinese_WH, 0)
  }  

}
write(paste(chinese_WH,collapse=", "),'chinese_WH95.txt')

english_WH <- c()
for (i in 1:196){
  
  if (      (as.double(df[i,]$english_WH_coef_lower)>thresh && as.double(df[i,]$english_WH_coef_upper)>thresh) || (as.double(df[i,]$english_WH_coef_lower)<neg_thresh && as.double(df[i,]$english_WH_coef_upper)<neg_thresh)   ){
  
    english_WH <- append(english_WH, df[i,]$english_WH_coef)
  } else{
  
    english_WH <- append(english_WH, 0)
  }  
  
}
write(paste(english_WH,collapse=", "),'english_WH95.txt')





BR_thresh <- 3.2
intersection_WH <- c()
for (i in 1:196){
  
        #both positive and similarly distributed
  if (      ((as.double(df[i,]$english_WH_coef_lower)>thresh && as.double(df[i,]$english_WH_coef_upper)>thresh) ) &&
            ((as.double(df[i,]$chinese_WH_coef_lower)>thresh && as.double(df[i,]$chinese_WH_coef_upper)>thresh) ) &&
              (as.double(df[i,]$`EN-0_WH_BR`) > BR_thresh) 
            
            
            ){
   
    intersection_WH <- append(intersection_WH, 1)

  }
        #both negative and closely distributed
  else if (    
                 (as.double((df[i,]$english_WH_coef_lower)<thresh && as.double(df[i,]$english_WH_coef_upper)<thresh) ) &&
                 (as.double((df[i,]$chinese_WH_coef_lower)<thresh && as.double(df[i,]$chinese_WH_coef_upper)<thresh) ) 
                 && (as.double(df[i,]$`EN-0_WH_BR`) > BR_thresh)
                 
                 
  ){
   
    intersection_WH <- append(intersection_WH, -1)
  }
  
  
  
  else{
   
    intersection_WH <- append(intersection_WH, 0)
   
  }  
  
}
write(paste(intersection_WH,collapse=", "),'intersection_WH95.txt')










#########################################################################################################


####### ObjRel

#get the fitted coefficients if the credible interval excludes 0
chinese_ObjRel <- c()
for (i in 1:196){
  
  if (      (as.double(df[i,]$chinese_obj_relatives_coef_lower)>thresh && as.double(df[i,]$chinese_obj_relatives_coef_upper)>thresh) || (as.double(df[i,]$chinese_obj_relatives_coef_lower)<neg_thresh && as.double(df[i,]$chinese_obj_relatives_coef_upper)<neg_thresh)   ){
    
    chinese_ObjRel <- append(chinese_ObjRel, df[i,]$chinese_obj_relatives_coef)
  } else{
   
    chinese_ObjRel <- append(chinese_ObjRel, 0)
  }  
  
}
write(paste(chinese_ObjRel,collapse=", "),'chinese_ObjRel95.txt')



english_ObjRel <- c()
for (i in 1:196){
  
  if (      (as.double(df[i,]$english_obj_relatives_coef_lower)>thresh && as.double(df[i,]$english_obj_relatives_coef_upper)>thresh) || (as.double(df[i,]$english_obj_relatives_coef_lower)<neg_thresh && as.double(df[i,]$english_obj_relatives_coef_upper)<neg_thresh)   ){
    
    english_ObjRel <- append(english_ObjRel, df[i,]$english_obj_relatives_coef)
  } else{
   
    english_ObjRel <- append(english_ObjRel, 0)
  }  
  
}
write(paste(english_ObjRel,collapse=", "),'english_ObjRel99.txt')





BR_thresh <- 3.2
intersection_ObjRel <- c()
for (i in 1:196){
  
          #both positive
  if (      
            ((as.double(df[i,]$english_obj_relatives_coef_lower)>thresh && as.double(df[i,]$english_obj_relatives_coef_upper)>thresh) ) &&
            ((as.double(df[i,]$chinese_obj_relatives_coef_lower)>thresh && as.double(df[i,]$chinese_obj_relatives_coef_upper)>thresh) ) 
            && (as.double(df[i,]$`EN-0_obj_relatives_BR`) > BR_thresh) 
            
            
  ){

    intersection_ObjRel <- append(intersection_ObjRel, 1)
  }
        #both negative
  else if (     
                 ((as.double(df[i,]$english_obj_relatives_coef_lower)<thresh && as.double(df[i,]$english_obj_relatives_coef_upper)<thresh) ) &&
                 ((as.double(df[i,]$chinese_obj_relatives_coef_lower)<thresh && as.double(df[i,]$chinese_obj_relatives_coef_upper)<thresh) ) 
                 && (as.double(df[i,]$`EN-0_obj_relatives_BR`) > BR_thresh) 
                 
  ){
    
    intersection_ObjRel <- append(intersection_ObjRel, -1)
  }
  
  
  
  else{
    
    intersection_ObjRel <- append(intersection_ObjRel, 0)
  }  
  
}
write(paste(intersection_ObjRel,collapse=", "),'intersection_ObjRel95.txt')


