#Supplementary Figure 1

#install.packages("ggplot2")

library(ggplot2)
library(tidyr) 
#tidyr - used for data manipulation (reshaping the data)

df <- read.csv('GC_core.csv')

names(df)[names(df) == 'Core_GC'] <- 'codon_30'

long <- df %>% 
  pivot_longer(
    cols = starts_with('codon'), 
    names_to = "codon",
    values_to = "GC"
  )

# %
long$GC <- long$GC * 100

#change the codon names to numbers to plot against
long$codon <- as.numeric(gsub("codon_", "", long$codon))

quartz()
  
ggplot(long, aes(codon, GC, colour = Species)) + geom_point(show.legend = FALSE) + labs(x="Codon",y="GC content (%)",title="")+ scale_y_continuous(limits = c(15, 80),expand = c(0, 0))

#Below plot scale matched GC3 plot:
#ggplot(long, aes(codon, GC, colour = Species)) + geom_point(show.legend = FALSE) + labs(x="Codon",y="GC content (%)",title="")+ scale_y_continuous(limits = c(0.05, 1),expand = c(0, 0))

ggsave("SFig1_ALL_GC.pdf", plot = last_plot())

