setConstructorS3("InstanceOperationRepresentationDistribution",function()
{  
  
  
  extend(Instance(),"InstanceOperationRepresentationDistribution")
})



setMethodS3("calculateNewRepresentation","InstanceOperationRepresentationDistribution", function(this,
                                                                             durationPartitions c(50,99),
                                                                             precedencePartition = c(0,0.5),
                                                                             ,...) {


  
  machinesCodification <- NULL
  
  for(m in 1:this$nrMachines())
  {
    operationCodification <- NULL 
    
    for(xa in 0:(length(durationPartitions) - 1))
       {
        for(xb in 0:(length(precedencePartition) - 1))
        {
          operationCodification[paste(xa,xb,sep=";")] <- 0
        }     
      }
        
    
    
    for(j in 1:this$mrJobs())
    {
      
      d <- this$duration[j,m]
      p <- this$precedence[j,m]
      
      
      dPartition <- which(durationPartitions >= d)[1] - 1
      pPartition <- which(precedencePartition >= p)[1] - 1 
      
      operationCodification[paste(dPartition,pPartition,sep=";")] <- operationCodification[paste(dPartition,pPartition,sep=";")] + 1
    }
        
    if(is.na(machinesCodification[ paste(operationCodification,collapse=";")]))
    {
      machinesCodification[ paste(operationCodification,collapse=";")] <- 1
    }
    else
      {
        machinesCodification[ paste(operationCodification,collapse=";")] <-machinesCodification[ paste(operationCodification,collapse=";")] + 1
      }
    
  }
  return(machinesCodification)
  
  
})



