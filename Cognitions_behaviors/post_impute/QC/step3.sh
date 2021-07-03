data=$1 #4722
#convert to rs_id
/export/home/guiyuanyuan/tools/plink --bfile ~/measures/Merge_ABCD_release_2.0.1_r1_7 --keep ${data} --make-bed --out ${data};
awk 'NR==FNR{a[$2]=$2":"$4":"$5":"$6;next}{if($2 in a){print $1"\t"a[$2]"\t"$3"\t"$4"\t"$5"\t"$6}else{print $0}}' ~/ABCD_ADHD/all_abcd_ksad01/ABCD_release_2.0.1_r1_5735.bim ${data}.bim > step1
awk -F":" '{print $1,$4}' step1|awk '{print $1"\t"$2"\t"$4"\t"$5"\t"$6"\t"$7}' > step2
awk '$2!~/^rs/' step2 > no_rs
awk 'NR==FNR{a[$1" "$4]=$2;next}{if($1" "$4 in a){print $1"\t"a[$1" "$4]"\t"$3"\t"$4"\t"$5"\t"$6}else{print $0}}' ~/ABCD_ADHD/abcd_ksad01/input_loose/all_sample/impute_data/keep_EUR/LDSC/ADHD/LD_eur/CHR_ALL_EUR.bim no_rs > step3
awk 'NR==FNR{a[$1" "$4]=$2;next}{if($1" "$4 in a){print $1"\t"a[$1" "$4]"\t"$3"\t"$4"\t"$5"\t"$6}else{print $0}}' step3 step2 > step5
awk '{print $2}' step5|sort|uniq -d > dup
awk 'NR==FNR{a[$1]=$0;next}{if(!($2 in a))print $0}' dup step5 >step6
awk 'NR==FNR{a[$1" "$4]=$0;next}{if($1" "$4 in a)print a[$1" "$4]}' ${data}.bim step6 > step7
/export/home/guiyuanyuan/tools/plink --bfile ${data} --extract step7 --make-bed --out temp
mv step6 tran_${data}.bim
cp temp.fam tran_${data}.fam
cp temp.bed tran_${data}.bed

Rscript ~/measures/script/mismatch.R
#4722.mismatch
/export/home/guiyuanyuan/tools/plink --bfile tran_4722 --extract 4722.adj.bim --make-bed --out adj
# Make a back up
#mv tran_4722.bim tran_4722.bim.bk
#ln -s 4722.adj.bim tran_4722.bim
cp adj.bed 4722.adj.bed
cp adj.fam 4722.adj.fam

/export/home/guiyuanyuan/tools/plink --bfile 4722.adj --exclude 4722.mismatch --make-bed --out tran_${data}_mismatch
/export/home/guiyuanyuan/tools/plink --bfile tran_${data}_mismatch --exclude range ~/ABCD_ADHD/all_abcd_ksad01/impute/PRS/high-ld.txt --indep-pairwise 50 5 0.2 --out indepSNP
/export/home/guiyuanyuan/tools/plink --bfile tran_${data}_mismatch --extract indepSNP.prune.in --pca 3 --out ${data}_prune
awk 'NR==FNR{a[$1]=$2/12" "$3;next}{if($2 in a)print $0,a[$2]}'  ~/ABCD_ADHD/all_abcd_ksad01/impute/PRS/dmri_prs/abcd_ksad01_age ${data}_prune.eigenvec > ${data}_covar0
awk '{if($7=="M")$7=1}{if($7=="F")$7=0}1' ${data}_covar0 > ${data}_covar
awk '{FID=$1;subjectkey=$2;pc1=$3;pc2=$4;pc3=$5;age=$6;sex=$7}(NR==1){print "FID subjectkey pc1 pc2 pc3 age sex"}{print FID, subjectkey, pc1, pc2, pc3, age, sex}' ${data}_covar > covar

rm no_rs dup temp*
