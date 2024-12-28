#Figure 6

data1 <- read.csv("Hyperthermophiles.csv",header=T)
attach(data1)

dims <- dim(data1)

m.gc<-c()
sd.gc<-c()
sem.gc<-c()
x<-c(2:30)

for (i in c(4:dims[2])){
gc<- unlist(data1[i])

m.gc<-c(m.gc,mean(gc))

sd.1<-sd(gc)
sd.gc<-c(sd.gc,sd.1)
sem.1<-sd.1/sqrt(length(gc))
sem.gc<-c(sem.gc,sem.1)

}

core.gc<-unlist(data1$Core_GC)
m.gc<-c(m.gc,mean(core.gc))
sd.gc<-c(sd.gc,sd(core.gc))
sem.gc<-c(sem.gc,sd(core.gc)/sqrt(length(core.gc)))

col_v.1 <- rep("blue",28)
col_v <-c(col_v.1,"red")

pdf("Fig6_Hyperthermophiles_Scatterplot_SEM.pdf")
plot(x,m.gc, pch=20,col=col_v, xlab="Codon position", ylab="Mean GC (%)", ylim=c(0.4,0.48))
arrows(x,m.gc+sem.gc,x,m.gc-sem.gc,length=0.05, angle=90, code=3, col=col_v)
dev.off()




