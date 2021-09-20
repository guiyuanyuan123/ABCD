merge.data2=read.table("/lustre/home/acct-clslh/clslh/gyy/4_centre/11025/SCZ20_random_profile_5k",header=T,dec=".",stringsAsFactors=F)[,-c(1,3,4,5,6)]

merge.data1=read.table("/lustre/home/acct-clslh/clslh/gyy/4_centre/11025/re20_M_abcd_merge.txt",header=T,dec=".",stringsAsFactors=F)

Data_m=merge(merge.data2,merge.data1,by="subjectkey")

#volume
result_m <- data.frame()
for (i in 5022:5180) {
result_j <- data.frame()
   for (j in 2:1001){
mnull.model <-lm(Data_m[,i]~ age + pc1 + pc2 + pc3 + pc4 + pc5 + pc6 + pc7 + pc8 + pc9 + pc10 + f.25000.2.0,data=Data_m)
mnull.r2 <- summary(mnull.model)$r.squared
mmodel <- lm(Data_m[,i]~ Data_m[,j] + age + pc1 + pc2 + pc3 + pc4 + pc5 + pc6 + pc7 + pc8 + pc9 + pc10 + f.25000.2.0,data=Data_m)
mmodel.r2 <- summary(mmodel)$r.squared
mprs.r2 <- mmodel.r2-mnull.r2
result_j<-rbind(result_j,cbind(colnames(Data_m)[i],mprs.r2))

}
result_m<-rbind(result_m,result_j)
}

result_m2 <- data.frame()
for (i in 5181:5540) {
result_j2 <- data.frame()
   for (j in 2:1001){
mnull.model <-lm(Data_m[,i]~ age + pc1 + pc2 + pc3 + pc4 + pc5 + pc6 + pc7 + pc8 + pc9 + pc10 ,data=Data_m)
mnull.r2 <- summary(mnull.model)$r.squared
mmodel <- lm(Data_m[,i]~ Data_m[,j] + age + pc1 + pc2 + pc3 + pc4 + pc5 + pc6 + pc7 + pc8 + pc9 + pc10 ,data=Data_m)
mmodel.r2 <- summary(mmodel)$r.squared
mprs.r2 <- mmodel.r2-mnull.r2
result_j2 <-rbind(result_j2,cbind(colnames(Data_m)[i],mprs.r2))

}
result_m2 <-rbind(result_m2,result_j2)
}
result_final <- rbind(result_m,result_m2)

write.table(result_final,"/lustre/home/acct-clslh/clslh/gyy/4_centre/11025/scz/scz_5k_1_M_SCORE_permu_R2.result",quote=F)
