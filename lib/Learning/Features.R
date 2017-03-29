setConstructorS3("Features",function(objectType = NULL,
                                     featuresNames = NULL)

{
  extend(Object(),"Features",
         allFeaturesByGroup = list(),
         allFeatures = NULL,
         groups = groups,
         moreFeatures = moreFeatures,
         exceptions = exceptions)
})


setMethodS3("addFeaturesFromGroups","Features", function(this,
                                                         con = NULL,
                                                         objectType = NULL,
                                                         ...)
{
  feats <- this$allFeaturesByGroup
  
  if(is.null(this$allFeaturesByGroup))
  {
    for(group in this$groups)
    {
      groupsFeatures <- this$getFeaturesFromGroups(con,objectType,groups=c(group))
      
      feats <- setdiff(c(groupsFeatures,this$moreFeatures),this$exceptions)
      this$allFeaturesByGroup[[group]] <- feats
      this$allFeatures <- c(this$allFeatures,feats)
    }
  }
  
  return(feats)
  
})

setMethodS3("setFeaturesFromGroups","Features", function(this,
                                                          con = NULL,
                                                          objectType = NULL,
                                                          ...)
{
  feats <- this$allFeaturesByGroup
  
  if(is.null(this$allFeaturesByGroup))
  {
    for(group in this$groups)
    {
      groupsFeatures <- this$getFeaturesFromGroups(con,objectType,groups=c(group))
      
      feats <- setdiff(c(groupsFeatures,this$moreFeatures),this$exceptions)
      this$allFeaturesByGroup[[group]] <- feats
      this$allFeatures <- c(this$allFeatures,feats)
    }
  }
  
  return(feats)
  
})

setMethodS3("getFeaturesUsedByGroup","Features", function(this,
                                                   con = NULL,
                                                   objectType = NULL,
                                                   ...)
{
  feats <- this$allFeaturesByGroup
  
  if(is.null(this$allFeaturesByGroup))
  {
    for(group in this$groups)
    {
    groupsFeatures <- this$getFeaturesFromGroups(con,objectType,groups=c(group))
    
    feats <- setdiff(c(groupsFeatures,this$moreFeatures),this$exceptions)
    this$allFeaturesByGroup[[group]] <- feats
    this$allFeatures <- c(this$allFeatures,feats)
    }
    }
  
  return(feats)
  
})

setMethodS3("getFeaturesUsed","Features", function(this,
                                                   con = NULL,
                                                   objectType = NULL,
                                                   ...)
{
  feats <- this$allFeatures
  
  if(is.null(this$allFeatures))
  {
  groupsFeatures <- this$getFeaturesFromGroups(con,objectType)
  
  feats <- setdiff(c(groupsFeatures,this$moreFeatures),this$exceptions)
  this$allFeatures <- feats
  }
  
  return(feats)
  
})


setMethodS3("getFeaturesFromGroups","Features", function(this,
                                                         con = NULL,
                                                         groups = NULL,
                                                         objectType = NULL,
                                                                   ...) {
  
  if(is.null(groups))
  {
  groups <- this$groups
  }
  featNames <- NULL
  
  if(!is.null(groups))
  {
    for(group in groups)
    {
      featDBObj <- DBFeatures()
      featDBObj$attributes <- list("group" = group,
                                    "object" = objectType)
      
      allFeatDBObj <- featDBObj$getAllByAttributes(con) 
      
      for(featObj in allFeatDBObj)
      {
        featNames <- c(featNames,
                       featObj$attributes[["name"]])        
        
      }
      
    }
    
  }
  else
  {
    featDBObj <- DBFeatures()
    featDBObj$attributes <- list("object" = objectType)
    
    allFeatDBObj <- featDBObj$getAllByAttributes(con) 
    
    for(featObj in allFeatDBObj)
    {
      featNames <- c(featNames,
                     featObj$attributes[["name"]])        
      
    }
    
  }
  
  
  return(featNames)
  
})