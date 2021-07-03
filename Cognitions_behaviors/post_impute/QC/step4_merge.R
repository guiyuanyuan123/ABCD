a=list.files("/export/home/guiyuanyuan/measures/score")
dir=paste("/export/home/guiyuanyuan/measures/score/",a,sep="")
n=length(dir)
merge.data1=read.table("/export/home/guiyuanyuan/measures/covar",header=T,dec=".",stringsAsFactors=F)[,-1]
merge.data2=read.table("/export/home/guiyuanyuan/measures/SCZ.profile",header=T,dec=".",stringsAsFactors=F)[,c(2,6)]
merge.data3=read.table("/export/home/guiyuanyuan/measures/BD.profile",header=T,dec=".",stringsAsFactors=F)[,c(2,6)]
merge.data7=read.table("/export/home/guiyuanyuan/measures/MDD.profile",header=T,dec=".",stringsAsFactors=F)[,c(2,6)]
merge.data8=read.table("/export/home/guiyuanyuan/measures/ASD.profile",header=T,dec=".",stringsAsFactors=F)[,c(2,6)]

merge.data4=read.table(file=dir[1],header=T,dec=".",stringsAsFactors=F)[,-c(2,3,4)]

merge.data5=merge(merge.data2,merge.data3,by="subjectkey")
merge.data5_1=merge(merge.data5,merge.data7,by="subjectkey")
merge.data5_2=merge(merge.data5_1,merge.data8,by="subjectkey")

merge.data6=merge(merge.data5_2,merge.data1,by="subjectkey")
merge.data=merge(merge.data6,merge.data4,by="subjectkey")
for (i in 2:n){
    new.data=read.table(file=dir[i],header=T,dec=".",stringsAsFactors=F)[,-c(2,3,4)]
    merge.data=merge(merge.data,new.data,by="subjectkey")
}
m=merge.data[merge.data$sex==1,]
f=merge.data[merge.data$sex==0,]
write.table(merge.data,file="abcd_merge.txt",row.names=F,quote=F)
write.table(m,file="M_abcd_merge.txt",row.names=F,quote=F)
write.table(f,file="F_abcd_merge.txt",row.names=F,quote=F)
