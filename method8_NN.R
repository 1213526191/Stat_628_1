library(tidyverse)
library(car)
library(foreign)

# Load data ---------------------------------------------------------------

path = "data/newbodyfat2.csv"
bf_ori = read_csv(path)

# CV ----------------------------------------------------------------------

mse = numeric(20)
for (j in 1:20) {
  a = character(5)
  
  for (i in 1:5) {
    bf_nn = bf %>%
      select(AGE:group, BODYFAT)
    bf_train = bf_nn %>%
      filter(group != i) %>%
      select(-group)
    bf_test = bf_nn %>%
      filter(group == i) %>%
      select(-group)
    write.arff(bf_train, "train.arff")
    write.arff(bf_test, "test.arff")
    a[i] = system(paste('./neuralnet2', j,  sep = " "), intern = TRUE)
    a = as.numeric(a)
    mse[j] = mean(a)
  }
  # system(paste('say', '第', j, '个已经完成', sep = " "))
}


# Output ------------------------------------------------------------------

NN = c(mean(mse), 14, NA)
