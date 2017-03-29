setConstructorS3("InstanceFeaturedElement",function()
{
      
  
  featobj <- FeaturedElement()
  featobj$object <- Instance()
  
  
  extend(featobj ,"InstanceFeaturedElement")
})


setMethodS3("Target_Makespan_Heuristic_1","InstanceFeaturedElement", function(this,
                                                                              dataset,
                                                                              ...) {
  
  
  browser()
  
})

 

# 
# setMethodS3("featuresICSWorkDistributionByMachines1","InstanceFeaturedElement", function(this,
#                                                                                          ...) {
#   ## Gives a distribution of the work in ICS.
# 
#   inst5x5obj <-this$object
#   
#   instance <- inst5x5obj$instance 
#   
#   sched <- Schedule()
#   sched$setInstance(instance)
#   sched$ICS()
#   
#   feat <- list()
#   
#   for(m in 1:instance$nrMachines())
#   {
#     work <- NULL
#     
#     for(j in 1:instance$nrJobs())
#     {       
#       work <- c(work,
#                 sched$operationStartTime[j,m]:(sched$operationStartTime[j,m] + instance$duration[j,m]))
#       
#     }
#     
#     
#     work <- sort(work)
#     summarywork <- summary(work)
#     
#     
#     feat[[paste("avgICSWorkDistMachine",m,sep="")]] <- mean(work)
#     feat[[paste("varICSWorkDistMachine",m,sep="")]] <- var(work)    
#           
#     qtiles <- quantile(1:10,probs = c(0.25,0.75))
#     
#     feat[[paste("minICSWorkDistMachine",m,sep="")]] <- min(work)
#     feat[[paste("maxICSWorkDistMachine",m,sep="")]] <- max(work)
#     
#     feat[[paste("medianICSWorkDistMachine",m,sep="")]] <- median(work)
#     
#     feat[[paste("1stQuantileICSWorkDistMachine",m,sep="")]] <- qtiles[1]   
#     feat[[paste("3rdQuantileICSWorkDistMachine",m,sep="")]] <- qtiles[2]    
#   }
#   return(feat)
# })
# 
# setMethodS3("featuresRelativeMachines1","InstanceFeaturedElement", function(this,
#                                                                             ...) {
#   
#   inst5x5obj <-this$object
#   
#   instance <- inst5x5obj$instance
#   feat <- list()
#   
#   sched <- Schedule()
#   sched$setInstance(instance)
#   sched$ICS()
#   
#   meanDurations <- apply(instance$duration,2,mean)
#   maxMeanDurations <- max(meanDurations)
#   varDurations <- apply(instance$duration,2,var)
#   
#   meanStartTimes <- apply(sched$operationStartTime,2,mean)
#   maxMeanStartTimes <- max(meanStartTimes)
#   varStartTimes <- apply(sched$operationStartTime,2,var)
#   
#   meanPrec <- apply(instance$precedence,2,mean)
#   maxMeanPrecs <- max(meanPrec)
#   varPrecs <- apply(instance$precedence,2,var)
#   
#   
#   for(m in 1:instance$nrMachines())
#   {
#     
#     feat[[paste("avgDurationMachine",m,sep="")]] <- meanDurations[m]
#     feat[[paste("avgRelativeDurationMachine",m,sep="")]] <- meanDurations[m]/maxMeanDurations
#     feat[[paste("varDurationMachine",m,sep="")]] <- varDurations[m] 
#     
#     feat[[paste("avgMinStartTimeMachine",m,sep="")]] <- meanStartTimes[m]
#     feat[[paste("avgRelativeMinStartTimeMachine",m,sep="")]] <- meanStartTimes[m]/maxMeanStartTimes
#     feat[[paste("varMinStartTimeMachine",m,sep="")]] <- varStartTimes[m]
#     
#     feat[[paste("avgPrecedenceMachine",m,sep="")]] <- meanPrec[m]
#     feat[[paste("avgRelativePrecedenceMachine",m,sep="")]] <- meanPrec[m]/maxMeanPrecs
#     feat[[paste("varDurationMachine",m,sep="")]] <- varPrecs[m] 
#     
#     
#     
#     ## feat[[   ]]
#   }
#     
#   return(feat)
#   
# })



# setMethodS3("featuresCountMachineAggRelativeDurations3BinDiscretize1","InstanceFeaturedElement", function(this,...) {
#   
#   instance <- this$object
#   
#   
#   feat <- NULL
#   
#   for(machine in 1:instance$nrMachines())
#   {
#     Duration <- instance$duration[,machine]
#     TotalDurationInMachine <- sum(instance$duration[,machine])
#     TotalDurationInJob <- apply(instance$duration,1,sum) 
#     TotalDurationInstance <- sum(instance$duration)
#     
#     
#     newfeat <- data.frame("MachineMinOfRelativeDurationInMachine" = min(Duration/TotalDurationInMachine),
#                           "MachineMaxOfRelativeDurationInMachine" = max(Duration/TotalDurationInMachine),
#                           "MachineMeanOfRelativeDurationInMachine" = mean(Duration/TotalDurationInMachine),
#                           "MachineMedianOfRelativeDurationInMachine" = median(Duration/TotalDurationInMachine),               
#                           "MachineVarOfRelativeDurationInMachine" = var(Duration/TotalDurationInMachine),  
#                           
#                           "MachineMinOfRelativeDurationInJob" = min(Duration/TotalDurationInJob),
#                           "MachineMaxOfRelativeDurationInJob" = max(Duration/TotalDurationInJob),
#                           "MachineMeanOfRelativeDurationInJob" = mean(Duration/TotalDurationInJob),
#                           "MachineMedianOfRelativeDurationInJob" = median(Duration/TotalDurationInJob),               
#                           "MachineVarOfRelativeDurationInJob" = var(Duration/TotalDurationInJob), 
#                           
#                           "MachineMinOfRelativeDurationInInstance" = min(Duration/TotalDurationInstance),
#                           "MachineMaxOfRelativeDurationInInstance" = max(Duration/TotalDurationInstance),
#                           "MachineMeanOfRelativeDurationInInstance" = mean(Duration/TotalDurationInstance),
#                           "MachineMedianOfRelativeDurationInInstance" = median(Duration/TotalDurationInstance),               
#                           "MachineVarOfRelativeDurationInInstance" = var(Duration/TotalDurationInJob))
#     
#     feat <- rbind(feat,newfeat)    
#   }
#   
#   
#   
#   
#   
#   
# })
# 

setMethodS3("featuresAggOfMachineAggRelativeDurations1","InstanceFeaturedElement", function(this,...) {
  
  instance <- this$object
  
  
  feat <- NULL
  
  for(machine in 1:instance$nrMachines())
  {
    Duration <- instance$duration[,machine]
    TotalDurationInMachine <- sum(instance$duration[,machine])
    TotalDurationInJob <- apply(instance$duration,1,sum) 
    TotalDurationInstance <- sum(instance$duration)
    
    
    newfeat <- data.frame("MachineMinOfRelativeDurationInMachine" = min(Duration/TotalDurationInMachine),
                          "MachineMaxOfRelativeDurationInMachine" = max(Duration/TotalDurationInMachine),
                          "MachineMeanOfRelativeDurationInMachine" = mean(Duration/TotalDurationInMachine),
                          "MachineMedianOfRelativeDurationInMachine" = median(Duration/TotalDurationInMachine),               
                          "MachineVarOfRelativeDurationInMachine" = var(Duration/TotalDurationInMachine),  
                          
                          "MachineMinOfRelativeDurationInJob" = min(Duration/TotalDurationInJob),
                          "MachineMaxOfRelativeDurationInJob" = max(Duration/TotalDurationInJob),
                          "MachineMeanOfRelativeDurationInJob" = mean(Duration/TotalDurationInJob),
                          "MachineMedianOfRelativeDurationInJob" = median(Duration/TotalDurationInJob),               
                          "MachineVarOfRelativeDurationInJob" = var(Duration/TotalDurationInJob), 
                          
                          "MachineMinOfRelativeDurationInInstance" = min(Duration/TotalDurationInstance),
                          "MachineMaxOfRelativeDurationInInstance" = max(Duration/TotalDurationInstance),
                          "MachineMeanOfRelativeDurationInInstance" = mean(Duration/TotalDurationInstance),
                          "MachineMedianOfRelativeDurationInInstance" = median(Duration/TotalDurationInstance),               
                          "MachineVarOfRelativeDurationInInstance" = var(Duration/TotalDurationInJob))
    
    feat <- rbind(feat,newfeat)    
  }
  
  featAvg <- colMeans(feat)
  names(featAvg) <- paste("AvgOf",names(featAvg),sep="")
  
  featVar <- apply(feat,2,var)
  names(featVar) <- paste("VarOf",names(featVar),sep="")
  
  
  allfeat <- c(as.list(featAvg),as.list(featVar))
  
  
  return(allfeat)
})


setMethodS3("featuresAggOfMachineAggDurationAfterOperationInJob1","InstanceFeaturedElement", function(this,...) {
  
  instance <- this$object
    
  nrJobs <- instance$nrJobs()
  allfeats <- NULL
  
  for(machine in 1:instance$nrMachines())
  {
    
  feat <- list("WorkRemaining" = NULL,
               "AvgDurationAfterInJob" = NULL,
               "MinDurationAfterInJob" = NULL,
               "MaxDurationAfterInJob" = NULL,
               "MedianDurationAfterInJob" = NULL,
               "VarDurationAfterInJob" = NULL)
  
  
  for(job in 1:nrJobs)
  {
    order <- instance$precedence[job,machine]
    
    TotalDurationAfterInJob <- 0 
    
    AvgDurationAfterInJob <- 0 
    MinDurationAfterInJob <- 0 
    MaxDurationAfterInJob <- 0 
    MedianDurationAfterInJob <- 0 
    VarDurationAfterInJob <- 0     
    
    if(order < instance$nrMachines())    
    {
      machinesAfter <- which(instance$precedence[job,] > order)
      TotalDurationAfterInJob <-  sum(instance$duration[job,machinesAfter])    
      AvgDurationAfterInJob <- mean(instance$duration[job,machinesAfter])
      MinDurationAfterInJob <- min(instance$duration[job,machinesAfter]) 
      MaxDurationAfterInJob <- max(instance$duration[job,machinesAfter])
      MedianDurationAfterInJob <- median(instance$duration[job,machinesAfter])
      VarDurationAfterInJob <- var(instance$duration[job,machinesAfter])
    }
    
    
    feat[["WorkRemaining"]] <- c(feat[["WorkRemaining"]],TotalDurationAfterInJob)
    feat[["AvgDurationAfterInJob"]] <- c(feat[["AvgDurationAfterInJob"]],AvgDurationAfterInJob)    
    feat[["MinDurationAfterInJob"]] <- c(feat[["MinDurationAfterInJob"]],MinDurationAfterInJob)
    feat[["MaxDurationAfterInJob"]] <- c(feat[["MaxDurationAfterInJob"]],MaxDurationAfterInJob)
    feat[["MedianDurationAfterInJob"]] <- c(feat[["MedianDurationAfterInJob"]],MedianDurationAfterInJob)
    feat[["VarDurationAfterInJob"]] <- c(feat[["VarDurationAfterInJob"]],VarDurationAfterInJob)
    
  }
  
  machinefeatures <- data.frame("MachineAvgOfWorkRemaining" = mean( feat[["WorkRemaining"]]),
                          "MachineAvgOfAvgDurationAfterInJob" = mean( feat[["AvgDurationAfterInJob"]]),
                          "MachineAvgOfMinDurationAfterInJob" = mean( feat[["MinDurationAfterInJob"]]),
                          "MachineAvgOfMaxDurationAfterInJob" = mean( feat[["MaxDurationAfterInJob"]]),
                          "MachineAvgOfMedianDurationAfterInJob" = mean( feat[["MedianDurationAfterInJob"]]),
                          "MachineAvgOfVarDurationAfterInJob" = mean( feat[["VarDurationAfterInJob"]]),
                          "MachineMinOfWorkRemaining" = min( feat[["WorkRemaining"]]),
                          "MachineMinOfAvgDurationAfterInJob" = min( feat[["AvgDurationAfterInJob"]]),
                          "MachineMinOfMinDurationAfterInJob" = min( feat[["MinDurationAfterInJob"]]),
                          "MachineMinOfMaxDurationAfterInJob" = min( feat[["MaxDurationAfterInJob"]]),
                          "MachineMinOfMedianDurationAfterInJob" = min( feat[["MedianDurationAfterInJob"]]),
                          "MachineMinOfVarDurationAfterInJob" = min( feat[["VarDurationAfterInJob"]]),
                          "MachineMaxOfWorkRemaining" = max( feat[["WorkRemaining"]]),
                          "MachineMaxOfAvgDurationAfterInJob" = max( feat[["AvgDurationAfterInJob"]]),
                          "MachineMaxOfMinDurationAfterInJob" = max( feat[["MinDurationAfterInJob"]]),
                          "MachineMaxOfMaxDurationAfterInJob" = max( feat[["MaxDurationAfterInJob"]]),
                          "MachineMaxOfMedianDurationAfterInJob" = max( feat[["MedianDurationAfterInJob"]]),
                          "MachineMaxOfVarDurationAfterInJob" = max( feat[["VarDurationAfterInJob"]]),
                          "MachineMedianOfWorkRemaining" = median( feat[["WorkRemaining"]]),
                          "MachineMedianOfAvgDurationAfterInJob" = median( feat[["AvgDurationAfterInJob"]]),
                          "MachineMedianOfMinDurationAfterInJob" = median( feat[["MinDurationAfterInJob"]]),
                          "MachineMedianOfMaxDurationAfterInJob" = median( feat[["MaxDurationAfterInJob"]]),
                          "MachineMedianOfMedianDurationAfterInJob" = median( feat[["MedianDurationAfterInJob"]]),
                          "MachineMedianOfVarDurationAfterInJob" = median( feat[["VarDurationAfterInJob"]]),
                          "MachineVarOfWorkRemaining" = var( feat[["WorkRemaining"]]),
                          "MachineVarOfAvgDurationAfterInJob" = var( feat[["AvgDurationAfterInJob"]]),
                          "MachineVarOfMinDurationAfterInJob" = var( feat[["MinDurationAfterInJob"]]),
                          "MachineVarOfMaxDurationAfterInJob" = var( feat[["MaxDurationAfterInJob"]]),
                          "MachineVarOfMedianDurationAfterInJob" = var( feat[["MedianDurationAfterInJob"]]),
                          "MachineVarOfVarDurationAfterInJob" = var( feat[["VarDurationAfterInJob"]])
  )
  
  
  allfeats <- rbind(allfeats,machinefeatures)
  
  }
  
  allfeats[is.na(allfeats)] <- 0
  
  featAvg <- colMeans(allfeats)
  names(featAvg) <- paste("AvgOf",names(featAvg),sep="")
  
  featVar <- apply(allfeats,2,var)
  names(featVar) <- paste("VarOf",names(featVar),sep="")
  
  
  finalfeat <- c(as.list(featAvg),as.list(featVar))
 
  
  return(finalfeat)
  
})


setMethodS3("featuresAggOfMachineAggDurationBeforeOperationInJob1","InstanceFeaturedElement", function(this,...) {
  
  instance <- this$object
  
  nrJobs <- instance$nrJobs()
  allfeats <- NULL
  
  for(machine in 1:instance$nrMachines())
  {
    
    feat <- list("MinStartTime" = NULL,
                 "AvgDurationBeforeInJob" = NULL,
                 "MinDurationBeforeInJob" = NULL,
                 "MaxDurationBeforeInJob" = NULL,
                 "MedianDurationBeforeInJob" = NULL,
                 "VarDurationBeforeInJob" = NULL)
    
    
    for(job in 1:nrJobs)
    {
      order <- instance$precedence[job,machine]
      
      TotalDurationBeforeInJob <- 0 
      
      AvgDurationBeforeInJob <- 0 
      MinDurationBeforeInJob <- 0 
      MaxDurationBeforeInJob <- 0 
      MedianDurationBeforeInJob <- 0 
      VarDurationBeforeInJob <- 0     
      
      if(order > 1)    
      {
        machinesBefore <- which(instance$precedence[job,] < order)
        TotalDurationBeforeInJob <-  sum(instance$duration[job,machinesBefore])    
        AvgDurationBeforeInJob <- mean(instance$duration[job,machinesBefore])
        MinDurationBeforeInJob <- min(instance$duration[job,machinesBefore]) 
        MaxDurationBeforeInJob <- max(instance$duration[job,machinesBefore])
        MedianDurationBeforeInJob <- median(instance$duration[job,machinesBefore])
        VarDurationBeforeInJob <- var(instance$duration[job,machinesBefore])
      }
      
      
      feat[["MinStartTime"]] <- c(feat[["MinStartTime"]],TotalDurationBeforeInJob)
      feat[["AvgDurationBeforeInJob"]] <- c(feat[["AvgDurationBeforeInJob"]],AvgDurationBeforeInJob)    
      feat[["MinDurationBeforeInJob"]] <- c(feat[["MinDurationBeforeInJob"]],MinDurationBeforeInJob)
      feat[["MaxDurationBeforeInJob"]] <- c(feat[["MaxDurationBeforeInJob"]],MaxDurationBeforeInJob)
      feat[["MedianDurationBeforeInJob"]] <- c(feat[["MedianDurationBeforeInJob"]],MedianDurationBeforeInJob)
      feat[["VarDurationBeforeInJob"]] <- c(feat[["VarDurationBeforeInJob"]],VarDurationBeforeInJob)
      
    }
    
    machinefeatures <- data.frame("MachineAvgOfMinStartTime" = mean( feat[["MinStartTime"]]),
                                  "MachineAvgOfAvgDurationBeforeInJob" = mean( feat[["AvgDurationBeforeInJob"]]),
                                  "MachineAvgOfMinDurationBeforeInJob" = mean( feat[["MinDurationBeforeInJob"]]),
                                  "MachineAvgOfMaxDurationBeforeInJob" = mean( feat[["MaxDurationBeforeInJob"]]),
                                  "MachineAvgOfMedianDurationBeforeInJob" = mean( feat[["MedianDurationBeforeInJob"]]),
                                  "MachineAvgOfVarDurationBeforeInJob" = mean( feat[["VarDurationBeforeInJob"]]),
                                  "MachineMinOfMinStartTime" = min( feat[["MinStartTime"]]),
                                  "MachineMinOfAvgDurationBeforeInJob" = min( feat[["AvgDurationBeforeInJob"]]),
                                  "MachineMinOfMinDurationBeforeInJob" = min( feat[["MinDurationBeforeInJob"]]),
                                  "MachineMinOfMaxDurationBeforeInJob" = min( feat[["MaxDurationBeforeInJob"]]),
                                  "MachineMinOfMedianDurationBeforeInJob" = min( feat[["MedianDurationBeforeInJob"]]),
                                  "MachineMinOfVarDurationBeforeInJob" = min( feat[["VarDurationBeforeInJob"]]),
                                  "MachineMaxOfMinStartTime" = max( feat[["MinStartTime"]]),
                                  "MachineMaxOfAvgDurationBeforeInJob" = max( feat[["AvgDurationBeforeInJob"]]),
                                  "MachineMaxOfMinDurationBeforeInJob" = max( feat[["MinDurationBeforeInJob"]]),
                                  "MachineMaxOfMaxDurationBeforeInJob" = max( feat[["MaxDurationBeforeInJob"]]),
                                  "MachineMaxOfMedianDurationBeforeInJob" = max( feat[["MedianDurationBeforeInJob"]]),
                                  "MachineMaxOfVarDurationBeforeInJob" = max( feat[["VarDurationBeforeInJob"]]),
                                  "MachineMedianOfMinStartTime" = median( feat[["MinStartTime"]]),
                                  "MachineMedianOfAvgDurationBeforeInJob" = median( feat[["AvgDurationBeforeInJob"]]),
                                  "MachineMedianOfMinDurationBeforeInJob" = median( feat[["MinDurationBeforeInJob"]]),
                                  "MachineMedianOfMaxDurationBeforeInJob" = median( feat[["MaxDurationBeforeInJob"]]),
                                  "MachineMedianOfMedianDurationBeforeInJob" = median( feat[["MedianDurationBeforeInJob"]]),
                                  "MachineMedianOfVarDurationBeforeInJob" = median( feat[["VarDurationBeforeInJob"]]),
                                  "MachineVarOfMinStartTime" = var( feat[["MinStartTime"]]),
                                  "MachineVarOfAvgDurationBeforeInJob" = var( feat[["AvgDurationBeforeInJob"]]),
                                  "MachineVarOfMinDurationBeforeInJob" = var( feat[["MinDurationBeforeInJob"]]),
                                  "MachineVarOfMaxDurationBeforeInJob" = var( feat[["MaxDurationBeforeInJob"]]),
                                  "MachineVarOfMedianDurationBeforeInJob" = var( feat[["MedianDurationBeforeInJob"]]),
                                  "MachineVarOfVarDurationBeforeInJob" = var( feat[["VarDurationBeforeInJob"]])
    )
    
    
    allfeats <- rbind(allfeats,machinefeatures)
    
  }
  
  allfeats[is.na(allfeats)] <- 0
  
  featAvg <- colMeans(allfeats)
  names(featAvg) <- paste("AvgOf",names(featAvg),sep="")
  
  featVar <- apply(allfeats,2,var)
  names(featVar) <- paste("VarOf",names(featVar),sep="")
  
  
  finalfeat <- c(as.list(featAvg),as.list(featVar))
  
  
  return(finalfeat)
  
})
