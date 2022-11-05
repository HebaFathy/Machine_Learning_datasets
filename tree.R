# 5- fit the tree model using the training data
  # use tree lib
  library(tree)
  tree_model = tree(class_type~., training_data)
  summary(tree_model)
  plot(tree_model)
  text(tree_model,pretty = 0)
  
  infgain()   # information gain for all variables over building the whole tree 
  
  
# 6- check the model using the test data  
  tree_pred = predict(tree_model, testing_data, type="class")
  mean(tree_pred != testing_High) # 0.1405864
  summary(tree_pred)
  table(testing_data[,9], tree_pred) # to see misclassified 
  
  
# 7- prun the tree
  prune_model = prune.misclass(tree_model, best = 9)
  summary(prune_model);
  plot(prune_model)
  text(tree_model,pretty = 0)

    
# 8- check how pruning is doing 
  tree_pred = predict(prune_model,testing_data, type="class") 
  mean(tree_pred != testing_High) # 0.1405864  no change
  summary(tree_pred)
  table(testing_data[,9], tree_pred) # to see misclassified 
  
