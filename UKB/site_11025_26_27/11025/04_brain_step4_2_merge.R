j=20
path2=paste("/export/home/guiyuanyuan/UKB/brain_imaging/notask_fmri/site_54/11025_Cheadle/SCZ",j,"/SCZ.profile",sep="")
path3=paste("/export/home/guiyuanyuan/UKB/brain_imaging/notask_fmri/site_54/11025_Cheadle/BD",j,"/BD.profile",sep="")
path4=paste("/export/home/guiyuanyuan/UKB/brain_imaging/notask_fmri/site_54/11025_Cheadle/MDD",j,"/MDD.profile",sep="")
path5=paste("/export/home/guiyuanyuan/UKB/brain_imaging/notask_fmri/site_54/11025_Cheadle/ASD",j,"/ASD.profile",sep="")
path6=paste("/export/home/guiyuanyuan/UKB/brain_imaging/notask_fmri/site_54/11025_Cheadle/BD1",j,"/BD1.profile",sep="")
path7=paste("/export/home/guiyuanyuan/UKB/brain_imaging/notask_fmri/site_54/11025_Cheadle/BD2",j,"/BD2.profile",sep="")
path8=paste("/export/home/guiyuanyuan/UKB/brain_imaging/notask_fmri/fluid/fluid",j,"/intelligence.profile",sep="")

merge.data1=read.table("/export/home/guiyuanyuan/UKB/brain_imaging/notask_fmri/covar",header=T,dec=".",stringsAsFactors=F)[,-1]
merge.data2=read.table(path2,header=T,dec=".",stringsAsFactors=F)[,c(2,6)]
merge.data3=read.table(path3,header=T,dec=".",stringsAsFactors=F)[,c(2,6)]
merge.data4=read.table(path4,header=T,dec=".",stringsAsFactors=F)[,c(2,6)]
merge.data5=read.table(path5,header=T,dec=".",stringsAsFactors=F)[,c(2,6)]
merge.data6=read.table(path6,header=T,dec=".",stringsAsFactors=F)[,c(2,6)]
merge.data7=read.table(path7,header=T,dec=".",stringsAsFactors=F)[,c(2,6)]
merge.data8=read.table(path8,header=T,dec=".",stringsAsFactors=F)[,c(2,6)]

merge.data9=read.table("/export/home/guiyuanyuan/UKB/brain_imaging/notask_fmri/brain_MRI_6",header=T,dec=".",stringsAsFactors=F)

merge.datax1=merge(merge.data2,merge.data3,by="subjectkey")
merge.datax2=merge(merge.datax1,merge.data4,by="subjectkey")
merge.datax3=merge(merge.datax2,merge.data5,by="subjectkey")
merge.datax4=merge(merge.datax3,merge.data6,by="subjectkey")
merge.datax5=merge(merge.datax4,merge.data7,by="subjectkey")
merge.datax6=merge(merge.datax5,merge.data8,by="subjectkey")
merge.datax7=merge(merge.datax6,merge.data1,by="subjectkey")

merge.data=merge(merge.datax7,merge.data9,by="subjectkey")
#for (i in 2:n){
#    new.data=read.table(file=dir[i],header=T,dec=".",stringsAsFactors=F)[,-c(2,3,4)]
#    merge.data=merge(merge.data,new.data,by="subjectkey")
#}
m=merge.data[merge.data$sex==1,]
f=merge.data[merge.data$sex==0,]

file1=paste("/export/home/guiyuanyuan/UKB/brain_imaging/notask_fmri/site_54/11025_Cheadle/results20/re",j,"_abcd_merge.txt",sep="")
file2=paste("/export/home/guiyuanyuan/UKB/brain_imaging/notask_fmri/site_54/11025_Cheadle/results",j,"/re",j,"_M_abcd_merge.txt",sep="")
file3=paste("/export/home/guiyuanyuan/UKB/brain_imaging/notask_fmri/site_54/11025_Cheadle/results",j,"/re",j,"_F_abcd_merge.txt",sep="")
write.table(merge.data,file1,row.names=F,quote=F)
write.table(m,file2,row.names=F,quote=F)
write.table(f,file3,row.names=F,quote=F)
