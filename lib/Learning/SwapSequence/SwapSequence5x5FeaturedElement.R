setConstructorS3("SwapSequence5x5FeaturedElement",function()
{
  swpSeq <- SwapSequence5x5()
  
  obj <- SwapSequenceFeaturedElement()
  
  obj$object <- swpSeq
  
  extend(obj,"SwapSequence5x5FeaturedElement")
})


setMethodS3("getObjectTableName","SwapSequence5x5FeaturedElement", function(this,
                                                             ...) {  
  return("SwapSequence5x5")  
})


setMethodS3("featuresNewSequence5x5JobsDistribution2","SwapSequence5x5FeaturedElement", function(this,
                                                                                                 ...) {
  
  swpSeq <- this$object
  
  
  instance <- swpSeq$instance
  
  seqObj <- swpSeq$sequence
  index1 <- swpSeq$index1
  index2 <-  swpSeq$index2
  
  
  seq <- seqObj$sequence
  
  newseq <- seq
  
  newseq[index1] <- seq[index2]
  newseq[index2] <- seq[index1]  
  
  feat <- list()
  for(j in 1:instance$nrJobs())
  {
    positions <- which(j == newseq)
    
    s <-summary(positions)
    
    
    feat[[paste("1stQuarterPositionDistJob",j,sep="")]] <- s[2]
    feat[[paste("3rdQuarterPositionDistJob",j,sep="")]] <- s[5]
  
  }

  return(feat)
})

setMethodS3("featuresNewSequence5x5MachineDistribution1","SwapSequence5x5FeaturedElement", function(this,
                                                                                                 ...) {
  
  swpSeq <- this$object
  
  
  instance <- swpSeq$instance
  precIndex <- instance$precedenceIndex()
  
  seqObj <- swpSeq$sequence
  index1 <- swpSeq$index1
  index2 <-  swpSeq$index2
  
  
  seq <- seqObj$sequence
  
  newseq <- seq
  
  newseq[index1] <- seq[index2]
  newseq[index2] <- seq[index1]  
  
  newseqmachines <- rep(0,length(newseq))
  
  for(i in 1:length(newseq))
  {   
       O <- length(which(newseq[1:i] == newseq[i]))
       M <- precIndex[newseq[i],O]
       newseqmachines[i] <- M
  }
  
  feat <- list()
  
  for(m in 1:instance$nrMachines())
  {
    positions <- which(m == newseqmachines)
    
    minPosition <- min(positions)
    maxPosition <- max(positions)
    medianPosition <- median(positions)
    
    feat[[paste("minPositionDistMachine",m,sep="")]] <- minPosition
    feat[[paste("maxPositionDistMachine",m,sep="")]] <- maxPosition
    feat[[paste("medianPositionDistMachine",m,sep="")]] <- medianPosition    
    
  }
  
  return(feat)
})


setMethodS3("featuresNewSequence5x5JobsDistribution1","SwapSequence5x5FeaturedElement", function(this,
                                                                                           ...) {
  
  swpSeq <- this$object
  
  
  instance <- swpSeq$instance
  
  seqObj <- swpSeq$sequence
  index1 <- swpSeq$index1
  index2 <-  swpSeq$index2
  
  
  seq <- seqObj$sequence
  
  newseq <- seq
  
  newseq[index1] <- seq[index2]
  newseq[index2] <- seq[index1]  
  
  feat <- list()
  for(j in 1:instance$nrJobs())
  {
    positions <- which(j == newseq)
    
    minPosition <- min(positions)
    maxPosition <- max(positions)
    medianPosition <- median(positions)
    
    feat[[paste("minPositionDistJob",j,sep="")]] <- minPosition
    feat[[paste("maxPositionDistJob",j,sep="")]] <- maxPosition
    feat[[paste("medianPositionDistJob",j,sep="")]] <- medianPosition    
    
  }
  
  return(feat)
})


setMethodS3("featuresSandeep","SwapSequence5x5FeaturedElement", function(this,...) {
  
  
  swpSeq <- this$object
    
  
  instance <- swpSeq$instance

  seqObj <- swpSeq$sequence
  index1 <- swpSeq$index1
  index2 <-  swpSeq$index2
  
  
  seq <- seqObj$sequence  
 
  sched <- seqObj$getSchedule(instance)

  
  newseq <- seq
  newseq[index1] <- seq[index2]
  newseq[index2] <- seq[index1]
  
  precIndex <- instance$precedenceIndex()

  J1 <- seq[index1]
  J2 <- seq[index2]  
  
  O1 <- length( which(seq[1:index1] == J1))
  O2 <- length( which(seq[1:index2] == J2))  
  
  newO1 <- length( which(newseq[1:index2] == J1))
  newO2 <- length( which(newseq[1:index1] == J2))    
  
  
  M1 <- precIndex[J1,O1]
  M2 <- precIndex[J2,O2]  
  
  newM1 <- precIndex[J1,newO1]
  newM2 <- precIndex[J2,newO2]    
  
  D1 <- instance$duration[J1,M1]
  D2 <- instance$duration[J2,M2]    
  
  newD1 <- instance$duration[J1,newM1]
  newD2 <- instance$duration[J2,newM2]  
  
  
  TMJ1 <- sum(instance$duration[,M1])
  TMJ2 <- sum(instance$duration[,M2])  
  
  newTMJ1 <- sum(instance$duration[,newM1])
  newTMJ2 <- sum(instance$duration[,newM2])  
  
  
  jobsBeforeInMachine1 <- which(sched$operationStartTime[,M1] < sched$operationStartTime[J1,M1] )
  jobsBeforeInMachine2 <- which(sched$operationStartTime[,M2] < sched$operationStartTime[J2,M2] )
  
  jobsAfterInMachine1 <- which(sched$operationStartTime[,M1] >= sched$operationStartTime[J1,M1] )
  jobsAfterInMachine2 <- which(sched$operationStartTime[,M2] >= sched$operationStartTime[J2,M2] )
  
  feat <- data.frame("J1" = J1,
                     "J2" = J2,
                     "O1" = O1,
                     "O2" = O2,
                     "M1" = M1,
                     "M2" = M2,
                     "D1" = D1,
                     "D2" = D2,             
                     "MOJ" = min(J1,J2),
                     "MAOJ" = max(J1,J2), 
                     "SM" = ifelse(M1 == M2,1,0),
                     "DBP" = index1-index2,
                     "TMJ1" = TMJ1,
                     "TMJ2" = TMJ2,   
                     "TTBMTMJ1" = TMJ1/max(apply(instance$duration,2,sum)),
                     "TTBMTMJ2" = TMJ2/max(apply(instance$duration,2,sum)),               
                     "NM1" = newM1,
                     "NM2" = newM2,
                     "SNM" = ifelse(newM1 == newM2,1,0),
                     "TTOMBTTNMJ1" = TMJ1/newTMJ1,
                     "TTOMBTTNMJ2" = TMJ2/newTMJ2, 
                     "RJMPJ1" = length(jobsBeforeInMachine1)/length(jobsAfterInMachine1),
                     "RJMPJ2" = length(jobsBeforeInMachine2)/length(jobsAfterInMachine2),
                     "NSOB1"  = length(which(seq[index1:index2] == J1)   ),
                     "NSOB2"  = length(which(seq[index1:index2] == J2)   ),
                     "DPM" = length(jobsBeforeInMachine1) - length(jobsBeforeInMachine2),
                     "TPJMJ1" = sum(instance$duration[jobsBeforeInMachine1,M1]),
                     "TPJMJ2" = sum(instance$duration[jobsBeforeInMachine2,M2]))
  return(feat)
  
})

setMethodS3("featuresJobMachineOrderIndexBased5x5","SwapSequence5x5FeaturedElement", function(this,...) {
  
  swpSeq <- this$object
  
  
  instance <- swpSeq$instance
  
  seqObj <- swpSeq$sequence
  index1 <- swpSeq$index1
  index2 <-  swpSeq$index2
  
  
  seq <- seqObj$sequence   
  
  sched <- seqObj$getSchedule(instance)
  precIndex <- instance$precedenceIndex()  
  
  J1 <- seq[index1]
  J2 <- seq[index2]  
  
  O1 <- length( which(seq[1:index1] == J1))
  O2 <- length( which(seq[1:index2] == J2))  
  
  M1 <- precIndex[J1,O1]
  M2 <- precIndex[J2,O2]  
  
  D1 <- instance$duration[J1,M1]
  D2 <-instance$duration[J2,M2]
  
  nrChangesJob1 <- 0 + ifelse(J1 == 1,1,0) + ifelse(J2 == 1,1,0)
  nrChangesJob2 <- 0 + ifelse(J1 == 2,1,0) + ifelse(J2 == 2,1,0)
  nrChangesJob3 <- 0 + ifelse(J1 == 3,1,0) + ifelse(J2 == 3,1,0)

  nrChangesMachine1 <- 0 + ifelse(M1 == 1,1,0) + ifelse(M2 == 1,1,0)
  nrChangesMachine2 <- 0 + ifelse(M1 == 2,1,0) + ifelse(M2 == 2,1,0)
  nrChangesMachine3 <- 0 + ifelse(M1 == 3,1,0) + ifelse(M2 == 3,1,0)
  
  nrChangesOrder1 <- 0 + ifelse(O1 == 1,1,0) + ifelse(O2 == 1,1,0)
  nrChangesOrder2 <- 0 + ifelse(O1 == 2,1,0) + ifelse(O2 == 2,1,0)
  nrChangesOrder3 <- 0 + ifelse(O1 == 3,1,0) + ifelse(O2 == 3,1,0)
  
  feat <- list("nrChangesJob1" = nrChangesJob1,
               "nrChangesJob2" = nrChangesJob2,
               "nrChangesJob3" = nrChangesJob3,
               "nrChangesMachine1" = nrChangesMachine1,
               "nrChangesMachine2" = nrChangesMachine2,
               "nrChangesMachine3" = nrChangesMachine3,
               "nrChangesOrder1" = nrChangesOrder1,
               "nrChangesOrder2" = nrChangesOrder2,
               "nrChangesOrder3" = nrChangesOrder3)
    
  return(feat)
  
})


setMethodS3("featuresOperationPartition5x5","SwapSequence5x5FeaturedElement", function(this,...) {
  
  swpSeq <- this$object
  
  
  instance <- swpSeq$instance
  
  seqObj <- swpSeq$sequence
  index1 <- swpSeq$index1
  index2 <-  swpSeq$index2
  
  
  seq <- seqObj$sequence   
  
  sched <- seqObj$getSchedule(instance)
  precIndex <- instance$precedenceIndex()  
  
  cp <- sched$getCriticalPath()
  gaps <- sched$jobGaps()
  machineGaps <- sched$machineGaps()

  mkspan <- sched$makespan()
  
  indexs <- c(index1,index2)
  endTimes <- sched$endTimes()
   
#   
#   
#   
#   maxDurationJob <- ##224
#   maxDurationMachine <- ##267
#   
#   maxGapsJob <- #394
#   maxGapsMachine <- ##526
#   
#   nrDurationJobPartition <- 4
#   nrDurationMachinePartition <- 4  
#   
#   nrGapsJobPartition <- 4
#   nrGapsMachinePartition <- 4
#   
# 
#   
#   partition <- (1:4)/4
#   partitionGaps <- (-1:2)/2
#   gapsJobPartition <- partitionGaps## c(0,(1:nrGapsJobPartition)*floor(maxGapsJob/nrGapsJobPartition),Inf)
#   gapsMachinePartition <- partitionGaps##c(0,(1:nrGapsMachinePartition)*floor(maxGapsMachine/nrGapsMachinePartition),Inf) 
#   
#   durationJobPartition <- partition##c(0,(1:nrDurationJobPartition)*floor(maxDurationJob/nrDurationJobPartition),Inf)
#   durationMachinePartition <- partition##c(0,(1:nrDurationMachinePartition)*floor(maxDurationMachine/nrDurationMachinePartition),Inf) 
#   
#   
#   
#   
  featNames <- c(##paste("MinStartTimeInterval-",1:length(durationJobPartition),sep=""),
    
    paste("StartTime",1:2,sep=""),
    paste("Precedence",1:2,sep=""),
    paste("Duration",1:2,sep=""),
    paste("WorkRemaining",1:2,sep=""),
    paste("DurationAfterMachine",1:2,sep=""),
    ## paste("DurationBeforeMachineInterval",1:length(durationMachinePartition),sep=""),
    paste("GapsPreviousJob",1:2,sep=""),
    ## paste("GapsAfterJobInterval",1:length(gapsJobPartition),sep=""),
    paste("GapsPreviousMachine",1:2,sep="")
    ## paste("GapsAfterMachineInterval",1:length(gapsMachinePartition),sep="")
                 )
  
  
  feat <- as.list(rep(0,length(featNames)))
  names(feat) <- featNames
  
  for(i in 1:2)
  {
    index <- indexs[i]
    J <- seq[index]
    O <- length( which(seq[1:index] == J))
    M <- precIndex[J,O]
    ST <- sched$operationStartTime[J,M]
    ET <- endTimes[J,M]
    ##jobET <- sum(endTimes[J,])
    ##machineET <- sum(endTimes[,M])
    totalGapsJob <- sum(gaps[J,])
   
    totalGapsMachine <- sum(machineGaps[which(machineGaps[,"Machine"] == M),"Gap"])  ##sum(gaps[,M])
    
    totalDurationJob <- sum(instance$duration[J,])
    totalDurationMachine <- sum(instance$duration[,M])
    
    
    StartTime <- ST/mkspan
    Precedence <- (O-1)/(instance$nrMachines()-1)
    
    
    
    SumGapsAfterMachineOperation <- 0
    
    
    afterMachineGaps <- machineGaps[which(machineGaps[,"Machine"]==M & machineGaps[,"Job1"]==J ),"Gap"]        ##which(endTimes[,M] > ET)
    
    if(length(afterMachineGaps)>0)
    {
      SumGapsAfterMachineOperation <- (sum(afterMachineGaps) - 1)/(totalGapsMachine + 1)    
    }
 
    SumGapsPreviousMachineOperation <- 0
    
   
    previousMachineGaps <- machineGaps[which(machineGaps[,"Machine"]==M & machineGaps[,"Job2"]==J ),"Gap"]        ##which(endTimes[,M] > ET)
    
    
    if(length(previousMachineGaps)>0)
    {
      SumGapsPreviousMachineOperation <- (sum(previousMachineGaps)-1)/(totalGapsMachine + 1)         
    }

    
    SumGapsAfterJobOperation <- 0
    
    if(O < instance$nrMachines())
    {
      machines <- precIndex[J,(O+1):instance$nrMachines()]
      SumGapsAfterOperation <- (sum(gaps[J,machines]) - 1)/(totalGapsJob + 1)
    }
    
    
    SumGapsPreviousJobOperation <- 0
    
    if(O > 1)
    {
      machines <- precIndex[J,1:(O-1)]
      SumGapsPreviousOperation <- (sum(gaps[J,machines]) - 1)/(totalGapsJob + 1)
    }

        
    WorkRemainingOperation <- 0
    
    if(O < instance$nrMachines())
    {
      machines <- precIndex[J,(O+1):instance$nrMachines()]
      WorkRemainingOperation <- sum(instance$duration[J,machines])/totalDurationJob
    }
        
    MinStartTimeOperation <- 0
    
    if(O > 1)
    {
      machines <- precIndex[J,1:(O-1)]
      MinStartTimeOperation <- sum(instance$duration[J,machines])/totalDurationJob      
    }      
      
    DurationAfterMachine <- 0
    operationAfter <- which(sched$operationStartTime[,M] > sched$operationStartTime[J,M])
    
    if(length(operationAfter) > 0)
    {
      DurationAfterMachine <-  sum(instance$duration[operationAfter,M])/totalDurationMachine
    }    
    
    DurationPreviousMachine <- 0
    operationPrevious <- which(sched$operationStartTime[,M] < sched$operationStartTime[J,M])
    
    if(length(operationPrevious) > 0)
    {
      DurationPreviousMachine <- sum(instance$duration[operationPrevious,M])/totalDurationMachine
    }

#     intervalStartTime <- which(StartTime <= partition)[1] 
#     intervalPrecedence <- which(Precedence <= partition)[1]     
#       
#     intervalSumGapsAfterJobOperation <- which(SumGapsAfterJobOperation <= gapsJobPartition)[1] 
#     intervalSumGapsPreviousJobOperation <- which(SumGapsPreviousJobOperation <= gapsJobPartition)[1]     
#     intervalSumGapsAfterMachineOperation <- which(SumGapsAfterMachineOperation <= gapsMachinePartition)[1]  
#     intervalSumGapsPreviousMachineOperation <- which(SumGapsPreviousMachineOperation <= gapsMachinePartition)[1]   
#     
#     intervalWorkRemainingOperation <- which(WorkRemainingOperation <= durationJobPartition)[1]     
#     intervalMinStartTime <- which(MinStartTimeOperation <= durationJobPartition)[1] 
#     intervalDurationAfterMachine <- which(DurationAfterMachine <= durationMachinePartition)[1]   
#     intervalDurationBeforeMachine <- which(DurationPreviousMachine <= durationMachinePartition)[1]   
# 
#     feat[[paste("StartTimeInterval",intervalStartTime,sep="")]] <- feat[[paste("StartTimeInterval",intervalStartTime,sep="")]] + 1
#     feat[[paste("PrecedenceInterval",intervalPrecedence,sep="")]] <- feat[[paste("PrecedenceInterval",intervalPrecedence,sep="")]] + 1 
#         
#   ##feat[[paste("MinStartTimeInterval-",intervalMinStartTime,sep="")]] <- feat[[paste("MinStartTimeInterval-",intervalMinStartTime,sep="")]] + 1
#     feat[[paste("WorkRemainingInterval",intervalWorkRemainingOperation,sep="")]] <-     feat[[paste("WorkRemainingInterval",intervalWorkRemainingOperation,sep="")]] + 1
#     feat[[paste("DurationAfterMachineInterval",intervalDurationAfterMachine,sep="")]] <- feat[[paste("DurationAfterMachineInterval",intervalDurationAfterMachine,sep="")]] + 1 
#   ##feat[[paste("DurationBeforeMachineInterval-",intervalDurationBeforeMachine,sep="")]] <- feat[[paste("DurationBeforeMachineInterval-",intervalDurationBeforeMachine,sep="")]] + 1
#     feat[[paste("GapsPreviousJobInterval",intervalSumGapsPreviousJobOperation,sep="")]] <- feat[[paste("GapsPreviousJobInterval",intervalSumGapsPreviousJobOperation,sep="")]] + 1
#   ##feat[[paste("GapsAfterJobInterval-",intervalSumGapsAfterJobOperation,sep="")]] <- feat[[paste("GapsAfterJobInterval-",intervalSumGapsAfterJobOperation,sep="")]] + 1
#     feat[[paste("GapsPreviousMachineInterval",intervalSumGapsPreviousMachineOperation,sep="")]] <- feat[[paste("GapsPreviousMachineInterval",intervalSumGapsPreviousMachineOperation,sep="")]]  + 1
#   ##feat[[paste("GapsAfterMachineInterval-",intervalSumGapsAfterMachineOperation,sep="")]] <- feat[[paste("GapsAfterMachineInterval-",intervalSumGapsAfterMachineOperation,sep="")]]  + 1
#   }
 
    feat[[paste("StartTime",i,sep="")]] <- StartTime
    feat[[paste("Precedence",i,sep="")]] <- Precedence
    
    feat[[paste("WorkRemaining",i,sep="")]] <- WorkRemainingOperation   
    feat[[paste("DurationAfterMachine",i,sep="")]] <- DurationAfterMachine
    feat[[paste("GapsPreviousJob",i,sep="")]] <- SumGapsPreviousJobOperation
    feat[[paste("GapsPreviousMachine",i,sep="")]] <- SumGapsPreviousMachineOperation
   
}

  return(feat)

  

})




setMethodS3("featuresRelativeFeaturesOfIndexs","SwapSequence5x5FeaturedElement", function(this,...) {
  
  swpSeq <- this$object
  
  
  instance <- swpSeq$instance
  
  seqObj <- swpSeq$sequence
  index1 <- swpSeq$index1
  index2 <-  swpSeq$index2
  
  nrJobs <- instance$nrJobs()
  nrMachines <- instance$nrMachines()
  nrOperations <- nrJobs*nrMachines
  
  seq <- seqObj$sequence   
  
  sched <- seqObj$getSchedule(instance)
  precIndex <- instance$precedenceIndex()  
  
  cp <- sched$getCriticalPath()
  gaps <- sched$jobGaps()
  machineGaps <- sched$machineGaps()
  
  mkspan <- sched$makespan()
  
  indexs <- c(index1,index2)
  startTimes <- sched$operationStartTime
  endTimes <- sched$endTimes()
  
  feat <- list()
  for(i in 1:2)
  {
    index <- indexs[i]
    J <- seq[index]
    O <- length( which(seq[1:index] == J))
    M <- precIndex[J,O]
    ST <- sched$operationStartTime[J,M]
    ET <- endTimes[J,M]
    ##jobET <- sum(endTimes[J,])
    ##machineET <- sum(endTimes[,M])
    D <- instance$duration[J,M]
    totalGapsJob <- sum(gaps[J,])
    
    totalGapsMachine <- sum(machineGaps[which(machineGaps[,"Machine"] == M),"Gap"])  ##sum(gaps[,M])
    
    totalDurationJob <- sum(instance$duration[J,])
    totalDurationMachine <- sum(instance$duration[,M])
    
    
    StartTime <- ST/mkspan
    Precedence <- (O-1)/(instance$nrMachines()-1)
    
    
    
    SumGapsAfterMachineOperation <- 0
    
    
    afterMachineGaps <- machineGaps[which(machineGaps[,"Machine"]==M & machineGaps[,"Job1"]==J ),"Gap"]        ##which(endTimes[,M] > ET)
    
    if(length(afterMachineGaps)>0)
    {
      SumGapsAfterMachineOperation <- (sum(afterMachineGaps) - 1)/(totalGapsMachine + 1)    
    }
    
    SumGapsPreviousMachineOperation <- 0
    
    
    previousMachineGaps <- machineGaps[which(machineGaps[,"Machine"]==M & machineGaps[,"Job2"]==J ),"Gap"]        ##which(endTimes[,M] > ET)
    
    
    if(length(previousMachineGaps)>0)
    {
      SumGapsPreviousMachineOperation <- sum(previousMachineGaps)
      ##SumGapsPreviousMachineOperation <- (sum(previousMachineGaps)-1)/(totalGapsMachine + 1)         
    }
    
    
    SumGapsAfterJobOperation <- 0
    
    if(O < instance$nrMachines())
    {
      machines <- precIndex[J,(O+1):instance$nrMachines()]
      SumGapsAfterOperation <- (sum(gaps[J,machines]) - 1)/(totalGapsJob + 1)
    }
    
    
    SumGapsPreviousJobOperation <- 0
    
    if(O > 1)
    {
      machines <- precIndex[J,1:(O-1)]
      SumGapsPreviousOperation <- sum(gaps[J,machines]) 
      ##SumGapsPreviousOperation <- (sum(gaps[J,machines]) - 1)/(totalGapsJob + 1)
      
      }
    
    
    WorkRemainingOperation <- 0
    
    if(O < instance$nrMachines())
    {
      machines <- precIndex[J,(O+1):instance$nrMachines()]
      WorkRemainingOperation <- sum(instance$duration[J,machines])/totalDurationJob
    }
    
    MinStartTimeOperation <- 0
    
    if(O > 1)
    {
      machines <- precIndex[J,1:(O-1)]
      MinStartTimeOperation <- sum(instance$duration[J,machines])/totalDurationJob      
    }      
    
    DurationAfterMachine <- 0
    operationAfter <- which(sched$operationStartTime[,M] > sched$operationStartTime[J,M])
    
    if(length(operationAfter) > 0)
    {
      DurationAfterMachine <-  sum(instance$duration[operationAfter,M])/totalDurationMachine
    }    
    
    DurationPreviousMachine <- 0
    operationPrevious <- which(sched$operationStartTime[,M] < sched$operationStartTime[J,M])
    
    if(length(operationPrevious) > 0)
    {
      DurationPreviousMachine <- sum(instance$duration[operationPrevious,M])/totalDurationMachine
    }
    

    
    feat[[paste("DurationRelativeTotalDuration",i,sep="")]] <- D/mkspan
    feat[[paste("DurationRelativeTotalJobDuration",i,sep="")]] <- D/totalDurationJob
    feat[[paste("DurationRelativeTotalMachineDuration",i,sep="")]] <- D/totalDurationMachine   
    
    
    feat[[paste("RelativeRankDurationInstance",i,sep="")]] <- length(which(instance$duration < D ))/nrOperations
    feat[[paste("RelativeRankDurationJob",i,sep="")]] <-  length(which(instance$duration[J,] < D ))/nrJobs
    feat[[paste("RelativeRankDurationMachine",i,sep="")]] <-length(which(instance$duration[,M] < D ))/nrMachines
    
    
    
    feat[[paste("StartTimeRelativeMakespan",i,sep="")]] <- ST/mkspan
    feat[[paste("StartTimeRelativeJobMakespan",i,sep="")]] <- ST/max(startTimes[J,])    
    feat[[paste("StartTimeRelativeMachineMakespan",i,sep="")]] <- ST/max(startTimes[,M])    
    
    
    feat[[paste("Precedence",i,sep="")]] <- Precedence
    
    feat[[paste("WorkRemaining",i,sep="")]] <- WorkRemainingOperation   
    feat[[paste("DurationAfterMachine",i,sep="")]] <- DurationAfterMachine
    feat[[paste("GapsPreviousJob",i,sep="")]] <- SumGapsPreviousJobOperation
    feat[[paste("GapsPreviousMachine",i,sep="")]] <- SumGapsPreviousMachineOperation
    
  }
  
  return(feat)
  
  
  
})

setMethodS3("featuresOperationIndexBased5x5","SwapSequence5x5FeaturedElement", function(this,...) {
  
  swpSeq <- this$object
  
  
  instance <- swpSeq$instance
  
  seqObj <- swpSeq$sequence
  index1 <- swpSeq$index1
  index2 <-  swpSeq$index2

  
  seq <- seqObj$sequence   
  
  sched <- seqObj$getSchedule(instance)
  precIndex <- instance$precedenceIndex()  
  
  cp <- sched$getCriticalPath()
  gaps <- sched$gaps()
  
  
  J1 <- seq[index1]
  J2 <- seq[index2]  
  
  O1 <- length( which(seq[1:index1] == J1))
  O2 <- length( which(seq[1:index2] == J2))  
  
  M1 <- precIndex[J1,O1]
  M2 <- precIndex[J2,O2]  
  
  D1 <- instance$duration[J1,M1]
  D2 <-instance$duration[J2,M2]
  
  feat <- list()
  i <- 1
  
  for(j in 1:instance$nrJobs())
  {
    for(m in 1:instance$nrMachines())
    {
      order <- instance$precedence[j,m]
  
      feat[[paste("DurationOperation",i,sep="")]] <- instance$duration[j,m]
      feat[[paste("PrecedenceOperation",i,sep="")]] <- instance$precedence[j,m]
      feat[[paste("StartTimeOperation",i,sep="")]] <- sched$operationStartTime[j,m]


      feat[[paste("SumGapsAfterOperation",i,sep="")]] <- 0
      
      if(order < instance$nrMachines())
      {
        machines <- precIndex[j,(order+1):instance$nrMachines()]
        feat[[paste("SumGapsAfterOperation",i,sep="")]] <- sum(gaps[j,machines])
        
      }
      
      feat[[paste("SumGapsPreviousOperation",i,sep="")]] <- 0
      
      if(order > 1)
      {
        machines <- precIndex[j,1:(order-1)]
        feat[[paste("SumGapsPreviousOperation",i,sep="")]] <- sum(gaps[j,machines])
        
      }
      
      
      
      
      feat[[paste("WorkRemainingOperation",i,sep="")]] <- 0
      
      if(order < instance$nrMachines())
      {
       machines <- precIndex[j,(order+1):instance$nrMachines()]
       feat[[paste("WorkRemainingOperation",i,sep="")]] <- sum(instance$duration[j,machines])
       
      }
      
      feat[[paste("MinStartTimeOperation",i,sep="")]] <- 0
      
      if(order > 1)
      {
        machines <- precIndex[j,1:(order-1)]
        feat[[paste("MinStartTimeOperation",i,sep="")]] <- sum(instance$duration[j,machines])
        
      }      
      
      placeInCP <- unlist(lapply(cp,function(x)x$operationInPath(j,m)))
      feat[[paste("OrderCriticalPathOperation",i,sep="")]] <- mean(placeInCP)
      
   
      feat[[paste("nrChangesInOperation",i,sep="")]] <- 0
   
      
      if(j == J1 & m == M1)
      {
        feat[[paste("nrChangesInOperation",i,sep="")]] <- 1        
      }
      
      if(j == J2 & m == M2)
      {
        feat[[paste("nrChangesInOperation",i,sep="")]] <-  feat[[paste("nrChangesInOperation",i,sep="")]] + 1        
      }
         
      i <- i + 1
    }
    
  }


  return(feat)
  
})






  
