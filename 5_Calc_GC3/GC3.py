#exec(open("GC3.py").read())

import glob
from pathlib import Path
import os
import re
import statistics

fout = open(f"GC3_core.csv", "w")
#Creating a new CSV - which will contain the same content as Calc_GC CSV + core genome GC content 

banner = ""
for l in range(2,30):
	banner = f"{banner},codon_{l}"
	
fout.write(f"Accession,Species,Core_GC3{banner}\n")

f = "Clean2.csv"
f_o = open(f, "r")
f_r =f_o.read()
f_o.close()

path = os.getcwd()
Lines = f_r.splitlines()[1:]
numgenomes = len(Lines)
cnt_bad = 0
cnt = 0
bad_list = []

for ln in Lines:
	cnt = cnt + 1
	bits = ln.split(",")
	accn = bits[0]
	if cnt %10 == 0:
		print(f"analysing {accn}: {cnt} of {numgenomes}")
	isExist = os.path.exists(os.path.join(path, accn))

	if isExist:
		try:		
			CDS_File = glob.glob(os.path.join(path,accn, "*.fna")) 
			CDS_File_str = "".join(CDS_File)
			
			#print(CDS_File_str)
			f_CDS1 = open(CDS_File_str,"r")
			f_CDS2 = f_CDS1.read()
			f_CDS1.close()
			
			f_CDS2_a = re.sub("\n>","\n£",f_CDS2)
			f_CDS2_a = f_CDS2_a[1:]
			gene_list = f_CDS2_a.split("£")
			
			GC_dict = {}
			num_dict = {}
			m_GC_dict = {}	
			
			for i in range(2,30):
				GC_dict[i]=0
				num_dict[i]=0
			
			core_GC3 = []
			
			#seq = ""
			#codon_list = []
			
			for gn in gene_list:
				fta = gn.splitlines()
				seq = "".join(fta[1:])
				
				codon_list = []
				for j in range(0, 90, 3): 
				#for j in range(0, len(seq), 3): - change to len(seq) will look at the whole sequence.
					if j < len(seq)-3:
						codon = seq[j:j + 3]
						codon_list.append(codon)
					else:
						codon_list.append("xxx")						
						
				for k in range(2, 30):
					cdn = codon_list[k-1]
					if cdn != "xxx":
						third_site = cdn[2]
						
						GC3 = (third_site.count("G")+third_site.count("C"))/len(third_site)
						GC_dict[k] = GC_dict[k] + GC3
						num_dict[k] = num_dict[k] + 1
					else:	
						GC_dict[k] = GC_dict[k]
						num_dict[k] = num_dict[k]
				
				if len(seq) > 270:
					all_codons = []
					for l in range (0, len(seq), 3):
						codon = seq[l:l + 3]
						all_codons.append(codon)
			
					middle_pos = int(len(all_codons)/2)
					
					middle_cdns = all_codons[middle_pos - 15:middle_pos + 15]
					middle_seq = "".join(middle_cdns)
					middle_seq_3 = middle_seq[2::3]
					
					middle_seq_g3 = middle_seq_3.count("G")
					middle_seq_c3 = middle_seq_3.count("C")
					middle_seq_gc3 = (middle_seq_g3 + middle_seq_c3)/len(middle_seq_3)
					core_GC3.append(middle_seq_gc3)
					
			#Calculating average GC core
			
			m_core_gc3 = statistics.mean(core_GC3)
				
			#Calculating average GC content 5'
			
			for m in range(2, 30):
				m_GC_dict[m] = GC_dict[m]/num_dict[m]
				
			outline = f"{accn},{bits[7]},{m_core_gc3}"
			
			for n in range(2,30):
				outline = f"{outline},{m_GC_dict[n]}"
			#outline = f"{outline}\n"
			fout.write(f"{outline}\n")
				
		except Exception as E:
			cnt_bad = cnt_bad + 1
			bad_list.append(accn)
			print(f"{accn} has no fna file")
			print(f"{accn} has no fna file or encountered an error: {E}")
			continue

fout.close()
            

            
        