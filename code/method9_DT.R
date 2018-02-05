library(tidyverse)
library(car)


# Load data ---------------------------------------------------------------

path = "../data/newbodyfat2.csv"
bf_ori = read_csv(path)


# Create Describe File ----------------------------------------------------

bf = bf_ori
bf.names = names(bf)
role = rep("n", ncol(bf))
role[1] = "d"
role[16] = "x"

write_csv(bf, "bf.csv")
write("bf.csv","bfdsc.txt")
write("NA",file="bfdsc.txt",append=TRUE)
write("2",file="bfdsc.txt",append=TRUE)
write.table(cbind(1:ncol(bf),bf.names,role),
            file="bfdsc.txt",append=TRUE,
            row.names=FALSE,col.names=FALSE,quote=FALSE)
system("./guide < DecisionTree.txt > log.txt")


## we find that decision tree is the same as our final model, so we don't 
## do any calculatin.

system("rm bfdsc.txt output.txt tree.tex fit.txt bf.csv log.txt")

