Read_me

Used file:
Clean1.py filters for "complete genome" and "chromosome" 
input file = assembly_summary.csv downloaded from https://ftp.ncbi.nlm.nih.gov/genomes/refseq/archaea/ on 22/10/2024
output file = clean1.csv

Before filtering there were 2314 prefiltered species

Clean2.py reads in clean1.csv and for each species determines the longest genome and writes out the corresponding line to clean2.csv
removes duplicates and takes the biggest genome size

There are 624 genomes in data set clean1

There are 549 genomes in the non-redundant final data set (following clean2.py removal of duplicates) – clean2.csv.

