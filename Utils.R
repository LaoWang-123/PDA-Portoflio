#Utils

missing_heatmap <- function(data,title){
  missing_values <- is.na(data)
  
  # Melt the matrix for use with ggplot
  missing_melted <- reshape2::melt(missing_values,
                                   id.vars = rownames(missing_values))
  
  # Create the heatmap
  g <- ggplot2::ggplot(missing_melted, aes(x = Var2, y = Var1)) +
    geom_tile(aes(fill = value)) +
    scale_fill_manual(name = "", labels = c("Present", "Missing"),
                      values = c("yellow", "black")) +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
    labs(x = "Variables", y = "Observations",title = title)+
    theme(plot.title = element_text(hjust = 0.5))
  return(g)
}



Tran_Brier <- function(test_set,Y.fram.test.true,Y.fram.test.pred){
  
  Ps_X <- glm(IS.framingham~log(HDLC)+log(TOTCHOL)+log(AGE)+log(SYSBP_UT+1)+log(SYSBP_T+1)+CURSMOKE+DIABETES, 
              data= test_set, family= "binomial")
  
  O_X <- (1-Ps_X$fitted.values)/Ps_X$fitted.values
  O_X.fram <- O_X[test_set$IS.framingham==1]
  
  phi_beta <- sum(O_X.fram*(Y.fram.test.true - Y.fram.test.pred)^2)/sum(test_set$IS.framingham==0)
  
  phi_beta
}
