#if (!require("BiocManager", quietly = TRUE))
#  +     install.packages("BiocManager")
#BiocManager::install(version = "3.19")
#BiocManager::install("biomaRt")
#BiocManager::install("biomartr")
#BiocManager::install("Biostrings")
#install.packages("biomartr", dependencies = TRUE)
library(biomartr)

#curr_dir <- setwd("/Users/sofiaradrizzani/Documents/Scripts/Fivecodons/Data")

curr_dir <- getwd()

#setwd("")

#setwd('/Users/alexmckenna/Desktop/Final year/S1 Modules/FinalYearProject/1 - Project_Code/not finishedR/R_2')

getwd()

allfiles <- list.files(curr_dir, pattern = "_onepergenus", full.names = TRUE)

for(f in allfiles) {
data1 <- read.csv(f, header = TRUE)
attach(data1)

df1 <- data.frame(data1)
df1$data1_accn <- df1$assembly_accession

for (a in data1$assembly_accession) {
  is.genome.available(db = "refseq", organism = a)
  
  pathname <- paste0(f, "_complete.csv")
  HS.cds.refseq <- getGenome(db = "refseq", organism = a, path = file.path(a), gunzip=TRUE)
  
}
}

#Checking column names in data1:
for (f in allfiles) {
    data1 <-read.csv(f, header = TRUE)
    print(colnames(data1))
}



