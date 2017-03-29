setConstructorS3("GroupFeatures",function()
{
  extend(Object(),"GroupFeatures",
         objectName = "",
         group = "",         
         featuresName = NULL,
         featuresType = NULL)
})


setMethodS3("getFeatures","GroupFeatures", function(this,
                                                    con,
                                                    ...) {
  

  allFeat <- this$featuresName
  
  if(length(allFeat) == 0)
  {
    featDBObj <- DBFeatures()
    featDBObj$attributes <- list("object" = this$objectName,
                                  "group" = this$group)
    
    allFeatObj <- featObj$getAllByAttributes(con)
    
    
    for(featObj in allFeatObj)
    {
      this$featuresName <- c(this$featuresName,
                              featObj$attributes[["name"]])
      
      this$featuresType <- c(this$featuresType,
                              featObj$attributes[["type"]])
      }
      
  }
    
  
 
  })
