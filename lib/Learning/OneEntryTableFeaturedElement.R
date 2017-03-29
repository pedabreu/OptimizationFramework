setConstructorS3("OneEntryTableFeaturedElement",function()
{
  extend(FeaturedElement(),"OneEntryTableFeaturedElement")
})

setMethodS3("getAllDataset","OneEntryTableFeaturedElement", function(this,
                                                        con = NULL,
                                                        features = NULL,
                                                        uniqueIDs = NULL,
                                                        limit = NULL,
                                                        nrRowsPerQuery = 1000,
                                                        ...) {
  
  table <- this$getObjectTableName()
  featTable <- this$getObjectTableName()
  
  
  querylimit <- ""

  
  allColumns <- features
  a <- paste(allColumns,"IS NOT NULL")
  
  dataset <- data.frame()
  
  nrColumnsPerQuery <- 10
  
  
  
  offset <- 0
  
  missingRows <- TRUE
  
  while(missingRows)
  {
    print("Getting dataset.....")
    query <- paste("SELECT uniqueID,",paste(allColumns,collapse=",")," FROM ",featTable," WHERE  uniqueID IN ('",paste(uniqueIDs,collapse="','"),"') AND ",paste(a,collapse=" AND ")," LIMIT ",nrRowsPerQuery," OFFSET ",offset,sep="")
    
    
    querysolution <- dbGetQuery(con,query)
    
    if(nrow(querysolution) < nrRowsPerQuery | nrow(dataset) >= limit)
    {
      missingRows <- FALSE
    }
    offset <- offset + nrRowsPerQuery  
    
    newDataset <-  as.data.frame(querysolution)
    
    dataset <- rbind(dataset,
                     newDataset)
    
  }
  
  queryFeat <- paste("SELECT * FROM Features WHERE name IN ('",paste(allFeatures,collapse="','"),"')",sep="" ) 
  
  queryFeatsolution <- dbGetQuery(con,queryFeat)
  
  for(feat in 1:nrow(queryFeatsolution))
  {
    name <- queryFeatsolution[feat,"name"]
    
    dataset[,name] <-eval(call(paste("as.",queryFeatsolution[feat,"type"],sep=""),dataset[,name]))
    ##dataset[,name] <- as( queryFeatsolution[feat,"type"], dataset[,name])
  }
  
  return(dataset) 
  
})


setMethodS3("cleanValuesFeaturesInDB","OneEntryTableFeaturedElement", function(this,
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


setMethodS3("deleteFeaturesInDB","OneEntryTableFeaturedElement", function(this,
                                                                  con,
                                                                  groups,
                                                                  ...) {
  
    
  for(group in groups)
  {
    
    featObj <- DBFeatures()
    
    featObj$attributes <- list("FeaturesGroups_name" = group,
                             "FeaturesGroups_object" = this$getObjectClassName())
    
    allfeat <- featObj$getAllByAttributes(con)
    
    query5 <- paste("SHOW COlUMNS FROM ",this$getObjectTableName())
    
    sol5<- dbGetQuery(con,query5)
    
    for(feat in allfeat)
    {
      
      name <- feat$attributes[["name"]]
      
      
      if(any(sol5[,"Field"]== name))
      {
        
        
        queryDeleteValues <- paste("ALTER TABLE ",this$getObjectTableName()," DROP `",name,"`",sep="")
        dbGetQuery(con,queryDeleteValues)
      }
      
      feat$deleteByAttributes(con)
    
      featGroupObj <- DBFeaturesGroups()
      
      featGroupObj$attributes <- list("name" = group,
                                       "object" = this$getObjectClassName())
      
      featGroupObj$deleteByAttributes(con)
      
      
      }
  }
  
  
  
  
  
  
  
})



setMethodS3("addFeaturesInDB","OneEntryTableFeaturedElement", function(this,
                                                      con,
                                                      groups,
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
    
    
    
    
    this$features <- list()
    this$calculateFeatures(con,groups = group)   
   
    for(feat in names(this$features))
    {
      value <- this$features[[feat]]
      
      type <- class(value)[1]
      
      if(type == "character")
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
        query5 <- paste("SHOW COlUMNS FROM ",this$getObjectTableName())
        
        sol5<- dbGetQuery(con,query5)
        
        if(any(sol5[,"Field"]== feat))
        {
          queryDeleteValues <- paste("UPDATE ",this$getObjectTableName()," SET ",feat,"= NULL")
          
          dbGetQuery(con,queryDeleteValues)
        }
        else
        {
         
          dbGetQuery(con,paste("ALTER TABLE `",this$getObjectTableName(),"` ADD COLUMN `",feat,"` VARCHAR(20) NULL",sep=""))
          
          
        }
        
      }
   
      
      
      
    }
  }

  
})

setMethodS3("calculateTargets","FeaturedElement", function(this,
                                                            con = NULL,                                                            
                                                            ...) {
  
  targ <- this$targets(con)
  this$targets <- targ
  
  
})

setMethodS3("calculateFeatures","OneEntryTableFeaturedElement", function(this,
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




setMethodS3("DBsaveFeatures","OneEntryTableFeaturedElement", function(this,                                                
                                                         con=NULL,
                                                         ...) {
  
  obj <- this$object
  
  ## save features
  objString <- paste("DB",this$getObjectTableName(),sep="") 
  
  DBobj2 <- eval(call(objString))
  
  
  attrib <- list(uniqueID = obj$uniqueID)
  
  attrib <- c(attrib,
              this$features)

  DBobj2$attributes <- attrib


  DBobj2$save(con)        
  ##}   
  
})

setMethodS3("DBgetByObjectUniqueID","OneEntryTableFeaturedElement", function(this,
                                                                uniqueID = NULL,
                                                                con=NULL,...) {
  

  obj <-this$object
  


  obj$DBgetByUniqueID(uniqueID,con)

  this$object <- obj
 
  ##get features values
  objclass <- this$getObjectTableName()

  objString <- paste("DB",objclass,sep="") 


  DBobj<- eval(call(objString))
  
  if(!is.null(uniqueID))
  {
    DBobj$attributes[["uniqueID"]] <- uniqueID   
  }
  
 
  DBobj$getByAttributes(con) 
    
  attrib <- DBobj$attributes
   uniqueID <- DBobj$attributes[["uniqueID"]]  

  this$features <- attrib[which(names(attrib) != "uniqueID")]

 
  ##get targets values
  targets <- list()

  objclass <- this$getObjectTableName()
  
  objString <- paste("DB",objclass,sep="") 
  
  
  DBobj<- eval(call(objString))

  DBobj$attributes[["uniqueID"]] <- uniqueID
  DBobj$getByAttributes(con) 
  
  attrib <- DBobj$attributes
  
  
  this$targets <- attrib[which(names(attrib) != "uniqueID")]
  
  
})

