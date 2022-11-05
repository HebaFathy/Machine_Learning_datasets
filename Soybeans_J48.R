# 5-  fit the tree model using the training data 
  #use J48
  library(RWeka)
  library(party)
  
  m=J48(class_type~., data = training_data)
  print(m)
  if(require("party", quietly = TRUE)) plot(m)
  
  # To get the confusion matrix of J48 algorithm
  summary(m)
  

# 6- check the model using the test data  
  p=predict(m, testing_data)
  summary(p)
  table(testing_data[,36], p) # no misclassficiation in 24 testing example
  