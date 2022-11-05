library("randomForest")


# Create the forest.
output.forest <- randomForest(formula = Outcome ~ ., data = Diabetes)

plot(output.forest)
# View the forest results.
print(output.forest) 

# Importance of each predictor.
print(importance(fit,type = 2)) 
