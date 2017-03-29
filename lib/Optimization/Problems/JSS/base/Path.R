setConstructorS3("Path",function()
{  
  extend(Object(),"Path",
         isCriticalPath = TRUE,
         path=NULL)  
})


setMethodS3("operationInPath","Path", function(this,
                                               job,
                                               machine,...) {
  
  result <- 0
  place  <- apply(this$path,1,function(x){ x[1] == job & x[2] == machine})
  
  if(any(place))
  {
    result <- which(place)
  }
  
  
  return(result)  
})

setMethodS3("totalDurationOfPath","Path", function(this,
                                                   instance,...) {
  
  result <- 0
  
  for(i in 1:(dim(this$path)[1]))
  {  
    result <- result + instance$duration[this$path[i,1],this$path[i,2]]
  }
  
  return(result)  
})




setMethodS3("getMachineBlocks","Path", function(this,...) {
  
  p <- this$path
  
  machineDiff <- which(p[1:(nrow(p)-1),2]-p[2:nrow(p),2] != 0)
  
  block <- data.frame("From" = c(1,machineDiff + 1),
                      "To" = c(machineDiff,nrow(p)),
                      "MachineID" = p[c(machineDiff,nrow(p)),2])
  
  return(block)  
})



setMethodS3("getBlocks","Path", function(this,...) {
  
  p <- as.data.frame(this$path)
  
  colnames(p)[1] <- "job"
  colnames(p)[2] <- "machine"  
  
  p$blockType <- "job"
  
  #  >
  if(nrow(p) > 1)
  {
    for(i in 1:(nrow(p)-1 ))
    {
      #p[i,"blockID"] <- blockID
      
      if(p[i ,2] == p[i + 1,2])
      {
        p[i,"componentID"] <- p[i ,2]
        p[i,"blockType"] <- "machine"
        
        p[i + 1,"componentID"] <- p[i + 1 ,2]
        p[i + 1,"blockType"] <- "machine"
      }
    }
  }
  
  p[p$blockType == "job","componentID"] <- p[p$blockType == "job" ,1]
  
  typeAndID <- paste(p[,"blockType"],p[,"componentID"])
  
  blockID <- 1
  p[1,"blockID"] <- 1
  
  if(nrow(p) > 1)
  {
    
    for(k in 2:length(typeAndID))
    {
      if(typeAndID[k] != typeAndID[k-1])
      {
        blockID <- blockID + 1
      }
      
      p[k,"blockID"] <- blockID
    }
    
    
    
  }
  
  return(p)  
})

