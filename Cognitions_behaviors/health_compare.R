a<-read.table("../results20/re20_abcd_merge.txt",header=T)[,c(1,12,13,36:45)]
b=read.table("ksad01_tbi01_control",header=T)[,-3]
c=merge(a,b,by="subjectkey")[,1:13]
write.table(c,"health_cognitions_res",quote=F,row.names=F)
for i in {4..13};do awk '$"'${i}'"!="NA" {print $1,$3,$"'${i}'"}' health_cognitions_res > health_cognitions_res_${i};done

import pandas as pd
from scipy import stats
data=pd.read_csv("health_cognitions_res_4",sep='\\s+',header=0)
dm1=data[data['sex']==1]
dm=dm1['nihtbx_picvocab_uncorrected']
sorted(dm)[0]
mx=stats.boxcox(dm+55,stats.boxcox_normmax(dm+55))
m=pd.DataFrame(list(mx))
tmp_m = [dm1,m.stack()]
tmp_m1=pd.concat([s.reset_index(drop=True) for s in tmp_m], axis=1)

df1=data[data['sex']==0]
df=df1['nihtbx_picvocab_uncorrected']
sorted(df)[0]
fx=stats.boxcox(df+21,stats.boxcox_normmax(df+21))
f=pd.DataFrame(list(fx))
tmp_f = [df1,f.stack()]
tmp_f1=pd.concat([s.reset_index(drop=True) for s in tmp_f], axis=1)


tst_c=data.frame()
twst_c=data.frame()
wtest_c=data.frame()
effsize=data.frame()


library(rstatix)

Wilcox<-function(wilcoxModel,N)
{
z<-qnorm(wilcoxModel$p.value/2)
r<-z/sqrt(N)
return(r)
#cat(wilcoxModel$data.name,"Effect Size, r=",r)
}

for (j in 4:13){
     f<-lm(c[,j] ~ c$age)$residuals
     c[,j][!is.na(c[,j])]=f
#正态检验
pm_c =shapiro.test(c[c$sex==1,j])$p.value
pf_c =shapiro.test(c[c$sex==0,j])$p.value
p_c =var.test(c[c$sex==0,j],c[c$sex==1,j])$p.value

        if(pm_c>0.05 & pf_c>0.05 & p_c > 0.05){
#方差齐
        tp<-t.test(c[c$sex==0,j],c[c$sex==1,j],var.equal=T,alternative="two.sided")$p.value
        ts=t.test(c[c$sex==0,j],c[c$sex==1,j],var.equal=T,alternative="two.sided")$statistic
        tst_c=rbind(tst_c,cbind(colnames(c)[j],tp,ts))

        }else if(pm_c>0.05 & pf_c>0.05 & p_c < 0.05){
        twp<-t.test(c[c$sex==0,j],c[c$sex==1,j],var.equal=F,alternative="two.sided")$p.value
        tws=t.test(c[c$sex==0,j],c[c$sex==1,j],var.equal=F,alternative="two.sided")$statistic
        twst_c=rbind(twst_c,cbind(colnames(c)[j],twp,tws))

        }else{
        model=wilcox.test(c[c$sex==0,j],c[c$sex==1,j],alternative="two.sided")
        wp=model$p.value
        ws=model$statistic

        m_x<-c[c$sex==1,j]
        f_x<-c[c$sex==0,j]
        m_x<-na.omit(m_x)
        f_x<-na.omit(f_x)
        l=length(m_x)*length(f_x)/2
        l1=length(m_x)+length(f_x)
        r=Wilcox(model,l1)
        wtest_c=rbind(wtest_c,cbind(colnames(c)[j],wp,ws,l,r))
        }
}
wtest_c <- within(wtest_c,{wstat= as.numeric(as.character(ws))-as.numeric(as.character(l))})[,c("V1","wp","wstat","r")]

colnames(twst_c)<-c("V1","tp","ts")
tst_c$ts <- as.numeric(as.character(tst_c$ts))
twst_c$ts <- as.numeric(as.character(twst_c$ts))
ct_test <- rbind(tst_c,twst_c)

write.table(wtest_c,"/export/home/guiyuanyuan/measures/SDPR/plot/health/wilcox_test",quote=F,row.names=F)
