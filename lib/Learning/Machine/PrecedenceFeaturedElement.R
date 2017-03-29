setConstructorS3("PrecedenceFeaturedElement",function()
{
  swpSeq <- Precedence()
  
  featElmt <-FeaturedElement()
  
  featElmt$object <- swpSeq
  
  extend(featElmt,"PrecedenceFeaturedElement")
})

# setMethodS3("featuresMachineAggRelativeDurations1","MachineFeaturedElement", function(this,...) {
#   
#   obj <- this$object
#   
#   instance <- obj$instance  
#   machine <- obj$machine 
#   
#   Duration <- instance$duration[,machine]
#   TotalDurationInMachine <- sum(instance$duration[,machine])
#   TotalDurationInJob <- apply(instance$duration,1,sum) 
#   TotalDurationInstance <- sum(instance$duration)
#   
#   
#   feat <- list("MachineMinOfRelativeDurationInMachine" = min(Duration/TotalDurationInMachine),
#                "MachineMaxOfRelativeDurationInMachine" = max(Duration/TotalDurationInMachine),
#                "MachineMeanOfRelativeDurationInMachine" = mean(Duration/TotalDurationInMachine),
#                "MachineMedianOfRelativeDurationInMachine" = median(Duration/TotalDurationInMachine),               
#                "MachineVarOfRelativeDurationInMachine" = var(Duration/TotalDurationInMachine),  
#                
#                "MachineMinOfRelativeDurationInJob" = min(Duration/TotalDurationInJob),
#                "MachineMaxOfRelativeDurationInJob" = max(Duration/TotalDurationInJob),
#                "MachineMeanOfRelativeDurationInJob" = mean(Duration/TotalDurationInJob),
#                "MachineMedianOfRelativeDurationInJob" = median(Duration/TotalDurationInJob),               
#                "MachineVarOfRelativeDurationInJob" = var(Duration/TotalDurationInJob), 
#                
#                "MachineMinOfRelativeDurationInInstance" = min(Duration/TotalDurationInstance),
#                "MachineMaxOfRelativeDurationInInstance" = max(Duration/TotalDurationInstance),
#                "MachineMeanOfRelativeDurationInInstance" = mean(Duration/TotalDurationInstance),
#                "MachineMedianOfRelativeDurationInInstance" = median(Duration/TotalDurationInstance),               
#                "MachineVarOfRelativeDurationInInstance" = var(Duration/TotalDurationInJob))
# 
#   return(feat)
# })

# 
# setMethodS3("featuresMachineAggDurationAfterOperationInJob1","MachineFeaturedElement", function(this,...) {
#   
#   obj <- this$object
#   
#   instance <- obj$instance
#   machine <- obj$machine
#   
#   nrJobs <- instance$nrJobs()
#   
#   feat <- list("WorkRemaining" = NULL,
#                "AvgDurationAfterInJob" = NULL,
#                "MinDurationAfterInJob" = NULL,
#                "MaxDurationAfterInJob" = NULL,
#                "MedianDurationAfterInJob" = NULL,
#                "VarDurationAfterInJob" = NULL)
#   
#   
#   for(job in 1:nrJobs)
#   {
#     order <- instance$precedence[job,machine]
#     
#     TotalDurationAfterInJob <- 0 
#     
#     AvgDurationAfterInJob <- 0 
#     MinDurationAfterInJob <- 0 
#     MaxDurationAfterInJob <- 0 
#     MedianDurationAfterInJob <- 0 
#     VarDurationAfterInJob <- 0     
#     
#     if(order < instance$nrMachines())    
#     {
#       machinesAfter <- which(instance$precedence[job,] > order)
#       TotalDurationAfterInJob <-  sum(instance$duration[job,machinesAfter])    
#       AvgDurationAfterInJob <- mean(instance$duration[job,machinesAfter])
#       MinDurationAfterInJob <- min(instance$duration[job,machinesAfter]) 
#       MaxDurationAfterInJob <- max(instance$duration[job,machinesAfter])
#       MedianDurationAfterInJob <- median(instance$duration[job,machinesAfter])
#       VarDurationAfterInJob <- var(instance$duration[job,machinesAfter])
#     }
#     
#     
#     feat[["WorkRemaining"]] <- c(feat[["WorkRemaining"]],TotalDurationAfterInJob)
#     feat[["AvgDurationAfterInJob"]] <- c(feat[["AvgDurationAfterInJob"]],AvgDurationAfterInJob)    
#     feat[["MinDurationAfterInJob"]] <- c(feat[["MinDurationAfterInJob"]],MinDurationAfterInJob)
#     feat[["MaxDurationAfterInJob"]] <- c(feat[["MaxDurationAfterInJob"]],MaxDurationAfterInJob)
#     feat[["MedianDurationAfterInJob"]] <- c(feat[["MedianDurationAfterInJob"]],MedianDurationAfterInJob)
#     feat[["VarDurationAfterInJob"]] <- c(feat[["VarDurationAfterInJob"]],VarDurationAfterInJob)
#     
#   }
#   
#   machinefeatures <- list("MachineAvgOfWorkRemaining" = mean( feat[["WorkRemaining"]]),
#                           "MachineAvgOfAvgDurationAfterInJob" = mean( feat[["AvgDurationAfterInJob"]]),
#                           "MachineAvgOfMinDurationAfterInJob" = mean( feat[["MinDurationAfterInJob"]]),
#                           "MachineAvgOfMaxDurationAfterInJob" = mean( feat[["MaxDurationAfterInJob"]]),
#                           "MachineAvgOfMedianDurationAfterInJob" = mean( feat[["MedianDurationAfterInJob"]]),
#                           "MachineAvgOfVarDurationAfterInJob" = mean( feat[["VarDurationAfterInJob"]]),
#                           "MachineMinOfWorkRemaining" = min( feat[["WorkRemaining"]]),
#                           "MachineMinOfAvgDurationAfterInJob" = min( feat[["AvgDurationAfterInJob"]]),
#                           "MachineMinOfMinDurationAfterInJob" = min( feat[["MinDurationAfterInJob"]]),
#                           "MachineMinOfMaxDurationAfterInJob" = min( feat[["MaxDurationAfterInJob"]]),
#                           "MachineMinOfMedianDurationAfterInJob" = min( feat[["MedianDurationAfterInJob"]]),
#                           "MachineMinOfVarDurationAfterInJob" = min( feat[["VarDurationAfterInJob"]]),
#                           "MachineMaxOfWorkRemaining" = max( feat[["WorkRemaining"]]),
#                           "MachineMaxOfAvgDurationAfterInJob" = max( feat[["AvgDurationAfterInJob"]]),
#                           "MachineMaxOfMinDurationAfterInJob" = max( feat[["MinDurationAfterInJob"]]),
#                           "MachineMaxOfMaxDurationAfterInJob" = max( feat[["MaxDurationAfterInJob"]]),
#                           "MachineMaxOfMedianDurationAfterInJob" = max( feat[["MedianDurationAfterInJob"]]),
#                           "MachineMaxOfVarDurationAfterInJob" = max( feat[["VarDurationAfterInJob"]]),
#                           "MachineMedianOfWorkRemaining" = median( feat[["WorkRemaining"]]),
#                           "MachineMedianOfAvgDurationAfterInJob" = median( feat[["AvgDurationAfterInJob"]]),
#                           "MachineMedianOfMinDurationAfterInJob" = median( feat[["MinDurationAfterInJob"]]),
#                           "MachineMedianOfMaxDurationAfterInJob" = median( feat[["MaxDurationAfterInJob"]]),
#                           "MachineMedianOfMedianDurationAfterInJob" = median( feat[["MedianDurationAfterInJob"]]),
#                           "MachineMedianOfVarDurationAfterInJob" = median( feat[["VarDurationAfterInJob"]]),
#                           "MachineVarOfWorkRemaining" = var( feat[["WorkRemaining"]]),
#                           "MachineVarOfAvgDurationAfterInJob" = var( feat[["AvgDurationAfterInJob"]]),
#                           "MachineVarOfMinDurationAfterInJob" = var( feat[["MinDurationAfterInJob"]]),
#                           "MachineVarOfMaxDurationAfterInJob" = var( feat[["MaxDurationAfterInJob"]]),
#                           "MachineVarOfMedianDurationAfterInJob" = var( feat[["MedianDurationAfterInJob"]]),
#                           "MachineVarOfVarDurationAfterInJob" = var( feat[["VarDurationAfterInJob"]])
#                            )
#   return(machinefeatures)
# })
# 
# 
# setMethodS3("featuresMachineAggDurationBeforeOperationInJob1","MachineFeaturedElement", function(this,...) {
#   
#   
#   
#   obj <- this$object
#   
#   instance <- obj$instance
#   machine <- obj$machine
#   
#   nrJobs <- instance$nrJobs()
#   
#   feat <- list("MinStartTime" = NULL,
#                "AvgDurationBeforeInJob" = NULL,
#                "MinDurationBeforeInJob" = NULL,
#                "MaxDurationBeforeInJob" = NULL,
#                "MedianDurationBeforeInJob" = NULL,
#                "VarDurationBeforeInJob" = NULL)
#   
#   
#   for(job in 1:nrJobs)
#   {
#     order <- instance$precedence[job,machine]
#     
#     TotalDurationBeforeInJob <- 0 
#     
#     AvgDurationBeforeInJob <- 0 
#     MinDurationBeforeInJob <- 0 
#     MaxDurationBeforeInJob <- 0 
#     MedianDurationBeforeInJob <- 0 
#     VarDurationBeforeInJob <- 0     
#     
#     if(order > 1)    
#     {
#       machinesBefore <- which(instance$precedence[job,] > order)
#       TotalDurationBeforeInJob <-  sum(instance$duration[job,machinesBefore])    
#       AvgDurationBeforeInJob <- mean(instance$duration[job,machinesBefore])
#       MinDurationBeforeInJob <- min(instance$duration[job,machinesBefore]) 
#       MaxDurationBeforeInJob <- max(instance$duration[job,machinesBefore])
#       MedianDurationBeforeInJob <- median(instance$duration[job,machinesBefore])
#       VarDurationBeforeInJob <- var(instance$duration[job,machinesBefore])
#     }
#     
#     
#     feat[["MinStartTime"]] <- c(feat[["MinStartTime"]],TotalDurationBeforeInJob)
#     feat[["AvgDurationBeforeInJob"]] <- c(feat[["AvgDurationBeforeInJob"]],AvgDurationBeforeInJob)    
#     feat[["MinDurationBeforeInJob"]] <- c(feat[["MinDurationBeforeInJob"]],MinDurationBeforeInJob)
#     feat[["MaxDurationBeforeInJob"]] <- c(feat[["MaxDurationBeforeInJob"]],MaxDurationBeforeInJob)
#     feat[["MedianDurationBeforeInJob"]] <- c(feat[["MedianDurationBeforeInJob"]],MedianDurationBeforeInJob)
#     feat[["VarDurationBeforeInJob"]] <- c(feat[["VarDurationBeforeInJob"]],VarDurationBeforeInJob)
#     
#   }
# 
#   machinefeatures <- list("MachineAvgOfMinStartTime" = mean( feat[["MinStartTime"]]),
#                           "MachineAvgOfAvgDurationBeforeInJob" = mean( feat[["AvgDurationBeforeInJob"]]),
#                           "MachineAvgOfMinDurationBeforeInJob" = mean( feat[["MinDurationBeforeInJob"]]),
#                           "MachineAvgOfMaxDurationBeforeInJob" = mean( feat[["MaxDurationBeforeInJob"]]),
#                           "MachineAvgOfMedianDurationBeforeInJob" = mean( feat[["MedianDurationBeforeInJob"]]),
#                           "MachineAvgOfVarDurationBeforeInJob" = mean( feat[["VarDurationBeforeInJob"]]),
#                           "MachineMinOfMinStartTime" = min( feat[["MinStartTime"]]),
#                           "MachineMinOfAvgDurationBeforeInJob" = min( feat[["AvgDurationBeforeInJob"]]),
#                           "MachineMinOfMinDurationBeforeInJob" = min( feat[["MinDurationBeforeInJob"]]),
#                           "MachineMinOfMaxDurationBeforeInJob" = min( feat[["MaxDurationBeforeInJob"]]),
#                           "MachineMinOfMedianDurationBeforeInJob" = min( feat[["MedianDurationBeforeInJob"]]),
#                           "MachineMinOfVarDurationBeforeInJob" = min( feat[["VarDurationBeforeInJob"]]),
#                           "MachineMaxOfMinStartTime" = max( feat[["MinStartTime"]]),
#                           "MachineMaxOfAvgDurationBeforeInJob" = max( feat[["AvgDurationBeforeInJob"]]),
#                           "MachineMaxOfMinDurationBeforeInJob" = max( feat[["MinDurationBeforeInJob"]]),
#                           "MachineMaxOfMaxDurationBeforeInJob" = max( feat[["MaxDurationBeforeInJob"]]),
#                           "MachineMaxOfMedianDurationBeforeInJob" = max( feat[["MedianDurationBeforeInJob"]]),
#                           "MachineMaxOfVarDurationBeforeInJob" = max( feat[["VarDurationBeforeInJob"]]),
#                           "MachineMedianOfMinStartTime" = median( feat[["MinStartTime"]]),
#                           "MachineMedianOfAvgDurationBeforeInJob" = median( feat[["AvgDurationBeforeInJob"]]),
#                           "MachineMedianOfMinDurationBeforeInJob" = median( feat[["MinDurationBeforeInJob"]]),
#                           "MachineMedianOfMaxDurationBeforeInJob" = median( feat[["MaxDurationBeforeInJob"]]),
#                           "MachineMedianOfMedianDurationBeforeInJob" = median( feat[["MedianDurationBeforeInJob"]]),
#                           "MachineMedianOfVarDurationBeforeInJob" = median( feat[["VarDurationBeforeInJob"]]),
#                           "MachineMedianOfMinStartTime" = median( feat[["MinStartTime"]]),
#                           "MachineMedianOfAvgDurationBeforeInJob" = median( feat[["AvgDurationBeforeInJob"]]),
#                           "MachineMedianOfMinDurationBeforeInJob" = median( feat[["MinDurationBeforeInJob"]]),
#                           "MachineMedianOfMaxDurationBeforeInJob" = median( feat[["MaxDurationBeforeInJob"]]),
#                           "MachineMedianOfMedianDurationBeforeInJob" = median( feat[["MedianDurationBeforeInJob"]]),
#                           "MachineMedianOfVarDurationBeforeInJob" = median( feat[["VarDurationBeforeInJob"]]),
#                           "MachineVarOfMinStartTime" = var( feat[["MinStartTime"]]),
#                           "MachineVarOfAvgDurationBeforeInJob" = var( feat[["AvgDurationBeforeInJob"]]),
#                           "MachineVarOfMinDurationBeforeInJob" = var( feat[["MinDurationBeforeInJob"]]),
#                           "MachineVarOfMaxDurationBeforeInJob" = var( feat[["MaxDurationBeforeInJob"]]),
#                           "MachineVarOfMedianDurationBeforeInJob" = var( feat[["MedianDurationBeforeInJob"]]),
#                           "MachineVarOfVarDurationBeforeInJob" = var( feat[["VarDurationBeforeInJob"]])
#   )
#   return(machinefeatures)
# })
# 
