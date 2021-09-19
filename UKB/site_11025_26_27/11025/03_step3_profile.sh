#step3_profile.sh
i=20
mkdir SCZ${i};
~/tools/plink --bfile /export/home/guiyuanyuan/UKB/brain_imaging/notask_fmri/site_54/11025_Cheadle/11025_mismatch --score ~/measures/SDPR/SCZ/scz${i}/SCZ.txt 1 2 3 header --out SCZ${i}/SCZ;
sed -i 's/IID/subjectkey/' SCZ${i}/SCZ.profile; sed -i 's/SCORE/SCORE_SCZ/' SCZ${i}/SCZ.profile;
rm SCZ${i}/SCZ.nopred SCZ${i}/SCZ.log;

for i in `cat test`;do cp step3_profile.sh ${i}_step3_profile.sh;sed -i 's/SCZ/'${i}'/g'  ${i}_step3_profile.sh;done
sed -i 's/scz/bd/g' BD_step3_profile.sh 
sed -i 's/scz/bd1/g' BD1_step3_profile.sh 
sed -i 's/scz/bd2/g' BD2_step3_profile.sh 
sed -i 's/scz/mdd/g' MDD_step3_profile.sh 
sed -i 's/scz/asd/g' ASD_step3_profile.sh 
sed -i 's|~/measures/SDPR/MDD/mdd${i}|~/measures/SDPR/MDD/MDD_short/mdd${i}|g' MDD_step3_profile.sh 

for i in `cat test`;do echo "nohup sh ${i}_step3_profile.sh &";done
