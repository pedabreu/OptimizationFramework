setConstructorS3("LearningExperiment",function()
{
  extend(DBConnection(),"LearningExperiment",
         featuresTable = NULL,
         targetTable = NULL,
         featuresGroups = NULL,
         moreFeatures = NULL,
         exceptions = NULL,
         name = NULL,
         featureElement = NULL,
         dataset = data.frame(),
         trainIndex = NULL,
         testIndex = NULL,
         target = NULL,
         ## list(<learningAlgorithmName> = <model>  )  
         models = list(),
         ## list(<features group> = <features names>     )
         features = NULL,
         predictions = NULL,
         ##list(<learningAlgorithmName> = <parameters>  )  
         learningAlgorithms = NULL,
         performance = NULL,
         type = NULL)
})



setMethodS3("scheduleFeaturesCalculationByUniqueIDs","LearningExperiment", function(this,
                                                                                instanceUniqueID,
                                                                                algUniqueID,...)
{
  con <- this$connectionDB
  
  for(dbInst in instanceUniqueID)
  {
    
    for(dbAlg in algUniqueID)
    {
      
      this$scheduledExperiments <- rbind(this$scheduledExperiments ,
                                          c(algorithmID = dbAlg,  
                                            instanceID = dbInst,
                                            uniqueID = paste(format(Sys.time(), "%y%m%d%H%M%S"),paste(sample(c(0:9, letters, LETTERS))[1:4],collapse=""),sep=""),
                                            inDB = 0))     
      
      
    }
    
  }
  
  
})

setMethodS3("scheduleFeaturesCalculation","LearningExperiment", function(this,
                                                                     repetition = 1,                                              
                                                                     nrJobs = 1:10,
                                                                     nrMachines = 1:10,
                                                                     algorithmName = c("GifflerThompson"),                                              
                                                                     ...) {
  con <- this$connectionDB
  
  for(r in 1:repetition)
  {  
    for(j in nrJobs)
    {
      for(m in nrMachines)
      {
        instDB <- DBInstance()
        instDB$attributes[["nrJobs"]] <- j
        instDB$attributes[["nrMachines"]] <- m
        
        allDBInst <- instDB$getAllByAttributes(con)
        
        for(algName in algorithmName)
        {
          algDB <- DBAlgorithmParameterized()
          algDB$attributes[["Algorithm_name"]] <- algName
          
          allDBAlg <- algDB$getAllByAttributes(con)
          
          for(dbInst in allDBInst)
          {
            
            for(dbAlg in allDBAlg)
            {
              
              this$scheduledExperiments <- rbind(this$scheduledExperiments ,
                                                  c(algorithmID = dbAlg$attributes[["uniqueID"]],  
                                                    instanceID = dbInst$attributes[["uniqueID"]],
                                                    uniqueID = paste(format(Sys.time(), "%y%m%d%H%M%S"),paste(sample(c(0:9, letters, LETTERS))[1:4],collapse=""),sep=""),
                                                    inDB = 0))     
              
            }
            
            
          }
          
          
          
        }
        
      }
      
    }
  }
  
})


setMethodS3("setScheduledFeaturesCalculationDB","LearningExperiment", function(this,...) {
  
  con <- this$connectionDB
  experiments <- this$scheduledExperiments
  
  d <- dim(experiments)
  
  
  for(exp in 1:d[1])
  {
    expDB <- DBExperiment()
    
    
    expDB$attributes <- list(AlgorithmParameterized_uniqueID = experiments[exp,"algorithmID"],
                              Instance_uniqueID = experiments[exp,"instanceID"],
                              uniqueID = experiments[exp,"uniqueID"],
                              status = "Scheduled"
    )
    
    expDB$save(con)
    
  }
  
  
})

setMethodS3("getScheduledFeaturesCalculationDB","LearningExperiment", function(this,nrExperiments=1,...) {
  
  con <- this$connectionDB
  
  query <- paste("SELECT get_experiments(",nrExperiments,")",sep="")
  experiments <- dbGetQuery(con,query)
  
  this$scheduledExperiments <- experiments
  ##dimnames(a)[[2]][which(dimnames(a)[[2]]=="")] <- "algorithmID" 
  
  
  
  ##expDB <- DBExperiment()
  ##expDB$attributes[["status"]] <- "scheduled"
  
  ##allDBExp <- expDB$getAllByAttributes(con,limit=nrExperiments,orderby="priority ASC")
  
  ##  for(expDB in 1:(dim(experiments)[2]))
  ##  {
  ##    this$scheduledExperiments <- rbind(this$scheduledExperiments,
  ##                                         c(algorithmID = experiments[expDB,"AlgorithmParameterized_uniqueID"],  
  ##                                           instanceID = expDB$attributes[["Instance_uniqueID"]],
  ##                                         uniqueID = expDB$attributes[["uniqueID"]],
  ##                                           inDB = 1)
  ##                                       )
  ##     
  ##     
  ##   }
  
})





setMethodS3("getObjectFeaturesTableName","LearningExperiment", function(this,
                                                                        ...) {
  
  
  featTable <- this$featuresTable
  
  if(is.null(featTable))
  {
    featObj <- this$featureElement
    featTable <- featObj$getFeaturesTableName()     
  }

  return(featTable)
  })


setMethodS3("populateDBOperationFeatures","LearningExperiment", function(this,
                                                                        nrJobs = 5,
                                                                        nrMachines = 5,
                                                                        tableName = paste("Operation",nrJobs,"x",nrMachines,"Features",sep=""),
                                                                        
                                                                        nrElements = 10,
                                                                        ...) {
  
  con <- this$connectionDB
  
  query <- sprintf("SELECT uniqueID,nrJobs,nrMachines FROM Instance WHERE nrJobs = %i AND nrMachines=%i AND uniqueID NOT IN (SELECT Instance_uniqueID FROM %s) ",nrJobs,nrMachines,tableName)  
  
  if(!is.null(nrElements))
  {
    query <- paste(query," LIMIT ",nrElements,sep="")
  }
  
  solution <- dbGetQuery(con,query)
  instFeat <- this$featureElement
  
  obj <- instFeat$object
  objClass <- class(obj)[1]
  
  for(ui in solution[,"uniqueID"])
  {
    ## dbobj <- eval(call(paste("DB",tableName,sep="")))
    ## dbobj$attributes <- list("Instance_uniqueID" = ui)
    inst <- Instance()
    
    inst$DBgetByUniqueID(uniqueID=ui,con=con)
    
    for(j in 1:nrJobs)
    {
      for(m in 1:nrMachines)
      {
        newobj <- eval(call(objClass))
        newobj$instance <- inst
        newobj$job <- j
        newobj$machine <- m
        newobj$DBsave(con)      
      }
    }
    
    
  }
  
  
  
})

setMethodS3("populateDBInstanceFeatures","LearningExperiment", function(this,
                                                                        nrJobs = 5,
                                                                        nrMachines = 5,
                                                                        tableName = paste("Instance",nrJob,"x",nrMachine,"Features",sep=""),
                                                                        
                                                                        nrElements = 10,
                                                                        ...) {
  
  con <- this$connectionDB

  query <- sprintf("SELECT uniqueID FROM Instance WHERE nrJobs = %i AND nrMachines=%i AND uniqueID NOT IN (SELECT Instance_uniqueID FROM %s) ",nrJobs,nrMachines,tableName)  
    
  if(!is.null(nrElements))
  {
    query <- paste(query," LIMIT ",nrElements,sep="")
  }
  
  solution <- dbGetQuery(con,query)
  instFeat <- this$featureElement
  
  obj <- instFeat$object
  objClass <- class(obj)[1]
  
  for(ui in solution[,"uniqueID"])
  {
    ## dbobj <- eval(call(paste("DB",tableName,sep="")))
    ## dbobj$attributes <- list("Instance_uniqueID" = ui)
     inst <- Instance()
     
     inst$DBgetByUniqueID(uniqueID=ui,con=con)

    newobj <- eval(call(objClass))
    newobj$instance <- inst
    
    newobj$DBsave(con)
  }
  
  
    
  })

setMethodS3("populateDBSwapSequencesSameBigInstance","LearningExperiment", function(this,
                                                                            instanceUniqueID = NULL,
                                                                            nrElements = 10,
                                                                          ...) {
 
  con <- this$connectionDB
  instID <- instanceUniqueID
  
  
  if(!is.null(instanceUniqueID))
  {    
    instance <- Instance()
    instance$DBgetByUniqueID(instID,con)
    
    

    j <- instance$nrJobs()
    m <- instance$nrMachines()
    
    i <- 1

    while(i < nrElements)
    {
      initialSeq <- rep(1:j,m)
      seq <- sample(initialSeq)
    
      swap <- sort(sample(1:length(seq),2))
   
      if(seq[swap[1]] != seq[swap[2]])
      {
        seqObj <- Sequence()
        seqObj$sequence <- seq
      
    
        elemtClass <-  class(this$featureElement$object)[1]
        swpSeq <- eval(call(elemtClass))          
        
        swpSeq$sequence <- seqObj
        swpSeq$instance <- instance
        swpSeq$index1 <- swap[1]
        swpSeq$index2 <- swap[2]
        
        swpSeq$DBsave(con)
        i <- i + 1
      }
      
      
        
    }
  }

  
})


# 
# setMethodS3("cleanFeaturesDB","LearningExperiment", function(this,...) {
#   
#   con <- this$connectionDB
#   objFeat <- this$featureElement
#   
#   ##to all groups in DB for current object type
#   featGroupObj <- DBFeaturesGroups()
#   
#   featGroupObj$attributes <- list("name" = group,
#                                    "object" = this$getObjectClassName())
#   
#   allFeatGroupObj <- featGroupObj$getAllByAttributes(con)
#   
#   for(eachfeatGroupObj in allFeatGroupObj)
#   {
#     groupName <- eachfeatGroupObj$name
#     
#     ##for each group,calculate features
#     objFeat$calculateFeatures(con,groups = groupName)
# 
#     for(feat in names(objFeat$features))
#     {
#       ##compare to the features table and clean the table
#       featObj <- DBFeatures()      
#       featObj$attributes <- list("name" = feat,
#                                   "Features_name" = group,
#                                   "Features_object" = this$getObjectClassName())      
#    
#       if(!featObj$existByAttributes(con))
#       {
#         
#       }
#       
#       
#       ##compare to the fields of table DB and add or delete the fields
# 
#     }
#     
# 
#     
#   }
#   
#   
#   
#   
# 
#   
#   
#   
# })


setMethodS3("analysisModelPlot","LearningExperiment", function(this,index = 1,...) {
  
  if(!is.null(dev.list()))
  {
    dev.off()     
  }

  
  print(this$performance)
  
  modelObj <- this$models[[index]]
    plot(modelObj$modelObject)
    text(modelObj$modelObject)    
    
  
  
  
  
})

setMethodS3("resume","LearningExperiment", function(this,...) {

  print(paste("Experiment:",this$name))
  
  print(paste("Features Groups:",  paste(this$featuresGroups,collapse=" ")))             
  print(paste("More Features:", paste(this$moreFeatures,collapse=" ")))                     
  print(paste("Exceptions:", paste( this$exceptions,collapse=" ")))

  print(paste("Nr train rows:",length(this$trainIndex)))
  print(paste("Nr test rows:",length(this$testIndex)))
  print(paste("Nr Features:",length(this$features)))
  
  print(this$performance)
  
  print("---------------Experiment---------------------")
  
})


setMethodS3("calculatePerformance","LearningExperiment", function(this,...) {
  
  namesTestIndex <- dimnames(this$dataset)[[1]][this$testIndex]
  modelsNames <- this$getModelsNames()
  real <-  this$dataset[namesTestIndex,this$target]
  
  pred <- this$predictions
  
  
  baseline <- NULL
  
  if(is.numeric(real))
  {
    baseline <- mean(real)   
  }
  else
  {
    w <- table(df2[,"SPTvsLPT"])
    baseline <- names(which(max(w) == w))
  }

  
  performance <- array(dim =c(length(this$models),1),
                       dimnames = list("Models"=modelsNames,
                                       "Measures" = c("RMSE")))
  
  for(modelIndex in 1:length(this$models)   )
  {
    
    model <- this$models[[modelIndex]]
    modelName <- paste(model$getName(),modelIndex,sep="")
 
    rmse <- 0    

    if(is.numeric(real))
    {
      rmse <-  sum((real - pred[namesTestIndex,modelName])^2)/sum((real - baseline)^2)
    }
    else
    {
     rmse <- sum( ifelse(as.character(real) == as.character(pred[namesTestIndex,modelName]),0,1))/sum(ifelse(as.character(real) == baseline,0,1))
        
    }
    


    performance[modelName,"RMSE"] <- rmse
    
    
  }


  this$performance <- performance
})

  
setMethodS3("getModelsNames","LearningExperiment", function(this,...) {
  
  modelsNames <- paste(unlist(lapply(this$models,function(x){x$getName()})),1:length(this$models),sep="")
  return(modelsNames)
})
setMethodS3("execute","LearningExperiment", function(this,...) {
  

  namesTestIndex <- dimnames(this$dataset)[[1]][this$testIndex]
  modelsNames <- this$getModelsNames()

  
  formula <- as.formula(paste(this$target,"~",paste(this$features,collapse="+"),sep=""))
  predTable <- array(dim = c(length(this$testIndex),length(this$models)),
                dimnames = list("UniqueID" = namesTestIndex,
                                "Models" = modelsNames))
  
  predTable <- as.data.frame(predTable)
  
  for(modelIndex in 1:length(this$models)   )
  {
    
    model <- this$models[[modelIndex]]
    modelName <- paste(model$getName(),modelIndex,sep="")
    modelParam <- model$parameters

   
    model$generateModelObject(formula ,this$dataset[this$trainIndex,])
    pred <- model$getPrediction(this$dataset[-this$trainIndex,]) 
  
  ##  for(i in 1:length(pred))
  ##  {
     predTable[,modelName] <-  pred
    ##}
 
  }
  
  this$predictions <- predTable
})



setMethodS3("crossvalidation","LearningExperiment", function(this,
                                               percentage = 0.8,
                                               ...) {
   
   nrElemts <- nrow(this$dataset)
   qt <- round(percentage * nrElemts)
   
   this$trainIndex <- sort(sample(1:nrElemts,qt))
   this$testIndex <- setdiff(1:nrElemts,this$trainIndex)  
   
 })

setMethodS3("getGroupsFromFeatures","LearningExperiment", function(this,
                                                                   con,
                                                                   features = NULL,
                                                                   ...) {
  
  objFeat <- this$featureElement
  
  featStg <- paste(features,collapse="','")
  
  
  
  
  query <- sprintf("SELECT * FROM Features WHERE FeaturesGroups_object = '%s'",
                   objFeat$getObjectClassName())
  

  if(length(features)>0)
    {
    query <- paste(query," AND name IN ('",featStg,"')",sep="")
    }

  
  
  sol <- dbGetQuery(con,query)
  
  return(unique(sol[,"FeaturesGroups_name"]))
  
})

setMethodS3("addFeaturesFromGroups","LearningExperiment", function(this,
                                                                   groups = NULL,
                                                                    ...) {

  
  this$features <- c(this$features,
                      this$getFeaturesFromGroups(groups))
  
})
  

setMethodS3("getFeaturesFromGroups","LearningExperiment", function(this,
                                                                   groups = NULL,
                                                                   ...) {
  con <- this$connectionDB
  objFeat <- this$featureElement

  featNames <- NULL
  
  if(!is.null(groups))
  {
    for(group in groups)
    {
    
      featDBObj <- DBFeatures()
      featDBObj$attributes <- list("FeaturesGroups_name" = group,
                                    "FeaturesGroups_object" = objFeat$getObjectClassName())
    
      allFeatDBObj <- featDBObj$getAllByAttributes(con) 
      
      for(featObj in allFeatDBObj)
      {
       
        featNames <- c(featNames,
                       featObj$attributes[["name"]])        
        
      }
      
    }
    
  }
  else
  {
    featDBObj <- DBFeatures()
    featDBObj$attributes <- list("FeaturesGroups_object" = objFeat$getObjectClassName())
    
    allFeatDBObj <- featDBObj$getAllByAttributes(con) 
    
    for(featObj in allFeatDBObj)
    {
      featNames <- c(featNames,
                     featObj$attributes[["name"]])        
      
    }
    
  }

    
 return(featNames)
  
})

setMethodS3("getAllFeatures","LearningExperiment", function(this,
                                                           ...) {
  con <- this$connectionDB
  featObj <- this$featureElement
  
  allFeatures <- NULL
  

  featObj <- this$features
    
  ##allFeatures <- featObj$getFeaturesUsed(con,featObj$getObjectClassName())
    allFeatures <-  this$features
    
  
  
  return(allFeatures)
})
  
setMethodS3("getAllDataset","LearningExperiment", function(this,
                                                           attributes = NULL,
                                                           limit = NULL,
                                                           nrRowsPerQuery = 1000,
                                                           ...) {
  
  
  
  con <- this$connectionDB
  featObj <- this$featureElement
  
  ##obj <- featObj$object
  
  table <- featObj$getObjectTableName()
  featTable <- featObj$getFeaturesTableName()
  
  
  querylimit <- ""
  
  if(!is.null(limit))
  {
    querylimit <- paste(" LIMIT ",limit)
    
  }
  
  
  allFeatures <- this$getAllFeatures()
  
  
  allColumns <- c(allFeatures,this$target)
  a <- paste(allColumns,"IS NOT NULL")
  
  dataset <- data.frame()
  
  nrColumnsPerQuery <- 10
 
  
  
  offset <- 0
  
  missingRows <- TRUE
    
    while(missingRows)
    {
      print("Getting dataset.....")
      query <- paste("SELECT uniqueID,",paste(allColumns,collapse=",")," FROM ",featTable," WHERE ",paste(a,collapse=" AND ")," limit ",nrRowsPerQuery," OFFSET ",offset,sep="")
    
      
      querysolution <- dbGetQuery(con,query)
      
      if(nrow(querysolution) < nrRowsPerQuery | nrow(dataset) >= limit)
      {
        missingRows <- FALSE
      }
        offset <- offset + nrRowsPerQuery  
      
      newDataset <-  as.data.frame(querysolution)
      
      dataset <- rbind(dataset,
                       newDataset)
      
   }
  
  queryFeat <- paste("SELECT * FROM Features WHERE name IN ('",paste(allFeatures,collapse="','"),"')",sep="" ) 
 
  queryFeatsolution <- dbGetQuery(con,queryFeat)
  
  for(feat in 1:nrow(queryFeatsolution))
  {
    name <- queryFeatsolution[feat,"name"]
 
    dataset[,name] <-eval(call(paste("as.",queryFeatsolution[feat,"type"],sep=""),dataset[,name]))
    ##dataset[,name] <- as( queryFeatsolution[feat,"type"], dataset[,name])
  }

  queryTarg <- paste("SELECT * FROM Targets WHERE name LIKE '",this$target,"'",sep="" ) 
  queryTargsolution <- dbGetQuery(con,queryTarg)
  
  for(targ in 1:nrow(queryTargsolution))
  {
    name <- queryTargsolution[targ,"name"]
    type <- "numeric"
    
    if(queryTargsolution[targ,"type"] == "Classification")
    {
      type <- "factor"
    }
    dataset[,name] <-eval(call(paste("as.",type,sep=""),dataset[,name]))
    
  }

  
  
  this$dataset <- dataset

  
  
})


setMethodS3("calculateTargetsToDB","LearningExperiment", function(this,
                                                                   attributes = NULL,
                                                                   uniqueIDs = NULL,
                                                                   limit = NULL,
                                                                   addFeatures = TRUE,
                                                                   ...) {
  
  con <- this$connectionDB
  featObj <- this$featureElement
  
  ##obj <- featObj$object
  
  if(is.null(uniqueIDs))
  {
    table <- featObj$getObjectTableName()
    
    targetsTable <- featObj$getObjectTableName()
    
    a <- paste(this$target," IS  NULL")
    
    ## query <- paste("SELECT uniqueID FROM ",table," WHERE uniqueID NOT IN (SELECT ",table,"_uniqueID FROM ",featTable," FS,Features F WHERE FS.Features_name=F.name AND Features_name IN ('",paste(this$features,collapse="','"),"') GROUP BY ",table,"_uniqueID HAVING COUNT(*) = ",length(this$features)," AND sum(F.lastchange < FS.lastchange) = ",length(this$features),")",sep="" )
    query <- paste("SELECT uniqueID FROM ",targetsTable," WHERE (",paste(a,collapse=" OR "),")",sep="")
   
    
    if(!is.null(attributes))
    {
            
      for(attrib in names(attributes))
      {
        value <- attributes[[attrib]]
        
        if(class(value) == "character")
        {
          value <- paste("'",value,"'",sep="")
          
        }
        
        
        query <- paste(" AND ",query,attrib,"=",value,sep="")
        
      }    
      
    }
    
    
    
    if(!is.null(limit))
    {
      query <- paste(query," limit ",limit,sep="")    
    }
    
    
    querysolution <- dbGetQuery(con,query)
    
    uniqueIDs <- querysolution[,"uniqueID"]
  }
  
  for(ui in uniqueIDs)
  {
  
    
    featObj$features <- list()
    
    featObj$DBgetByObjectUniqueID(ui,con)  
    
    featObj$calculateTargets(con)
    
    featObj$DBsaveTargets(con)
    
  }
  
})



setMethodS3("calculateFeatures","LearningExperiment",
            function(this,
                     
                     attributes = NULL,
                     uniqueIDs = NULL,
                     limit = NULL,
                     addFeaturesToDB = TRUE,
                     ...) {
              
              con <- this$connectionDB
              featObj <- this$featureElement
              table <- featObj$getObjectTableName()
              featTable <- featObj$getObjectTableName()
              allFeatures <- this$getAllFeatures()
              ##obj <- featObj$object
              
              if(is.null(uniqueIDs))
              {
                
                
                a <- paste("`",this$allFeatures,"` IS  NULL",sep="")
                
                ## query <- paste("SELECT uniqueID FROM ",table," WHERE uniqueID NOT IN (SELECT ",table,"_uniqueID FROM ",featTable," FS,Features F WHERE FS.Features_name=F.name AND Features_name IN ('",paste(this$features,collapse="','"),"') GROUP BY ",table,"_uniqueID HAVING COUNT(*) = ",length(this$features)," AND sum(F.lastchange < FS.lastchange) = ",length(this$features),")",sep="" )
                query <- paste("SELECT uniqueID FROM ",featTable," WHERE (",paste(a,collapse=" OR "),")",sep="")
                
                
                if(!is.null(attributes))
                {    
                  for(attrib in names(attributes))
                  {
                    value <- attributes[[attrib]]
                    
                    if(class(value) == "character")
                    {
                      value <- paste("'",value,"'",sep="")
                      
                    }
                    
                    
                    query <- paste(query," AND `",attrib,"`=",value,sep="")
                    
                  }    
                  
                }
                
                if(!is.null(limit))
                {
                  query <- paste(query," limit ",limit,sep="")    
                }
                
                querysolution <- dbGetQuery(con,query)
                
                uniqueIDs <- querysolution[,"uniqueID"]
                
                print("Lido os uniques IDs dos objectos a calcular")
              }
              
              
              
              
              
              
              
              groups <- this$getGroupsFromFeatures(con,allFeatures)
              
              
              for(ui in uniqueIDs)
              {
                
                print(paste("Carregar object ID",ui))
                featObj$features <- list()
                
                featObj$DBgetByObjectUniqueID(ui,con)  
                print(paste("Calcular features"))
                
                featObj$calculateFeatures(con,groups = groups) 
                
                if(addFeaturesToDB)
                {
                  
                  print("Gravar na DB")
                  featObj$DBsaveFeatures(con)      
                }
                else
                {
                  this$dataset <- rbind(this$dataset,
                                         as.data.frame(featObj$attributes))
                }
              }
            })


