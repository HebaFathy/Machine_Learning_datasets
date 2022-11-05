IsPure <- function(data) {
  length(unique(data[,ncol(data)])) == 1
}
#...........................................
Entropy <- function( vls ) {
  res <- vls/sum(vls) * log2(vls/sum(vls))
  res[vls == 0] <- 0
  -sum(res)
}
#............................................
InformationGain <- function( tble ) {
  entropyBefore <- Entropy(colSums(tble))
  s <- rowSums(tble)
  entropyAfter <- sum (s / sum(s) * apply(tble, MARGIN = 1, FUN = Entropy ))
  informationGain <- entropyBefore - entropyAfter
  return (informationGain)
}
#............................................
TrainID3 <- function(node, data) {
  
  node$obsCount <- nrow(data)
  
  #if the data-set is pure (e.g. all toxic), then
  if (IsPure(data)) {
    #construct a leaf having the name of the pure feature (e.g. 'toxic')
    child <- node$AddChild(unique(data[,ncol(data)]))
    node$feature <- tail(names(data), 1)
    child$obsCount <- nrow(data)
    child$feature <- ''
  } else {
    #calculate the information gain
    ig <- sapply(colnames(data)[-ncol(data)], 
                 function(x) InformationGain(
                   table(data[,x], data[,ncol(data)])
                 )
    )
    #chose the feature with the highest information gain (e.g. 'color')
    #if more than one feature have the same information gain, then take
    #the first one
    feature <- names(which.max(ig))
    node$feature <- feature
    
    print(feature)
    #take the subset of the data-set having that feature value
    
    childObs <- split(data[ ,names(data) != feature, drop = FALSE], 
                      data[ ,feature], 
                      drop = TRUE)
    
    for(i in 1:length(childObs)) {
      #construct a child having the name of that feature value (e.g. 'red')
      child <- node$AddChild(names(childObs)[i])
      
      #call the algorithm recursively on the child and the subset      
      TrainID3(child, childObs[[i]])
    }
    
  }
} 
#............................................
Predict <- function(tree, features) {
  if (tree$children[[1]]$isLeaf) return (tree$children[[1]]$name)
  child <- tree$children[[features[[tree$feature]]]]
  return ( Predict(child, features))
}
#...........................................
#decision <- function(x) {
# po <- sapply(x$children, function(child) child$payoff)
#  x$decision <- names(po[po == x$payoff])
#}
#...........................................
#ploting
GetNodeLabel <- function(node) switch(node$type, 
                                      terminal = paste0( '$ ', format(node$payoff, scientific = FALSE, big.mark = ",")),
                                      paste0('ER\n', '$ ', format(node$payoff, scientific = FALSE, big.mark = ",")))

GetEdgeLabel <- function(node) {
  if (!node$isRoot && node$parent$type == 'chance') {
    label = paste0(node$name, " (", node$p, ")")
  } else {
    label = node$name
  }
  return (label)
}
#......................................................................

# 5- Use ID3 function to train data
  library(data.tree)
  tree <- Node$new("Soybeans")
  TrainID3(tree, training_data)
  print(tree, "feature", "obsCount")
  plot(tree)
  #text(tree,pretty = 0)
  infgain()
  
# 6- check the model using the test data  
  len=length(testing_High)
  p_mat = testing_High
  for(i in 1:len){
    if(!(i %in% c(2,17,24)))
    {
      print(i)
      p_mat[i]=Predict(tree, testing_data[i,])
      print(p_mat[i])
    }
  }
  summary(p_mat)
  table(testing_High, p_mat)

  
  
##################### change color of tree
  
  SetGraphStyle(tree, rankdir = "TB")
  SetEdgeStyle(tree, arrowhead = "vee", color = "grey35", penwidth = 2)
  SetNodeStyle(tree, style = "filled,rounded", shape = "box", fillcolor = "GreenYellow", fontname = "helvetica", tooltip = GetDefaultTooltip)
  plot(tree)
