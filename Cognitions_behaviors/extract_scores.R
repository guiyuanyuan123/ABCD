###NIH Toolbox
setwd("/Users/apple/Downloads/ABCD")
datapath = "/Users/apple/Downloads/brain-imaging_share/FixedClinicTabulate/abcd_tbss01.txt"
## 读取数据 ####
nih01 = fread(datapath)
headinfo = nih01[1,]
nih01 = nih01[-1,]

nih01_cor = nih01[,c(which(colnames(headinfo)%in%c("subjectkey", "interview_age", "sex", "eventname")),which(grepl(".*Age-Corrected Standard Score", as.vector(headinfo)))), with = F]
nih01_cor[nih01_cor==""]<-NA
write.table(nih01_cor[eventname=="baseline_year_1_arm_1"],file="NIH_Age-Corrected_score",quote = F,row.names = F)

#NIH Toolbox
setwd("/Users/apple/Downloads/ABCD")
datapath = "/Users/apple/Downloads/brain-imaging_share/FixedClinicTabulate/abcd_tbss01.txt"
## 读取数据 ####
nih01 = fread(datapath)
headinfo = nih01[1,]
nih01 = nih01[-1,]

nih01_cor = nih01[,c(which(colnames(headinfo)%in%c("subjectkey", "interview_age", "sex", "eventname")),which(grepl(".*Uncorrected Standard Score", as.vector(headinfo)))), with = F]
nih01_cor[nih01_cor==""]<-NA
write.table(nih01_cor[eventname=="baseline_year_1_arm_1"],file="NIH_uncorrected_score",quote = F,row.names = F)
##################################################################################################################

###CBCL
setwd("/Users/apple/Downloads/ABCD")
datapath = "/Users/apple/Downloads/brain-imaging_share/FixedClinicTabulate/abcd_cbcls01.txt"
## 读取数据 ####
library(data.table)
cbcls01 = fread(datapath, stringsAsFactors = F)
headinfo = cbcls01[1,]
cbcls01 = cbcls01[-1,]

cbcls01_raw = cbcls01[,c(which(colnames(headinfo)%in%c("subjectkey", "interview_age", "sex", "eventname")),which(grepl(".*raw.*", as.vector(headinfo)))), with = F]
cbcls01_raw[cbcls01_raw==""]<-NA
write.table(cbcls01_raw[eventname=="baseline_year_1_arm_1"],file="CBCL_raw_score",quote = F,row.names = F)
################################################################################################################

###CBCL_OCS
setwd("/Users/apple/Downloads/ABCD")
datapath = "/Users/apple/Downloads/brain-imaging_share/FixedClinicTabulate/abcd_cbcl01.txt"

cbcl01 = fread(datapath, stringsAsFactors = F)
cbcl01 = cbcl01[-1,]
write.csv(cbcl01,"/Users/apple/Downloads/ABCD/cbcl_1",row.names = F)
s <- read.csv("/Users/apple/Downloads/ABCD/cbcl_1", header = TRUE, stringsAsFactors = F)[,c("subjectkey", "interview_age", "sex", "eventname","cbcl_q09_p","cbcl_q31_p","cbcl_q32_p","cbcl_q52_p","cbcl_q66_p","cbcl_q84_p","cbcl_q85_p","cbcl_q112_p")]
s[s==""]<-NA
s$cbcl_OCS <- rowSums(s[,c("cbcl_q09_p","cbcl_q31_p","cbcl_q32_p","cbcl_q52_p","cbcl_q66_p","cbcl_q84_p","cbcl_q85_p","cbcl_q112_p")])
write.table(s[s$eventname=="baseline_year_1_arm_1",c("subjectkey", "interview_age", "sex", "eventname","cbcl_OCS")],file="CBCL_OCS_raw_score",quote = F,row.names = F)
