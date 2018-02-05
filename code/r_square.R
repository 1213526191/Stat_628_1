r_square=function(a,b){
  return(1-sum((b-a)^2)/sum((b-mean(b))^2))
}
