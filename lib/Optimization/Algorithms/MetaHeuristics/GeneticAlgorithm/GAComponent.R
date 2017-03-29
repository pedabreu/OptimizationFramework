setConstructorS3("GAComponent",function()
           {
             extend(Object(),"GAComponent",
                    probability = 0.5,
                    chromossomeClass = NULL)
  
           })




setMethodS3("DBsave","GAComponent", function(this,con=NULL,...) {
  
  DBobj<-DBAlgorithmParameterized()
  DBobj$attributes<- list(uniqueID = this$uniqueID,                 
                           Algorithm_name = this$name)
  DBobj$save(con) 
  
  allparameters <- this$parameters
  
  for(i in name(allparameters))
  {
    
    DBobjOp<-DBAlgorithmParameterizedHasAlgorithmParameter()
    
    DBobjOp$attributes<- list(AlgorithmParameterized_uniqueID = this$uniqueID, 
                               AlgorithmParameter_name = i, 
                               valor = allparameters[[i]])
    
    
    DBobjOp$save(con)
  }
  
})

setMethodS3("DBgetByUniqueID","GAComponent", function(this,uniqueID=NULL,con=NULL,...) {
  
  DBobj<-DBAlgorithmParameterized()
  DBobj$attributes[["uniqueID"]]<-uniqueID
  DBobj$getByAttributes(con) 
  
  
  
  attribObj<-DBobj$attributes
  
  this$name <- attribObj[["Algorithm_name"]]
  
  
  DBobjAlg<-DBAlgorithm()
  DBobjAlg$attributes[["name"]] <- this$name
  DBobjAlg$getByAttributes(con) 
  
  
  
  attribObjAlg<-DBobjAlg$attributes
  
  this$type <- attribObjAlg[["type"]]
  
  
  
  
  
  DBobjOp<-DBAlgorithmParameterizedHasAlgorithmParameter()
  
  DBobjOp$attributes[["AlgorithmParameterized_uniqueID"]] <- uniqueID
  
  allDBOp <- DBobjOp$getAllByAttributes(con)  
  
  for(i in 1:length(allDBOp))
  {
    allDBOpInd<- allDBOp[[i]]
    
    parameterName <- allDBOpInd[["AlgorithmParameter_name"]]
    parameterValor <- allDBOpInd[["valor"]]
    
    this$parameters[[parameterName]] <- parameterValor
  }
  
})
