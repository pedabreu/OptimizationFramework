setConstructorS3("MachineFeaturesLearning",function()
{
  
  learningObj <- LearningExperiment()
  
  obj <- MachineFeaturedElement()
  
  
  learningObj$featureElement <- obj
  
  extend(learningObj,"MachineFeaturesLearning")
  
})
         

setMethodS3("populateDBMachinesFeatures","MachineFeaturesLearning", 
            function(this,
                     nrJobs = 5,
                     nrMachines = 5,
                     tableName = "Machine",
                     
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
    
    #for(j in 1:nrJobs)
    #{
    for(m in 1:nrMachines)
    {
      newobj <- eval(call(objClass))
      newobj$instance <- inst
      #     newobj$job <- j
      newobj$machine <- m
      newobj$DBsave(con)      
    }
    #}
    
    
  }
  
  
  
})
                                                                                                      
