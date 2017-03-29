setConstructorS3("SwapSequenceFeaturedElement",function()
{
  swpSeq <- SwapSequence()
  
  obj <- FeaturedElement()
  
  obj$object <- swpSeq
  
  extend(obj,"SwapSequenceFeaturedElement")
})


setMethodS3("featuresIndexOperationInstance1","SwapSequenceFeaturedElement", function(this,
                                                                           ...) {
  
  swpSeq <- this$object
  
  
  instance <- swpSeq$instance
  
  seqObj <- swpSeq$sequence
  index1 <- swpSeq$index1
  index2 <-  swpSeq$index2
  
  nrJobs <- instance$nrJobs()
  nrMachines <- instance$nrMachines()
  nrOperations <- nrJobs*nrMachines
  
  seq <- seqObj$sequence   
  

  precIndex <- instance$precedenceIndex()  

  indexs <- c(index1,index2)
  
  feat <- list()
  
  for(i in 1:2)
  {
    index <- indexs[i]
    J <- seq[index]
    O <- length( which(seq[1:index] == J))
    M <- precIndex[J,O]

    D <- instance$duration[J,M]
   
    totalDurationJob <- sum(instance$duration[J,])
    totalDurationMachine <- sum(instance$duration[,M])
    
    
    Precedence <- (O-1)/(instance$nrMachines()-1)
    
    WorkRemainingOperation <- 0
    
    if(O < instance$nrMachines())
    {
      machines <- precIndex[J,(O+1):instance$nrMachines()]
      WorkRemainingOperation <- sum(instance$duration[J,machines])/totalDurationJob
    }

    
    
    
    feat[[paste("DurationRelativeTotalDuration",i,sep="")]] <- D/sum(instance$duration)
    feat[[paste("DurationRelativeTotalJobDuration",i,sep="")]] <- D/totalDurationJob
    feat[[paste("DurationRelativeTotalMachineDuration",i,sep="")]] <- D/totalDurationMachine   
    
    
    feat[[paste("RelativeRankDurationInstance",i,sep="")]] <- length(which(instance$duration < D ))/nrOperations
    feat[[paste("RelativeRankDurationJob",i,sep="")]] <-  length(which(instance$duration[J,] < D ))/nrJobs
    feat[[paste("RelativeRankDurationMachine",i,sep="")]] <-length(which(instance$duration[,M] < D ))/nrMachines
    
    feat[[paste("RelativePrecedence",i,sep="")]] <- (Precedence-1)/(nrMachines-1)    
    feat[[paste("RelativeWorkRemaining",i,sep="")]] <- WorkRemainingOperation   
   
  }
  
  return(feat)
  
  
  
})

setMethodS3("featuresIndexOperationSchedule1","SwapSequenceFeaturedElement", function(this,
                                                                                         ...) {
  
})

setMethodS3("featuresSchedule1","SwapSequenceFeaturedElement", function(this,
                                                                          ...) {
  
  
  swpSeq <- this$object
  
  
  instance <- swpSeq$instance
  
  seqObj <- swpSeq$sequence
  index1 <- swpSeq$index1
  index2 <-  swpSeq$index2
  
  
  seq <- seqObj$sequence  
  
  
  sched <- seqObj$getSchedule(instance)
  
  mkspan <- sched$makespan()
  
  jobGaps <- apply(sched$jobGaps(),1,sum)
  
  
  features <- list("Makespan" = mkspan,
                   "TotalJobsGaps" = sum(jobGaps),
                   "AvgJobGaps" = mean(jobGaps))
  
  
  return(features)
})

setMethodS3("featuresIndexComparationSchedule1","SwapSequenceFeaturedElement", function(this,
                                                                                           ...) {
  
  
})

setMethodS3("featuresIndexComparationInstance1","SwapSequenceFeaturedElement", function(this,
                                                                          ...) {
  
  
  swpSeq <- this$object
  
  
  instance <- swpSeq$instance
  
  seqObj <- swpSeq$sequence
  index1 <- swpSeq$index1
  index2 <-  swpSeq$index2
  
  
  seq <- seqObj$sequence  
   
  J1 <- seq[index1]
  J2 <- seq[index2]  
  
  O1 <- length( which(seq[1:index1] == J1))
  O2 <- length( which(seq[1:index2] == J2))  
  
  precIndex <- instance$precedenceIndex()  
  
  M1 <- precIndex[J1,O1]
  M2 <- precIndex[J2,O2]  
  
  D1 <- instance$duration[J1,M1]
  D2 <- instance$duration[J2,M2]    
  
  
  
  features <- list("SameJob" = ifelse(J1 == J2,1,0),
                   "SameMachine" = ifelse(M1 == M2,1,0),
                   "PrecedenceDiff" = O1 - O2,
                   "DurationDiff" = D1 - D2)
  
  
  return(features)
})

setMethodS3("featuresNewSequenceJobsMoments1","SwapSequenceFeaturedElement", function(this,
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
    
    avg <- mean(positions)
    variation <- var(positions)
    
    feat[[paste("avgPositionJob",j,sep="")]] <- avg
    feat[[paste("variationPositionJob",j,sep="")]] <- variation
    
  }
  
  return(feat)
})

setMethodS3("featuresNewSequenceJobsDistribution2","SwapSequenceFeaturedElement", function(this,
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


setMethodS3("featuresNewSequenceMachinesMoments1","SwapSequenceFeaturedElement", function(this,
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
    
    avgPosition <- mean(positions)
    varPosition <- var(positions)
   
    
    feat[[paste("avgPositionMachine",m,sep="")]] <- avgPosition
    feat[[paste("varPositionMachine",m,sep="")]] <- varPosition    
    
  }
  
  return(feat)
})

setMethodS3("featuresNewSequenceMachineDistribution1","SwapSequenceFeaturedElement", function(this,
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


setMethodS3("featuresNewSequenceJobsDistribution1","SwapSequenceFeaturedElement", function(this,
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


setMethodS3("featuresSandeep","SwapSequenceFeaturedElement", function(this,...) {
  
  
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


setMethodS3("targets","SwapSequenceFeaturedElement", function(this,...) {
  
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
  
  newseqObj <- Sequence()
  newseqObj$sequence <- newseq
  
  newsched <- newseqObj$getSchedule(instance)
  
  fit <- sched$makespan()
  newfit <- newsched$makespan()
  

  startTimesVariation <- mean(abs(sched$operationStartTime - newsched$operationStartTime)/instance$duration)
  
  targ <- list("DiffFitness" = fit - newfit,
               "RacioFitness" = fit/newfit,
               "StartTimesVariation" = startTimesVariation)
  
})

