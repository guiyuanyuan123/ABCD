export LD_LIBRARY_PATH=~/tools/SDPR/MKL/lib/:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=~/tools/SDPR/gsl/lib/:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=~/tools/anaconda3/lib/:$LD_LIBRARY_PATH
for i in {1..22};do
~/tools/SDPR/SDPR -mcmc -ref_dir ~/measures/SDPR/reference/ref/ -ss ~/measures/SDPR/SCZ/SCZ_SDPR.txt -a 0.1 -N 65955 -chr ${i} -out ${i}_SCZ.txt -n_threads 3;
done
#profile
data=4722

cat *_SCZ.txt|awk '(NR>1){SNP=$1;A1=$2;beta=$3}(NR==1){print "SNP	A1	beta"}(NR>1 && $1!="SNP"){print SNP"\t"A1"\t"beta}' > SCZ.txt;
~/tools/plink --bfile ~/measures/tran_${data}_mismatch --score SCZ.txt 1 2 3 header --out SCZ;
sed -i 's/IID/subjectkey/' SCZ.profile; sed -i 's/SCORE/SCORE_SCZ/' SCZ.profile;
rm SCZ.nopred SCZ.log


#之前运行了20次，生成20个
