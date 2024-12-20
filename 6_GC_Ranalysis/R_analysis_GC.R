#source('/Users/alexmckenna/Desktop/Final year/S1 Modules/FinalYearProject/1 - Project_Code/6_R_analysis/R_analysis_GC.R')
data1 <- read.csv("GC_core.csv",header=T)
attach(data1)
coreGC <- data1[3]
data1$new_core <- coreGC
d <- dim(data1)
d.1 <- d[2]
data2 <- data1[]

r <- c(4:d.1)

accn_clean <- gsub("\\..*", "", accn)  # Removes the version part after the first dot
#print(accn_clean)


species <- unlist(data1[2])
accn <- unlist(data1[1])
accn2 <- gsub(".1","",accn)
accn3 <- gsub(".2","",accn2)

sp2 <- gsub(" ","_",species)

data2 <- subset(data1,select=r)
row.names(data2) <- sp2

data2.m <- as.matrix(data2)
data.t <- t(data2.m)

#Colour of data points - 5' 29 codons blue and core in red.

col_v.1 <- rep("blue",28)
col_v <-c(col_v.1,"red")

d.2 <- dim(data.t)[2]

for (i in c(1:d.2)) {
#fname <- paste(accn3[i],".pdf",sep="")
fname <- paste(accn_clean[i],".pdf",sep="")
pdf(fname)

#Plotting average GC at codon positions per species with core region data poiy in red. 
#Added a main title + x&y axis labels 

plot(c(1:29),data.t[,i],pch=20,col=col_v,main=paste("The average GC content at codon position in",sp2[i]),xlab="Codon",ylab="Average GC Content",ylim=c(0,1),cex.main=0.8)

#plot(c(1:29),data.t[,i],pch=20,col="black",main=paste("The average GC content at codon position in",sp2[i]),xlab="Codon",ylab="Average GC Content",ylim=c(0,1),cex.main=0.8)

abline(lm(data.t[,i]~c(1:29)))
dev.off()
}
outline <- c()

#Output CSV - column titles.
df <- data.frame("Species_Accession","Species","GC_core","The_mean_GC_of_the_first_10_codons","Difference_between_core_and_first_10_codons_GC","Linear_Regression_slope","Difference_First_and_second_codons_GC","Maximum_difference_to_core","Where_max_difference","Max_Deviation_From_Core_GC")
for (i in c(1:d.2)) {

#Accession number
acc <- accn[i]

#Species name
spn <- sp2[i]

gc_all <- data.t[,i]

#GC of the core region
gc_core <- gc_all[29]

#GC of the first 10 codons (5' region)
gc_10 <- gc_all[1:10]

#Mean GC of the first 10 codons (5' region)
m.10 <- mean(gc_10)

#Difference between the average GC of the core region and the 5' first 10 codons 
dif.core.10 <- gc_core - m.10

#Linear regression (GC content vs codon position)
reg <- lm(gc_all~c(1:29))

#Slope of the regression line
slp <- coef(reg)[2]

#GC of the first and the second codons
gc_1 <- gc_all[1]
gc_2 <- gc_all[2]
#Difference between the GC of the first and the second codons
dif.1.2 <- gc_1 - gc_2

#Difference between the GC value (1>28) and the core region GC
dif.core.all <- gc_all[1:28]-gc_core 

#Absolute difference - Identifies the largest deviation from the core region GC content 
#Greatest difference - without concern for whether the GC content is higher of lower than core region GC.
abs.core.all <- abs(dif.core.all)

#Identifies the maximum absolute difference
max.dif <- max(abs.core.all)

#Identifies the codon position of the maximum difference (+1 - due to start codon?)
where.max.dif <- which.max(abs.core.all)+1

#Shows whether the GC content is higher or lower than the core value for the greatest absolute deviation 
dif.core.all.max.value <- dif.core.all[where.max.dif-1]

outline <- c(acc,spn,gc_core,m.10,dif.core.10,slp,dif.1.2,max.dif,where.max.dif,dif.core.all.max.value)
df <- rbind(df,outline)
}

#write.csv(df,"GC_properties.csv",row.names=FALSE,col.names=FALSE)

#Creating CSV table
write.table(df,file="GC_properties.csv",sep=",",row.names=FALSE,col.names=FALSE)

