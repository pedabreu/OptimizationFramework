setConstructorS3("GifflerThompson",function(evaluation = "ProcessingTime",
                                                 selection = "min")                 
           {
        
      alg <- AlgorithmParameterized()
      alg$algorithmName <- "GifflerThompson"
      
      alg$parameters <- list(   
        evaluation = evaluation,
        selection = selection)
      
      
         extend(alg,"GifflerThompson")

         })


setMethodS3("run","GifflerThompson", function(this,instance,...) {

  param <- this$parameters 
  heuristic <- Rule()
  heuristic$operationEvaluationFunction <- param[["evaluation"]] 
  heuristic$selectionFunction <- param[["selection"]] 

  sched <- heuristic$generateSchedule(instance)
  search <- Search()
  search$schedule <- sched
    
  return(search)
})
# 
# setMethodS3("DBsave","GifflerThompson", function(this,con= NULL,...) {
#   
# 
#   DBobj<-DBAlgorithmParameterized()
# 
#   DBobj$attributes<- list(uniqueID = this$uniqueID,                 
#                            Algorithm_name = this$name)
#   DBobj$save(con) 
# 
#   param <- this$parameters 
#   
#   DBobjGTHeu<-DBGTHeuristicParameters()
#   DBobjGTHeu$attributes<- list(AlgorithmParameterized_uniqueID = this$uniqueID,
#                                 selection = param[["selection"]] ,                     
#                                 evaluation = param[["evaluation"]] )
#   DBobjGTHeu$save(con)   
# 
#   })
# 
# setMethodS3("DBgetByUniqueID","GifflerThompson", function(this,uniqueID=NULL,con=NULL,...) {
#   
#   this$uniqueID <- uniqueID
#   DBobj<-DBAlgorithmParameterized()
#   DBobj$attributes[["uniqueID"]]<-uniqueID
#   DBobj$getByAttributes(con) 
#   
#   DBobjAlg<-DBAlgorithm()
#   DBobjAlg$attributes[["name"]] <- this$name
#   DBobjAlg$getByAttributes(con) 
#   
#   
#   
#   attribObjAlg<-DBobjAlg$attributes
#   
#   this$type <- attribObjAlg[["type"]]
#   
#   
#   DBobjGTHeu<-DBGTHeuristicParameters()
#   DBobjGTHeu$attributes[["AlgorithmParameterized_uniqueID"]]<- uniqueID
#   DBobjGTHeu$getByAttributes(con)
#   
#   attribGTHeu<-DBobjGTHeu$attributes
# 
#   param <- list("evaluation" =  attribGTHeu[["evaluation"]],
#                 "selection" = attribGTHeu[["selection"]])
#   
#   this$parameters <- param
#   
#  ## this$operationEvaluationFunction <- DBobjGTHeu[["selection"]]
#  ## this$selectionFunction <- DBobjGTHeu[["evaluation"]]
# 
#   
# })
