library("R.oo")

setConstructorS3("OptimizationExperiment",function()
{  
  extend(DBConnection(),"OptimizationExperiment",
         scheduledExperiments = NULL)  
})



setMethodS3("RunStatus","OptimizationExperiment", function(this,                                         
                                                                 ...) {
  
  con <- this$connectionDB
  


"SELECT status,count(*) FROM Run GROUP BY status"
  
})

setMethodS3("exportDBToFiles","OptimizationExperiment", function(this,path,                                         
                                                     ...) {
  
  con <- this$connectionDB
  experiments <- this$scheduledExperiments
  
  d <- dim(experiments)
  
  
  for(exp in 1:d[1])
  {
    
    uniqueIDinst <- experiments[exp,"instanceID"]
    uniqueIDAlg <- experiments[exp,"algorithmID"]    
    
    inst <- Instance()
    inst$DBgetByUniqueID(uniqueIDinst,con)
    
    algDB <- DBAlgorithmParameterized()
    algDB$attributes[["uniqueID"]] <- uniqueIDAlg
    algDB$getByAttributes(con)
    
    
    algName <- algDB$attributes[["Algorithm_name"]]
    
    eval(parse(text=paste("alg<-",algName,"()",sep="")))
    alg$DBgetByUniqueID(uniqueIDAlg,con)
    
    
    
    dbExp <- DBExperiment()
    dbExp$attributes[["uniqueID"]] <- experiments[exp,"uniqueID"]
    dbExp$attributes[["Instance_uniqueID"]] <-   uniqueIDinst 
    dbExp$attributes[["AlgorithmParameterized_uniqueID"]] <- uniqueIDAlg
    dbExp$attributes[["status"]] <- "Running" 
    
    dbExp$save(con)
    
    runalg <- Run()
    runalg$setRun(alg,inst)
    runalg$go()
    
    DBsave(runalg,con)     
    
    dbExp <- DBExperiment()
    dbExp$attributes[["uniqueID"]] <- experiments[exp,"uniqueID"]
    dbExp$attributes[["status"]] <- "Finished" 
    
    dbExp$save(con)
    
  }
  
  
})


setMethodS3("execute","OptimizationExperiment", function(this,...) {
  
  con <-this$connectionDB
  experiments <- this$scheduledExperiments

  d <- dim(experiments)
    
  
  for(exp in 1:d[1])
  {

    uniqueIDinst <- experiments[exp,"instanceID"]
    uniqueIDAlg <- experiments[exp,"algorithmID"]    
  
    inst <- Instance()
    inst$DBgetByUniqueID(uniqueIDinst,con)
      
    algDB <- DBAlgorithmParameterized()
    algDB$attributes[["uniqueID"]] <- uniqueIDAlg
    algDB$getByAttributes(con)
    
    
    algName <- algDB$attributes[["Algorithm_name"]]
    
    eval(parse(text=paste("alg<-",algName,"()",sep="")))
    alg$DBgetByUniqueID(uniqueIDAlg,con)
    
    
    
    dbExp <- DBExperiment()
    dbExp$attributes[["uniqueID"]] <- experiments[exp,"uniqueID"]
    dbExp$attributes[["Instance_uniqueID"]] <-   uniqueIDinst 
    dbExp$attributes[["AlgorithmParameterized_uniqueID"]] <- uniqueIDAlg
    dbExp$attributes[["status"]] <- "Running" 
    
    dbExp$save(con)
    
    runalg <- Run()
    runalg$setRun(alg,inst)
    runalg$go()
    
    DBsave(runalg,con)
    
    dbExp <- DBExperiment()
    dbExp$attributes[["uniqueID"]] <- experiments[exp,"uniqueID"]
    dbExp$attributes[["status"]] <- "Finished" 
    
    dbExp$save(con)
    
  }
  
})



setMethodS3("getAlgorithmsParameterizedFromName","OptimizationExperiment", function(this,                                                          
                                                                        
                                                                        algorithmNames,
                                                                        ...) {  
  con <- this$connectionDB
  
  allNames <- paste(algorithmNames,collapse="','")
  
  ## query1 <- paste("SELECT AlgorithmParameterized_uniqueID,",repeatitionAggregator,"(makespan) AS mkspan,InstanceSize,count(*) AS nrInstances FROM (SELECT AlgorithmParameterized_uniqueID,R.Instance_uniqueID,CONCAT(CONVERT(nrJobs,CHAR),'x',CONVERT(nrMachines,CHAR)) AS InstanceSize  FROM Run R,Instance I,FeasibleSchedule F WHERE R.FeasibleSchedule_uniqueID=F.uniqueID AND I.uniqueId=R.Instance_uniqueID   GROUP BY AlgorithmParameterized_uniqueID,R.Instance_uniqueID HAVING count(*)>",repeatitions - 1,") l GROUP BY AlgorithmParameterized_uniqueID,InstanceSize",sep="")
  query1 <- paste("SELECT uniqueID FROM AlgorithmParameterized WHERE Algorithm_name IN ('",allNames,"')",sep="")
  
  sol1 <- dbGetQuery(con,query1)
  
  allAlgUniqueID <- unique(sol1[,"uniqueID"])
  
  return(allAlgUniqueID)
  
})


setMethodS3("experimentsDescription","OptimizationExperiment", function(this,  
                                                          
                                                          repeatitions = 1,
                                                          algorithmNames,
                                                          algorithmParameterizedIDs = this$getAlgorithmsParameterizedFromName(algorithmNames),
                                                          ...) {
  con <- this$connectionDB
  algIDs <- paste(algorithmParameterizedIDs,collapse="','")
  query1 <- paste("SELECT AlgorithmParameterized_uniqueID,InstanceSize,count(*) AS nrInstances FROM (SELECT AlgorithmParameterized_uniqueID,Instance_uniqueID,CONCAT(CONVERT(nrJobs,CHAR),'x',CONVERT(nrMachines,CHAR)) AS InstanceSize  FROM Run R,Instance I WHERE AlgorithmParameterized_uniqueID IN ('",algIDs,"')  AND I.uniqueId=R.Instance_uniqueID   GROUP BY AlgorithmParameterized_uniqueID,Instance_uniqueID HAVING count(*)>",repeatitions - 1,") l GROUP BY AlgorithmParameterized_uniqueID,InstanceSize",sep="")
  sol1 <- dbGetQuery(con,query1)
  
  instTable<-array(dim = c(length(unique(sol1[,"AlgorithmParameterized_uniqueID"])),
                           length(unique(sol1[,"InstanceSize"]))),
                   dimnames=list(Algorithm = unique(sol1[,"AlgorithmParameterized_uniqueID"]),
                                 InstanceSize = c(unique(sol1[,"InstanceSize"]))))
  
  d1 <- dim(sol1)
  
  for(j in 1:d1[1])
  {
    
    instTable[sol1[j,"AlgorithmParameterized_uniqueID"],
              sol1[j,"InstanceSize"]] <- sol1[j,"nrInstances"]    
    
    
  }
  
  return(instTable)  
})


setMethodS3("parameterDescription","OptimizationExperiment", function(this,  
                                                          
                                                          algorithmNames,
                                                          algorithmParameterizedIDs = this$getAlgorithmsParameterizedFromName(algorithmNames),
                                                                                                    ...) {
  con <- this$connectionDB
  allAlgUniqueID <- paste(algorithmParameterizedIDs,collapse="','")
  
  query <- paste("SELECT value,CONCAT(parameter,'@',attribute) AS parameter,AlgorithmParameterized_uniqueID  FROM AlgorithmParameterizedParameters APP,AlgorithmParameterized AP WHERE APP.AlgorithmParameterized_uniqueID = AP.uniqueID AND AP.uniqueID IN ('",allAlgUniqueID,"')",sep="")
  sol <- dbGetQuery(con,query)
#   
#   header1 <- unlist(lapply(unique(sol[,"parameter"]),function(x){strsplit(x,"@")[[1]][2]   }))
#   
#   header1[duplicated(header1)] <- ""
#   
#   header1 <- c("",header1,"Instances (nr jobs x nr machines)")
  
  paramTable<-array(dim = c(length(unique(sol[,"AlgorithmParameterized_uniqueID"])),
                            1+length(unique(sol[,"parameter"]))),
                    dimnames=list(Algorithm = unique(sol[,"AlgorithmParameterized_uniqueID"]),
                                  Parameter = c("AlgorithmUniqueID",unique(sol[,"parameter"]))))
  
  
  
  d <- dim(sol)
  
  for(i in 1:d[1])
  {
    paramTable[sol[i,"AlgorithmParameterized_uniqueID"],
               sol[i,"parameter"]] <- sol[i,"value"]
    
    paramTable[sol[i,"AlgorithmParameterized_uniqueID"],
               "AlgorithmUniqueID"] <- sol[i,"AlgorithmParameterized_uniqueID"]    
    
    
    
    
  }
  
  return(paramTable)
  
})


setMethodS3("winningDescription","OptimizationExperiment", function(this,  
                                                  
                                                  algorithmNames,
                                                  algorithmParameterizedIDs = this$getAlgorithmsParameterizedFromName(algorithmNames),
                                                  repeatitions = 1,
                                                  ...) {
  
  con <- this$connectionDB
  query <- paste("SELECT name,Algorithm_name AS AlgorithmName,count(*) AS repetitions,AlgorithmParameterized_uniqueID AS algorithmID,R.Instance_uniqueID AS instanceID,AVG(makespan) AS mkspan,CONCAT(CONVERT(nrJobs,CHAR),'x',CONVERT(nrMachines,CHAR)) AS InstanceSize FROM `Run` R,FeasibleSchedule F,Instance I,AlgorithmParameterized A WHERE A.uniqueID IN ('",paste(algorithmParameterizedIDs,collapse="','"),"') AND A.uniqueID=R.AlgorithmParameterized_uniqueID AND R.FeasibleSchedule_uniqueID=F.uniqueID AND R.Instance_uniqueID=I.uniqueID GROUP BY AlgorithmParameterized_uniqueID,R.Instance_uniqueID HAVING count(*) >= ",repeatitions,sep="")
  sol <- dbGetQuery(con,query)
  
  
  instTable<-array(0,dim = c(length(unique(sol[,"algorithmID"])),
                           length(unique(sol[,"InstanceSize"]))),
                   dimnames=list(Algorithm = unique(sol[,"algorithmID"]),
                                 InstanceSize = c(unique(sol[,"InstanceSize"]))))
  

  
  for(instID in unique(sol[,"instanceID"]))
  {
    sol1 <- sol[which(sol[,"instanceID"]==instID),]
    instSize <- sol1[1,"InstanceSize"]
    
    if(dim(sol1)[1] == length(algorithmParameterizedIDs)   )
    {
      algsWinner <- sol1[which(min(sol1[,"mkspan"])==sol1[,"mkspan"]),"algorithmID"]
      
      instTable[algsWinner,instSize] <- instTable[algsWinner,instSize] + 1 
    }
  }
  
  return(instTable)
  
})


setMethodS3("winningTable","OptimizationExperiment", function(this,  
                                                              
                                                              algorithmNames,
                                                              algorithmParameterizedIDs = this$getAlgorithmsParameterizedFromName(algorithmNames),                                                 
                                                              repeatitions = 1,
                                                              ficheiro = NULL,
                                                              ...) {
  
  
  paramTable <- this$parameterDescription(algorithmParameterizedIDs = algorithmParameterizedIDs)
  instTable <- this$winningDescription(algorithmParameterizedIDs = algorithmParameterizedIDs,repeatitions=repeatitions)
  
  dimNamesParam <- dimnames(paramTable)[[2]]
  dimNamesInst <- dimnames(instTable)[[2]]
  
  
  header1 <- unlist(lapply(dimNamesParam[-1],function(x){strsplit(x,"@")[[1]][2]   }))   
  header1[duplicated(header1)] <- ""     
  header1 <- c("",header1,"Instances (nr jobs x nr machines)")
  
  header2 <- unlist(lapply(dimNamesParam[-1],function(x){strsplit(x,"@")[[1]][1]   }))
  header2 <- c("Algorithm UI",header2,dimNamesInst)
  
  
  finalTable <- cbind(paramTable,instTable)
  
  write(header1, file = ficheiro, sep = ";",
        ncolumns = length(header2)) 
  
  write(header2, file = ficheiro, sep = ";",
        ncolumns = length(header2), append=TRUE)   
  
  write.table(finalTable, file = ficheiro, sep = ";",append=TRUE, 
              row.names = FALSE,
              col.names = FALSE)
  
  
  
  
  return(finalTable)
  
  
})




setMethodS3("experimentTable","OptimizationExperiment", function(this,
                                                                 
                                                                 algorithmNames,
                                                                 algorithmParameterizedIDs = this$getAlgorithmsParameterizedFromName(algorithmNames),                                                   
                                                                 repeatitions = 1,
                                                                 ficheiro = NULL,
                                                                 ...) {
  
  con <- this$connectionDB
  paramTable <- this$parameterDescription(algorithmParameterizedIDs = algorithmParameterizedIDs)
  instTable <- this$experimentsDescription(algorithmParameterizedIDs = algorithmParameterizedIDs,repeatitions=repeatitions)
  
  dimNamesParam <- dimnames(paramTable)[[2]]
  dimNamesInst <- dimnames(instTable)[[2]]
  
  
  header1 <- unlist(lapply(dimNamesParam[-1],function(x){strsplit(x,"@")[[1]][2]   }))   
  header1[duplicated(header1)] <- ""     
  header1 <- c("",header1,"Instances (nr jobs x nr machines)")
  
  header2 <- unlist(lapply(dimNamesParam[-1],function(x){strsplit(x,"@")[[1]][1]   }))
  header2 <- c("Algorithm UI",header2,dimNamesInst)
  
  
  finalTable <- cbind(paramTable,instTable)
  
  write(header1, file = ficheiro, sep = ";",
        ncolumns = length(header2)) 
  
  write(header2, file = ficheiro, sep = ";",
        ncolumns = length(header2), append=TRUE)   
  
  write.table(finalTable, file = ficheiro, sep = ";",append=TRUE, 
              row.names = FALSE,
              col.names = FALSE)



  
  return(finalTable)
})





