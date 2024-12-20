import re

#Opening file
fl ="assembly_summary.csv"
print(f"Analysing the file:{fl}")
f_o1 = open(fl, "r")
f_r1 =f_o1.read()
f_o1.close()

#Split by line
all_lines=f_r1.splitlines()
top_line=all_lines[0]
other_lines=all_lines[1:]

#Open my out file
fout_csv = open(f"Clean1.csv", "w")

fout_csv.write(f"{top_line}\n")#I added this 
cnt=0
for ln in other_lines:
	bits = ln.split(",")
	ass = bits[11]
	if re.search("[A-Za-z]",ass):
		cnt=cnt+1
	if ass == "Complete Genome" or ass == "Chromosome":
		fout_csv.write(f"{ln}\n")
fout_csv.close()

print(f"There are {cnt} prefiltered species")

