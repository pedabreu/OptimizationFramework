



setMethodS3("WorkRemainingInJob","Operation", function(this,schedule,...) {
  
  result <- 0
  inst <- schedule$instance
  
  
  d <- dim(schedule$operationStartTime)
  precedence <- this$precedence
  machine <- this$machineID  
  job <- this$jobID    
  
  maxPrecedence <- max(inst$precedence)
  
  if(precedence < maxPrecedence)
  {    
    result <- sum(inst$duration[inst$precedence[,machine] > inst$precedence[job,machine],machine])    
  }
  
  return(result)  
  
})


setMethodS3("OperationsRemainingInJob","Operation", function(this,schedule,...) {
  
  result <- 0
  inst <- schedule$instance
  
  
  d <- dim(schedule$operationStartTime)
  precedence <- this$precedence
  machine <- this$machineID  
  job <- this$jobID    
  
  maxPrecedence <- max(inst$precedence)
  
  if(precedence < maxPrecedence)
  {    
    result <- length(which(inst$precedence[,machine] > inst$precedence[job,machine]))    
  }
  
  return(result)  
  
})

setMethodS3("getMachineID","Operation", function(this,...) {
  return(this$machineID)
})

setMethodS3("getJobID","Operation", function(this,...) {
  return(this$jobID)
})

setMethodS3("getPrecedence","Operation", function(this,...) {
  inst <- this$instance
  
  return(isnt$precedence)
})

setMethodS3("getDuration","Operation", function(this,...) {
  
  inst <- this$instance
  
  return(inst$duration)
})

setMethodS3("sameMachine","Operation", function(this,operation = NA,...) {
  resultado <- FALSE
  
  if (inherits(operation, "Operation"))
    {
      if(operation$getMachineID() == this$getMachineID())
        {
          resultado <- TRUE
        }
    }
  
  return(resultado)
})



setMethodS3("DBsave","Operation", function(this,con=NULL,...) {
  
  DBobj<-DBOperation()
  
  
  inst <- this$instance
  
  DBobj$attributes<-list("Instance_uniqueID" = inst$uniqueID,
                          "machine" = this$machine,
                          "job" = this$job)
  
  DBobj$save(con)
  
})


setMethodS3("constructObjectFromDBMainObject",
            "Operation", function(this,
                                                  con = NULL,
                                                  ...) {
        
              DBobj <- this$mainDBObject
              
              attrib <- DBobj$attributes
              
            
              
            
              this$job <- attrib[["job"]]
              this$machine <- attrib[["machine"]]
              this$duration <- attrib[["duration"]]
              this$precedence <- attrib[["precedence"]]
     
              inst <- Instance()
              inst$DBgetByUniqueID(list(uniqueID=attrib[["Instance_uniqueID"]]),
                                   con)
       
              
              this$instance <- inst
              
              
              
            })




setMethodS3("DBgetByUniqueID","Operation", function(this,uniqueID = NULL,con=NULL,...) {
  
  # sourceDirectory(paste("./lib/MySQLInterface/",sep=""))
  DBobj<-DBOperation()

  if(!is.null(uniqueID))
  {
    DBobj$attributes[["uniqueID"]] <- uniqueID   
  }
    

  
  
  DBobj$getByAttributes(con)
  
  
  attrib <- DBobj$attributes
  
  uniqueID <- attrib[["uniqueID"]] 
  
  this$uniqueID <- uniqueID    
  this$job <- attrib[["job"]]
  this$machine <- attrib[["machine"]]
  this$duration <- attrib[["duration"]]
  this$precedence <- attrib[["precedence"]]
                          
  inst <- Instance()
  inst$DBgetByUniqueID(attrib[["Instance_uniqueID"]],con)
  
  
  this$instance <- inst
  
})


