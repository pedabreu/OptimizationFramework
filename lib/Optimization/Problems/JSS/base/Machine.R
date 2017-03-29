
setConstructorS3("Machine",function()
{
  extend(ExperimentFrameworkObject(),"Machine",
         instance = NULL,
         machine = NA)
  
}
)



setMethodS3("DBsave","Machine", function(this,con=NULL,...) {
  
  DBobj<-DBMachine()
  
  
  inst <- this$instance
  
  DBobj$attributes<-list("uniqueID" = this$uniqueID,
                          "Instance_uniqueID" = inst$uniqueID,
                          "machine" = this$machine)
  
  DBobj$save(con)
  
})


setMethodS3("DBgetByUniqueID","Machine", function(this,uniqueID = NULL,con=NULL,...) {
  
  # sourceDirectory(paste("./lib/MySQLInterface/",sep=""))
  DBobj<-DBMachine()
  
  if(!is.null(uniqueID))
  {
    DBobj$attributes[["uniqueID"]] <- uniqueID   
  }
  
    
  DBobj$getByAttributes(con)
  
  
  attrib <- DBobj$attributes
  
  uniqueID <- attrib[["uniqueID"]] 
  
  this$uniqueID <- uniqueID   
  this$machine <- attrib[["machine"]]
                          
  inst <- Instance()
  inst$DBgetByUniqueID(attrib[["Instance_uniqueID"]],con)

    
  this$instance <- inst
  
})


