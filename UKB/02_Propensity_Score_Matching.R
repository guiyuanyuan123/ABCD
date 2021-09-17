
dem<-read.table("~/UKB/demographics.tab",header=T)
a<-read.table("~/UKB/new_fluid/tt/fluid_2",header=T)
b=read.table("~/UKB/healthy/fluid_health_3",header=T)
colnames(b)=c("f.eid","age","sex","fluid")
c=merge(a,dem,by="f.eid")
d=merge(c,d,by="f.eid")[,-c(44,45,46)]
e=d[,c(1:20,26,32,38)]
write.table(e,"~/UKB/new_fluid/tt/dem_1",quote=F,row.names=F)

#since the TDI was recoded at the initial accessment,we only extracted the 0.0 data, and the EA accessment using 6138, the raw category. 
awk '{if($3!="NA" && $7!="NA" && $12!="NA" && $13!="NA" && $20!="NA"){print $0,$3,$7,$12,$13,$20}else if($7=="NA" && $11!="NA"&& $12!="NA" && $13!="NA" && $20!="NA"){print $0,$3,$11,$12,$13,$20}}' dem_1 \
|awk '$27!="-1" && $27!="-3" && $28!="-3" && $28!="-7"{print $1,$2,$24,$25,$26,$27,$28}'  > dem_2

###
2个主要R包：nonrandom 和 tableone

其中nonrandom 包，已被移除，无法通过install.package() 正常安装

不过可以采用本地R包导入的方法

到R package 官网搜索下载即可

下载链接：https://cran.r-project.org/src/contrib/Archive/nonrandom/
###
install.packages("nonrandom_1.42.tar.gz",repos=NULL, type="source")
install.packages("tableone")

library(nonrandom)
library(tableone)
df<-read.table("dem_2",header=T)
stable=CreateTableOne(vars=c("f.21003.0.0","f.189.0.0","f.738.0.0","f.6138.0.0"),strata="f.22001.0.0",data=df,factorVars=c("f.738.0.0","f.6138.0.0"))
print(stable,showAllLevels = TRUE)
mydata.ps <- pscore(data= df,  formula =f.22001.0.0 ~ f.21003.0.0 + f.189.0.0 + f.738.0.0 + f.6138.0.0)
head(mydata.ps$data)
 mydata.match <- ps.match(object= mydata.ps,who.treated =1,ratio= 1,caliper = "logit",x=0.2,givenTmatchingC = T,matched.by = "pscore",  setseed = 12345)
#很久

df_2=mydata.ps$data
f<-lm(df_2[,4] ~ df_2$pscore)$residuals
 t.test(df_2[df_2$f.22001.0.0==0,4],df_2[df_2$f.22001.0.0==1,4],var.equal=F,alternative="two.sided")$statistic
 t.test(df_2[df_2$f.22001.0.0==0,4],df_2[df_2$f.22001.0.0==1,4],var.equal=F,alternative="two.sided")$p.value
 
 
 #EA --0    1"college"
 awk '{if($7!="1" && $7!="f.6138.0.0"){$7=0}}1' dem_2 > dem_3
 
 
 #all_fluid
 c=merge(a,dem,by="f.eid")
 write.table(d,"test",quote=F,row.names=F)
 awk '{if($12!="NA"){$12=$12}if($12=="NA" && $13!="NA"){$12=$13}if($12=="NA" && $13=="NA" && $14!="NA"){$12=$14}if($12=="NA" && $13=="NA" && $14=="NA" && $15!="NA"){$12=$15};print}' test \
 |awk '$12!="-3" && $12!="-7"{print $1,$2,$12}' > test2
 awk '{if($3!="1" && $3!="f.6138.0.0"){$3=0}}1' test2 > test3
 
