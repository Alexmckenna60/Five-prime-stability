#exec(open("Pandas_combine_GC3.py").read())
#import os
#import pandas as pd # pip install pandas 

#master_df = pd.DataFrame()

#csv_f = [pd.read_csv(file) for file in os.listdir(os.getcwd()) if file.endswith(".csv")]

#if csv_f:
#	master_df = pd.concat(csv_f, ignore_index = True)

#master_df.to_csv("Master_f_GC_TOPT1.csv", index=False)

import os
import pandas as pd # pip install pandas 

m_df = pd.DataFrame()

csv_f = [file for file in os.listdir(os.getcwd()) if file.endswith(".csv") and os.path.isfile(file)]

if csv_f:
	dfs = [pd.read_csv(file) for file in csv_f]
	m_df = pd.concat(dfs, axis = 1)

m_df.to_csv("GC3_TOPT.csv", index=False)

