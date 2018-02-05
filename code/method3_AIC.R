library(tidyverse)
library(car)


# Load data ---------------------------------------------------------------

path = "../data/newbodyfat2.csv"
bf_ori = read_csv(path)


# Select Variable ---------------------------------------------------------

bf = bf_ori %>%
  select(-group)
model2 = lm(BODYFAT ~ ., bf)
model.AIC <- step(model2, k=2)
newbf = model.AIC$model
num = ncol(newbf) - 1









# R^2 ---------------------------------------------------------------------

model_AIC=lm(BODYFAT ~ ., data=newbf)
a = summary(model_AIC)

# CV ----------------------------------------------------------------------

source("cv_information.R")
newbf$group = bf_ori$group
mse = cv_information(newbf)

# Output ------------------------------------------------------------------


AIC = c(mse, num, a$r.squared)