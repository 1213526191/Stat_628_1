library(tidyverse)
library(car)


# Load data ---------------------------------------------------------------

path = "data/newbodyfat2.csv"
bf_ori = read_csv(path)



# Number of Compenonts ----------------------------------------------------

library(pls)
bf = bf_ori %>%
  select(-group)
model1 <- plsr(BODYFAT ~ ., data = bf, validation = "LOO")
pls.RMSEP = RMSEP(model1, estimate="CV")
plot(pls.RMSEP, legendpos = "topright")
pls1.1_num = which.min(pls.RMSEP$val)
pls1.2_num = 3 # although 9 is the minimun, but we think 3 may be less enough


# R^2 ---------------------------------------------------------------------

source("r_square.R")
model1.1 <- plsr(BODYFAT ~ ., data = bf, validation = "LOO")
pred1 = predict(model1.1, ncomp = pls1.1_num, newdata = bf)
a1 = r_square(pred1, bf$BODYFAT)


pred2 = predict(model1.1, ncomp = pls1.2_num, newdata = bf)
a2 = r_square(pred2, bf$BODYFAT)

# CV ----------------------------------------------------------------------

bf = bf_ori
mse = 0
for(i in 1:5){
  bf_nn = bf %>%
    select(AGE:group, BODYFAT) 
  bf_train = bf_nn %>%
    filter(group != i) %>%
    select(-group)
  
  bf_test = bf_nn %>%
    filter(group == i) %>%
    select(-group)
  
  model1 <- plsr(BODYFAT ~ ., data = bf_train, validation = "LOO")
  output = predict(model1, ncomp = pls1.1_num, newdata = bf_test)
  
  mse = mse + sum((output - bf_test$BODYFAT)^2)
}
pls1.1_mse = mse/249

bf = bf_ori
mse = 0
for(i in 1:5){
  bf_nn = bf %>%
    select(AGE:group, BODYFAT) 
  bf_train = bf_nn %>%
    filter(group != i) %>%
    select(-group)
  
  bf_test = bf_nn %>%
    filter(group == i) %>%
    select(-group)
  
  model1 <- plsr(BODYFAT ~ ., data = bf_train, validation = "LOO")
  output = predict(model1, ncomp = pls1.2_num, newdata = bf_test)
  
  mse = mse + sum((output - bf_test$BODYFAT)^2)
}
pls1.2_mse = mse/249


# Conclusion --------------------------------------------------------------

## If we reduce the number of compenonts from 9 to 3, corss validation 
## merely increase by 1. So we think 3 compenonts is enough.

# Output ------------------------------------------------------------------


PLS1 = c(pls1.2_mse, pls1.2_num, a2)