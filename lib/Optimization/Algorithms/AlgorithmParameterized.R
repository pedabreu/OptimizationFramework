library("R.oo")

setConstructorS3("AlgorithmParameterized",function()
{
  extend(Object(),"AlgorithmParameterized",
         uniqueID =  paste(format(Sys.time(), "%y%m%d%H%M%S"),paste(sample(c(0:9, letters, LETTERS))[1:4],collapse=""),sep=""),
         name = NULL,
         algorithmName = NULL,
         type = "heuristic",
         search = NULL,
         searchClass = "Search",
         parameters = list())

})


setMethodS3("setParameter","AlgorithmParameterized", function(this,parameter = NULL,value = NULL,...) {
  this$parameters[[parameter]] <- value 
})

setMethodS3("getParameter","AlgorithmParameterized", function(this,parameter = NULL,...) {  
  return(this$parameters[[parameter]])  
})


setMethodS3("prerun","AlgorithmParameterized", function(this,instance,...) {
  return(TRUE)
})
                 
setMethodS3("posrun","AlgorithmParameterized", function(this,instance,...) {   
  return(TRUE)
})                 
                 

setMethodS3("run","AlgorithmParameterized", function(this,instance,...) {
    search = Search()
  
     return(search)
})
                 
setMethodS3("DBsave","AlgorithmParameterized", function(this,con=NULL,...) {
                   

  DBobj<-DBAlgorithmParameterized()
  DBobj$attributes<- list(uniqueID = this$uniqueID, 
                           name = this$name,
                           Algorithm_name = this$algorithmName)
 
  DBobj$save(con) 
 
  allparameters <- this$parameters
  
  for(i in names(allparameters))
  {   
 
    if(is.object(allparameters[[i]])   )
    {
      obj <- allparameters[[i]]
      classe <- class(obj)[1]
      
      
      DBobjClasse<-DBAlgorithmParameterizedParameters()
      
      DBobjClasse$attributes<- list(AlgorithmParameterized_uniqueID = this$uniqueID,
                                     parameter = "<class_definition>",
                                     value = classe,
                                     attribute = i)
      
      
      DBobjClasse$save(con)
      
      
      parametersComponent <- getFields(obj)
      
      
      for(comp in parametersComponent)
      {
        
        valor <- obj[[paste(comp,sep="")]]
        
        DBobjComp<-DBAlgorithmParameterizedParameters()
        
        DBobjComp$attributes<- list(AlgorithmParameterized_uniqueID = this$uniqueID,
                                     parameter = comp,
                                     attribute = i,
                                     value = valor,
                                     type = class(valor))
        
        
        DBobjComp$save(con)
     
      }

    }
    else
      {
  
    DBobjOp<-DBAlgorithmParameterizedParameters()
    
    DBobjOp$attributes<- list(AlgorithmParameterized_uniqueID = this$uniqueID, 
                               attribute = i,
                               parameter = i, 
                               value = allparameters[[i]],
                               type = class(allparameters[[i]]))

    DBobjOp$save(con)
      }
 }
  
})
               
setMethodS3("DBgetByUniqueID","AlgorithmParameterized", function(this,uniqueID=NULL,con=NULL,...) {
  
  this$uniqueID <- uniqueID
  
  DBobj<-DBAlgorithmParameterized()
  DBobj$attributes[["uniqueID"]]<-uniqueID
  DBobj$getByAttributes(con) 
  
  
  
  attribObj<-DBobj$attributes
  
  this$name <- attribObj[["name"]]
  this$algorithmName <- attribObj[["Algorithm_name"]] 
  
  DBobjAlg<-DBAlgorithm()
  DBobjAlg$attributes[["name"]] <-  this$algorithmName
  DBobjAlg$getByAttributes(con) 
  
  
  
  attribObjAlg<-DBobjAlg$attributes
  
  this$type <- attribObjAlg[["type"]]
  
  DBobjOp<-DBAlgorithmParameterizedParameters()
  
  DBobjOp$attributes[["AlgorithmParameterized_uniqueID"]] <- uniqueID
 ## DBobjOp$attributes[["parameter"]] <- "<class_definition>"  
  
  
  allDBOp <- DBobjOp$getAllByAttributes(con)  
 
 
  
  attrib <- list()
  
  
  
  for(i in 1:length(allDBOp))
  {
    allDBOpInd<- allDBOp[[i]]
    
    allDBOpIndAttrib <- allDBOpInd$attributes
    
    parameterName <- allDBOpIndAttrib[["parameter"]]
    parameterValor <- allDBOpIndAttrib[["value"]]
    attribute <- allDBOpIndAttrib[["attribute"]] 
    type <- allDBOpIndAttrib[["type"]]     
    
    if(!is.na(type))
    {
      class(parameterValor) <- type
      
    }
    
    
    
    attrib[[attribute]][parameterName] <- parameterValor
  }

  for(j in names(attrib))
  {
    h <- attrib[[j]]
    
    if(is.na(h["<class_definition>"]))
    {
      for(r in names(h))
      {
        this$parameters[[r]] <- h[r]
        
        
      }
      
    }
    else
    {
      obj <- eval(parse(text=paste(h["<class_definition>"],"()",sep=""))  )
     
      
      for(y in names( h[-which(names(h) == "<class_definition>")]))
      {
        obj[[y]] <- h[y]
        
      }
      
      
      this$parameters[[j]] <- obj
    }
    
  }

   
#   componentsParameters <- list()
#   thisParameters <- list()
#   thisParametersComponents <- list()
#   
#   
#   for(i in 1:length(allDBOp))
#   {
#     allDBOpInd<- allDBOp[[i]]
#     
#     allDBOpIndAttrib <- allDBOpInd$attributes
#     
#     parameterName <- allDBOpIndAttrib[["parameter"]]
#     parameterValor <- allDBOpIndAttrib[["value"]]
#     component <- allDBOpIndAttrib[["component"]]    
# 
#     
#     if(is.na(component))
#     {
#          thisParameters[[parameterName]] <- parameterValor
#     }
#     else
#     {
#       if(!is.na(parameterValor)  && parameterValor == "component@parameterDefinition")
#       {
#         thisParametersComponents[[component]] <- parameterName
#       }
#       else
#       {
#        compParam <- list()
#        compParam[[parameterName]] <- parameterValor   
#         
#         componentsParameters[[component]] <- c(componentsParameters[[component]],
#                                                compParam)
#       }
#         
#       
#     }
#         
#   }
#   
#   
#   for(k in names(componentsParameters))
#   {
#     obj <- eval(parse(text=paste(k,"()",sep=""))  )
#     parametersObj <- componentsParameters[[k]]
#     
#     for(y in  names(parametersObj))
#     {
#       obj[[paste(y,sep="")]] <- parametersObj[[y]]
#       
#     }
#     thisParameters[[thisParametersComponents[[k]]]]<- obj
#     
#   }
#   
#   this$parameters <- thisParameters
  
  
  
})
                 
                 
                 