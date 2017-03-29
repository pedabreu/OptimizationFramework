
setConstructorS3("EnsembleLearningExperiment",function(featureElement = NULL,
                                                       targets = NULL,
                                                       featuresNames = NULL,
                                                       dataset = data.frame())
{
  extend(Experiment(),"EnsembleLearningExperiment",   
         experiments = list(),
         featureElement = featureElement,
         dataset = dataset,
         trainIndex = NULL,
         testIndex = NULL,
         targets = targets,
         featuresByGroup = list(),
         ## list(<features group> = <features names>     )
         featuresPartition = list(),
         featuresNames = featuresNames)
})

setMethodS3("cleanExperiments",
            "EnsembleLearningExperiment", function(this,
                                                   ...) {   
            
              this$experiments <- list()
              })
 
 
 setMethodS3("addNormalizationFeatures",
             "EnsembleLearningExperiment", function(this,
                                                    features,
                                                    ...) {
             })


setMethodS3("addPartitionMode",
            "EnsembleLearningExperiment", function(this,
                                                   partitions,
                                                   ...) {           
              newdataset <- this$dataset
              
              allFeats <- dimnames(this$dataset)[[2]]

              for(partition in partitions)
              {
                allFeatPrefix <- partition$features
                nrIntervals <- length(partition$partition)                
                                
                for(featPrefix in allFeatPrefix)
                {
                  newfeats <- paste(featPrefix,"Interval",1:nrIntervals,sep="")
                  
                  this$featuresPartition[[featPrefix]] <- c(this$featuresPartition[[featPrefix]],
                                                             newfeats)
                  
                  
                  currentdataset <- array(0,
                                          dim = c(nrow(this$dataset),length(newfeats)),
                                          dimnames = list("ui" = NULL,
                                                          "Features" = newfeats))
                  
                  selectFeats <- grep(featPrefix,allFeats)
                                          
                  for(i in 1:nrow(this$dataset))
                  {
                    for(j in selectFeats)
                    {
                      interval <- partition$getInterval(this$dataset[i,j])
                      currentdataset[i, paste(featPrefix,"Interval",interval,sep="")] <- 1 + currentdataset[i, paste(featPrefix,"Interval",interval,sep="")]
                      
                    }               
                  }
                  
                  newdataset <- cbind(newdataset,
                                      data.frame(currentdataset))
                }
              }
              
  this$dataset <- newdataset
})

setMethodS3("resume","EnsembleLearningExperiment", function(this,...) {
  

  
  for(experim in this$experiments)
  {
    print("------------------------------Set Experiments-----------------------------------")  
    for(exp in experim)
    {
    exp$resume()
    }
    print("---------------------------End Set Experiments-------------------------------")    
    
  }
  
  
})


setMethodS3("getDataFromQueryDB","EnsembleLearningExperiment", function(this,
                                                                        query = NULL,
                                                                  
                                                                        ...)
{

  con <- this$simpleConnectDB()
  this$connectionDB <- con
  
  querysolution <- dbGetQuery(con,query)

  this$dataset <- as.data.frame(querysolution)
  
  
})

setMethodS3("getDataFromDB","EnsembleLearningExperiment", function(this,
                                                                   featuresGroups = NULL,
                                                                   moreFeatures = NULL,
                                                                   exceptions = NULL,                                                                 
                                                                   attributes = NULL,
                                                                   limit = 1000,
                                                                   nrRowsPerQuery=500,
                                                                   ...)
{
  con <- this$simpleConnectDB()
  this$connectionDB <- con
  
  allFeatures <- moreFeatures
  
  for(group in featuresGroups)
  {

    featuresNames <- this$getFeaturesFromGroup(con,
                                               group,
                                              this$featureElement$getObjectClassName() )
  
    this$featuresByGroup[[group]] <- setdiff(featuresNames,exceptions)
    
    allFeatures <- c(allFeatures,
                     featuresNames)
                     
                     
  }
  
  allFeatures <- setdiff(allFeatures,exceptions)

  dataset <- this$getAllDataset(con = con,              
                                features = allFeatures,                 
                                attributes = attributes,                   
                                limit = limit,                     
                                nrRowsPerQuery = nrRowsPerQuery)
  this$dataset <- dataset
  
  this$disconnectDB()  
})



setMethodS3("runExperiment","EnsembleLearningExperiment", function(this,
                                                                   name = NULL,
                                                                   featuresGroups = NULL,
                                                                   featuresPartition = NULL,
                                                                   moreFeatures = NULL,
                                                                   exceptions = NULL,  
                                                                   models = NULL,
                                                                   target = NULL,
                                                                   trainSize = 0.8,
                                                                   ...)
{

  allexp <- list()

  for(trainS in trainSize)
  {
    this$crossvalidation(percentage = trainS)
    allFeatures <- moreFeatures
    
    for(group in featuresGroups)
    {
      
      
      allFeatures <- c(allFeatures,
                       this$featuresByGroup[[group]])
      
      
    }
    
    for(partition in featuresPartition)
    {
      
      
      allFeatures <- c(allFeatures,
                       this$featuresPartition[[partition]])
      
      
    }
    
    allFeatures <- setdiff(allFeatures,exceptions)
    
    
    
    exp <- LearningExperiment() 
    
    exp$featuresGroups <- featuresGroups
    exp$moreFeatures <- moreFeatures
    exp$exceptions <- exceptions
    
    exp$name <- name
    featureElementObj <- this$featureElement 
    exp$featureElement <- featureElementObj
    exp$trainIndex <- this$trainIndex
    exp$testIndex <- this$testIndex      
    exp$dataset <- this$dataset
    
    exp$target <- target
    
    exp$models <- models
    exp$features <- allFeatures
    
    exp$execute()
    exp$calculatePerformance()
    
 
  
    allexp<- c(allexp,
               list(exp))
  }

  this$experiments <- c(this$experiments,
                         list(allexp))
  
  return(allexp)
})



setMethodS3("getFeaturesFromGroup","EnsembleLearningExperiment", function(this,
                                                         con = NULL,
                                                         group = NULL,
                                                         objectType = NULL,
                                                         ...) {
  

  featNames <- NULL
  
  if(!is.null(group))
  {

      featDBObj <- DBFeatures()
      featDBObj$attributes <- list("FeaturesGroups_name" = group,
                                    "FeaturesGroups_object" = objectType)
  
      allFeatDBObj <- featDBObj$getAllByAttributes(con) 
      
      for(featObj in allFeatDBObj)
      {
        featNames <- c(featNames,
                       featObj$attributes[["name"]])        
        
      }
      
    
    
  }
  else
  {
    featDBObj <- DBFeatures()
    featDBObj$attributes <- list("object" = objectType)
    
    allFeatDBObj <- featDBObj$getAllByAttributes(con) 
    
    for(featObj in allFeatDBObj)
    {
      featNames <- c(featNames,
                     featObj$attributes[["name"]])        
      
    }
    
  }
  
  
  return(featNames)
  
})





setMethodS3("crossvalidation","EnsembleLearningExperiment", function(this,
                                               percentage = 0.8,
                                               ...) {
   
   nrElemts <- nrow(this$dataset)
   qt <- round(percentage * nrElemts)
   
   this$trainIndex <- sort(sample(1:nrElemts,qt))
   this$testIndex <- setdiff(1:nrElemts,this$trainIndex)  
   
 })


setMethodS3("getAllDataset","EnsembleLearningExperiment", function(this,
                                                                   con = NULL,
                                                                   features = NULL,
                                                                   attributes = NULL,
                                                                   limit = NULL, 
                                                                   nrRowsPerQuery = 1000,
                                                                   ...) {
  
  
  

  featObj <- this$featureElement
  
  ##obj <- featObj$object
  
  table <- featObj$getObjectTableName()
  featTable <- featObj$getObjectTableName()
  
  
  querylimit <- ""
  
  if(!is.null(limit))
  {
    querylimit <- paste(" LIMIT ",limit)
    
  }
  
  
  allFeatures <- features
  
  
  allColumns <- c(allFeatures,this$targets)
  a <- paste("`",allColumns,"` IS NOT NULL",sep="")
  
  dataset <- data.frame()
  
  nrColumnsPerQuery <- 10
 
  
  
  offset <- 0
  
  missingRows <- TRUE
    
  
  while(missingRows)  
  
    {
    
    print("Getting dataset.....")
   
    query <- paste("SELECT uniqueID,`",paste(allColumns,collapse="`,`"),"` FROM ",featTable," WHERE ",paste(a,collapse=" AND ")," limit ",nrRowsPerQuery," OFFSET ",offset,sep="")
   
      
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

  queryTarg <- paste("SELECT * FROM Targets WHERE name IN ('",paste(this$targets,collapse="','"),"')",sep="" ) 
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

  
  
 return(dataset)

  
  
})
