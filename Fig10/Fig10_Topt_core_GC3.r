#Figure 10

data1 <- read.csv("GC3_all_prop.csv",header=T)
attach(data1)

Temp<-unlist(data1[2])
core.gc3<-unlist(data1[5]) *100

pdf("Fig10_Temp_Core_GC3.pdf")
plot(Temp,core.gc3,pch=19,cex=0.7,xlab="Optimal growth temperature (°C)",ylab="Core GC3 content (%)",col="blue") #Make a plot for this aswell - to show correlation/interaction

abline(lm(core.gc3~Temp),col="red")

ct2 <-cor.test(Temp,core.gc3)
ct2.p<-ct2$p.value
ct2.rho<-ct2$estimate

#Significant figures
ctrho2 <- signif(ct2.rho, digits =3)
ctp2 <- signif(ct2.p, digits =3)

txt2<-paste("rho=",ctrho2,", p-value=",ctp2,sep="")
mtext(txt2,side=3,adj=0.9,line=-2,cex=0.8)

cor.test(Temp,core.gc3)

dev.off()



