import numpy as np
import pandas as pd
data=pd.read_csv("/export/home/guiyuanyuan/UKB/brain_imaging/notask_fmri/site_54/11025_Cheadle/SCZ20/SCZ.profile",sep='\\s+')
n=5000
for i in range(n):
    data['SCORE_SCZ'+str(i)] = np.random.choice(data['SCORE_SCZ'].values,data.shape[0],replace=False)

np.savetxt("/export/home/guiyuanyuan/UKB/brain_imaging/notask_fmri/site_54/11025_Cheadle/SCZ20/SCZ_random_profile_5k",data,fmt='%s')
#cat ~/measures/SDPR/SCZ/scz20/3 SCZ_short_profile_5k > SCZ_20_short_profile_5k
