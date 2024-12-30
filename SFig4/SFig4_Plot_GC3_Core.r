#Supplementary Figure 4

data1 <- read.csv("Hyperthermophiles.csv",header=T)
attach(data1)

data2 <- read.csv("Thermophiles.csv",header=T)
attach(data2)

data3 <- read.csv("Mesophiles.csv",header=T)
attach(data3)

# Hyperthermophiles

dims1 <- dim(data1)

m.gc1 <- c()
for (i in c(4:dims1[2])) {
    gc <- unlist(data1[i]) * 100
    m.gc1 <- c(m.gc1, mean(gc))
}

core.gc1 <- unlist(data1$Core_GC) * 100
m.gc1 <- c(m.gc1, mean(core.gc1))

x1 <- 1:length(m.gc1) 

# Thermophiles 

dims2 <- dim(data2)

m.gc2 <- c()
for (i in c(4:dims2[2])) {
    gc2 <- unlist(data2[i]) * 100
    m.gc2 <- c(m.gc2, mean(gc2))
}

core.gc2 <- unlist(data2$Core_GC) * 100
m.gc2 <- c(m.gc2, mean(core.gc2))

x2 <- 1:length(m.gc2) 

# Mesoophiles

dims3 <- dim(data3)

m.gc3 <- c()
for (i in c(4:dims3[2])) {
    gc3 <- unlist(data3[i]) * 100
    m.gc3 <- c(m.gc3, mean(gc3))
}

core.gc3 <- unlist(data3$Core_GC) * 100
m.gc3 <- c(m.gc3, mean(core.gc3))  

x3 <- 1:length(m.gc3) 

col_v.1 <- rep("blue", length(m.gc1) - 1)
col_v <- c(col_v.1, "red")

# Output PDF
pdf("SFig4_Core_GC3.pdf", height=5, width=10)
par(mfrow=c(1,3))
par(pty="s")

# PLOT A - Hyperthermophiles
plot(x1, m.gc1, pch=20, col=col_v, xlab="Codon position", ylab="Mean GC (%)", ylim=c(40, 55),cex.lab=1.3)
lm_model1 <- lm(m.gc1 ~ x1)
abline(lm_model1, col="red")
mtext("A.",side=3,adj=0,line=1)

# PLOT B - Thermophiles
plot(x2, m.gc2, pch=20, col=col_v, xlab="Codon position", ylab="Mean GC (%)", ylim=c(40, 55),cex.lab=1.3)
lm_model2 <- lm(m.gc2 ~ x2)
abline(lm_model2, col="red")
mtext("B.",side=3,adj=0,line=1)

# PLOT C - Mesophiles
plot(x3, m.gc3, pch=20, col=col_v, xlab="Codon position", ylab="Mean GC (%)", ylim=c(40, 55),cex.lab=1.3)
lm_model3 <- lm(m.gc3 ~ x3)
abline(lm_model3, col="red")
mtext("C.",side=3,adj=0,line=1)

dev.off()












