setConstructorS3("MetaHeuristicSearch",function()                 
{
  extend(Search(),"MetaHeuristicSearch",
         solution = NULL,
         nrIterations = 0,
         resolution = 1,
         lastInserted = 1,
         historicalFitnessInfo = data.frame())
})



setMethodS3("plotIterationFitness","MetaHeuristicSearch", function(this,...) {

  



  })
  

setMethodS3("sameDBObject","MetaHeuristicSearch", function(this,search,con=NULL,...) {
  
  thisSol <- this$solution
  
  searchSol <- search$solution
  
  sameSolution <-  sameDBObject(thisSol,searchSol,con)
  
  
  
  
  
  same <- all(this$nrIterations == search$nrIterations) &
    this$resolution == search$resolution &
    all(this$historicalFitnessInfo == search$historicalFitnessInfo) &
    sameSolution
  
  
  return(same)
})


setMethodS3("finalInformation","MetaHeuristicSearch", function(this,population,...) {
  this$nrIterations <- population$generation
  
})


setMethodS3("addIterationInformation","MetaHeuristicSearch", function(this,population,...) {
  
 
  
  if(this$lastInserted%%this$resolution == 0)
  {
    values <- population$parentFitness()
    summary_values <- summary(values)
    
    avgFitness <- mean(values) 
    medianFitness <- median(values) 
    minFitness <- min(values)
    maxFitness <- max(values)
    nrSolutionPerIteration <- length(values)
    firstQuartilFitness <- quantile(values,0.25)
    thirdQuartilFitness <- quantile(values,0.75)

    info_values <- data.frame(
      avgFitness = mean(values), 
      medianFitness = medianFitness, 
      minFitness = minFitness, 
      maxFitness = maxFitness, 
      iteration =  population$generation,
      nrSolutionPerIteration = length(values),
      firstQuartilFitness = firstQuartilFitness, 
      thirdQuartilFitness = thirdQuartilFitness)
    
    
    if(nrow(this$historicalFitnessInfo) > 0)
    {
     
      if(this$historicalFitnessInfo[this$lastInserted,"avgFitness"] != avgFitness |
           this$historicalFitnessInfo[this$lastInserted,"medianFitness"] != medianFitness|
           this$historicalFitnessInfo[this$lastInserted,"minFitness"] != minFitness|
           this$historicalFitnessInfo[this$lastInserted,"maxFitness"] != maxFitness|
           this$historicalFitnessInfo[this$lastInserted,"nrSolutionPerIteration"] != nrSolutionPerIteration|
           this$historicalFitnessInfo[this$lastInserted,"firstQuartilFitness"] != firstQuartilFitness|
           this$historicalFitnessInfo[this$lastInserted,"thirdQuartilFitness"] != thirdQuartilFitness)
      {
        
        
        this$historicalFitnessInfo <- rbind(this$historicalFitnessInfo,
                                            info_values)
        
        this$lastInserted <- this$lastInserted + 1
      }
    }
    else
    {
    
      this$historicalFitnessInfo <- info_values
    }
  }
})

setMethodS3("DBgetByRunUniqueID","MetaHeuristicSearch", function(this,
                                                                 rununiqueID=NULL,
                                                                 con=NULL,...) {
  

  dbmetaheuristicrun <- DBMetaheuristicRun()
  dbmetaheuristicrun$attributes[["Run_uniqueID"]] <- rununiqueID
 
  dbmetaheuristicrun$getByAttributes(con)
  
  solUniqueID <- dbmetaheuristicrun$attributes[["Solution_uniqueID"]]
 
  
  sol <- this$solution
  
  DBgetByUniqueID(sol,solUniqueID,con)
  
  this$solution <- sol
  
  this$nrIterations <- dbmetaheuristicrun$attributes[["nrIterations"]]
  this$resolution <- dbmetaheuristicrun$attributes[["resolution"]]
  
  dbiterationStats <- DBIterationStatistics()
  dbiterationStats$attributes[["Run_uniqueID"]] <- rununiqueID  
 
  
  allDBOp <- dbiterationStats$getAllByAttributes(con)   
  
  for(i in 1:length(allDBOp))
  {
    currentDBOp <- allDBOp[[i]]
    
    attribCurrentDBOp <- currentDBOp$attributes
  
  newdf <- data.frame(avgFitness = attribCurrentDBOp[["avgFitness"]],
                      medianFitness = attribCurrentDBOp[["medianFitness"]],
                      minFitness = attribCurrentDBOp[["minFitness"]],
                      maxFitness = attribCurrentDBOp[["maxFitness"]], 
                      iteration = attribCurrentDBOp[["iteration"]], 
                      nrSolutionPerIteration = attribCurrentDBOp[["nrSolutionPerIteration"]],
                      firstQuartilFitness = attribCurrentDBOp[["firstQuartilFitness"]], 
                      thirdQuartilFitness = attribCurrentDBOp[["thirdQuartilFitness"]])
  
  
    this$historicalFitnessInfo <- rbind(this$historicalFitnessInfo,
                                         newdf)
    
    
    }
  
  
  
  
  
  
})


setMethodS3("DBsave","MetaHeuristicSearch", function(this,con,...) {
  

  sol <- this$solution

  DBsave(sol,con)
  
  DBobjMetaRun<-DBMetaheuristicRun()
  DBobjMetaRun$attributes<- list(Run_uniqueID = this$run,                 
                                 Solution_uniqueID = sol$uniqueID,
                                 nrIterations = this$nrIterations,
                                 resolution = this$resolution)
  DBobjMetaRun$save(con) 
  
  
  historical <- this$historicalFitnessInfo
  historical$Run_uniqueID <- this$run
  
  dbWriteTable(con,
               "IterationStatistics",
               value = historical,
               row.names = FALSE,
               append = TRUE)
  
  
#   d <- dim(historical)
#   
#   for(i in 1:d[1])
#   {
#     dados <- historical[i,]
#     DBobjIteration <- DBIterationStatistics()
#     
#     DBobjIteration$attributes<- list( avgFitness = dados["avgFitness"],
#                                        medianFitness = dados["medianFitness"],
#                                        minFitness = dados["minFitness"],
#                                        maxFitness = dados["maxFitness"], 
#                                        iteration = dados["iteration"], 
#                                        nrSolutionPerIteration = dados["nrSolutionPerIteration"],
#                                        firstQuartilFitness = dados["firstQuartilFitness"], 
#                                        thirdQuartilFitness = dados["thirdQuartilFitness"],
#                                        Run_uniqueID =this$run)
#     DBobjIteration$save(con) 
#   }
  
  
  
  
})
