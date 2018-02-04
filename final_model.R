library(tidyverse)
library(car)

path = "data/newbodyfat2.csv"
bf_ori = read_csv(path)

# Correlation Plot (All Variables) ----------------------------------------

library(corrplot)
bf = bf_ori
corrplot.mixed(cor(bf),tl.cex=0.6)

# Correlation Plot (One Variable) -----------------------------------------

ggplot(bf, aes(ABDOMEN, BODYFAT)) +
  geom_point()+
  labs(x="ABDOMEN(cm)",y="Body Fat %",
       title = "Scatterplot of Body Fat % and ABDOMEN(cm)")+
  theme(plot.title = element_text(hjust = 0.5))

# Model Summary -----------------------------------------------------------

## estimated coefficients,standard errors
bf = bf_ori
model1=lm(BODYFAT~ABDOMEN,data=bf)
print(as.data.frame(summary(model1)$coefficients))

## R^2, p-values
model_information=c(summary(model1)$r.squared,
                    summary(model1)$adj.r.squared,
                    anova(model1)$'Pr(>F)'[1])%>%as.matrix()%>%t()
colnames(model_information)=c("R-square","Adj-R-square","p-value")
print((model_information))

## confidence intervals
print(confint(model1))


# Diagnostic --------------------------------------------------------------

source("diagPlot.R")
plot_total = diagPlot(model1)
grid.arrange(plot_total[[1]], plot_total[[2]], plot_total[[3]],
             plot_total[[5]], ncol=2) 







