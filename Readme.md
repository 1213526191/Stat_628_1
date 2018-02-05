Bodyfat Prediction
===========================

|Author|Yichen Shi|Yifan Li|Qizheng Ren
|------|----------|--------|-----------|
|E-mail|shi99@wisc.edu|yli768@wisc.edu|qren25@wisc.edu|


****
## Contents

* [Introduction](#Introduction)
* [Getting Started](#Getting-Started)
* [Code](#Code)
* [Data](#Data)
* [Image](#Image)
* [Summary](#Summary)

# Introduction

This project is to predict one's bodyfat. We have tried several ways including:   
1. one variable prediction   
2. stepwise by P-value  
3. stepwise by AIC  
4. stepwise by BIC  
5. Mellow's CP  
6. PLS  
7. PLS without **HEIGHT** variable  
8. Neural Net  
9. Decision Tree  
Finally we find that, although one variable prediction is not as precise as other methods, it is concise and easy to use as long as its accepting accuracy

# Getting Started

You need to install R.



# Code

* **final_model.R**: detecting outliers and providing estimations of parameters, R square, confidence intervals, and diagnostic plots.
* **CV_total.R**: providing Corss Validation table used in jupeter notebook.
* **guide**: creating Decision Tree provided by Professor Loh.
* **neuralnet2, neuralnet2.py, myFun.py**: creating neural net.
* **method\*.R**: providing value of CV, number of parameters used, and R square for different methods.
* **diagPlot.R**: creating diagnostic plots.
* **cv_information.R**: providing value of CV for different model.
* **DecisionTree.txt**: used in guide.
* **r_square.R**: providing R square for different models.

# Data

* **BodyFat.csv**: original dataset given by Professor.
* **newbodyfat2.csv**: created by **data_create.R** in code file. 

# Image

Three pictures used in jupyter notebook

# Summary

* **Module1.ipynb**: Final jupyter notebook.
* **Module_presentation2.ipynb**: creating slides used in class presentation through bash command below

```bash
jupyter nbconvert Module_presentation2.ipynb --to slides --post serve #Bash
```
























