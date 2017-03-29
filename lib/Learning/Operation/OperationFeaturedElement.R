setConstructorS3("OperationFeaturedElement",function()
{
  swpSeq <- Operation()
  
  obj <- FeaturedElement()
  
  obj$object <- swpSeq
  
  extend(obj,"OperationFeaturedElement")
})

# 
# setMethodS3("WorkDone","OperationFeaturedElement", 
#             function(this,dataset,...) {
#               
#        
#               
#               finalDataset <- unique(dataset[,c("Instance_uniqueID","job","machine","Duration","Precedence")])
#               
#               
#               funcs <- list(sum,mean,min,max,var)
#               nameFeats <- c("MinStartTime","AvgWorkDone","MinWorkDone","MaxWorkDone","VarWorkDone")
#               
#               for(i in 1:length(funcs))
#               {
#                 f<-funcs[[i]]
#                 feat <- nameFeats[i]
#                 
#                 aggData <- with(dataset,aggregate(Duration_subset~Instance_uniqueID+job+machine,
#                                                   data=dataset,
#                                                   f,
#                                                   subset=Precedence > Precedence_subset))
#                
#                 colnames(aggData)[which(colnames(aggData)=="Duration_subset")] <- feat
#                 
#                 finalDataset <- merge(finalDataset,aggData,
#                                       all.x=TRUE,
#                                       by=c("Instance_uniqueID","job","machine"))
#                 
#               }
#               
#               
#               finalDataset[is.na(finalDataset)] <- 0
#               
#               finalDataset$MinEndTime <- with(finalDataset,Duration+MinStartTime)
#               finalDataset$RelativeMinEndTime <- with(finalDataset,MinEndTime/max(MinEndTime))
#               finalDataset$RelativeMinStartTime <- with(finalDataset,MinStartTime/max(MinStartTime))
#               
#               
#               return(finalDataset) 
#             })

# 
# setMethodS3("featuresRelativeDurations1","OperationFeaturedElement", function(this,...) {
#   
#   obj <- this$object
# 
#   instance <- obj$instance
#   machine <- obj$machine
#   job <- obj$job  
#   prec <- instance$precedence[job,machine]
# 
# 
#   Duration <- instance$duration[job,machine]
#   TotalDurationInMachine <- sum(instance$duration[,machine])
#   TotalDurationInJob <- sum(instance$duration[job,])
#   TotalDurationInstance <- sum(instance$duration)
#   
#   OperationsAfter <- which(instance$precedence[job,] > prec)
#   
#   WorkRemaining <- 0
#   RelativeDurationInWorkRemaining <- 0 
#   
#   if(length(OperationsAfter)>0)
#   {
#     WorkRemaining <- sum(instance$duration[job,OperationsAfter])
#     RelativeDurationInWorkRemaining <- Duration/WorkRemaining
#   }
#   
#   
#   
#   feat <- list("RelativeDurationInMachine" = Duration/TotalDurationInMachine,
#                "RelativeDurationInJob" = Duration/TotalDurationInJob,
#                "RelativeDurationInInstance" = Duration/TotalDurationInstance,
#                "RelativeDurationInWorkRemaining" = RelativeDurationInWorkRemaining)
# 
#   return(feat)
# })
# 
# 
# setMethodS3("featuresDurationAfterOperationInJob1","OperationFeaturedElement", function(this,...) {
#   
#   obj <- this$object
#   
#   instance <- obj$instance
#   machine <- obj$machine
#   job <- obj$job  
#   
#   order <- instance$precedence[job,machine]
#   
#   TotalDurationAfterInJob <- 0 
#   
#   AvgDurationAfterInJob <- 0 
#   MinDurationAfterInJob <- 0 
#   MaxDurationAfterInJob <- 0 
#   MedianDurationAfterInJob <- 0 
#   
#   
#   if(order < instance$nrMachines())    
#   {
#     machinesAfter <- which(instance$precedence[job,] > order)
#     TotalDurationAfterInJob <-  sum(instance$duration[job,machinesAfter])    
#     AvgDurationAfterInJob <- mean(instance$duration[job,machinesAfter])
#     MinDurationAfterInJob <- min(instance$duration[job,machinesAfter]) 
#     MaxDurationAfterInJob <- max(instance$duration[job,machinesAfter])
#     MedianDurationAfterInJob <- median(instance$duration[job,machinesAfter])
#     VarDurationAfterInJob <- var(instance$duration[job,machinesAfter])
#   }
#   
#   feat <- list("WorkRemaining" = TotalDurationAfterInJob,
#                "AvgDurationAfterInJob"=AvgDurationAfterInJob,
#                "MinDurationAfterInJob"=MinDurationAfterInJob,
#                "MaxDurationAfterInJob"=MaxDurationAfterInJob,
#                "MedianDurationAfterInJob"=MedianDurationAfterInJob,
#                "VarDurationAfterInJob"=VarDurationAfterInJob)
#   
#   return(feat)
# })
# 
# 
# setMethodS3("featuresDurationBeforeOperationInJob1","OperationFeaturedElement", function(this,...) {
#   
#   obj <- this$object
#   
#   instance <- obj$instance
#   machine <- obj$machine
#   job <- obj$job  
#   
#   order <- instance$precedence[job,machine]
#   
#   
#   TotalDurationBeforeInJob <- 0   
#   AvgDurationBeforeInJob <- 0 
#   MinDurationBeforeInJob <- 0 
#   MaxDurationBeforeInJob <- 0 
#   MedianDurationBeforeInJob <- 0 
#   
#   
#   if(order > 1)
#   {
#     
#     machinesBefore <- which(instance$precedence[job,] < order)
#     TotalDurationBeforeInJob <-  sum(instance$duration[job,machinesBefore])
#     
#     AvgDurationBeforeInJob <- mean(instance$duration[job,machinesBefore])
#     MinDurationBeforeInJob <- min(instance$duration[job,machinesBefore])
#     MaxDurationBeforeInJob <- max(instance$duration[job,machinesBefore])
#     MedianDurationBeforeInJob <- median(instance$duration[job,machinesBefore])
#     VarDurationBeforeInJob <- var(instance$duration[job,machinesBefore])
#   }
#   
#   feat <- list("MinStartTime" = TotalDurationBeforeInJob,
#                "AvgDurationBeforeInJob"=AvgDurationBeforeInJob,
#                "MinDurationBeforeInJob"=MinDurationBeforeInJob,
#                "MaxDurationBeforeInJob"=MaxDurationBeforeInJob,
#                "MedianDurationBeforeInJob"=MedianDurationBeforeInJob,
#                "VarDurationBeforeInJob"=MedianDurationBeforeInJob)
#   
#   
#   
#   return(feat)
# })
# 
