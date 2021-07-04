for (j in 1:20){
datapath1=paste("/export/home/guiyuanyuan/measures/SDPR/results",j,"/re",j,"_abcd_merge.txt",sep="")
datapath2=paste("/export/home/guiyuanyuan/measures/SDPR/results",j,"/re",j,"_M_abcd_merge.txt",sep="")
datapath3=paste("/export/home/guiyuanyuan/measures/SDPR/results",j,"/re",j,"_F_abcd_merge.txt",sep="")
#library(data.table)
Data_all=read.table(datapath1,stringsAsFactors = F,header=T)
Data_f=read.table(datapath3,header=T)
Data_m=read.table(datapath2,header=T)

result <- data.frame()
result_f <- data.frame()
result_m <- data.frame()

for (i in 15:45) {
null.model <-lm(Data_all[,i]~ sex + age + pc1 + pc2 + pc3,data=Data_all)
null.r2 <- summary(null.model)$r.squared

model <- lm(Data_all[,i]~ SCORE_SCZ + sex + age + pc1 + pc2 + pc3,data=Data_all)
model.r2 <- summary(model)$r.squared
prs.r2 <- model.r2-null.r2

prs.coef <- summary(model)$coeff["SCORE_SCZ",]
prs.beta <- as.numeric(prs.coef[1])
prs.p <- as.numeric(prs.coef[4])


result <- rbind(result,cbind(colnames(Data_all)[i],prs.r2,prs.beta,prs.p))

#male
mnull.model <-lm(Data_m[,i]~ age + pc1 + pc2 + pc3,data=Data_m)
mnull.r2 <- summary(mnull.model)$r.squared
mmodel <- lm(Data_m[,i]~ SCORE_SCZ + age + pc1 + pc2 + pc3,data=Data_m)
mmodel.r2 <- summary(mmodel)$r.squared
mprs.r2 <- mmodel.r2-mnull.r2

mprs.coef <- summary(mmodel)$coeff["SCORE_SCZ",]
mprs.p <- as.numeric(mprs.coef[4])
mprs.beta <- as.numeric(mprs.coef[1])

result_m <- rbind(result_m,cbind(colnames(Data_m)[i],mprs.r2,mprs.beta,mprs.p))
#female
fnull.model <-lm(Data_f[,i]~ age + pc1 + pc2 + pc3,data=Data_f)
fnull.r2 <- summary(fnull.model)$r.squared
fmodel <- lm(Data_f[,i]~ SCORE_SCZ+ age + pc1 + pc2 + pc3,data=Data_f)
fmodel.r2 <- summary(fmodel)$r.squared
fprs.r2 <- fmodel.r2-fnull.r2

fprs.coef <- summary(fmodel)$coeff["SCORE_SCZ",]
fprs.p <- as.numeric(fprs.coef[4])
fprs.beta <- as.numeric(fprs.coef[1])

result_f <- rbind(result_f,cbind(colnames(Data_f)[i],fprs.r2,fprs.beta,fprs.p))

}
file1=paste("~/measures/SDPR/scz_r2_all/re",j,"_SDPR_SCZ.result",sep="")
file2=paste("~/measures/SDPR/scz_r2_M/re",j,"_SDPR_SCZ_male.result",sep="")
file3=paste("~/measures/SDPR/scz_r2_F/re",j,"_SDPR_SCZ_female.result",sep="")
write.table(result,file1,quote=F)
write.table(result_m,file2,quote=F)
write.table(result_f,file3,quote=F)
}
