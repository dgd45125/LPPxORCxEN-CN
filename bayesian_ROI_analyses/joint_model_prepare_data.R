setwd("/scratch/dgd45125/joint_roi/")

# Load libraries
library(tidyverse)



english_data.path  <- '/scratch/dgd45125/joint_roi/lpp_en_HCPMMP1_volumetric_roi_signals.csv.gz'

english_raw        <- read_csv(english_data.path) %>% rename(subject = subj)
english_pr <- read_tsv('../lpp_en_regressors_19Apr2022.tsv') %>% 
  select(-c(disc_filler_gap, gpt3_surprisal,chinchilla_surprisal))

roi.names <- names(english_raw)[1:360]
con.names <- c('word_rate','rms','freq','f0')
filler_gap.names <- c('obj_relatives','WH')
complexities.names <- c('projective_bottomup')
srp.names <- c('gpt2_surprisal')
all.names = c(con.names, filler_gap.names, complexities.names, srp.names)


#set up variables
english_subjects  <- unique(english_raw$subject)


#Z-score the predictors and add explicit TR values (1 - 2816)
english_pr <- english_pr %>% 
  mutate(tr = 1:n()) %>% # add TR
  mutate(across(all_of(all.names), scale)) %>% # z-score predictors
  mutate(across(all_of(all.names), as.numeric)) 

#restructure the participant time series adding overall TR values (1 - 2816)
#as well as section TR values
english_raw <- english_raw %>% 
  group_by(subject) %>% 
  mutate(tr = 1:n()) %>%
  ungroup() %>%
  group_by(subject, section) %>%
  mutate(tr_sect = 1:n())

#join subject brain data with predictors based upon TR
#and then pivot data such that 'bold' becomes a column and 'roi' becomes column
english <- english_raw %>% 
  left_join(english_pr, by = c('tr','section')) %>%
  mutate(section = factor(section),
         subject = factor(subject)) %>%
  pivot_longer(cols = all_of(roi.names), 
               names_to ='roi', 
               values_to ='bold',
               names_transform = list(roi = as.factor),
               values_drop_na = TRUE)
english <- english %>%  mutate(language='english')


#########################

chinese_data.path  <- '/scratch/dgd45125/joint_roi/lpp_cn_HCPMMP1_volumetric_roi_signals.csv.gz'
chinese_raw        <- read_csv(chinese_data.path) %>% rename(subject = subj)


chinese_pr <- read_tsv('../lpp_cn_regressors_19Apr2022.tsv') %>%
  rename(gpt2_surprisal = chinese_gpt2_surprisal) %>%
  select(-c(disc_filler_gap,relatives,subj_relatives))



chinese_subjects  <- unique(chinese_raw$subject)

chinese_pr <- chinese_pr %>% 
  mutate(tr = 1:n()) %>% # add TR
  mutate(across(all_of(all.names), scale)) %>% # z-score predictors
  mutate(across(all_of(all.names), as.numeric))


#restructure the participant time series adding overall TR values (1 - XXXX)
#as well as section TR values
chinese_raw <- chinese_raw %>% 
  group_by(subject) %>% 
  mutate(tr = 1:n()) %>%
  ungroup() %>%
  group_by(subject, section) %>%
  mutate(tr_sect = 1:n())



#join subject brain data with predictors based upon TR
#and then pivot data such that 'bold' becomes a column and 'roi' becomes column
chinese <- chinese_raw %>% 
  left_join(chinese_pr, by = c('tr','section')) %>%
  mutate(section = factor(section),
         subject = factor(subject)) %>%
  pivot_longer(cols = all_of(roi.names), 
               names_to ='roi', 
               values_to ='bold',
               names_transform = list(roi = as.factor),
               values_drop_na = TRUE)

chinese <- chinese %>%  mutate(language='chinese')



#combine everything together:
combined <- bind_rows(chinese, english)



#Z-scoring bold by group(s) removes the need to model random intercept(s) 
#for the group(s) because the rand intercept(s) become 0
combined <- combined %>% 
  group_by(language, subject, section, roi) %>%
  mutate(bold = as.numeric( scale(bold) ) )                   
                            
                            
                            
                            
#save out the ready-to-model data
save(combined, 
     chinese_subjects,english_subjects,
     file='CN-EN-roi-regressor-timeseries_7Aug2022.rData')
                            