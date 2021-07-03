#2020/9/16
dir=/export/home/guiyuanyuan/ABCD_ADHD/all_abcd_ksad01/impute/fcgene
data1=$1 #merged bfile = target data Merge_ABCD_release_2.0.1_r1
plink=/export/home/guiyuanyuan/tools

# post_imputation GWAS QC
$plink/plink --bfile ~/ABCD_ADHD/all_abcd_ksad01/impute/fcgene/Merge_ABCD_release_2.0.1_r1 --geno 0.2 --allow-no-sex --make-bed --out ${data1}_1;
$plink/plink --bfile ${data1}_1 --mind 0.2 --allow-no-sex --make-bed --out ${data1}_2;
$plink/plink --bfile ${data1}_2 --geno 0.05 --make-bed --out ${data1}_3;
$plink/plink --bfile ${data1}_3 --mind 0.05 --make-bed --out ${data1}_4;
$plink/plink --bfile ${data1}_4 --maf 0.05 --make-bed --out ${data1}_5;
$plink/plink --bfile ${data1}_5 --hwe 1e-10 --make-bed --out ${data1}_6_0;

$plink/plink --bfile ${data1}_6_0 --exclude /export/home/guiyuanyuan/ABCD_ADHD/all_abcd_ksad01/impute/PRS/range high-ld.txt --indep-pairwise 50 5 0.2 --out indepSNP;
$plink/plink --bfile ${data1}_6_0 --extract indepSNP.prune.in --het --out R_check
Rscript --no-save heterozygosity_outliers_list.R
sed 's/"// g' fail-het-qc.txt | awk '{print$1, $2}'> het_fail_ind.txt
$plink/plink --bfile ${data1}_6_0 --remove het_fail_ind.txt --make-bed --out ${data1}_6
$plink/plink --bfile ${data1}_6 --exclude range /export/home/guiyuanyuan/ABCD_ADHD/all_abcd_ksad01/impute/PRS/high-ld.txt --indep-pairwise 50 5 0.2 --out indepSNP;
$plink/plink --bfile ${data1}_6 --extract indepSNP.prune.in --genome --min 0.2 --out pihat_min0.2;
$plink/plink --bfile ${data1}_6 --missing;
awk 'NR==FNR{a[$2]=$6;next}{if($2 in a)print $1,$2,a[$2],$3,$4}' plink.imiss pihat_min0.2.genome > 1
awk 'NR==FNR{a[$2]=$6;next}{if($5 in a)print $0,a[$5]}' plink.imiss 1 > 2;
awk '{if($3>$6)$7=$1" "$2}{if($3<=$6)$7=$4" "$5}1' 2 |awk '{print $7,$8}'> 0.2_low_call_rate_pihat.txt;
$plink/plink --bfile ${data1}_6 --remove 0.2_low_call_rate_pihat.txt --make-bed --out ${data1}_7;

#prune abcd
$plink/plink --bfile ${data1}_7 --exclude /export/home/guiyuanyuan/ABCD_ADHD/all_abcd_ksad01/impute/PRS/high-ld.txt --range --indep-pairwise 50 5 0.2 --out indepSNP
$plink/plink --bfile ${data1}_7 --extract indepSNP.prune.in --make-bed --out indepSNP.prune
awk '$2=$1":"$4' indepSNP.prune.bim > trans_indepSNP.prune.bim
cp indepSNP.prune.bed trans_indepSNP.prune.bed
cp indepSNP.prune.fam trans_indepSNP.prune.fam
rm indepSNP.prune.bed indepSNP.prune.bim indepSNP.prune.fam
#删去重复位点，multi_snp
awk '{print $1":"$4}' trans_indepSNP.prune.bim |sort|uniq -d > indepSNP.prune_dup
$plink/plink --bfile trans_indepSNP.prune --exclude indepSNP.prune_dup --make-bed --out trans_indepSNP.prune_dum

#1kg extract
$plink/plink --bfile /export/home/guiyuanyuan/ABCD_ADHD/abcd_ksad01/input_loose/shapeit/pca/all_qc_prune --extract trans_indepSNP.prune_dum.bim --make-bed --out 1kg_same_adhd
$plink/plink --bfile trans_indepSNP.prune_dum --extract 1kg_same_adhd.bim --make-bed --out adhd_same_1kg
#same build
awk '{print $2,$4}' adhd_same_1kg.bim > buildadhd.txt
$plink/plink --bfile 1kg_same_adhd --update-map buildadhd.txt --make-bed --out 1kg_same_adhd_same_build
#same allele
awk '{print $2,$5}' 1kg_same_adhd_same_build.bim > 1kg_ref-list.txt
$plink/plink --bfile adhd_same_1kg --reference-allele 1kg_ref-list.txt --make-bed --out adhd_same_1kg-adj
#flip 
awk '{print $2,$5,$6}' 1kg_same_adhd_same_build.bim > 1kg_same_adhd_same_build_tmp
awk '{print $2,$5,$6}' adhd_same_1kg-adj.bim > adhd_same_1kg-adj_tmp
sort adhd_same_1kg-adj_tmp 1kg_same_adhd_same_build_tmp | uniq -u > all_differences.txt
awk '{print $1}' all_differences.txt | sort -u > flip_list.txt
$plink/plink --bfile adhd_same_1kg-adj --flip flip_list.txt --reference-allele 1kg_ref-list.txt --make-bed --out corrected_adhd
awk '{print $2,$5,$6}' corrected_adhd.bim > corrected_adhd_tmp
sort corrected_adhd_tmp 1kg_same_adhd_same_build_tmp |uniq -u > uncorresponding_SNPs.txt
awk '{print $1}' uncorresponding_SNPs.txt | sort -u > SNPs_for_exlusion.txt
$plink/plink --bfile corrected_adhd --exclude SNPs_for_exlusion.txt --make-bed --out abcd
$plink/plink --bfile 1kg_same_adhd_same_build --exclude SNPs_for_exlusion.txt --make-bed --out 1kg_0

#匹配population region
awk 'NR==FNR{a[$2]=$7;next}{if($2 in a){print a[$2]" "$2" "$3" "$4" "$5" "$6}else{print $0}}' /export/home/guiyuanyuan/ABCD_ADHD/abcd_ksad01/input_loose/shapeit/pca/20130606_g1k.ped 1kg_0.fam >1
awk 'NR==FNR{a[$1]=$2;next}{if($1 in a)print $1"_"a[$1]"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6}' /export/home/guiyuanyuan/ABCD_ADHD/all_abcd_ksad01/impute/PRS/population_region 1 > 1kg.fam
cp 1kg_0.bed 1kg.bed
cp 1kg_0.bim 1kg.bim

$plink/plink --bfile abcd --bmerge 1kg.bed 1kg.bim 1kg.fam --make-bed --out prune_abcd_merge_1kg
$plink/plink --bfile prune_abcd_merge_1kg --pca 3 --out prune_abcd_merge_1kg_pc
for i in {1..5};do rm ${data1}_${i}.bed ${data1}_${i}.bim ${data1}_${i}.fam ${data1}_${i}.log;done
rm 1 1kg_0* SNPs_for_exlusion.txt uncorresponding_SNPs.txt corrected_adhd* flip_list.txt all_differences.txt adhd_same_1kg* 1kg_same_adhd* buildadhd.txt
