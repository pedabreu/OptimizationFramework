setConstructorS3("PartialPriorityList",function()
{  
  father <- GTHeuristic()
  father$solutionType <- "PartialPriorityList"   
  
  extend(father,"PartialPriorityList",
         id = NA,
 #        max_size = NA,
         defaultRule = Rule(),
         priorityList = list())
})

setMethodS3("sameDBObject","PartialPriorityList", function(this,pl,con=NULL,...) {
  
  sameheuristic <-NextMethod("sameDBObject",this,pl,con)
  
  same <- all(this$priorityList == pl$priorityList)  &
    sameheuristic
  
  return(same)
})


setMethodS3("DBsave","PartialPriorityList", function(this,con=NULL,...) {

 NextMethod("DBsave",this,con)
  
  DBobj<-DBPartialPriorityList()
  
  
  rule <- this$defaultRule
  
  DBobj$attributes<-list(
    defaultEvaluationFunction = rule$operationEvaluationFunction,
              defaultSelectionFunction = rule$selectionFunction,
                          Solution_uniqueID = this$uniqueID)
   
  
  id <- DBobj$save(con)
 this$id <- id
  ##instanceID <- a[1,"LAST_INSERT_ID()"]

  priorityList <- this$priorityList
  
  for(m in 1:length(priorityList))
  {
    machineList <- priorityList[[m]]
    
    for(p in 1:length(machineList))
    {
      DBobj1<-DBListsPartialPriorityList()
      
      DBobj1$attributes<-list(machine = m,
                               job = machineList[p],
                               priority = p,
                               PartialPriorityList_id = id)
      DBobj1$save(con)
    }
    
    
  }
  
})



setMethodS3("DBgetByUniqueID","PartialPriorityList", function(this,uniqueID=NULL,con=NULL,...) {
  

  
  NextMethod("DBgetByUniqueID",this,uniqueID,con)
  
  DBobj<-DBPartialPriorityList()
  
  
  DBobj$attributes["Solution_uniqueID"]<-uniqueID
  DBobj$getByAttributes(con) 
  
  attribObj<-DBobj$attributes
  this$id <- attribObj[["id"]] 
  
  rule <- Rule()
  
  rule$attributes <- list(operationEvaluationFunction = attribObj[["defaultEvaluationFunction"]],
               selectionFunction = attribObj[["defaultSelectionFunction"]])
 

  this$defaultRule <- rule
  

  
  DBobjOp<-DBListsPartialPriorityList()
  
  DBobjOp$attributes[["PartialPriorityList_id"]] <- attribObj[["id"]] 
  
  allDBOp <- DBobjOp$getAllByAttributes(con)    
  
  ##this$priorityList <- array(dim=c(nrJobs,nrMachines))
  priorityList <- list()

  length(priorityList) <- this$nrMachines
  

  for(i in 1:length(allDBOp))
  {
    currentDBOp <- allDBOp[[i]]
    
    attriCurrentDBOp <- currentDBOp$attributes
      
    j <- attriCurrentDBOp[["job"]]
    m <- attriCurrentDBOp[["machine"]]
    p <- attriCurrentDBOp[["priority"]]
    

    machineList <- priorityList[[m]]
    machineList[p] <- j
    
    priorityList[[m]] <- machineList
        
  }
  
  this$priorityList <- priorityList
  
})




setMethodS3("randomGeneration","PartialPriorityList", function(this,
                                                               instance,
                                                               ...) {
  
 
  NextMethod("randomGeneration",instance)
  minListLength = 1
  maxListLength = instance$nrJobs()
  listLengthByMachine = round(runif(instance$nrMachines(),
                                    min = minListLength,
                                    max = maxListLength))
  #p <- GTHeuristic()
 # randomGeneration.GTHeuristic(this,instance)

  nr.machines<-instance$nrMachines()
  nr.jobs<-instance$nrJobs()

  for(m in 1:nr.machines)
    {
      this$priorityList[[m]] <- sample(1:nr.jobs,listLengthByMachine[m])
    } 


})


setMethodS3("selectOperationIndex","PartialPriorityList", function(this,
                                                                   operations=NULL,
                                                                   schedule = NULL,...) {

  firstOperation <- operations[[1]]
  
  machine <- firstOperation$getMachineID()
  all.jobs <- unlist(lapply(operations,function(x){x$getJobID()}))

  
  pList <- this$priorityList[[machine]]
 
  intersectionLists <- intersect(pList,all.jobs)
  choose.priority <- 1
  
  if(length(intersectionLists)== length(all.jobs))
    {
      
      evaluation <- unlist(lapply(operations,function(x){job <- x$getJobID();which(pList == job)}))
      choose.priority <-  which.min(evaluation) 
    }
  else
    {
      
     ruleHeuristic <- this$defaultRule
     choose.priority <- ruleHeuristic$selectOperationIndex(operations,schedule)   
    }


  return(choose.priority)
  
})



