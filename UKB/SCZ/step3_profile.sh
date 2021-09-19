mkdir scz${i};
i=20
#cat scz${i}/*_SCZ.txt|awk '(NR>1){SNP=$1;A1=$2;beta=$3}(NR==1){print "SNP	A1	beta"}(NR>1 && $1!="SNP"){print SNP"\t"A1"\t"beta}' > scz${i}/SCZ.txt;
~/tools/plink --bfile /export/home/guiyuanyuan/UKB/brain_imaging/notask_fmri/21523_mismatch --score ~/measures/SDPR/SCZ/scz${i}/SCZ.txt 1 2 3 header --out scz${i}/SCZ;
sed -i 's/IID/subjectkey/' scz${i}/SCZ.profile; sed -i 's/SCORE/SCORE_SCZ/' scz${i}/SCZ.profile;
rm scz${i}/SCZ.nopred scz${i}/SCZ.log;

#后面用bootstrap 所以算20次没有意义
