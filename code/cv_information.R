cv_information=function(newdata){
  errorrate<-0
  for(i in 1:5){
    train_cv<-newdata[newdata$group !=i,] %>%
      select(-group)
    test_cv<-newdata[newdata$group ==i,] %>%
      select(-group)
    model<-lm(BODYFAT~.,data=train_cv)
    pred<-predict(model,test_cv)
    errorrate<-errorrate + sum((pred-test_cv$BODYFAT)^2)
  }
  return ((errorrate/nrow(newdata)))
}