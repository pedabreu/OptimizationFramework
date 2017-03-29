
setConstructorS3("Partition",function(objectName = "Machine",
                                      mainTable = "Operation_Basic",
                                      groupName = "HistogramOfOperationBasic_4_2",
                                      targetFieldName = "Instance_uniqueID",
                                      
                                      groupby = c("Instance_uniqueID","machine"), 
                                      #  subset = "Precedence < Precedence_subset",
                                      features = list(list("partition" = list(c(0,25,50,75,99)),
                                                           "formula"="Duration",
                                                           "defaultValue" = 0 )),
                                      keepMainFeatures = FALSE)
{ 
  extend(FeaturedElement(),"Partition",  
         objectName = objectName,
         type= "partition",
         mainTable = mainTable,
         groupby = groupby,
         groupName = groupName,
         targetFieldName = targetFieldName,
         keepMainFeatures = FALSE)
})





setMethodS3("addNewFeatureTable","Partition", function(this,
                                                       ...) {
  
  
})
            



setMethodS3("calculate","Partition", function(this,
                                              dataset,
                                              ...) {
  
  

  
  
  
  
  
  
  
})











# 
# setMethodS3("getInterval","Partition", function(this,
#                                                 value,
#                                                 ...) {  
# 
#   parti <- this$partition
#     
#   result <- which(parti >= value)[1]
# 
#   return(result)
# })
# 
# 
# setMethodS3("partitionDataset","Partition", function(this,
#                                                      dataset,
#                                                      ...) {
#   parti <- this$partition
#   
#   for(feat in this$features)
#   {
#     values <- dataset[,feat]
#   
#     
#     result <- lapply(values,function(x){ which(parti >= x)[1]})
#     
#     newname <- paste(feat,"Partition",sep="") 
#     newvalues <- list()
#     
#     newvalues[[newname]] <- result
#     
#     dataset <- cbind(dataset,as.data.frame(newvalues))
#   }
#   
#   return(dataset)
# })
