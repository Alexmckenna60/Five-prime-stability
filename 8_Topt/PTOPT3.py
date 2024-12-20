#exec(open("PTOPT3.py").read())
#In terminal run command: pip install webdriver-manager

import time
from selenium import webdriver
import glob
import os
import re
import pyperclip
from selenium.webdriver.common.by import By
from os.path import exists
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.action_chains import ActionChains

import webdriver_manager
print(webdriver_manager.__version__)

from selenium import webdriver
from selenium.webdriver.chrome.service import Service 
from selenium.webdriver.chrome.options import Options
from webdriver_manager.chrome import ChromeDriverManager

#options = Options()
#options.add_experimental_option("detach",True)

#driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()), options=options)
						
#driver.get("http://www.orgene.net/CnnPOGTP/")

#Up till this point code works and it opens CnnPOGTP in chrome

#Input files = FASTA .fna

strt = time.time()

f = "species_accession.csv"
f_o = open(f, "r")
f_r =f_o.read()
f_o.close()

accns = f_r.splitlines()

# Output CSV file - working
output_csv = "Predicted_Topt3.csv"
#output_csv = "Predicted_Topt1_60.csv" - if i dont have time

fout = open(output_csv,"w")
fout.write("Accession Number, Predicted Optimum Growth Temperature\n")

failedpredictionsfile = 'failedpredictions.txt'
if exists(failedpredictionsfile):
    os.remove(failedpredictionsfile)
failed_predictions = open(failedpredictionsfile, 'w')

M = 0

for fl in accns[200:300]:

#for fl in accns[0:60]:#First 60 accessions - because of time - edit range 
	
	#fasta_d = "/Users/alexmckenna/Desktop/Final year/S1 Modules/FinalYearProject/1 - Project_Code/12_Topt"
	fasta_d = os.getcwd()
	
	M = M+1
	
	fasta_f = glob.glob(os.path.join(fasta_d,fl, "*.fna"))
		
	if len(fasta_f) > 0:
		
		fasta = fasta_f[0]
		f_o2 = open(fasta,"r")
		outstuff = f_o2.read()
		f_o2.close()
		
		#accn = os.path.basename(fasta).split("_")[0]
		
		acc = os.path.basename(fasta).split("_")
		acc_1 = acc[0]
		acc_2 = acc[1]
		parts = [acc_1,acc_2]
		accn = "_".join(parts)
		
		print(f"Processing file: {accn}")
		
		try:	
			pyperclip.copy(outstuff)

			web = webdriver.Chrome()
			url = 'http://www.orgene.net/CnnPOGTP/'
			web.get(url)
			time.sleep(2)
			actions = ActionChains(web)

			geno = web.find_element(By.XPATH, '/html/body/div[2]/div/div/div[1]/div/div/form[1]/textarea')
			geno.click()
			actions.key_down(Keys.COMMAND).perform()
			actions.send_keys("v").perform()
			actions.key_up(Keys.COMMAND).perform()
			web.implicitly_wait(10)
			RadioButtonPeriod = web.find_element(By.XPATH, '/html/body/div[2]/div/div/div[1]/div/div/form[1]/input').click()

			web.implicitly_wait(500)
			get_confirmation_text_dix_text = web.find_element(By.CSS_SELECTOR, '.Introduction_font3')
			temp = get_confirmation_text_dix_text.text
			
			# Close the browser
			web.quit()
			
		except BaseException as error:
			print('the code failed here', M, 'out of', len(accns), accn)
			fout.write(f"{accn},NA\n")
			
		else:
			if temp.endswith('℃'):
				print(f'this worked: {temp},{M} out of {len(accns)}, {accn}')
				fout.write(f"{accn},{temp}\n")
        
			else:
				print('THIS DIDNT WORK')
				failed_predictions.write(accn + '\n')
				fout.write(f"{accn},{temp}\n")
	else:
		print(f"{fl} does not exist")
		fout.write(f"{accn},{temp}\n")
		
failed_predictions.close()
fout.close()

fnn = time.time()
print(f"script took {fnn-strt} seconds")
	
#fout = open(f"Predicted_Topt.csv", "w")
#fout.write(f"Accession Number, Predicted Optimum Growth Temperature\n")

# Open CSV file for writing results
#Used right click inspection on CnnPOGT website to identify "genome_fasta_file", "button","wrap_search"





	