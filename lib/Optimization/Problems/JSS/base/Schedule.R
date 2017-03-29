library("R.oo")

## for a operation with job and machine gives the duration of the conflict of the others operation in same machine
## the positive values is the duration of intersection and the negative is the gap of the operations that aren't in conflict
setConstructorS3("Schedule",function()
{
  
  
  dc <- DomainComponent()
  dc$mainTable <- "FeasibleSchedule"
  
  
  extend(dc,"Schedule",
         criticalPaths = NULL,
         instance = NULL,
         operationStartTime = NULL,
         algorithmParameterized_uniqueID = NULL)
  
  
}
)

setMethodS3("isfeasible","Schedule", function(this,
                                              ...) {
  
  
  ## Verify precedence
  inst <- this$instance
  isfeas <- TRUE
  nrJobs <- inst$nrJobs()
  j <- 1
  
  
  while(isfeas & j < nrJobs)
  {
    startTimes <- this$operationStartTime[j,] 
    prec <- inst$precedence
    
    sortStartTimes <- sort(startTimes,index.return = TRUE)
    sortPrecedence <- sort(prec,index.return = TRUE) 
    
    precedenceFeasible <- all(sortStartTimes$ix == sortPrecedence$ix)
    
    j <- j + 1    
  }
  
  nrMachines <- inst$nrMachines()
  m <- 1
  
  while(isfeas & m < nrMachines)
  {
    startTimes <- this$operationStartTime[j,] 
    prec <- inst$precedence
    
    sortStartTimes <- sort(startTimes,index.return = TRUE)
    sortPrecedence <- sort(prec,index.return = TRUE) 
    
    precedenceFeasible <- all(sortStartTimes$ix == sortPrecedence$ix)
    
    m <- m + 1    
  }
  
  
  return(isfeas)
})


setMethodS3("distanceOperations","Schedule", function(this,              
                                                      machine,
                                                      job1,
                                                      job2,
                                                      ...) {
  
  inst <- this$instance
  startTime1 <- this$operationStartTime[job1,machine] 
  startTime2 <- this$operationStartTime[job2,machine]  
  dist <- 0
  
  if(startTime1 <= startTime2)
  {
    endtime <- startTime1 + inst$duration[job1,machine]
    
    dist <- startTime2 - endtime 
    
  }
  else
  {
    endtime <- startTime2 + inst$duration[job2,machine]
    
    dist <- startTime1 - endtime
    
  }
  
  return(dist)
  
})

setMethodS3("machineGaps","Schedule", function(this,                                                    
                                               ...) {
  
  
  
  inst <- this$instance
  machineGaps <- NULL
  
  endTimes <- this$operationStartTime + inst$duration
  
  
  
  for(m in 1:inst$nrMachines())
  {     
    for(j1 in 1:inst$nrJobs())
    {      
      for(j2 in 1:inst$nrJobs())
      {
        if(j1!=j2)
        {
          st <- this$operationStartTime[j2,m] - endTimes[j1,m]
          
          if(st >= 0)
          {
            
            
            machineGaps <- rbind(machineGaps,                       
                                 c("Machine" = m,
                                   "Job1" = j1,
                                   "Job2" = j2,
                                   "Gap" = st))     
          }
          
          
        }
        
        
        
        
      }        
    }    
  }    
  
  
  
  return(machineGaps)
})

setMethodS3("jobGaps","Schedule", function(this,                                                    
                                           ...) {
  
  
  inst <- this$instance
  
  endTimes <- this$operationStartTime + inst$duration
  
  preced <- inst$precedenceIndex()
  
  gaps <- this$operationStartTime
  
  for(j in 1:inst$nrJobs())
  {
    for(o in 2:inst$nrMachines())
    {     
      machine <- preced[j,o] 
      prevMachine <- preced[j,o-1]
      gaps[j,machine] <- this$operationStartTime[j,machine] - endTimes[j,prevMachine]
      
    }    
    
    
  }
  
  return(gaps)
})

setMethodS3("endTimes","Schedule", function(this,                                                    
                                            ...) {
  
  
  inst <- this$instance
  
  endTimes <- this$operationStartTime + inst$duration
  
  return(endTimes)
})

setMethodS3("conflictIntersection","Schedule", function(this,
                                                        job = 1,
                                                        machine = 1,
                                                        ...) {
  
  inst <- this$instance
  results <- NULL
  
  
  dur <- inst$duration[job,machine]
  st <- this$operationStartTime[job,machine] 
  end <- st + inst$duration[job,machine]
  
  
  for(j in 1:inst$nrJobs())
  {
    if(j != job)
    {
      stOp <- this$operationStartTime[j,machine] 
      endOp <- stOp + inst$duration[j,machine]  
      
      
      stInt <- max(stOp,st)
      endInt <- min(end,endOp)
      
      
      results[j] <- endInt - stInt
      
      
      #       if(stInt <= endInt)
      #       {
      #         results[j] <- endInt - stInt
      #         
      #       }
      #       else{
      #         results[j] <- 0 
      #       }
      
      
      
    }
    
    
    
  }
  
  
  return(results)
})


setMethodS3("ICS","Schedule", function(this,...) {
  
  inst <- this$instance
  
  precIndex <- inst$precedenceIndex()
  
  
  for(j in 1:inst$nrJobs())
  {
    for(m in 1:inst$nrMachines())
    {
      dur <- 0
      
      if(inst$precedence[j,m]>1)
      {
        prec <- inst$precedence[j,m]     
        durations <- inst$duration[j,  precIndex[j,1:(prec-1)]  ]     
        dur <- sum(durations)      
      }
      
      this$operationStartTime[j,m] <- dur  
      
      
    }    
    
    
  }
  
  
})



setMethodS3("sameDBObject","Schedule", function(this,schedule,con=NULL,...) {
  
  thisInst <- this$instance
  scheduleInst <- schedule$instance
  
  sameInst <-  thisInst$sameDBObject(scheduleInst,con)
  
  
  same <- all(this$operationStartTime == schedule$operationStartTime) &
    this$uniqueID == schedule$uniqueID &
    sameInst
  
  
  return(same)
})

setMethodS3("addInstance","Schedule", function(this,instance,...) {
  
  this$instance <- instance
  
  this$operationStartTime <- array(NA,dim=c(instance$nrJobs(),instance$nrMachines()))
  
  
  
})

# 
# setMethodS3("DBsave","Schedule", function(this,con=NULL,...) {
#   
#   instance <- this$instance
#   instUI <- instance$uniqueID
#   
#   mkspan <- this$makespan()
#   
#   fs <- data.frame("Instance_uniqueID" = instUI,
#                    "makespan" = as.integer(mkspan),
#                    "uniqueID"=this$uniqueID)
#   # 
#   
#   #  dbWriteTable(con,"FeasibleSchedule",fs,append=TRUE,row.names=FALSE)
#   
#   dbSendQuery(con,
#               paste("INSERT INTO FeasibleSchedule VALUES ('", instance$uniqueID,"',",mkspan,",'",this$uniqueID,"')",sep=""))
#   #   
#   df <- data.frame()
#   
#   for(j in 1:instance$nrJobs())
#   {
#     for(m in 1:instance$nrMachines())
#     {
#       df <- rbind(df,
#                   data.frame(uniqueID = paste(format(Sys.time(), "%y%m%d%H%M%S"),paste(sample(c(0:9, letters, LETTERS))[1:4],collapse=""),sep=""),
#                              machine = m, 
#                              job = j, 
#                              startTime = this$operationStartTime[j,m],
#                              FeasibleSchedule_uniqueID = this$uniqueID))
#     }    
#   }
#   
#   dbWriteTable(con,"FeasibleScheduleOperation",df,append=TRUE,row.names=FALSE)
#   
# })
# 
setMethodS3("DBgetByUniqueID","Schedule", function(this,
                                                   uniqueID = NULL,
                                                   con=NULL,
                                                   ...) {
  
  
  if(!is.null(uniqueID))
  {
    this$uniqueID <- uniqueID
    # sourceDirectory(paste("./lib/MySQLInterface/",sep=""))
    #  DBobj<-DBFeasibleSchedule_4x4()
    
    #  DBobj$attributes[["uniqueID"]]<- uniqueID
    
    #  DBobj$getByAttributes(con)
    
    #  attrib <- DBobj$attributes
    
    
    attrib <- dbGetQuery(con,paste("SELECT * FROM FeasibleSchedule WHERE uniqueID='",uniqueID,"' LIMIT 1",sep=""))
    
    
    instance <- Instance()
    DBgetByUniqueID(instance,list(uniqueID=attrib[["Instance_uniqueID"]]),con)
    this$instance <- instance    
    
    nrJobs <- instance$nrJobs()
    nrMachines <-  instance$nrMachines()
    
    
    DBobjOp<-DBFeasibleScheduleOperation()
    
    DBobjOp$attributes[["FeasibleSchedule_uniqueID"]] <- uniqueID
    
    allDBOp <- DBobjOp$getAllByAttributes(con)    
    
    this$operationStartTime <- array(dim=c(nrJobs,nrMachines))
    
    for(i in 1:length(allDBOp))
    {
      currentDBOp <- allDBOp[[i]]
      
      attribCurrentDBOp <- currentDBOp$attributes
      
      j <- attribCurrentDBOp[["job"]]
      m <- attribCurrentDBOp[["machine"]]
      
      this$operationStartTime[j,m] <- attribCurrentDBOp[["startTime"]]
      
      
    }
    
  }
  
})

setMethodS3("DBsave","Schedule", function(this,con=NULL,...) {
  
  instance <- this$instance
  instUI <- instance$uniqueID
  
  mkspan <- this$makespan()
  
  tt <- this$StartTime2XML()
  
  texto<-toString(xmlRoot(tt))
  
  fs <- data.frame("Instance_uniqueID" = instUI,
                   "makespan" = as.integer(mkspan),
                   "uniqueID"=this$uniqueID,
                   "start_time_xml" = texto)
  # 
  
  #  dbWriteTable(con,"FeasibleSchedule",fs,append=TRUE,row.names=FALSE)
  
  #  dbSendQuery(con,
  #               paste("INSERT INTO FeasibleSchedule_",instance$nrJobs(),"x",instance$nrMachines(),"(Instance_uniqueID,makespan,uniqueID,start_times_xml) VALUES ('", instance$uniqueID,"',",mkspan,",'",this$uniqueID,"','",texto,"')",sep=""))
  #   
  size <- paste(instance$nrJobs(),"x",instance$nrMachines(),sep="")
  dbSendQuery(con,
              paste("INSERT INTO FeasibleSchedule(Instance_uniqueID,makespan,uniqueID,AlgorithmParameterized_uniqueID,start_times_xml,size) VALUES ('", instance$uniqueID,"',",mkspan,",'",this$uniqueID,"','",this$algorithmParameterized_uniqueID,"','",texto,"','",size,"')",sep=""))
  
  
})



setMethodS3("DBgetByUniqueIDXML","Schedule", function(this,
                                                      uniqueID = NULL,
                                                      con=NULL,
                                                      ...) {
  
  
  if(!is.null(uniqueID))
  {
    this$uniqueID <- uniqueID
    # sourceDirectory(paste("./lib/MySQLInterface/",sep=""))
    
    schedRow <- dbGetQuery(con,
                           paste("SELECT * FROM FeasibleSchedule WHERE uniqueID='",uniqueID,"'",sep=""))
    
    instance <- Instance()
    DBgetByUniqueIDXML(instance,list(uniqueID=schedRow[1,"Instance_uniqueID"]),con)
    this$instance <- instance    
    
    nrJobs <- instance$nrJobs()
    nrMachines <- instance$nrMachines()
    
    this$operationStartTime <- this$XML2StartTime(schedRow[1,"start_times_xml"])
  }
  
})




setMethodS3("addStartTime","Schedule", function(this,jobID = NA,machineID = NA,start = 0,...) {
  
  this$operationStartTime[jobID,machineID]<-start 
})


setMethodS3("makespan","Schedule", function(this,...) {
  
  inst <- this$instance
  endTime <- this$operationStartTime + inst$duration
  
  mkspan <- max(endTime,na.rm=TRUE)
  return(mkspan)
  
})

setMethodS3("getOperation","Schedule", function(this,machineID = NA,jobID = NA,...) {
  
  operation <- FeasibleScheduleOperation()
  
  operation$machineID <- machineID
  operation$jobID <- jobID
  
  operation$schedule <- this
  
  return(operation)
})

setMethodS3("plotMachinesGanttChart","Schedule", function(this,
                                                          withCriticalPath = FALSE,
                                                          path=NULL,...) {
  if(withCriticalPath)
  {
    
    path <- this$getCriticalPath()[[1]]
    
  }
  
  inst <- this$instance
  
  problem <- list(nr.machines = inst$nrMachines(),
                  nr.jobs = inst$nrJobs(),
                  times = inst$duration,
                  order = inst$precedence)
  
  nr.machines<-problem$nr.machines
  nr.jobs<-problem$nr.jobs
  
  ##Structure of the matrix jobs is:
  ##(jobs,operation[or order],(start time,duration,order[if operation in index before],operation[if order in index before])) 
  jobs<-array(dim=c(nr.jobs,nr.machines,4))
  ##Insert duration of operations
  jobs[,,1]<-this$operationStartTime
  jobs[,,2]<-problem$times
  ##Insert order of operations
  jobs[,,3]<-problem$order
  
  mspan<-this$makespan()
  plot(c(0,0),c(1,nr.machines+0.5),t="l",xlim=c(0,mspan),xlab="time",ylab="Machines")
  
  for(machine in 1:nr.machines){
    for(operation in 1:nr.jobs){
      if(withCriticalPath)
      {
        
        in.critical.path <- path$operationInPath(operation,machine)
        
      }
      
      text(jobs[operation,machine,1],machine+0.2,operation)
      
      lines(c(jobs[operation,machine,1],jobs[operation,machine,2]+jobs[operation,machine,1]),
            c(machine,machine),lwd=7,lend=2,col=colours()[10*operation])
      
      if(withCriticalPath){
        lines(c(jobs[operation,machine,1],jobs[operation,machine,2]+jobs[operation,machine,1]),
              c(machine,machine),lwd=2,col="yellow")}
    }}
  
  
  lines(c(mspan,mspan),c(1,nr.machines+0.2))
  text(mspan,nr.machines+0.5,mspan)
  
})

setMethodS3("plotJobsGanttChart","Schedule", function(this,
                                                      withCriticalPath = FALSE,
                                                      path=NULL,
                                                      xlim = NULL,
                                                      title = "",
                                                      ...) {
  if(withCriticalPath)
  {
    
    path <- this$getCriticalPath()[[1]]
    
  }
  
  inst <- this$instance
  
  problem <- list(nr.machines = inst$nrMachines(),
                  nr.jobs = inst$nrJobs(),
                  times = inst$duration,
                  order = inst$precedence)
  
  nr.machines<-problem$nr.machines
  nr.jobs<-problem$nr.jobs
  
  ##Structure of the matrix jobs is:
  ##(jobs,operation[or order],(start time,duration,order[if operation in index before],operation[if order in index before])) 
  jobs<-array(dim=c(nr.jobs,nr.machines,4))
  ##Insert duration of operations
  jobs[,,1]<-this$operationStartTime
  jobs[,,2]<-problem$times
  ##Insert order of operations
  jobs[,,3]<-problem$order
  
  
  
  
  
  mspan<-this$makespan()
  
  if(is.null(xlim))
  {
    xlim <- mspan    
  }
  
  plot(c(0,0),c(1,nr.jobs+0.5),t="l",xlim=c(0,xlim),xlab="time",ylab="Jobs",main=title)
  for(job in 1:nr.jobs){
    for(operation in 1:nr.machines){
      if(withCriticalPath)
      {
        
        in.critical.path <- path$operationInPath(job,operation)
        
      }
      
      text((2*jobs[job,operation,1]+jobs[job,operation,2])/2,job+0.4,operation)
      
      lines(c(jobs[job,operation,1],jobs[job,operation,2]+jobs[job,operation,1]),
            c(job,job),lwd=20,lend=1,col=colours()[10*operation])
      
      if(withCriticalPath && in.critical.path>0){
        lines(c(jobs[job,operation,1],jobs[job,operation,2] + jobs[job,operation,1]),
              c(job,job),lwd=2,col="yellow")}
    }}
  
  
  lines(c(mspan,mspan),c(1,nr.jobs+0.2))
  text(mspan-25,nr.jobs+0.5,mspan,cex=2)
  
})


setMethodS3("getCriticalPath","Schedule", function(this,...) {
  
  if(length(this$criticalPaths) == 0)
  {
    inst <- this$instance
    endTime <- this$operationStartTime + inst$duration
    
    firstOperations <-  which(endTime == max(endTime) ,arr.ind=TRUE)
    
    allCriticalPathObjs <- this$getPath(firstOperations)
    
    this$criticalPaths <- allCriticalPathObjs
    
  }
  else
  {
    allCriticalPathObjs <- this$criticalPaths
  }
  
  return(allCriticalPathObjs)
  
})

setMethodS3("getPath","Schedule", function(this,
                                           firstOperations,...) {
  
  allCriticalPathObjs <- list ()
  
  inst <- this$instance
  endTime <- this$operationStartTime + inst$duration
  startTime <-   this$operationStartTime
  mkspan <- this$makespan()
  
  ##get all operations with same time as makespan
  
  
  
  allCriticalPath <- list()
  
  ##if there are several operation with the same makespan,
  ##we have several critical paths. 
  ##In the list allCriticalPath each element is a critical path
  
  if(dim(firstOperations)[1]> 1)
  {
    for(i in 1:dim(firstOperations)[1])
    {
      
      newcp <- firstOperations[i,]
      dim(newcp) <- c(1,2)
      
      job <- newcp[1,1]
      machine <-  newcp[1,2]
      
      
      if(!is.na(endTime[job,machine]))
      {
        allCriticalPath <- c(allCriticalPath,list(newcp))
      }
      
    }
  }
  else
  {
    job <- firstOperations[1,1]
    machine <-  firstOperations[1,2]
    
    if(!is.na(endTime[job,machine]))
    {
      allCriticalPath <- list(firstOperations)
    }
    
    
  }
  
  ##controls if the search of critical path is over
  orderAllCriticalPath <- rep(TRUE,length(allCriticalPath))
  
  
  while(any(orderAllCriticalPath))
  {
    criticalPathIndex <- which(orderAllCriticalPath)[1] 
    criticalPath <-allCriticalPath[[criticalPathIndex]]
    orderAllCriticalPath[criticalPathIndex] <- FALSE    
    
    nrOperationsCriticalPath <- dim(criticalPath)[1]
    
    job <- criticalPath[nrOperationsCriticalPath,1]
    machine <- criticalPath[nrOperationsCriticalPath,2]
    
    order <- inst$precedence[job,machine]
    thisEndTime <- endTime[job,machine]
    
    if(!is.na(thisEndTime))
    {
      isPrevMachineInJob <- FALSE
      
      if(order > 1)
      {    
        prevMachineInJob <- which(inst$precedence[job,] == order - 1)    
        prevEndTimeInJob <- endTime[job,prevMachineInJob]
        
        if(length(prevEndTimeInJob) > 0 && prevEndTimeInJob == this$operationStartTime[job,machine])
        {
          orderAllCriticalPath[criticalPathIndex] <- TRUE
          newCriticalPath <- criticalPath
          
          newCriticalPath <- rbind(newCriticalPath,
                                   c("job"=job,"machine"=prevMachineInJob))
          
          allCriticalPath[[criticalPathIndex]] <- newCriticalPath
          
          isPrevMachineInJob <- TRUE          
        }     
        
      }   
      
      endTimeMachine <- endTime[!is.na(endTime[,machine]),machine]
      
      thisStartTime <- this$operationStartTime[job,machine]
      
      if(any(endTimeMachine  <= thisStartTime))
      {
        prevJobInMachine <- which(max(endTimeMachine[endTimeMachine <= thisStartTime]) == endTime[,machine])     
        prevEndTimeInMachine <- endTime[prevJobInMachine,machine]    
        
        if(length(prevEndTimeInMachine) > 0 && prevEndTimeInMachine == this$operationStartTime[job,machine])
        {        
          newCriticalPath <- criticalPath
          
          
          newCriticalPath <- rbind(newCriticalPath,
                                   c("job"=prevJobInMachine,"machine"=machine))
          if(isPrevMachineInJob)
          {
            
            newCriticalPathIndex <- length(allCriticalPath) + 1         
            orderAllCriticalPath[newCriticalPathIndex] <- TRUE 
            allCriticalPath[[newCriticalPathIndex]] <- newCriticalPath
          }
          else
          {  
            orderAllCriticalPath[criticalPathIndex] <- TRUE 
            allCriticalPath[[criticalPathIndex]] <- newCriticalPath
          }
          
        }
        
      }
      
    }
  }
  
  for(i in allCriticalPath)
  {
    CPobj <- Path()
    CPobj$path <- i
    CPobj$isCriticalPath <- TRUE
    
    allCriticalPathObjs<- c(allCriticalPathObjs,list(CPobj))
  }
  
  
  
  return(allCriticalPathObjs)
  
})


setMethodS3("ILCriticalPathConstraints","Schedule", function(this,...) {
  
  
  all_cp <- this$getCriticalPath()
  
  
  for(all_cp_index in 1:length(all_cp))
  {
    cp <- all_cp[[all_cp_index]]
    
    cp_path <- cp$path
    
    allMachineBlocks <- cp$getMachineBlocks()
    allMachineBlocks<-as.data.frame(allMachineBlocks)
    
    machineBlockSize <- allMachineBlocks[,"To"] - allMachineBlocks[,"From"]
    
    machineBlocks <- allMachineBlocks[machineBlockSize > 0,]
    
    
    for(machineBlocksIndex in 1:nrow(machineBlocks))
    {
      from <- machineBlocks[machineBlocksIndex,"From"]
      to <- machineBlocks[machineBlocksIndex,"To"]
      
      info <- data.frame()
      ends <- NULL
      starts <- NULL
      
      for(op_index in from:to)
      {
        job <- cp_path[op_index,1]
        machine <- cp_path[op_index,2]
        
        prevOperationMachine <- this$instance$precedence[job,machine] - 1
        
        
        if(prevOperationMachine > 0)
        {
          prevMachineID <- this$instance$precedenceIndex()[job,prevOperationMachine]
          
          allPrevPath <- this$getPath(data.frame(job,prevMachineID))
          
          for(prevPathIndex in 1:length(allPrevPath))
          {
            prev_cp_path <- allPrevPath[[prevPathIndex]]$path
            
            
            info <- rbind(info,
                          data.frame(job = job,
                                     machine = machine,
                                     start =  paste("S",job,machine," = ",
                                                    paste(paste("D",prev_cp_path[,1], prev_cp_path[,2],sep = ""),
                                                    collapse = " + "),sep=""),
                                     end = paste("E",job,machine," = ",
                                                 paste(c(paste("D",prev_cp_path[,1], prev_cp_path[,2],sep = ""),
                                                   paste("D",job,machine,sep="")),collapse = " + "),sep="")))
          }
        }
        else
        {
          info <- rbind(info,
                        data.frame(job = job,
                                   machine = machine,
                                   start =  paste("S",job,machine," = 0",sep=""),
                                   end =  paste("E",job,machine," = D",job,machine,sep="")))
        }
        
        
        
        
      }
      
      
      
      
      combinations <- combn(x = 1:nrow(info),2)
      
      for(j in 1:ncol(combinations))
      {
        op1Index <- combinations[1,j]
        op2Index <- combinations[2,j]
        
        constraint <- paste("")
        
        
        mustIntersectConstraint <- paste("max(S",info[op1Index,"job"],info[op1Index,"machine"],",S",
                                         info[op2Index,"job"],info[op2Index,"machine"],") < min(E",info[op1Index,"job"],info[op1Index,"machine"],",E",
                                         info[op2Index,"job"],info[op2Index,"machine"],")",sep="")
        
        
        
        
        if(this$operationEvaluationFunction == "ProcessingTime")
        {
        }
        
      }
      
      
      
    }
  }
  
  
  
})






# 
# 
# setMethodS3("getCriticalPath_old","Schedule", function(this,...) {
#   
#   allCriticalPathObjs <- list ()
#   
#   if(length(this$criticalPaths) == 0)
#   {
#     inst <- this$instance
#     endTime <- this$operationStartTime + inst$duration
#     
#     mkspan <- this$makespan()
#     
#     ##get all operations with same time as makespan
#     firstOperations <-  which(endTime == max(endTime) ,arr.ind=TRUE)
#     
#     
#     allCriticalPath <- list()
#     
#     ##if there are several operation with the same makespan,
#     ##we have several critical paths. 
#     ##In the list allCriticalPath each element is a critical path
#     
#     if(dim(firstOperations)[1]> 1)
#     {
#       for(i in 1:dim(firstOperations)[1])
#       {
#         
#         newcp <- firstOperations[i,]
#         dim(newcp) <- c(1,2)
#         
#         allCriticalPath <- c(allCriticalPath,list(newcp))
#       }
#     }
#     else
#     {
#       allCriticalPath <- list(firstOperations)
#     }
#     
#     ##controls if the search of critical path is over
#     orderAllCriticalPath <- rep(TRUE,length(allCriticalPath))
#     
#     
#     while(any(orderAllCriticalPath))
#     {
#       criticalPathIndex <- which(orderAllCriticalPath)[1] 
#       criticalPath <-allCriticalPath[[criticalPathIndex]]
#       orderAllCriticalPath[criticalPathIndex] <- FALSE    
#       
#       nrOperationsCriticalPath <- dim(criticalPath)[1]
#       
#       job <- criticalPath[nrOperationsCriticalPath,1]
#       machine <- criticalPath[nrOperationsCriticalPath,2]
#       
#       order <- inst$precedence[job,machine]
#       thisEndTime <- endTime[job,machine]
#       
#       
#       isPrevMachineInJob <- FALSE
#       
#       if(order > 1)
#       {    
#         prevMachineInJob <- which(inst$precedence[job,] == order - 1)    
#         prevEndTimeInJob <- endTime[job,prevMachineInJob]
#         
#         if(prevEndTimeInJob == this$operationStartTime[job,machine])
#         {
#           orderAllCriticalPath[criticalPathIndex] <- TRUE
#           newCriticalPath <- criticalPath
#           
#           newCriticalPath <- rbind(newCriticalPath,
#                                    c("job"=job,"machine"=prevMachineInJob))
#           
#           allCriticalPath[[criticalPathIndex]] <- newCriticalPath
#           
#           isPrevMachineInJob <- TRUE          
#         }     
#         
#       }
#       
# 
#       
#       if(any(endTime[,machine] < thisEndTime))
#       {  
#         prevJobInMachine <- which(max(endTime[endTime[,machine] < thisEndTime,machine]) == endTime[,machine])     
#         prevEndTimeInMachine <- endTime[prevJobInMachine,machine]    
#         
#         if(prevEndTimeInMachine == this$operationStartTime[job,machine])
#         {        
#           newCriticalPath <- criticalPath
#           
#           
#           newCriticalPath <- rbind(newCriticalPath,
#                                    c("job"=prevJobInMachine,"machine"=machine))
#           if(isPrevMachineInJob)
#           {
#             
#             newCriticalPathIndex <- length(allCriticalPath) + 1         
#             orderAllCriticalPath[newCriticalPathIndex] <- TRUE 
#             allCriticalPath[[newCriticalPathIndex]] <- newCriticalPath
#           }
#           else
#           {  
#             orderAllCriticalPath[criticalPathIndex] <- TRUE 
#             allCriticalPath[[criticalPathIndex]] <- newCriticalPath
#           }
#           
#         }
#       }
#       
#     }
#     
#     for(i in allCriticalPath)
#     {
#       CPobj <- Path()
#       CPobj$path <- i
#       CPobj$isCriticalPath <- TRUE
#       
#       allCriticalPathObjs<- c(allCriticalPathObjs,list(CPobj))
#     }
#     
#     this$criticalPaths <- allCriticalPathObjs
#   }
#   else
#   {
#     allCriticalPathObjs <- this$criticalPaths
#   }
#   
#   return(allCriticalPathObjs)
#   
# })

setMethodS3("StartTime2XML","Schedule", function(this,
                                                 ...){
  
  inst <- this$instance
  
  tt <- xmlHashTree()
  schedNode <- addNode(xmlNode("Schedule",
                               attrs=c("id" = this$uniqueID,
                                       "nJobs"=inst$nrJobs(),
                                       "nMachines"=inst$nrMachines())), 
                       character(), tt)
  
  
  for(j in 1:inst$nrJobs())
  {
    for(m in 1:inst$nrMachines())
    {          
      operationNode <- addNode(xmlNode("Operation",attrs=c("job" = j,"machine" = m)), 
                               schedNode, tt)     
      
      stNode <- addNode(xmlNode("StartTime"), operationNode, tt)      
      addNode(xmlTextNode(this$operationStartTime[j,m]),stNode,tt)   
    }    
  }
  
  return(tt)
  
})


setMethodS3("XML2StartTime","Schedule", function(this,text,...){
  
  doc <- xmlRoot(xmlTreeParse(text,asText=TRUE))
  
  schedAttrib <- doc$attributes
  
  nr.jobs <- as.integer(schedAttrib["nJobs"])
  nr.machines <- as.integer(schedAttrib["nMachines"])
  
  
  this$uniqueID <- schedAttrib["id"]
  
  st <- array(dim=c(nr.jobs,nr.machines))
  
  for(i in 1:length(doc))
  {
    operationXML <- doc[[i]]
    operationAttrib <- operationXML$attributes
    
    j <- as.integer(operationAttrib["job"])
    m <- as.integer(operationAttrib["machine"])
    
    st[j,m] <- as.integer(xmlValue(operationXML[["StartTime"]]))
    
  }
  
  return(st)
  
})