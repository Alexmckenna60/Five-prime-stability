#Model 1 - GC

data1 <- read.csv("GC_all_prop.csv",header=T)
attach(data1)

Temp<-unlist(data1[2])
core.gc<-unlist(data1[5])

delta_core_f_10<-unlist(data1$Difference_between_core_and_first_10_codons_GC)

model1 <- lm(delta_core_f_10 ~ Temp * core.gc)
summary(model1)
model1_summary <- summary(model1)
print(model1_summary)

#Model 2 - GC3

data2 <- read.csv("GC3_all_prop.csv",header=T)
attach(data2)

Temp2<-unlist(data2[2])
core.gc3<-unlist(data2[5])

delta_core_f_10_GC3<-unlist(data2$Difference_between_core_and_first_10_codons_GC)

model2 <- lm(delta_core_f_10_GC3 ~ Temp2 * core.gc3)
summary(model2)
model2_summary <- summary(model2)
print(model2_summary)

