fluid<-read.table("/export/home/guiyuanyuan/UKB/SDPR/results20/re20_abcd_merge.txt",header=T)[,c("subjectkey","age")]
brain<-read.table("/export/home/guiyuanyuan/UKB/brain_imaging/notask_fmri/results20/re20_abcd_merge.txt",header=T)[,c("subjectkey","age")]
age <- merge(brain,fluid,by="subjectkey")
t.test(age$age.x,age$age.y)
