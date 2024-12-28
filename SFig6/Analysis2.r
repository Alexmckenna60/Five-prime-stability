data1 <- read.csv("Hyperthermophiles_GC.csv", header = TRUE)
attach(data1)

data2 <- read.csv("Hyperthermophiles_GC3.csv", header = TRUE)
attach(data2)

# GC

dims <- dim(data1)

m.gc <- c()
sd.gc <- c()
sem.gc <- c()
x <- c(4:dims[2])

for (i in x) {
  gc <- unlist(data1[i])
  m.gc <- c(m.gc, mean(gc))
  sd.gc <- c(sd.gc, sd(gc))
  sem.gc <- c(sem.gc, sd(gc) / sqrt(length(gc)))
}

# GC3

dims2 <- dim(data2)

m.gc2 <- c()
sd.gc2 <- c()
sem.gc2 <- c()

for (i in x) {  
  gc3 <- unlist(data2[i])
  m.gc2 <- c(m.gc2, mean(gc3))
  sd.gc2 <- c(sd.gc2, sd(gc3))
  sem.gc2 <- c(sem.gc2, sd(gc3) / sqrt(length(gc3)))
}

#GC and GC3 single data frame
gc_data <- data.frame(
  Codon_Position = x,
  Mean_GC = m.gc,
  Mean_GC3 = m.gc2
)

# Shapiro-Wilk test - GC - Testing for normality
shapiro_gc <- shapiro.test(gc_data$Mean_GC)
print(shapiro_gc)

# Shapiro-Wilk test - GC3
shapiro_gc3 <- shapiro.test(gc_data$Mean_GC3)
print(shapiro_gc3)

# Paired t-test - Data not normally distributed so don't use.
#t_test_result <- t.test(gc_data$Mean_GC, gc_data$Mean_GC3, paired = TRUE)
#print(t_test_result)

# Wilcoxon test 
wilcox_result <- wilcox.test(gc_data$Mean_GC, gc_data$Mean_GC3, paired = TRUE)
print(wilcox_result)

#Supplementary Figure 6

pdf("SFig6_GC_GC3.pdf")
plot(gc_data$Codon_Position, gc_data$Mean_GC, type = "b", col = "blue", pch = 20, ylim = c(0.4, 0.65), xlab = "Codon Position", ylab = "GC Content (%)", main = "")
lines(gc_data$Codon_Position, gc_data$Mean_GC3, type = "b", col = "red", pch = 20)
#legend("topright", legend = c("GC", "GC3"), col = c("blue", "red"), lty = 1, pch = 20)
dev.off()
