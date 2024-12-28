#Figure 2

data1 <- read.csv("GC_all_prop.csv",header=T)
attach(data1)

data2 <-read.csv("GC3_core.csv",header=T)

#Topt
Temp<-unlist(data1[2])

#CoreGC
core.gc<-unlist(data1[5])

#Core GC3
cgc <-unlist(data2[3])

pdf("Fig2_Histogram.pdf", height=10, width=10)

# Hist - two on top one below
layout(matrix(c(1, 2, 
                3, 3), nrow=2, byrow=TRUE))  

par(pty="s", mar=c(5, 5, 4, 2))

# Hist A - Core GC 
hist(core.gc, xlab="Core GC content (%)", col="blue", main="", cex.lab=1.5, cex.axis=1.2)
mtext("A.", side=3, adj=0, line=1, cex=1.5)

# Hist B - Core GC3
hist(cgc, xlab="Core GC3 content (%)", col="blue", main="", cex.lab=1.5, cex.axis=1.2)
mtext("B.", side=3, adj=0, line=1, cex=1.5)

# Hist C - Topt
hist(Temp, xlab="Optimal growth temperature (°C)", col="blue", main="", cex.lab=1.5, cex.axis=1.2)
mtext("C.", side=3, adj=0, line=1, cex=1.5)

dev.off()

#Ranges
core_gc_range <- range(core.gc, na.rm=TRUE)
core_gc3_range <- range(cgc, na.rm=TRUE)
topt_range <- range(Temp, na.rm=TRUE)

#cat("Range of Core GC content: ", core_gc_range[1], "to", core_gc_range[2], "\n")
#cat("Range of Core GC3 content: ", core_gc3_range[1], "to", core_gc3_range[2], "\n")
#cat("Range of Optimal Growth Temperature: ", topt_range[1], "to", topt_range[2], "\n")




