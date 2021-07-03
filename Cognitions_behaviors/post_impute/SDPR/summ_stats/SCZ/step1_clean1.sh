awk '(NR>1){SNP=$2;A1=$4;A2=$5;INFO=$8;BETA=log($9);P=$11;N=4*33426*32541/(33426+32541)}(NR==1){printf "SNP	A1	A2	INFO	BETA	P	N"}{print SNP"\t"A1"\t"A2"\t"INFO"\t"BETA"\t"P"\t"N}' sczvscont-sumstat > clean1.txt
~/tools/ldsc/munge_sumstats.py --sumstats clean1.txt --out clean

~/tools/ldsc/ldsc.py --h2 clean.sumstats.gz --ref-ld-chr  ~/ABCD_ADHD/abcd_ksad01/input_loose/all_sample/impute_data/keep_EUR/LDSC/ADHD/LD_eur/eur_w_ld_chr/ --out clean_h2 --w-ld-chr  ~/ABCD_ADHD/abcd_ksad01/input_loose/all_sample/impute_data/keep_EUR/LDSC/ADHD/LD_eur/eur_w_ld_chr/
# prepare for SDPR
gunzip -c clean.sumstats.gz > clean
awk 'NR==FNR{a[$1]=$5"\t"$6;next}{if($1 in a)print $1"\t"$2"\t"$3"\t"a[$1]}' clean1.txt clean > clean2
awk 'NR==FNR{a[$2]=$0;next}{if($1 in a)print $0}' ~/measures/SDPR/reference/snpinfo_1kg_nohm3 clean2 > SCZ_SDPR.txt  
rm clean clean2 clean1.txt
