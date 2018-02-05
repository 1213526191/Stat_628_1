library(tidyverse)
library(car)


# Load data ---------------------------------------------------------------

path = "../data/newbodyfat2.csv"
bf_ori = read_csv(path)


# Select Variable ---------------------------------------------------------

name_d = character()

bf = bf_ori[,-ncol(bf_ori)]
#basic model
bf2 = bf
for(i in 1:100){
  model2=lm(BODYFAT~.,data=bf2)
  a = summary(model2)
  p_v = a$coefficients[,4]
  if(all(p_v < 0.1)){
    break
  }
  name_d = c(name_d, names(bf2)[which.max(p_v[2:length(p_v)])+1])
  bf2 = bf %>%
    select(-one_of(name_d))
  names(bf2)
}

num = length(names(bf2)) - 1
names(bf2)





# R^2 ---------------------------------------------------------------------

newdata_lm = bf_ori %>%
  select(-one_of(name_d))
bf = newdata_lm %>%
  select(-group)
model1 = lm(BODYFAT ~ ., bf)
a = summary(model1)

# CV ----------------------------------------------------------------------

source("cv_information.R")
mse = cv_information(newdata_lm)

# Output ------------------------------------------------------------------


PV = c(mse, num, a$r.squared)