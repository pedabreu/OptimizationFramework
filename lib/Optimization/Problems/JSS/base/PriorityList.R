setConstructorS3("PriorityList",function()
{
  father <- GTHeuristic()
  father$solutionType <- "PriorityList"   
  
  extend(father,"PriorityList",
         priorityList = NULL)

})

setMethodS3("DBsave","PriorityList", function(this,con=NULL,...) {
  
 NextMethod("DBsave",this,con)
  
  
  pl <- this$priorityList
  d <- dim(pl)
  
  
  for(j in 1:(d[1]))
  {
    for(m in 1:(d[2]))
    {
      DBobj1<-DBPriorityList()
      
      DBobj1$attributes<-list(machine = m,
                               job = j,
                               priority = this$priorityList[j,m],
                               Solution_uniqueID = this$uniqueID)
      DBobj1$save(con)
      
    }
  }
  
})

setMethodS3("sameDBObject","PriorityList", function(this,pl,con=NULL,...) {

  sameheuristic <-NextMethod("sameDBObject",this,pl,con)
  
  same <- all(this$priorityList == pl$priorityList) &
    sameheuristic
  
  return(same)
  
  })


setMethodS3("DBgetByUniqueID","PriorityList", function(this,uniqueID,con=NULL,...) {
  

  
  
  NextMethod("DBgetByUniqueID",this,uniqueID,con)
  

  
  DBobjOp<-DBPriorityList()
  
  DBobjOp$attributes[["Solution_uniqueID"]] <- uniqueID
  
  allDBOp <- DBobjOp$getAllByAttributes(con)    
  
  priorityList <- list()
  
  for(i in 1:length(allDBOp))
  {
    currentDBOp <- allDBOp[[i]]
         
    attriCurrentDBOp <- currentDBOp$attributes
         
    j <- attriCurrentDBOp[["job"]]
    m <- attriCurrentDBOp[["machine"]]
    p <- attriCurrentDBOp[["priority"]]
    
    if(length(priorityList) < m)
    {
      length(priorityList) <- m      
    }
    
    priorityList[[m]][j] <- p    
    
  }

  this$priorityList <-  array(unlist(priorityList), dim = c(length(priorityList[[1]]), length(priorityList)))
    
})


setMethodS3("selectOperationIndex","PriorityList", function(this,
                                                            operations=NULL,
                                                            schedule = NULL,
                                                            ...) {
  
  firstOperation <- operations[[1]]
  machine <- firstOperation$getMachineID()
  
  evaluation <- unlist(lapply(operations,function(x){job <- x$getJobID();which(this$priorityList[,machine] == job)}))
  choose.priority <-  which.min(evaluation)     
  
  return(choose.priority)
})



setMethodS3("randomGeneration","PriorityList", function(this,instance,...) {

  NextMethod("randomGeneration",this,instance)
    
	nr.jobs<-instance$nrJobs()
	nr.machines<-instance$nrMachines()
      
  this$priorityList <- apply(array(1:nr.jobs,dim = c(nr.jobs,nr.machines)),2,sample)

})

