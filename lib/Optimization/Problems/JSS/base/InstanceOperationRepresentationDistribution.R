setConstructorS3("InstanceOperationRepresentationDistribution",function()
{  
  
  
  extend(Instance(),"InstanceOperationRepresentationDistribution",
         machinesCodification=NULL)
})

setMethodS3("calculateNewRepresentationMachine2",
            "InstanceOperationRepresentationDistribution",
            function(this,partitions = list(list("Duration" = c(50,99)),
                                            list("Precedence" = c(0.5,1)*max(this$precedence))),
                     ...) {
              
              
              machinesCodification <- NULL
              
              for(partGroupIndex in 1:length(partitions))
              {
                
                partGroup <- partitions[[partGroupIndex]]
                
                partNameGroup <- paste(names(partGroup),collapse="_")
               
                allPartValuesGrid <- expand.grid(lapply(partGroup,function(x){1:length(x)}))
                allPartValues <- apply(allPartValuesGrid,1,function(x)paste(x,collapse=";"))
                
          
                for(m in 1:this$nrMachines())
                {
 
                  operationCodification <- NULL
                  operationCodification[allPartValues] <- 0
                 
                  
                  for(j in 1:this$nrJobs())
                  {
                    
                    allValues <- this$operationFeatures(j,m)
                    parValues <- NULL
                    
                    for(p in 1:length(partGroup))
                    {
                      parName <- names(partGroup)[p]
                      value <- allValues[[parName]]
                      par <- partGroup[[p]]
                      
                      partitionValue <- which(par >= value)[1] 
                      
                      parValues[p] <- partitionValue
                      
                    }        
                 
                    finalPartitionValue <- paste(parValues,collapse=";")
                    operationCodification[finalPartitionValue] <- operationCodification[finalPartitionValue] + 1

                  }
                
                  
                  machinesCodification <- c(machinesCodification,
                                            paste("Machine",partNameGroup,paste(operationCodification,collapse=";"),sep="_")
                                            )
                }
                




                
              }
              
              this$machinesCodification <- machinesCodification
              return(machinesCodification)
              
              
            })



setMethodS3("calculateNewRepresentationJob2",
            "InstanceOperationRepresentationDistribution",
            function(this,partitions = list(list("Duration" = c(50,99)),
                                            list("Precedence" = c(0.5,1)*max(this$precedence))),
                     ...) {
              
              
              machinesCodification <- NULL
              
              for(partGroupIndex in 1:length(partitions))
              {
                
                partGroup <- partitions[[partGroupIndex]]
                
                partNameGroup <- paste(names(partGroup),collapse="_")
                
                allPartValuesGrid <- expand.grid(lapply(partGroup,function(x){1:length(x)}))
                allPartValues <- apply(allPartValuesGrid,1,function(x)paste(x,collapse=";"))
                
         
                for(j in 1:this$nrJobs())
                {
              
                  operationCodification <- NULL
                  operationCodification[allPartValues] <- 0
                  
                  
                  for(m in 1:this$nrMachines())
                  {
                    
                    allValues <- this$operationFeatures(j,m)
                    parValues <- NULL
                    
                    for(p in 1:length(partGroup))
                    {
                      parName <- names(partGroup)[p]
                      value <- allValues[[parName]]
                      par <- partGroup[[p]]
                      
                      partitionValue <- which(par >= value)[1] 
                      
                      parValues[p] <- partitionValue
                      
                    }        
                    
                    finalPartitionValue <- paste(parValues,collapse=";")
                    operationCodification[finalPartitionValue] <- operationCodification[finalPartitionValue] + 1
                    
                  }
                  
             
                  
                  machinesCodification <- c(machinesCodification,
                                            paste("Job",partNameGroup,paste(operationCodification,collapse=";"),sep="_")
                                            )
                }
                
                
                
                
                
                
              }
              
              this$machinesCodification <- machinesCodification
              return(machinesCodification)
              
              
            })


setMethodS3("calculateNewRepresentationMachine",
            "InstanceOperationRepresentationDistribution",
            function(this,partitions = list("Duration" = c(50,99),
                                            "Precedence" = c(0.5,1)*max(this$precedence)),
                     ...) {
              
              
              machinesCodification <- NULL
              
              allPartitionNames <- names(partitions)
              
              for(p in 1:length(partitions))
              {
                
                parName <- allPartitionNames[p]
                par <- partitions[[p]]
                allPartitionsValues <- paste(parName,1:length(par),sep="_")
                
                for(m in 1:this$nrMachines())
                {
                  operationCodification <- NULL
                  operationCodification[allPartitionsValues] <- 0
                  
                  
                  for(j in 1:this$nrJobs())
                  {
                    
                    allValues <- this$operationFeatures(j,m)
                    
                    value <- allValues[[parName]]
                    
                    
                    partitionValue <- which(par >= value)[1] 
                    
                    operationCodification[paste(parName,partitionValue,sep="_")] <- operationCodification[paste(parName,partitionValue,sep="_")] + 1
                    
                    
                  }  
                  machinesCodification <- c(machinesCodification,
                                            paste("Machine",parName,paste(operationCodification,collapse=";"),sep="_")
                                            )
                  
                  
                  
                }
              }
              
              this$machinesCodification <- machinesCodification
              return(machinesCodification)
              
              
            })



setMethodS3("calculateNewRepresentationJob",
            "InstanceOperationRepresentationDistribution",
            function(this,partitions = list("Duration" = c(50,99),
                                            "Precedence" = c(0.5,1)*max(this$precedence)),
                     ...) {
              
              
              machinesCodification <- NULL
              
              allPartitionNames <- names(partitions)
              
              for(p in 1:length(partitions))
              {
                parName <- allPartitionNames[p]
                par <- partitions[[p]]
                allPartitionsValues <- paste(parName,1:length(par),sep="_")
                
                for(j in 1:this$nrJobs())
                {
                  operationCodification <- NULL
                  operationCodification[allPartitionsValues] <- 0
                  
                  
                  for(m in 1:this$nrMachines())
                  {
                    
                    allValues <- this$operationFeatures(j,m)
                    
                    value <- allValues[[parName]]
                    
                    
                    partitionValue <- which(par >= value)[1] 
                    
                    operationCodification[paste(parName,partitionValue,sep="_")] <- operationCodification[paste(parName,partitionValue,sep="_")] + 1
                    
                    
                  }  
                  machinesCodification <- c(machinesCodification,
                                            paste("Job",parName,paste(operationCodification,collapse=";"),sep="_")
                                            )
                  
                  
                  
                }
              }
              this$machinesCodification <- machinesCodification
              return(machinesCodification)
              
              
            })


#             
# setMethodS3("calculateNewRepresentation",
#             "InstanceOperationRepresentationDistribution",
#             function(this,partitions = list("Duration" = c(50,99),
#                                             "Precedence" = c(0.5,1)*max(this$precedence)),
#                      ...) {
# 
# 
#   
#               machinesCodification <- NULL
#               
#               for(p in 1:length(partitions))
#               {
#                 
#                 
#                 
#                 
#                 
#                 
#                 
#               }
#               
#               
#               
#               
#               for(m in 1:this$nrMachines())
#               {
#                 operationCodification <- NULL 
#                 
#                 for(x in 0:(length(durationPartitions) -1))
#                 { 
#                   for(y in 0:(length(precedencePartition)-1))
#                   {
#                     operationCodification[paste(x,y,sep=";")] <- 0
#                   }
#                   
#                 }
#                 
#                 for(j in 1:this$nrJobs())
#                 {
#                   
#                   d <- this$duration[j,m]
#                   p <- this$precedence[j,m]
#                   
#                   
#                   dPartition <- which(durationPartitions >= d)[1] - 1
#                   pPartition <- which(precedencePartition >= p)[1] - 1 
#                   
#                   operationCodification[paste(dPartition,pPartition,sep=";")] <- operationCodification[paste(dPartition,pPartition,sep=";")] + 1
#                 }
#                 
#                 
#                 machinesCodification <- c(machinesCodification,
#                                           paste(operationCodification,collapse=";")
#                                           )
#                 
#                 
#               }
#               
#               this$machinesCodification <- machinesCodification
#               return(machinesCodification)
#               
#   
# })


setMethodS3("calculateNewRepresentation",
            "InstanceOperationRepresentationDistribution",
            function(this,partitions = list("Duration" = c(50,99),
                                            "Precedence" = c(0.5,1)*max(this$precedence)),
                     ...) {
              
              
              machinesCodification <- NULL
              
              allPartitionNames <- names(partitions)
              
              for(p in 1:length(partitions))
              {
                parName <- allPartitionNames[p]
                par <- partitions[[p]]
                allPartitionsValues <- paste(parName,1:length(par),sep="_")
               
                for(m in 1:this$nrMachines())
                {
                  operationCodification <- NULL
                  operationCodification[allPartitionsValues] <- 0
                  
                  
                  for(j in 1:this$nrJobs())
                  {
                    
                    allValues <- this$operationFeatures(j,m)
  
                    value <- allValues[[parName]]
                    
                    
                    partitionValue <- which(par >= value)[1] 
                  
                    operationCodification[paste(parName,partitionValue,sep="_")] <- operationCodification[paste(parName,partitionValue,sep="_")] + 1
                    
                    
                  }  
                  machinesCodification <- c(machinesCodification,
                                            paste(parName,paste(operationCodification,collapse=";"),sep="_")
                                            )
                  
                  
                  
                }
              }
              this$machinesCodification <- machinesCodification
              return(machinesCodification)
              
              
            })


setMethodS3("distance","InstanceOperationRepresentationDistribution", function(this,instance,...)
{
  thisMachinesCod <- this$machinesCodification
  instanceMachinesCod <- instance$machinesCodification
  
  dist <- NULL
  
  for(thisCod in thisMachinesCod)
  {
    for(instCod in instanceMachinesCod)
    {
      
     dist <- c(dist,
               abs(as.numeric(unlist(strsplit(instCod,";"))) - as.numeric(unlist(strsplit(thisCod,";")))))
      
    }    
    
    
  }
  return(sum(dist)/length(dist)  )
  
})
                                                                                               
                                                                                


