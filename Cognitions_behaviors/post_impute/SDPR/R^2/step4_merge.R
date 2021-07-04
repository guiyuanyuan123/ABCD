for (j in 1:20){
a=list.files("/export/home/guiyuanyuan/measures/score")
dir=paste("/export/home/guiyuanyuan/measures/score/",a,sep="")
n=length(dir)

path2=paste("/export/home/guiyuanyuan/measures/SDPR/SCZ/scz",j,"/SCZ.profile",sep="")
path3=paste("/export/home/guiyuanyuan/measures/SDPR/BD/bd",j,"/BD.profile",sep="")
path4=paste("/export/home/guiyuanyuan/measures/SDPR/MDD/MDD_short/mdd",j,"/MDD.profile",sep="")
path5=paste("/export/home/guiyuanyuan/measures/SDPR/ASD/asd",j,"/ASD.profile",sep="")
path6=paste("/export/home/guiyuanyuan/measures/SDPR/BD1/bd1",j,"/BD1.profile",sep="")
path7=paste("/export/home/guiyuanyuan/measures/SDPR/BD2/bd2",j,"/BD2.profile",sep="")
path8=paste("/export/home/guiyuanyuan/measures/SDPR/g_fluid/sumstats/g",j,"/intelligence.profile",sep="")

merge.data1=read.table("/export/home/guiyuanyuan/measures/covar",header=T,dec=".",stringsAsFactors=F)[,-1]
merge.data2=read.table(path2,header=T,dec=".",stringsAsFactors=F)[,c(2,6)]
merge.data3=read.table(path3,header=T,dec=".",stringsAsFactors=F)[,c(2,6)]
merge.data4=read.table(path4,header=T,dec=".",stringsAsFactors=F)[,c(2,6)]
merge.data5=read.table(path5,header=T,dec=".",stringsAsFactors=F)[,c(2,6)]
merge.data6=read.table(path6,header=T,dec=".",stringsAsFactors=F)[,c(2,6)]
merge.data7=read.table(path7,header=T,dec=".",stringsAsFactors=F)[,c(2,6)]
merge.data8=read.table(path8,header=T,dec=".",stringsAsFactors=F)[,c(2,6)]

merge.data9=read.table(file=dir[1],header=T,dec=".",stringsAsFactors=F)[,-c(2,3,4)]
#merge.data8=read.table("/export/home/guiyuanyuan/measures/score/CBCL_raw_score",header=T,dec=".",stringsAsFactors=F)[,-c(2,3,4)]

merge.datax1=merge(merge.data2,merge.data3,by="subjectkey")
merge.datax2=merge(merge.datax1,merge.data4,by="subjectkey")
merge.datax3=merge(merge.datax2,merge.data5,by="subjectkey")
merge.datax4=merge(merge.datax3,merge.data6,by="subjectkey")
merge.datax5=merge(merge.datax4,merge.data7,by="subjectkey")
merge.datax6=merge(merge.datax5,merge.data8,by="subjectkey")
merge.datax7=merge(merge.datax6,merge.data1,by="subjectkey")

merge.data=merge(merge.datax7,merge.data9,by="subjectkey")
for (i in 2:n){
    new.data=read.table(file=dir[i],header=T,dec=".",stringsAsFactors=F)[,-c(2,3,4)]
    merge.data=merge(merge.data,new.data,by="subjectkey")
}
#list<-which(rowSums(is.na(merge.data))>1)
#x_NA <- merge.data[list,]
#x_full<-merge.data[-list,]
#m=x_full[x_full$sex==1,]
#f=x_full[x_full$sex==0,]
m=merge.data[merge.data$sex==1,]
f=merge.data[merge.data$sex==0,]

file1=paste("~/measures/SDPR/results",j,"/re",j,"_abcd_merge.txt",sep="")
file2=paste("~/measures/SDPR/results",j,"/re",j,"_M_abcd_merge.txt",sep="")
file3=paste("~/measures/SDPR/results",j,"/re",j,"_F_abcd_merge.txt",sep="")
write.table(merge.data,file1,row.names=F,quote=F)
write.table(m,file2,row.names=F,quote=F)
write.table(f,file3,row.names=F,quote=F)
}
