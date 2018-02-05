library(tidyverse)
library(car)


# Load data ---------------------------------------------------------------

path = "../data/newbodyfat2.csv"
bf_ori = read_csv(path)


# R^2 ---------------------------------------------------------------------

bf = bf_ori %>%
  select(ABDOMEN, BODYFAT) 
model1 = lm(BODYFAT ~ ., bf)
a = summary(model1)

# CV ----------------------------------------------------------------------

bf = bf_ori
mse = 0
for(i in 1:5){
  bf_nn = bf %>%
    select(ABDOMEN, group, BODYFAT) 
  bf_train = bf_nn %>%
    filter(group != i) %>%
    select(-group)
  bf_test = bf_nn %>%
    filter(group == i) %>%
    select(-group)
  model_one = lm(BODYFAT~ABDOMEN, bf_train)
  out = predict(model_one, bf_test)
  mse = mse + sum((out - bf_test$BODYFAT)^2)
}

# Output ------------------------------------------------------------------

OV = c(mse/249, 1, a$r.squared)
