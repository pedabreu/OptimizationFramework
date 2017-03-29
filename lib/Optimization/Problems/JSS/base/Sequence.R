
setMethodS3("setSequenceFromString","Sequence", function(this,sequenceString,...) {
  
  this$sequence <- as.numeric(strsplit(sequenceString,";")[[1]])
    
})

setMethodS3("getSequenceString","Sequence", function(this,...) {
  
  return(paste(this$sequence,collapse=";"))
  
})

setMethodS3("DBsave","Sequence", function(this,con=NULL,...) {
  
 NextMethod("DBsave",this,con)
  

    for(o in 1:length(this$sequence))
    {
      DBobj1<-DBSequence()
      
      DBobj1$attributes<-list(job = this$sequence[o],
                               order = o,
                               Solution_uniqueID = this$uniqueID)
      DBobj1$save(con)
      
    }
  
  
})

setMethodS3("DBgetByUniqueID","Sequence", function(this,uniqueID,con=NULL,...) {
  
  NextMethod("DBgetByUniqueID",this,uniqueID,con)
  
  DBobjOp<-DBSequence()
  
  DBobjOp$attributes[["Solution_uniqueID"]] <- uniqueID
  
  allDBOp <- DBobjOp$getAllByAttributes(con)    
  
  ##this$priorityList <- array(dim=c(nrJobs,nrMachines))
  sequence <- NULL
  
  
  for(i in 1:length(allDBOp))
  {
    currentDBOp <- allDBOp[[i]]
    
    attriCurrentDBOp <- currentDBOp$attributes
    
    j <- attriCurrentDBOp[["job"]]
    o <- attriCurrentDBOp[["order"]]

    sequence[o] <- j  
  }

  this$sequence <- sequence
})

setMethodS3("fitnessSandeep","Sequence", function(this,instance,...) {
  
  schedule <- Schedule()
  schedule$addInstance(instance)
  
  
  tempos <- instance$duration
  process <- instance$precedence
  
  seq <- this$sequence

  
  startTimes <- array(NA,dim=c(instance$nrJobs(),
                               instance$nrMachines()))

  job.fim<-matrix(0,nrow=nrow(process),ncol=1)
  mach.free<-matrix(0,nrow=1,ncol=ncol(process))
  operacao.job<-matrix(0,nrow=nrow(process),ncol=1)
  
  for (j in 1:length(seq))
  {
    job <- seq[j]
    
    operacao.job[job,]<-operacao.job[job,]+1
    
    
    
    if (job.fim[job,]<mach.free[,process[job,operacao.job[job,]]])
    {
      mach.free[,process[job,operacao.job[job,]]]<-mach.free[,process[job,operacao.job[job,]]]+tempos[job,operacao.job[job,]]
      job.fim[job,]<-mach.free[,process[job,operacao.job[job,]]]
    }
    else
    {
      job.fim[job,]<-job.fim[job,]+tempos[job,operacao.job[job,]]
      mach.free[,process[job,operacao.job[job,]]]<-job.fim[job,]
    }
    
    
    
  }
  fitness <- max(c(mach.free,job.fim))
  
  ##schedule$operationStartTime <- startTimes 
  
  return(fitness)
})


setMethodS3("getSchedule","Sequence", function(this,instance,...) {
  
  schedule <- Schedule()
  schedule$addInstance(instance)
  
  seq <- this$sequence
  orderToSchedule <- rep(1,instance$nrJobs())
  
  startTimes <- array(NA,dim=c(instance$nrJobs(),
                               instance$nrMachines()))
  for(j in seq)
  {
    machine <- instance$getMachine(jobID = j,
                                   precedence = orderToSchedule[j])
    
    endTimes <- startTimes + instance$duration 

    newstarttime <- 0
    
    
    
    maxStartime <- c(endTimes[j,],endTimes[,machine])
    
    if(!all(is.na(maxStartime)))
    {   
      
      newstarttime <-  max(maxStartime,na.rm=TRUE) 
    
    }
    
    startTimes[j,machine] <- newstarttime       

    
    orderToSchedule[j] <- orderToSchedule[j] + 1
  }
  schedule$operationStartTime <- startTimes 
  
  return(schedule)
  })



setMethodS3("randomGeneration","Sequence", function(this,instance,...) {

  NextMethod("randomGeneration",this,instance)
    
	nr.jobs<-instance$nrJobs()
	nr.machines<-instance$nrMachines()     
  
  this$sequence <- sample(rep(1:nr.jobs,nr.machines))
  

})














