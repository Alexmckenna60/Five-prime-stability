#Opening file
fl ="Clean1.csv"
print(f"Analysing the file:{fl}")
f_o1 = open(fl, "r")
f_r1 =f_o1.read()
f_o1.close()

#Split by line
all_lines=f_r1.splitlines()
top_line=all_lines[0]
other_lines=all_lines[1:]
print(f"There are {len(other_lines)} genomes in data set clean1")
#Open my out file
fout_csv = open(f"Clean2.csv", "w")

fout_csv.write(f"{top_line}\n")

#Removing duplicate species
all_species = []

max_size = {}#dictionary
best_line = {}

for ln in other_lines:
	bits = ln.split(",")
	species_name = bits[7]
	genome_size = bits[25]
	if species_name not in all_species:
		all_species.append(species_name)
		max_size[species_name]=genome_size
		best_line[species_name]=ln
	else: 
		if genome_size > max_size[species_name]:
			max_size[species_name]=genome_size
			best_line[species_name]=ln

for gn in all_species:
	fout_csv.write(f"{best_line[gn]}\n")
fout_csv.close()

print(f"There are {len(all_species)} genomes in non redundant final data set")

#clean 2 contains complete genomes and unique organisms - largest genome
#how many before filters - include in methods 

