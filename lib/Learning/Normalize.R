setConstructorS3("Normalize",function(features = NULL)
{ 
  
  
  
  extend(Object(),"Partition",         
         features = features,
         average = NULL,
         variance = NULL)
})

setMethodS3("normalizeDataset","Normalize", function(this,
                                                    dataset,
                                                    ...) {
  
  for(feat in this$features)
  {
    values <- dataset[,feat]

    avg <- this$average
    
    if(is.null(avg))
    {
      avg <- mean(values)
    }
    
    variance <- this$variance
    
    if(is.null(variance))
    {
      variance <- var(values)
    }
    
    newname <- paste(feat,"Normalized",sep="") 
    newvalues <- list()
    
    newvalues[[newname]] <- (values - avg)/variance
    
    dataset <- cbind(dataset,as.data.frame(newvalues))
  }  
  
  return(dataset)
})
