import numpy as np
import pandas as pd
data=pd.read_csv("/export/home/guiyuanyuan/UKB/brain_imaging/notask_fmri/site_54/11025_Cheadle/SCZ20/SCZ.profile",sep='\\s+')
n=5000
for i in range(n):
    data['SCORE_SCZ'+str(i)] = np.random.choice(data['SCORE_SCZ'].values,data.shape[0],replace=False)

np.savetxt("/export/home/guiyuanyuan/UKB/brain_imaging/notask_fmri/site_54/11025_Cheadle/SCZ20/SCZ_random_profile_5k",data,fmt='%s')
#for i in `cat test`;do cp SCZ_header ${i}_header;sed -i 's/SCZ/'${i}'/g' ${i}_header;done
#for i in `cat test`;do cat ${i}_header ${i}20/${i}_random_profile_5k > ${i}20/${i}20_random_profile_5k;cat ${i}_header ${i}20/${i}_random_profile_1w > ${i}20/${i}20_random_profile_1w;done
#for i in `cat test`;do rm ${i}20/${i}_random_profile_5k ${i}20/${i}_random_profile_1w;done
