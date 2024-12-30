#Supplementary Figure 2

#install.packages("ggplot2")

library(ggplot2)
library(tidyr) 

df <- read.csv('GC3_core.csv')

names(df)[names(df) == 'Core_GC3'] <- 'codon_30'

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
  
ggplot(long, aes(codon, GC, colour = Species)) + geom_point(show.legend = FALSE) + labs(x="Codon",y="GC3 content (%)",title="")+ scale_y_continuous(limits = c(5, 100),expand = c(0, 0))

ggsave("SFig2_ALL_GC3.pdf", plot = last_plot())

