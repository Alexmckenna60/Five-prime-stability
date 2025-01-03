#Figure 12

data1 <- read.csv("GC3_all_prop.csv",header=T)
attach(data1)

Temp<-unlist(data1[2])
core.gc<-unlist(data1[5]) * 100

delta_core_f_10<-unlist(data1$Difference_between_core_and_first_10_codons_GC3)

pdf("Fig12_Diff_Core_GC3.pdf")
plot(core.gc,delta_core_f_10,pch=19,cex=0.7,xlab="Core GC3 content (%)",ylab=expression(Delta ~ "GC3"),col="blue")
par(pty="s")
abline(lm(delta_core_f_10~core.gc),col="red")
ct<-cor.test(delta_core_f_10,core.gc,method="spearman")
ct.p<-ct$p.value
ct.rho<-ct$estimate

#Significant figures 
ctrho <- signif(ct.rho, digits =3)
ctp <- signif(ct.p, digits =3)

txt<-paste("rho=",ctrho,", p-value=",ctp,sep="")
mtext(txt,side=3,adj=0.1,line=-2,cex=0.8)
dev.off()

