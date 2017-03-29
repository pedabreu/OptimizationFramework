setConstructorS3("AggregationFeaturedElement",function()
{
  extend(FeaturedElement(),"AggregationFeaturedElement")
})



setMethodS3("getAllDataset","AggregationFeaturedElement", function(this,
                                                        con,
                                                        aggregationField,
                                                        
                                                        ...) {

  
})



setMethodS3("addTargetsInDB","AggregationFeaturedElement", function(this,
                                                         con,
                                                         deleteExistsTarget = FALSE,
                                                       ...) {
  

  table <- this$getObjectTableName()
   
  query <- paste("SELECT uniqueID FROM ",table, " LIMIT 1")
  
  querysolution <- dbGetQuery(con,query)
 
  
  this$targets <- list()
  
  this$DBgetByObjectUniqueID(querysolution[1,"uniqueID"],con) 
 
   this$calculateTargets(con)   
 
  query5 <- paste("SHOW COlUMNS FROM ",this$getObjectTableName())
  
  sol5<- dbGetQuery(con,query5)
  
    for(targ in names(this$targets))
    {
      value <- this$targets[[targ]]
      
      type <- class(value)[1]
      
      if(type == "character")
      {
        type <- "Classification"
      }
      else
      {
        type <- "Regression"
      }
      
      DBobj1<-DBTargets()
      
      DBobj1$attributes<-list(name = targ,
                               type = type,
                               object = this$getObjectClassName())
      
      if(!DBobj1$existsByAttributes(con))
      {
        DBobj1$save(con)        
      }  
      
      
      if(all(sol5[,"Field"] != targ))
      {        
        dbGetQuery(con,paste("ALTER TABLE `JSS`.`",this$getObjectTableName(),"` ADD COLUMN `",targ,"` VARCHAR(20) NULL",sep=""))             
      }  
      
    }
    
    
  
  
  
})

setMethodS3("cleanValuesFeaturesInDB","AggregationFeaturedElement", function(this,
                                                          con,
                                                          groups,
                                                          ...) {
  

  table <- this$getObjectTableName()
  
  query <- paste("SELECT uniqueID FROM ",table, " LIMIT 1")
  
  querysolution <- dbGetQuery(con,query)
  
  
  
  this$DBgetByObjectUniqueID(querysolution[1,"uniqueID"],con) 
  
  for(group in groups)
  {
    
    
    this$features <- list()
    this$calculateFeatures(con,groups = group)   
    
    for(feat in names(this$features))
    {
      
    
        query5 <- paste("SHOW COlUMNS FROM ",this$getObjectTableName())
        
        sol5<- dbGetQuery(con,query5)
        
        if(any(sol5[,"Field"]== feat))
        {
          
          
          queryDeleteValues <- paste("UPDATE ",this$getObjectTableName()," SET `",feat,"` = NULL",sep="")
          dbGetQuery(con,queryDeleteValues)
        }
          
      
    }
  }
  
  
  
  
  
  
  
})


setMethodS3("deleteFeaturesInDB","AggregationFeaturedElement", function(this,
                                                                  con,
                                                                  groups,
                                                                  ...) {
  
    
  for(group in groups)
  {
    
    featObj <- DBFeatures()
    
    featObj$attributes <- list("FeaturesGroups_name" = group,
                             "FeaturesGroups_object" = this$getObjectClassName())
    
    allfeat <- featObj$getAllByAttributes(con)
    
    query5 <- paste("DROP TABLE ",this$getFeaturesTableName(group))
    
    sol5<- dbGetQuery(con,query5)
    
    for(feat in allfeat)
    {
      
      name <- feat$attributes[["name"]]
    
      
      feat$deleteByAttributes(con)
    

      
      }
    featGroupObj <- DBFeaturesGroups()
    
    featGroupObj$attributes <- list("name" = group,
                                     "object" = this$getObjectClassName())
    
    featGroupObj$deleteByAttributes(con)
    
    
    
  }
  
  
  
  
  
  
  
})



setMethodS3("addFeaturesInDB","AggregationFeaturedElement", function(this,
                                                                     con,
                                                                     group,
                                                                     dependentGroup,
                                                                     dependentObject,
                                                                     ...) {
  
  
  table <- this$getObjectTableName()

  
  query <- paste("SELECT uniqueID FROM ",table, " LIMIT 1")
  
  querysolution <- dbGetQuery(con,query)
  
 
  

  this$DBgetByObjectUniqueID(querysolution[1,"uniqueID"],con) 
   
  for(group in groups)
  {

    DBobjGroup<-DBFeaturesGroups()
    
    DBobjGroup$attributes <- list(name = group,
                                   object = this$getObjectClassName())
    

    if(!DBobjGroup$existsByAttributes(con))
    {
      DBobjGroup$save(con)  
          
    }
    
    tableFeat <- this$getFeaturesTableName(group)
  
    print("Creating group table...")
    queryCreateTable <- paste("CREATE TABLE ",tableFeat," (SELECT uniqueID AS object_uniqueID,'None' AS status FROM ",table,")",sep="")
    dbSendQuery(con,queryCreateTable)
    
    dbSendQuery(con,paste("ALTER TABLE `",tableFeat,"` CHANGE COLUMN `status` `status` VARCHAR(15) CHARACTER SET 'latin1' NOT NULL DEFAULT ''",sep=""))
    dbSendQuery(con,paste("ALTER TABLE `",tableFeat,"` ADD PRIMARY KEY (`object_uniqueID`)",sep=""))
    
    this$features <- list()
    this$calculateFeatures(con,groups = group)   
   
    for(feat in names(this$features))
    {
      value <- this$features[[feat]]
      
      type <- class(value)[1]
      
      if(!is.numeric(value))
      {
        type <- "factor"
      }
      
      DBobj1<-DBFeatures()
      

      DBobj1$attributes<-list(name = feat,
                               FeaturesGroups_name = group,
                               FeaturesGroups_object = this$getObjectClassName())
      
      ##DBobj1$deleteByAttributes(con)
      todeletepreviousvalues <- FALSE        
      tosave <- TRUE
     
      if(DBobj1$existsByAttributes(con))     
        {
     
          print(paste("Attention: The feature ",feat,"  allready exists."))
          tosave <- FALSE
        
        }
      else
      {
        DBobj1$attributes<-list(name = feat,
                                 type = type,
                                 FeaturesGroups_name = group,
                                 FeaturesGroups_object = this$getObjectClassName())
        
        DBobj1$save(con)        
        
      }
      
      
      
      if(tosave)
      {
        
        
    
             
                query5 <- paste("SHOW COlUMNS FROM ",tableFeat)
                
                sol5<- dbGetQuery(con,query5)
                
                if(any(sol5[,"Field"]== feat))
                {
                  queryDeleteValues <- paste("UPDATE ",tableFeat," SET ",feat,"= NULL")
                  
                  dbGetQuery(con,queryDeleteValues)
                }
                else
                {
                  typeVar <- "VARCHAR(20)"
                  
                  if(is.numeric(value))
                  {
                    typeVar <- "DOUBLE"
                  }
                  print("Creating features field...")
                  dbGetQuery(con,paste("ALTER TABLE `",tableFeat,"` ADD COLUMN `",feat,"` ",typeVar," NULL",sep=""))
                  
                  
                }
        
      }

      
      
      
    }

    
    
  }
  
  exp <- ExperimentFramework()
  exp$generateModels(file="./lib/MySQLInterface/DBModel.R")
 

  
})

setMethodS3("calculateTargets","AggregationFeaturedElement", function(this,
                                                            con = NULL,                                                            
                                                            ...) {
  
  targ <- this$targets(con)
  this$targets <- targ
  
  
})

setMethodS3("calculateFeatures","AggregationFeaturedElement", function(this,
                                                            con = NULL,
                                                            groups = NULL,

                                                            ...) {


  obj <- this$object
  allfeatures <- NULL  
  
  if(length(groups) == 0)
  {    
    DBobj1<-DBFeatures()

    DBobj1$attributes[["object"]] <- this$getObjectClassName()
 
    allObjs <- DBobj1$getAllByAttributes(con)
    
    for(i in 1:length(allObjs))
    {

      objFeature <- allObjs[[i]]
 
      allfeatures<- c(allfeatures,
                      objFeature$attributes[["group"]])
      
    }   
    
  }
  else
  {    
    allfeatures <- groups    
  }
 
  for(group in allfeatures)
  {
  
    
    values <- as.list(eval(call(paste("features",group,sep=""),this)))

    
    for(feat in names(values))
    {
      this$features[[feat]] <-  values[[feat]]  
    }  
  }

})


setMethodS3("DBsaveTargets","AggregationFeaturedElement", function(this,                                                
                                                         con=NULL,
                                                         ...) {
  
  obj <- this$object

  ## save features
  objString <- paste("DB",this$getObjectTableName(),sep="") 
  
  DBobj2 <- eval(call(objString))
  
  
  attrib <- list(uniqueID = obj$uniqueID)
  
  attrib <- c(attrib,
              this$targets)
  
  DBobj2$attributes <- attrib
  DBobj2$save(con)        
  ##}   
  
  })


setMethodS3("DBsaveFeatures","AggregationFeaturedElement", function(this,                                                
                                                         con,
                                                         ...) {
  
  obj <- this$object
  
  feats <- this$features

  groups <- this$getGroupsFromFeatures(con,names(this$features))

  
  ## save features
  
  for(group in groups)
  {
    featNames <- this$getFeaturesFromGroup(con,group)
    objString <- paste("DB",  this$getFeaturesTableName(group),sep="") 
    
    DBobj2 <- eval(call(objString))
    
    
    attrib <- list(object_uniqueID = obj$uniqueID,status="Done")
    
    attrib <- c(attrib,
                feats[featNames])
    
    DBobj2$attributes <- attrib
    
    DBobj2$save(con)      
    
  }
  
  
  ##}   
  
})

