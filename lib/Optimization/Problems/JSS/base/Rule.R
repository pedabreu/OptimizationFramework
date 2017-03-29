setMethodS3("EndTime","Rule", function(this,
                                       operations = NULL,
                                       ...) {
  
  
  
  allperm <- permn(1:length(operations))
  
  machine <- operations[[1]]$machineID
  
  schedule <- operations[[1]]$schedule
  inst <- schedule$instance
  
  allJobs <- unlist(lapply(operations,
                           function(operation){operation$jobID}))  
  
  evaluation <- NULL  
  
  for(opIndex in 1:length(operations))
  {
    currentEval <- Inf
    
    newperm <- setdiff(1:length(operations),opIndex)
    
    if(length(newperm) == 1)
    {
      allperm <- as.list(newperm)
    }
    else
    {
      allperm <- permn(newperm)
    }
    
    
    
    for(i in 1:length(allperm))
    {
      permOperation <- c(c(opIndex),allperm[[i]])
      allJobsPerm <- allJobs[permOperation]
      simschedule <- clone(schedule)
      
      for(jIndex in 1:(length(allJobsPerm)-1))
      {
        j <- allJobsPerm[jIndex]
        
        st <- sum(simschedule$operationStartTime[j,] + inst$duration[j,],na.rm = TRUE) 
        
        simschedule$operationStartTime[allJobsPerm[(jIndex + 1):length(allJobsPerm)],machine] <- st
        
        
        
      }   
      
      currentEval <- min(simschedule$makespan(),currentEval)
    }
    
    
    evaluation[opIndex] <- currentEval   
  }
  
  
  return(evaluation)
  
})

setMethodS3("Random","Rule", function(this,
                                      operations = NULL,
                                      ...) {
  
  
  evaluation <- runif(length(operations))
  
  return(evaluation)
  
})

setMethodS3("ProcessingTime","Rule", function(this,
                                              operations = NULL,
                                              ...) {
  
  
  evaluation <- unlist(lapply(operations,
                              function(operation){operation$getDuration()}))  
  
  return(evaluation)
  
})

setMethodS3("OperationsRemaining","Rule", function(this,
                                                   operations = NULL,
                                                   ...) {
  
  evaluation <- unlist(lapply(operations,
                              function(operation){operation$OperationsRemainingInJob()}))  
  
  return(evaluation)
  
})


setMethodS3("WorkRemaining","Rule", function(this,
                                             operations = NULL,
                                             ...) {
  
  evaluation <- unlist(lapply(operations,
                              function(operation){operation$WorkRemainingInJob()}))  
  
  return(evaluation)
  
  
})



setMethodS3("selectOperationIndex","Rule", function(this,
                                                    operations = NULL,
                                                    ...) {
  
  evaluation <- eval(call(this$operationEvaluationFunction,
                          this,operations))
  
  #evaluation <- unlist(lapply(operations,funcao))  
  choose.priority <-  which.min(abs(evaluation - eval(call(this$selectionFunction,evaluation))))[1]      
  
  return(choose.priority)
  
})



setMethodS3("randomGeneration","Rule", function(this,instance,...) {
  
  
  this$operationEvaluationFunction <- "ProcessingTime"
  this$selectionFunction <- sample(c("max","min","mean","median"))[1]	  
  
  
})

setMethodS3("DBsave","Rule", function(this,con=NULL,...) {
  
  NextMethod("DBsave",this,con)
  
  DBObjSol<-DBRule()    
  
  DBObjSol$attributes<-list("evaluation" = this$operationEvaluationFunction,
                            "selection" = this$selectionFunction,
                            "Solution_uniqueID" = this$uniqueID)
  DBObjSol$save(con)
  
  
})

setMethodS3("DBgetByUniqueID","Rule", function(this,uniqueID,con=NULL,...) {
  
  NextMethod("DBsave",this,con)
  
  DBobjOp<-DBRule()
  
  DBobjOp$attributes[["Solution_uniqueID"]] <- uniqueID
  
  DBobjOp$getByAttributes(con)  
  
  attrib <- DBobjOp$attributes
  
  this$operationEvaluationFunction <- attrib[["evaluation"]]
  this$selectionFunction <- attrib[["selection"]]  
  this$Solution_uniqueID <- uniqueID
})




setMethodS3("ILCriticalPathConstraints","Rule", function(this,
                                                         schedule,...) {
  
  
  all_cp <- schedule$getCriticalPath()
  explanation <- NULL
  
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
        
        prevOperationMachine <- schedule$instance$precedence[job,machine] - 1
        
        
        if(prevOperationMachine > 0)
        {
          prevMachineID <- schedule$instance$precedenceIndex()[job,prevOperationMachine]
          
          allPrevPath <- schedule$getPath(data.frame(job,prevMachineID))
          
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
        
        j1 <- info[op1Index,"job"]
        m1 <- info[op1Index,"machine"]
        
        j2 <- info[op2Index,"job"]
        m2 <- info[op2Index,"machine"]
        
        mustIntersectConstraint <- paste("max(S",j1,m1,",S",
                                         j2,m2,") < min(E",info[op1Index,"job"],info[op1Index,"machine"],",E",
                                         info[op2Index,"job"],info[op2Index,"machine"],")",sep="")
        
        
        constraint <- NULL
        
        if(this$operationEvaluationFunction == "ProcessingTime")
        {
         if(schedule$operationStartTime[j1,m1] < schedule$operationStartTime[j2,m2])
         {
           if(this$selectionFunction == "min")
           {
             constraint <- paste("D",j1,m1," < D",j2,m2,sep="")
           }
           
           if(this$selectionFunction == "max")
           {
             constraint <- paste("D",j1,m1," > D",j2,m2,sep="")
           }
           
         }
          else
          {
            if(this$selectionFunction == "min")
            {
              constraint <- paste("D",j1,m1," > D",j2,m2,sep="")
            }
            
            if(this$selectionFunction == "max")
            {
              constraint <- paste("D",j1,m1," < D",j2,m2,sep="")
            }
          }
         
        
          
          
        }
        
        explanation <- c(explanation,
                         mustIntersectConstraint,
                         constraint
                         )
        
      }
      
      explanation <- c(as.character(info[,"start"]),
                       as.character(info[,"end"]),
                       explanation)
    }
  }
  return(explanation)
  
  
})

