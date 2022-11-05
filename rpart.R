# 3- fit the tree model using the training data
# use rpart  (CART)
library(rpart)
rpart.Diabetes <- rpart(type~., training_data)
summary(rpart.Diabetes)
printcp(rpart.Diabetes)
library(rpart.plot)
rpart.plot(rpart.Diabetes)
plotcp(rpart.Diabetes) 

rpart.plot(rpart.Diabetes)


# 4- check the model using the test data  and calculate error
tree_pred = predict(rpart.Diabetes, testing_data, type="class")
mean(tree_pred != testing_type) #  0.32
summary(tree_pred)
table(testing_data[,9], tree_pred) # to see misclassified 
