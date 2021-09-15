
/data2/huangdaoyi/UKB/ukbconv /data2/huangdaoyi/UKB/ukb44064.enc_ukb r -iselection.txt -ocleaned_phenotype
#21003=age 22001=sex 22027=heterozygosity 22021 kinship 22006 caucasian
bd <- read.table("/export/home/guiyuanyuan/UKB/cleaned_phenotype.tab", header=TRUE, sep="\t")
bd_short<-bd[,c("f.eid","f.22006.0.0", "f.22021.0.0","f.22027.0.0","f.21003.0.0","f.21003.1.0","f.21003.2.0","f.21003.3.0","f.22001.0.0","f.20016.0.0","f.20016.1.0","f.20016.2.0","f.20016.3.0","f.20191.0.0")]
write.table(bd_short,"/export/home/guiyuanyuan/UKB/new_fluid/fluid_1",row.names=F,quote=F)


awk '{print $1,$172,$173,$174,$167,$168,$169,$170,$171,$138,$139,$140,$141,$143}' /export/home/guiyuanyuan/UKB/cleaned_phenotype.tab > fluid_1
awk '$1=="f.eid" || $2==1 && $3==0 && $4!=1 && $9!="NA" {print $1,$9,$5,$6,$7,$8,$10,$11,$12,$13,$14}' fluid_1|awk '$7!="NA" || $8!="NA" || $9!="NA" || $10!="NA" || $11!="NA"' > fluid_2
awk '{if($7!="NA" && $3!="NA"){print $0,$3,$7} \
else if($7=="NA" && $8!="NA" && $4!="NA"){print $0,$4,$8} \
else if($7=="NA" && $8=="NA" && $9!="NA" && $5!="NA"){print $0,$5,$9} \
else if($7=="NA" && $8=="NA" && $9=="NA" && $10!="NA" && $6!="NA"){print $0,$6,$10} \
else if($7=="NA" && $8=="NA" && $9=="NA" && $10=="NA" && $11!="NA" && $3!="NA"){print $0,$3,$11}}' fluid_2 > fluid_3
awk '(NR>1){FID=$1;IID=$1;age=$12;sex=$2;fluid=$13}(NR==1){print "FID'"\t"'IID'"\t"'age'"\t"'sex'"\t"'fluid"}(NR>1){print FID"\t"IID"\t"age"\t"sex"\t"fluid}' fluid_3 > fluid_4
