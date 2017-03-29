setMethodS3("sameDBObject","GTHeuristic", function(this,pl,con=NULL,...) {
  
  sameSol <- NextMethod("sameDBObject",this,pl,con)
  
  return(sameSol)
  
})


setMethodS3("randomGeneration","GTHeuristic", function(this,instance,...) {
  NextMethod("randomGeneration",this,instance)
})




setMethodS3("DBsave","GTHeuristic", function(this,con = NULL,...) {
  NextMethod("DBsave",this,con)
})

setMethodS3("selectOperationIndex","GTHeuristic", function(this,
                                                           operations = NULL,
                                                           ...) {
  return(1)
})

setMethodS3("DBgetByUniqueID","GTHeuristic", function(this,
                                                      uniqueID = NULL,
                                                      con = NULL,...) {
  NextMethod("DBgetByUniqueID",this,uniqueID,con)  
})

setMethodS3("generateSchedule","GTHeuristic", function(this,
                                                       instance,
                                                       historical = FALSE,
                                                       ...) {
  
  inst <- instance
  schedule <- Schedule()
  schedule$addInstance(inst)
  history <- NULL
  ILP <- NULL
  ##  GTheuristic$schedule <- this

  problem <- list(nr.machines = inst$nrMachines(),
                  nr.jobs = inst$nrJobs(),
                  times = inst$duration,
                  order = inst$precedence)
  
  nr.machines<-problem$nr.machines
  nr.jobs<-problem$nr.jobs
  
  jobs<-array(dim=c(nr.jobs,nr.machines,4))

  jobs[,,2]<-problem$times
  jobs[,,3]<-problem$order
  jobs[,,4]<- t(apply(jobs[,,3], 1, order))
  
  ##Structure of the matrix jobs is:
#  jobs[jobIndex,machineIndex,1] <- start_time   
#  jobs[jobIndex,machineIndex,2] <- duration
#  jobs[jobIndex,machineIndex,3] <- order
#  jobs[jobIndex,orderIndex,4] <- machineIndex
  
  
  jobs[which(is.na(jobs[,,3]),arr.ind = TRUE)[1],nr.machines,4] <- NA
  
  cut <- jobs[,1,4]
  
  ##Insert initial operation all in time 0
  for(i in 1:nr.jobs)
  {
    jobs[i,jobs[i,1,4],1]<-0
  }
  
  
  smallest.ct <- apply(jobs[,,1]+jobs[,,2], 1, max,na.rm=TRUE)
  operation.order.scheduled<-array(1,dim=nr.jobs)
  job.scheduled<-NULL
  sched <- TRUE
  number.machines <- rep(problem$nr.machines,nr.jobs)
  
  ##Begin scheduling
  while(!all(is.na(cut))){
    
    schedule$operationStartTime <- jobs[,,1]

    min.value <- min(smallest.ct,na.rm=TRUE)
    
    job.with.smallest.ct<-which(smallest.ct == min.value)
    
    machine.with.min.ct <- cut[job.with.smallest.ct[1]] # If several jobs finish at the same time, chooses the first one randomly
    jobs.with.conflict <-which(jobs[,machine.with.min.ct,1] < min.value & min.value <= (jobs[,machine.with.min.ct,1]+jobs[,machine.with.min.ct,2]))
    
    
    if (length(jobs.with.conflict) > 1)
    {
      operations <- list()
      
      for(j in 1:length(jobs.with.conflict))
      {
        operations[[j]] <- schedule$getOperation(machine.with.min.ct,
                                             jobs.with.conflict[j])
        
      }
     
      choose.priority <- selectOperationIndex(this,
                                              operations)
      
    #  ILP <- c(ILP,ilpexplanation(this,
  #                                operations))
      
      ##heuristic.value.job.with.conflict <- eval(call(discriminant.heuristic[machine.with.min.ct],jobs.with.conflict,machine.with.min.ct,jobs))
      ## choose.priority <-  which.min(abs(heuristic.value.job.with.conflict - eval(call(selection.function,heuristic.value.job.with.conflict))))[1]                        
      priority.of.conflict.jobs.for.machine <- c(jobs.with.conflict[choose.priority],jobs.with.conflict[-choose.priority])
      
      ##Resolve conflict in machine
      jobs[priority.of.conflict.jobs.for.machine[-1], machine.with.min.ct, 1] <-
        jobs[priority.of.conflict.jobs.for.machine[1],machine.with.min.ct,1] + jobs[priority.of.conflict.jobs.for.machine[1],machine.with.min.ct,2]
      
      smallest.ct[priority.of.conflict.jobs.for.machine[-1]] <-
        jobs[priority.of.conflict.jobs.for.machine[-1], machine.with.min.ct, 1]+jobs[priority.of.conflict.jobs.for.machine[-1], machine.with.min.ct, 2]
      
    }
    
    ##There aren't any conflicts so the job to schedule is the one with minor completation time
    else
    {
      job.scheduled<-job.with.smallest.ct[1]
      
      if(operation.order.scheduled[job.scheduled] < number.machines[job.scheduled]){
        ##Remove scheduled task from cut set
        operation.order.scheduled[job.scheduled]<-operation.order.scheduled[job.scheduled] + 1
        
        st <- jobs[job.scheduled,jobs[job.scheduled,(operation.order.scheduled[job.scheduled]-1),4],2] +
          jobs[job.scheduled,jobs[job.scheduled,(operation.order.scheduled[job.scheduled]-1),4],1]
        ##Insert next operation
        jobs[job.scheduled,jobs[job.scheduled,operation.order.scheduled[job.scheduled],4],1]<- st
        
        if(historical)
        {
          history <- rbind(history,
                           data.frame(
                             Job = job.scheduled,
                             Machine = jobs[job.scheduled,operation.order.scheduled[job.scheduled],4],
                             Duration = jobs[job.scheduled,operation.order.scheduled[job.scheduled],2],
                             Precedence = operation.order.scheduled[job.scheduled],
                             StartTime = st,
                             Makespan = max(jobs[,,1] + jobs[,,2]   ,na.rm = TRUE)
                                      )
                           
                           )
        }
        
        schedule$addStartTime(job.scheduled,jobs[job.scheduled,operation.order.scheduled[job.scheduled],4],st)
        
        smallest.ct[job.scheduled]<-max(jobs[job.scheduled,,1]+jobs[job.scheduled,,2],na.rm=TRUE)
        
        cut[job.scheduled]<-jobs[job.scheduled,operation.order.scheduled[job.scheduled],4]
      }
      else
      {
        cut[job.scheduled]<-NA
        smallest.ct[job.scheduled]<-NA
      }
    }
  }

  schedule$operationStartTime <- jobs[,,1]
  
  this$schedule <- schedule
  
  if(historical)
  {
    return(list(schedule = schedule,
                historical = history,
                ILP = ILP))
  }
  else
  {
    return(schedule)
  }
  
})

# 
# setMethodS3("generateSchedule_original","GTHeuristic", function(this,
#                                                        instance,
#                                                        historical = FALSE,
#                                                        ILP = NULL,
#                                                        ...) {
#   
#   inst <- instance
#   schedule <- Schedule()
#   schedule$addInstance(inst)
#   history <- NULL
#   ##  GTheuristic$schedule <- this
#   
#   problem <- list(nr.machines = inst$nrMachines(),
#                   nr.jobs = inst$nrJobs(),
#                   times = inst$duration,
#                   order = inst$precedence)
#   
#   nr.machines<-problem$nr.machines
#   nr.jobs<-problem$nr.jobs
#   
#   jobs<-array(dim=c(nr.jobs,nr.machines,4))
#   
#   jobs[,,2]<-problem$times
#   jobs[,,3]<-problem$order
#   jobs[,,4]<- t(apply(jobs[,,3], 1, order))
#   
#   ##Structure of the matrix jobs is:
#   #  jobs[jobIndex,machineIndex,1] <- start_time   
#   #  jobs[jobIndex,machineIndex,2] <- duration
#   #  jobs[jobIndex,machineIndex,3] <- order
#   #  jobs[jobIndex,orderIndex,4] <- machineIndex
#   
#   
#   jobs[which(is.na(jobs[,,3]),arr.ind = TRUE)[1],nr.machines,4] <- NA
#   
#   cut <- jobs[,1,4]
#   
#   ##Insert initial operation all in time 0
#   for(i in 1:nr.jobs)
#   {
#     jobs[i,jobs[i,1,4],1]<-0
#   }
#   
#   
#   smallest.ct <- apply(jobs[,,1]+jobs[,,2], 1, max,na.rm=TRUE)
#   operation.order.scheduled<-array(1,dim=nr.jobs)
#   job.scheduled<-NULL
#   sched <- TRUE
#   number.machines <- rep(problem$nr.machines,nr.jobs)
#   
#   ##Begin scheduling
#   while(!all(is.na(cut))){
#     
#     schedule$operationStartTime <- jobs[,,1]
#     min.value <- min(smallest.ct,na.rm=TRUE)
#     
#     job.with.smallest.ct<-which(smallest.ct == min.value)
#     
#     machine.with.min.ct <- cut[job.with.smallest.ct[1]] # If several jobs finish at the same time, chooses the first one randomly
#     jobs.with.conflict <-which(jobs[,machine.with.min.ct,1] < min.value & min.value <= (jobs[,machine.with.min.ct,1]+jobs[,machine.with.min.ct,2]))
#     
#     
#     if (length(jobs.with.conflict) > 1)
#     {
#       operations <- list()
#       
#       for(j in 1:length(jobs.with.conflict))
#       {
#         operations[[j]] <- schedule$getOperation(machine.with.min.ct,
#                                                  jobs.with.conflict[j])
#         
#       }
#       
#       
#       
#       choose.priority <- selectOperationIndex(this,
#                                               operations)
# 
#       ##heuristic.value.job.with.conflict <- eval(call(discriminant.heuristic[machine.with.min.ct],jobs.with.conflict,machine.with.min.ct,jobs))
#       ## choose.priority <-  which.min(abs(heuristic.value.job.with.conflict - eval(call(selection.function,heuristic.value.job.with.conflict))))[1]                        
#       priority.of.conflict.jobs.for.machine <- c(jobs.with.conflict[choose.priority],
#                                                  jobs.with.conflict[-choose.priority])
#       
#       ##Resolve conflict in machine
#       jobs[priority.of.conflict.jobs.for.machine[-1], machine.with.min.ct, 1] <-
#         jobs[priority.of.conflict.jobs.for.machine[1],machine.with.min.ct,1] + jobs[priority.of.conflict.jobs.for.machine[1],machine.with.min.ct,2]
#       
#       smallest.ct[priority.of.conflict.jobs.for.machine[-1]] <-
#         jobs[priority.of.conflict.jobs.for.machine[-1], machine.with.min.ct, 1]+jobs[priority.of.conflict.jobs.for.machine[-1], machine.with.min.ct, 2]
#       
#     }
#     
#     ##There aren't any conflicts so the job to schedule is the one with minor completation time
#     else
#     {
#       job.scheduled<-job.with.smallest.ct[1]
#       
#       if(operation.order.scheduled[job.scheduled] < number.machines[job.scheduled]){
#         ##Remove scheduled task from cut set
#         operation.order.scheduled[job.scheduled]<-operation.order.scheduled[job.scheduled] + 1
#         
#         st <- jobs[job.scheduled,jobs[job.scheduled,(operation.order.scheduled[job.scheduled]-1),4],2] +
#           jobs[job.scheduled,jobs[job.scheduled,(operation.order.scheduled[job.scheduled]-1),4],1]
#         ##Insert next operation
#         jobs[job.scheduled,jobs[job.scheduled,operation.order.scheduled[job.scheduled],4],1]<- st
#         
#         if(historical)
#         {
#           history <- rbind(history,
#                            data.frame(
#                              Job = job.scheduled,
#                              Machine = jobs[job.scheduled,operation.order.scheduled[job.scheduled],4],
#                              Duration = jobs[job.scheduled,operation.order.scheduled[job.scheduled],2],
#                              Precedence = operation.order.scheduled[job.scheduled],
#                              StartTime = st,
#                              Makespan = max(jobs[,,1] + jobs[,,2]   ,na.rm = TRUE)
#                            )
#                            
#           )
#         }
#         
#         schedule$addStartTime(job.scheduled,jobs[job.scheduled,operation.order.scheduled[job.scheduled],4],st)
#         
#         smallest.ct[job.scheduled]<-max(jobs[job.scheduled,,1]+jobs[job.scheduled,,2],na.rm=TRUE)
#         
#         cut[job.scheduled]<-jobs[job.scheduled,operation.order.scheduled[job.scheduled],4]
#       }
#       else
#       {
#         cut[job.scheduled]<-NA
#         smallest.ct[job.scheduled]<-NA
#       }
#     }
#   }
#   
#   schedule$operationStartTime <- jobs[,,1]
#   
#   this$schedule <- schedule
#   
#   if(historical)
#   {
#     return(list(schedule = schedule,
#                 historical = history))
#   }
#   else
#   {
#     return(schedule)
#   }
#   
# })
# 
# 

