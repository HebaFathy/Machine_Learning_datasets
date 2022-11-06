# 5- fit the tree model using the training data
  # use rpart  (CART)
  library(rpart)
  t_m <- rpart(class_type~., training_data)
  summary(t_m)
  printcp(t_m)
  library(rpart.plot)
  rpart.plot(t_m)
  plotcp(t_m) 
  
# 6- check the model using the test data  
  tr_pr = predict(t_m, testing_data, type="class")
  mean(tr_pr != testing_High)     # 0.1253086 less than tree lib
  summary(tr_pr)
  table(testing_data[,9], tr_pr) # to see misclassified
  
  
# 7- prun the tree
  p_m<- prune(t_m, cp = 0.02)
  #summary(p_m)
  rpart.plot(p_m)
  
  
# 8- check how pruning is doing 
  tr_pr = predict(p_m,testing_data, type="class")
  mean(tr_pr != testing_High) #bigger error (.04)0.1737654 (.02/.03)0.1523148  (0.01)0.1253086 
  summary(tr_pr)
  table(testing_data[,9], tr_pr) # to see misclassified
  