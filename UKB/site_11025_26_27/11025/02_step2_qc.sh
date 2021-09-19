#step2_qc.sh
 i=11025

/export/home/guiyuanyuan/tools/plink2 --bfile 11025 --geno 0.2 --threads 5 --memory 35840 --make-bed --out  chr${i}_1;
/export/home/guiyuanyuan/tools/plink2 --bfile chr${i}_1 --mind 0.2 --make-bed --out chr${i}_2 --threads 5 --memory 35840 ;
/export/home/guiyuanyuan/tools/plink2 --bfile chr${i}_2 --geno 0.05 --make-bed --out chr${i}_3 --threads 5 --memory 35840 ;
/export/home/guiyuanyuan/tools/plink2 --bfile chr${i}_3 --mind 0.05 --make-bed --out chr${i}_4 --threads 5 --memory 35840 ;
/export/home/guiyuanyuan/tools/plink2 --bfile chr${i}_4 --maf 0.01 --make-bed --out chr${i}_5 --threads 5 --memory 35840 ;
/export/home/guiyuanyuan/tools/plink2 --bfile chr${i}_5 --hwe 1e-10 --make-bed --out 11025_qc --threads 5 --memory 35840 ;
rm chr${i}_*.bed chr${i}_*.bim chr${i}_*.fam chr${i}_*.log;

data=11025

Rscript mismatch.R
#11025.mismatch
/export/home/guiyuanyuan/tools/plink --bfile 11025_qc --extract 11025.adj.bim --make-bed --out adj
# Make a back up
#mv tran_11025.bim tran_11025.bim.bk
#ln -s 11025.adj.bim tran_11025.bim
cp adj.bed 11025.adj.bed
cp adj.fam 11025.adj.fam

/export/home/guiyuanyuan/tools/plink --bfile 11025.adj --exclude 11025.mismatch --make-bed --out 11025_mismatch

#awk 'NR==FNR{a[$1]=$3" "$4;next}{if($1 in a)print $1,$1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,a[$1]}' brain_MRI_3 ~/UKB/pca.tab > pc
awk 'NR==FNR{a[$1]=$0;next}{if($1 in a)print $0}' 11025_mismatch.fam /export/home/guiyuanyuan/UKB/brain_imaging/notask_fmri/pc |awk '{FID=$1;subjectkey=$2;pc1=$3;pc2=$4;pc3=$5;pc4=$6; pc5=$7; pc6=$8;pc7=$9;pc8=$10;pc9=$11; pc10=$12;age=$13;sex=$14}(NR==1){print "FID subjectkey pc1 pc2 pc3 pc4 pc5 pc6 pc7 pc8 pc9 pc10 age sex"}{print FID, subjectkey, pc1, pc2, pc3, pc4, pc5, pc6, pc7, pc8, pc9, pc10, age, sex}' >covar

