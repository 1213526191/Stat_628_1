library(tidyverse)
library(car)


# Load Data ---------------------------------------------------------------

bf_ori<-read_csv("../data/BodyFat.csv")


# Delete Useless Variable --------------------------------------------

bf<-bf_ori %>%
  select(-IDNO, -DENSITY)

# Detect Outliers ---------------------------------------------------------

model=lm(BODYFAT~.,data=bf)
influenceIndexPlot(model, id.n=4) # 39th and 42th may be outliers
bf_df=as.data.frame(bf)
outliers=data.frame(
  "ID"=c(39,42,182),
  "Wrong_variable"=c("WEIGHT","HEIGHT","BODYFAT"),
  "Wrong_data"=c(bf_df[39,"WEIGHT"],bf_df[42,"HEIGHT"],bf_df[182,"BODYFAT"]),
  "min"=c(min(bf_df[,"WEIGHT"]),min(bf_df[,"HEIGHT"]),min(bf_df[,"BODYFAT"])),
  "25%"=c(quantile(bf_df[,"WEIGHT"],.25),quantile(bf_df[,"HEIGHT"],.25),
          quantile(bf_df[,"BODYFAT"],.25)),
  "mean"=c(mean(bf_df[,"WEIGHT"]),mean(bf_df[,"HEIGHT"]),mean(bf_df[,"BODYFAT"])),
  "75%"=c(quantile(bf_df[,"WEIGHT"],.75),quantile(bf_df[,"HEIGHT"],.75),
          quantile(bf_df[,"BODYFAT"],.75)),
  "max"=c(max(bf_df[,"WEIGHT"]),max(bf_df[,"HEIGHT"]),max(bf_df[,"BODYFAT"])))
print(outliers)
newbf<-bf[-c(39,42,182),]

# Create CV Fold ----------------------------------------------------------

set.seed(1111)
orders=sample(1:249)
newbf$group=rep(1,249)
newbf$group[orders[1:50]] = 1
newbf$group[orders[51:100]] = 2
newbf$group[orders[101:150]] = 3
newbf$group[orders[151:200]] = 4
newbf$group[orders[201:249]] = 5

# Create newbodyfat -------------------------------------------------------

write_csv(newbf,"../data/newbodyfat2.csv")
