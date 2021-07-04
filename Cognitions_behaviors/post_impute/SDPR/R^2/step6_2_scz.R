#SCZ=2 BD=3 MDD=4 ASD=5 BD1=6 SCZ=7
for (j in 1:20){
path=paste("~/measures/SDPR/results",j,"/re",j,"_abcd_merge.txt",sep="")
a<-read.table(path,header=T)
result<-data.frame()
result1=data.frame()
result_f=data.frame()
for (i in 14:57){
cor<-cor.test(a$SCORE_SCZ,a[,i])
p<-cor$p.value
r<-cor$estimate
result<-rbind(result,cbind(colnames(a)[i],r,p))

m1=a[a$sex==1,2]
m2=a[a$sex==1,i]
cor1<-cor.test(m1,m2)
p1<-cor1$p.value
r1<-cor1$estimate
result1<-rbind(result1,cbind(colnames(a)[i],r1,p1))

m4=a[a$sex==0,2]
m3=a[a$sex==0,i]
cor_f<-cor.test(m3,m4)
p_f<-cor_f$p.value
r_f<-cor_f$estimate
result_f<-rbind(result_f,cbind(colnames(a)[i],r_f,p_f))
}
file1=paste("/export/home/guiyuanyuan/measures/SDPR/scz_r2_all/re",j,"_SCZ_merge_all_cor.results",sep="")

file2=paste("/export/home/guiyuanyuan/measures/SDPR/scz_r2_M/re",j,"_SCZ_merge_M_cor.results",sep="")
file3=paste("/export/home/guiyuanyuan/measures/SDPR/scz_r2_F/re",j,"_SCZ_merge_F_cor.results",sep="")
write.table(result,file1,quote=F)
write.table(result1,file2,quote=F)
write.table(result_f,file3,quote=F)
}
