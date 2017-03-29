setConstructorS3("ExperimentFrameworkObject",function()
{
  extend(Object(),"ExperimentFrameworkObject",         
         mainTable = NULL,
         mainDBObject = NULL,
         pks = list("uniqueID" = NULL))
  
}
)

setMethodS3("getPKFields","ExperimentFrameworkObject", function(this,con,...) {
  
  sol <- dbGetQuery(con,paste("SHOW KEYS FROM ",this$mainTable," WHERE Key_name = 'PRIMARY'",sep=""))
  
  return(sol[,"Column_name"])
  
})

setMethodS3("getMainTable","ExperimentFrameworkObject", function(this,...) {
  
  mainTable <- this$mainTable 
  
  if(is.null(this$mainTable))
  {
    mainTable <- class(this)[1]
  }
  
  return(mainTable)
})





setMethodS3("getDBMainObject","ExperimentFrameworkObject", function(this,
                                                                    values = this$pks,
                                                                    restrictions = NULL,
                                                                    con = NULL,
                                                                    ...) {
  

  DBobj <- eval(call(paste("DB",this$getMainTable(),sep="")))
  
 

  
  if(!is.null(con))
  {    

    if(!any(unlist(lapply(values,is.null))))
    {
      pks <- values[unlist(DBobj$primaryKeys)]
      DBobj$attributes <- pks
    }
    else
    {
      if(!is.null(restrictions))
      {
        DBobj$attributes <- restrictions        
      }
    }  

    DBobj$getByAttributes(con) 
    this$pks <- DBobj$attributes[unlist(DBobj$primaryKeys)]
      
  }

  this$mainDBObject <- DBobj
  
  return(DBobj)          
  
})


setMethodS3("constructObjectFromDBMainObject",
            "ExperimentFrameworkObject", function(this,
                                                  con = NULL,
                                                  ...) {
              
  
              
              
  
})


setMethodS3("uniqueFieldTarget",
            "ExperimentFrameworkObject", function(this,
                                                  con = NULL,
                                                  ...) {
              
              
        
              paste(this$pks,collapse="_")
              
              
              
            })



setMethodS3("DBgetByUniqueID","ExperimentFrameworkObject", function(this,
                                                   pks,
                                                   con,...) {
  
 # print("Get main object")

  this$getDBMainObject(values=pks,con=con)
#  print("Construct Object")
  this$constructObjectFromDBMainObject(con)  

  
})


