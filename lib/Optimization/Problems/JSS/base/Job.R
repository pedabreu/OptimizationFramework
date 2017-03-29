
setConstructorS3("Job",function()
{
  extend(ExperimentFrameworkObject(),"Job",
         instance = NULL,
         job = NA)
  
}
)



setMethodS3("DBsave","Job", function(this,con=NULL,...) {
  
  DBobj<-DBJob()
  
  
  inst <- this$instance
  
  DBobj$attributes<-list("uniqueID" = this$uniqueID,
                          "Instance_uniqueID" = inst$uniqueID,
                          "job" = this$job)
  
  DBobj$save(con)
  
})


setMethodS3("DBgetByUniqueID","Job", function(this,uniqueID = NULL,con=NULL,...) {
  
  # sourceDirectory(paste("./lib/MySQLInterface/",sep=""))
  DBobj<-DBJob()
  
  if(!is.null(uniqueID))
  {
    DBobj$attributes[["uniqueID"]] <- uniqueID   
  }
  
    
  DBobj$getByAttributes(con)
  
  
  attrib <- DBobj$attributes
  
  uniqueID <- attrib[["uniqueID"]] 
  
  this$uniqueID <- uniqueID   
  this$job <- attrib[["job"]]
                          
  inst <- Instance()
  inst$DBgetByUniqueID(attrib[["Instance_uniqueID"]],con)

    
  this$instance <- inst
  
})


