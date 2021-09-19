#step3_profile.sh
cp ../../SCZ/step3_profile.sh .;vim 
for i in `cat test`;do cp step3_profile.sh ${i}_step3_profile.sh;sed -i 's/SCZ/'${i}'/g'  ${i}_step3_profile.sh;done
sed -i 's/scz/bd/g' BD_step3_profile.sh 
sed -i 's/scz/bd1/g' BD1_step3_profile.sh 
sed -i 's/scz/bd2/g' BD2_step3_profile.sh 
sed -i 's/scz/mdd/g' MDD_step3_profile.sh 
sed -i 's/scz/asd/g' ASD_step3_profile.sh 
vim MDD_step3_profile.sh 
for i in `cat test`;do echo "nohup sh ${i}_step3_profile.sh &";done

#merge PRScore covar brain_IDPs

