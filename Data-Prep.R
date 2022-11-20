# 1- after Loading nusery.data
# 2- name columns
  names(nursery)[1]<-paste("parent")
  names(nursery)[2]<-paste("has_nurs")
  names(nursery)[3]<-paste("fomr")
  names(nursery)[4]<-paste("childern")
  names(nursery)[5]<-paste("housing")
  names(nursery)[6]<-paste("finance")
  names(nursery)[7]<-paste("social")
  names(nursery)[8]<-paste("health")
  #target Class
  names(nursery)[9]<-paste("class_type")

# 3- load nursery dat into ur env.
  attach(nursery)

# 4- setup your data "spilt data"
  set.seed(2)
  train = sample(1:nrow(nursery), nrow(nursery) / 2)
  test = -train
  training_data = nursery[train,]
  testing_data = nursery[test,]
  testing_High = class_type[test]

  