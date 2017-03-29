



setMethodS3("WorkRemainingInJob","FeasibleScheduleOperation", function(this,...) {
  
  result <- 0
  schedule <- this$schedule
  inst <- schedule$instance
  
  
  d <- dim(schedule$operationStartTime)
  precedence <- inst$precedence
  machine <- this$machineID  
  job <- this$jobID    
  
  maxPrecedence <- max(inst$precedence[job,])
  
  if(precedence[job,machine] < maxPrecedence)
  {    
    result <- sum(inst$duration[inst$precedence[,machine] > inst$precedence[job,machine],machine])    
  }
  
  return(result)  
  
})


setMethodS3("OperationsRemainingInJob","FeasibleScheduleOperation", function(this,...) {
  
  result <- 0
  schedule <- this$schedule
  inst <- schedule$instance
  
  
  d <- dim(schedule$operationStartTime)
  precedence <- inst$precedence
  machine <- this$machineID  
  job <- this$jobID    
  
  maxPrecedence <- max(inst$precedence[job,])
  
  if(precedence[job,machine] < maxPrecedence)
  {
    result <- length(which(inst$precedence[,machine] > inst$precedence[job,machine]))    
  }
  
  return(result)  
  
})


setMethodS3("getScheduled","FeasibleScheduleOperation", function(this,...) {
  
  
  sched <- this$schedule
  
  result <- is.na(sched$operationStartTime[this$jobID,this$machineID])
  
  return(result)
})

setMethodS3("getMachineID","FeasibleScheduleOperation", function(this,...) {

  return(this$machineID)
})

setMethodS3("getJobID","FeasibleScheduleOperation", function(this,...) {
  return(this$jobID)
})

setMethodS3("getPrecedence","FeasibleScheduleOperation", function(this,...) {
  
  sched <- this$schedule
  inst <- sched$instance
  
  return(inst$precedence[this$jobID,this$machineID])
})

setMethodS3("getDuration","FeasibleScheduleOperation", function(this,...) {
  sched <- this$schedule
  inst <- sched$instance
  
  return(inst$duration[this$jobID,this$machineID])
})

setMethodS3("sameMachine","FeasibleScheduleOperation", function(this,operation = NA,...) {
  resultado <- FALSE
  
  if (inherits(operation, "FeasibleScheduleOperation"))
    {
      if(operation$getMachineID() == this$getMachineID())
        {
          resultado <- TRUE
        }
    }
  
  return(resultado)
})


