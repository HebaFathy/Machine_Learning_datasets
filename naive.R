library("e1071")

naive.Diabetes <- naiveBayes(Outcome ~ ., data = Diabetes)
summary(naive.Diabetes)
naive.pred = predict(naive.Diabetes, training_data, Outcome = "class")
with(training_data, table(naive.pred, Outcome))

# testing data
naive.pred = predict(naive.Diabetes , testing_data, Outcome="class")
print(naive.pred)
mean(naive.pred != testing_type) #0.24
nv <- table(testing_data[,9], naive.pred )
confusionMatrix(nv)

##################################################
#x = Diabetes[,1:8]
#y = Diabetes[,9]
#naive_bayes <- naiveBayes(x,y)

#model = train(y,x,'nb',trControl=trainControl(method='cv',number=10))



