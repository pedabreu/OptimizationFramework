setConstructorS3("Model",function(type = NULL,
                                  name = NULL,
                                  predictionParameters = list(),
                                  parameters = list())
{
  extend(Object(),"Model",
         type = type,
         name = name,
         uniqueID = paste(format(Sys.time(), "%y%m%d%H%M%S"),paste(sample(c(0:9, letters, LETTERS))[1:4],collapse=""),sep=""),         
         modelObject = NULL,
         learningType = "Regression",
         predictionParameters = predictionParameters ,
         parameters = parameters)
})


setMethodS3("getName","Model", function(this,...)
{
  name <- this$name
  
  if(is.null(name))
  {
    name <- paste(this$type,sep="") 
  }
  
  return(name)  
})


setMethodS3("generateModelObject","Model", function(this,
                                                    formula,
                                                    dataset,
                                                    ...)
{
  model <- eval(call(this$type,formula,dataset ,unlist(this$parameters)))
  this$modelObject <- model
  

})

setMethodS3("getPrediction","Model", function(this,
                                              dataset,
                                              ...)
{
  
  args <- list(this$modelObject,dataset)
  
  args <- c(args,this$predictionParameters)
  
  #browser()
  #predict(this$modelObject,dataset,type="class")
  pred <- eval(do.call("predict",args))
  
return(pred)
  
  
})