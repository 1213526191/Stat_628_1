library(tidyverse)
source("method1_finalModel.R")
source("method2_pvalue.R")
source("method3_AIC.R")
source("method4_BIC.R")
source("method5_CP.R")
source("method6_PLS1.R")
source("method7_PLS2.R")
source("method8_NN.R")

mse = tibble(
  OV = OV,
  PV = PV,
  AIC = AIC,
  BIC = BIC,
  CP = CP,
  PLS1 = PLS1,
  PLS2 = PLS2,
  NN = NN,
  DT = OV # Decision tree and one variable model are the same
)
