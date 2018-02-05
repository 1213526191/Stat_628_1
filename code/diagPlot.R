library(gridExtra)
library(grid)
# options(repr.plot.width=2, repr.plot.height=2)
diagPlot<-function(model){
  p1<-ggplot(model, aes(.fitted, .resid)) +
    geom_point() +
    stat_smooth(method="loess")+geom_hline(yintercept=0, col="red", linetype="dashed") +
    xlab("Fitted values")+ylab("Residuals") +
    ggtitle("Residual vs Fitted Plot")+theme_bw() 
  
  p2<-ggplot(model, aes(qqnorm(.stdresid)[[1]], .stdresid)) +
    geom_point(na.rm = TRUE) +
    # geom_abline(aes(qqline(.stdresid))) + 
    xlab("Theoretical Quantiles") +
    ylab("Standardized Residuals") +
    ggtitle("Normal Q-Q")+theme_bw()
  # ggplot(model, aes(qqline(.stdresid)))+geom_abline()
  p3<-ggplot(model, aes(.fitted, sqrt(abs(.stdresid)))) +
    geom_point(na.rm=TRUE) +
    stat_smooth(method="loess", na.rm = TRUE)+xlab("Fitted Value") +
    ylab(expression(sqrt("|Standardized residuals|"))) +
    ggtitle("Scale-Location")+theme_bw()
  
  p4<-ggplot(model, aes(seq_along(.cooksd), .cooksd)) +
    geom_bar(stat="identity", position="identity") +
    xlab("Obs. Number")+ylab("Cook's distance") +
    ggtitle("Cook's distance")+theme_bw()
  
  p5<-ggplot(model, aes(.hat, .stdresid)) +
    geom_point(aes(size=.cooksd), na.rm=TRUE) +
    stat_smooth(method="loess", na.rm=TRUE) +
    xlab("Leverage")+ylab("Standardized Residuals") +
    ggtitle("Residual vs Leverage Plot") +
    scale_size_continuous("Cook's Distance", range=c(1,5)) +
    theme_bw()+theme(legend.position="bottom")
  
  p6<-ggplot(model, aes(.hat, .cooksd)) +
    geom_point(na.rm=TRUE) +
    stat_smooth(method="loess", na.rm=TRUE) +
    xlab("Leverage hii")+ylab("Cook's Distance") +
    ggtitle("Cook's dist vs Leverage hii/(1-hii)") +
    geom_abline(slope=seq(0,3,0.5), color="gray", linetype="dashed") +
    theme_bw()
  
  return(list(rvfPlot=p1, qqPlot=p2, sclLocPlot=p3, cdPlot=p4, rvlevPlot=p5, cvlPlot=p6))
}