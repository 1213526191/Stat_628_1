library(tidyverse)
library(car)


# Load data ---------------------------------------------------------------

path = "../data/newbodyfat2.csv"
bf_ori = read_csv(path)


# Select Variable ---------------------------------------------------------

bf = bf_ori %>%
  select(-group)
model2 = lm(BODYFAT ~., bf)

bf2 = as.data.frame(bf)
X <- model.matrix(model2)[,-1]
Y <- bf2[,1]


library(leaps) # for leaps()
library(faraway) # for Cpplot()
g <- leaps(X, Y, nbest=1)
Cpplot(g)
#1 3 6 7 14
bf_cp = bf[,c(1,2,4,7,8,15)]



# R^2 ---------------------------------------------------------------------

model_cp=lm(BODYFAT~.,data=bf_cp)
a = summary(model_cp)

# CV ----------------------------------------------------------------------

source("cv_information.R")
bf_cp$group = bf_ori$group
mse = cv_information(bf_cp)

# Output ------------------------------------------------------------------



CP = c(mse, num, a$r.squared)