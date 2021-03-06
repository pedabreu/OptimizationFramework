setConstructorS3("TwoAlgorithmSelectionFeaturedElement",function()
{
  
  extend(objFeat,"InstanceFeaturedElement",
         algorithm1 = NULL,
         algorithm2 = NULL)
  
  })


setMethodS3("targets","TwoAlgorithmSelectionFeaturedElement", function(this,con=NULL,...) {
  
 
  instance <- this$object
  
  algs <-list(this$algorithm1,this$algorithm2)

  
  
  avgMkspan <- NULL
  targNames <- NULL
  
  for(algIndex in 1:2)
  {
    alg <- algs[[algIndex]]
    
    DBRun <- DBRun()
    DBRun$attributes <- list("Instance_uniqueID" = instance$uniqueID,
                              "AlgorithmParameterized_uniqueID"=alg$uniqueID)
    
    allDBRun <- DBRun$getAllByAttributes(con)
    
    mkspan <- NULL
    
    for(i in 1:length(allDBRun))
    {
      
      currentDBRun <- allDBRun1[[i]]
      
      schedUI <- currentDBRun$attributes[["FeasibleSchedule_uniqueID"]]
      
      sched <- Schedule()
      sched$DBgetByUniqueID(con)
      mkspan <- c(mkspan,sched$makespan())
      
    }
    
    avgMkspan[algIndex] <- mkspan
    
    
    targNames[[algIndex]] <- algs[[algIndex]]$uniqueID
    
    
    if(!is.null(algs[[algIndex]]$name) && nchar(algs[[algIndex]]$name)>0)
    {
      targName[[algIndex]] <- algs[[algIndex]] $name
    }
    
     
  }
  targ <- list()
  
  diffMkspan <-  avgMkspan[[1]] - avgMkspan[[2]]
  winner <- ifelse(diffMkspan < 0,1,2)
  
  if(diffMkspan == 0)
  {
    winner <- 0
  }

  
  targ[["DiffMakespan"]] <-  diffMkspan
  targ[["Winner"]] <- diffMkspan
  
  
  
  return(targ)
})

