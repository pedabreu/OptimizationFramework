setConstructorS3("FeaturedElement",function()
{
  extend(Object(),"FeaturedElement",
         object = NULL,
         featuresTableName = NULL,
         
         features = list(),
         targets = list())
})

setMethodS3("addTargetBasic","FeaturedElement", function(
  this,
  con,
  analyseConnection = NULL,
  nrJobs,
  nrMachines,
  parameterizedAlgorithmNames = c("SPT","LPT","MWR","MinEndTime") ,
  aggregation = FALSE,
  new = TRUE,
  ...)
{   
  
  prefix <-  paste("Instance_Targets_",algorithmName,"_",nrJobs,"x",nrMachines,sep="")
  solTables <-dbGetQuery(con,paste("SHOW TABLES LIKE '",prefix,"%'",sep=""))  
  
  if(new)
  {
    
    if(nrow(solTables)>0)
    {
      for(tableName in solTables[,1])
      {
        dbSendQuery(con,paste(" DROP TABLE IF EXISTS ",tableName,sep=""))
        print(paste("DELETE TABLE ",tableName," FROM DATABASE"))
      }
    }
    tableName <- paste(prefix,"_1",sep="")    
    query <- paste("SELECT R.Instance_uniqueID,AP.name,makespan FROM Instance I,Run R,AlgorithmParameterized AP,FeasibleSchedule FS  WHERE I.uniqueID=R.Instance_uniqueID AND FS.uniqueID=R.FeasibleSchedule_uniqueID AND R.AlgorithmParameterized_uniqueID=AP.uniqueID AND AP.name IN ('",paste(parameterizedAlgorithmNames,collapse="','"),"') AND I.nrJobs=",nrJobs," AND I.nrMachines=",nrMachines,sep="")
    
  }
  else
  {
    tableName <- paste(prefix,"_",length(solTables)+1,sep="")   
    
    query <- paste("SELECT R.Instance_uniqueID,AP.name,makespan FROM Instance I,Run R,AlgorithmParameterized AP,FeasibleSchedule FS  WHERE I.unqiueID=R.Instance_uniqueID AND FS.uniqueID=R.FeasibleSchedule_uniqueID AND R.AlgorithmParameterized_uniqueID=AP.uniqueID AND AP.name IN ('",paste(parameterizedAlgorithmNames,collapse="','"),"') AND I.nrJobs=",nrJobs," AND I.nrMachines=",nrMachines," AND ",paste(paste(" I.uniqueID NOT IN (SELECT Instance_uniqueID FROM ",solTables[,1],")",sep=""),collapse=" AND "),sep="")
                   
  }
  
  
  ##   dbSendQuery(con,paste(" DROP TABLE IF EXISTS ",tableName,sep=""))
  
  
  
  sol<-dbGetQuery(con,query)
  
  
  if(aggregation)
  {
    dataset <- aggregate.data.frame(sol,by=list("Instance_uniqueID"=sol[,"Instance_uniqueID"],,"name"=sol[,"name"]),
                                    function(x)(c(min(x),max(x),mean(x),var(x))))
    
  }
  
  
  dataf <- cast(sol,Instance_uniqueID~name,value="makespan",fun.aggregate="mean")
  
  any.value.missing <- apply(dataf[,parameterizedAlgorithmNames],1,function(x)any(is.na(x)))
  
  
  dataf <- dataf[!any.value.missing,]
  
  
  fieldtypes <- as.list(rep("DOUBLE",ncol(dataf)))
  names(fieldtypes) <- colnames(dataf)
  
  fieldtypes$Instance_uniqueID <- "VARCHAR(20)"
  
  dbWriteTable(analyseConnection,tableName,as.data.frame(dataf),row.names=FALSE,
               field.types= fieldtypes)
  
  dbSendQuery(analyseConnection,paste("ALTER TABLE `",tableName,"` ADD PRIMARY KEY (`Instance_uniqueID`)",sep=""))
  
})


setMethodS3("addFactMakespanTable","FeaturedElement", function(
  this,
  con,
  analyseConnection = NULL,
  nrJobs,
  nrMachines,
  parameterizedAlgorithmNames = c("SPT","LPT","MWR","MinEndTime") ,
  aggregation = FALSE,
  new= FALSE,  
  ...)
{   
  
  prefix <- "Fact_Makespan"
  solTables <-dbGetQuery(con,paste("SHOW TABLES LIKE '",prefix,"'",sep=""))  
  append <- FALSE  
  
  if(new)
  {    
    if(nrow(solTables)>0)
    {
      for(tableName in solTables[,1])
      {
        dbSendQuery(con,paste(" DROP TABLE IF EXISTS ",tableName,sep=""))
        print(paste("DELETE TABLE ",tableName," FROM DATABASE"))
      }
    }
    
    tableName <- paste(prefix,sep="")    
    query <- paste("SELECT R.Instance_uniqueID,AP.name,makespan FROM Instance I,Run R,AlgorithmParameterized AP,FeasibleSchedule FS  WHERE I.uniqueID=R.Instance_uniqueID AND FS.uniqueID=R.FeasibleSchedule_uniqueID AND R.AlgorithmParameterized_uniqueID=AP.uniqueID AND AP.name IN ('",paste(parameterizedAlgorithmNames,collapse="','"),"') AND I.nrJobs=",nrJobs," AND I.nrMachines=",nrMachines,sep="")
    
  }
  else
  {
    append <- TRUE
    

    print("ATTENTION: Input parameterizedAlgorithmNames ignore")
  
    parameterizedAlgorithmNamesSol <- dbGetQuery(analyzeConnection,"SHOW COLUMNS FROM Fact_Makespan")
    parameterizedAlgorithmNames <- parameterizedAlgorithmNamesSol[,"Field"]
    
    query <- paste("SELECT R.Instance_uniqueID,AP.name,makespan FROM Instance I,Run R,AlgorithmParameterized AP,FeasibleSchedule FS  WHERE I.uniqueID=R.Instance_uniqueID AND FS.uniqueID=R.FeasibleSchedule_uniqueID AND R.AlgorithmParameterized_uniqueID=AP.uniqueID AND AP.name IN ('",paste(parameterizedAlgorithmNames,collapse="','"),"') AND I.nrJobs=",nrJobs," AND I.nrMachines=",nrMachines," AND ",paste(paste(" I.uniqueID NOT IN (SELECT Instance_uniqueID FROM ",prefix,")",sep=""),collapse=" AND "),sep="")
    
  }
  
  
  ##   dbSendQuery(con,paste(" DROP TABLE IF EXISTS ",tableName,sep=""))
  
  
  
  sol<-dbGetQuery(con,query)
  
  
  if(aggregation)
  {
    dataset <- aggregate.data.frame(sol,by=list("Instance_uniqueID"=sol[,"Instance_uniqueID"],,"name"=sol[,"name"]),
                                    function(x)(c(min(x),max(x),mean(x),var(x))))
    
  }
  
  
  dataf <- cast(sol,Instance_uniqueID~name,value="makespan",fun.aggregate="mean")
 
  any.value.missing <- apply(dataf[,parameterizedAlgorithmNames],1,function(x)any(is.na(x)))
  
  
  dataf <- dataf[!any.value.missing,]
  
  
  fieldtypes <- as.list(rep("DOUBLE",ncol(dataf)))
  names(fieldtypes) <- colnames(dataf)
  
  fieldtypes$Instance_uniqueID <- "VARCHAR(20)"
  browser()
  dbWriteTable(analyseConnection,tableName,as.data.frame(dataf),row.names=FALSE,
               field.types= fieldtypes)
  
  dbSendQuery(analyseConnection,paste("ALTER TABLE `",tableName,"` ADD PRIMARY KEY (`Instance_uniqueID`)",sep=""))
  
})

# setMethodS3("addTargetBasic","FeaturedElement", function(
#   this,
#   con,
#   nrJobs,
#   nrMachines,
#   algorithmName="GifflerThompson",
#   aggregation = FALSE,
#   ...)
# { 
#   
#   tableName <- paste("Instance_Targets_",algorithmName,"_",nrJobs,"x",nrMachines,sep="")
#   dbSendQuery(con,paste(" DROP TABLE IF EXISTS ",tableName,sep=""))
#   
#   
#   query <- paste("SELECT R.Instance_uniqueID,AP.name,makespan FROM Instance I,Run R,AlgorithmParameterized AP,FeasibleSchedule FS  WHERE I.unqiueID=R.Instance_uniqueID AND FS.uniqueID=R.FeasibleSchedule_uniqueID AND R.AlgorithmParameterized_uniqueID=AP.uniqueID AND AP.Algorithm_name='",algorithmName,"' AND I.nrJobs=",nrJobs," AND I.nrMachines=",nrMachines,sep="")
#   
#   sol<-dbGetQuery(con,query)
#   
#   
#   if(aggregation)
#   {
#     dataset <- aggregate.data.frame(sol,by=list("Instance_uniqueID"=sol[,"Instance_uniqueID"],,"name"=sol[,"name"]),
#                                     function(x)(c(min(x),max(x),mean(x),var(x))))
#     
#   }
# 
#   
#   dataf <- cast(sol,Instance_uniqueID~name,value="makespan",fun.aggregate="mean")
# 
#   dataf[is.na(dataf)]<-0
#   
#   fieldtypes <- as.list(rep("DOUBLE",ncol(dataf)))
#   names(fieldtypes) <- colnames(dataf)
#   
#   fieldtypes$Instance_uniqueID <- "VARCHAR(20)"
# 
#   dbWriteTable(con,tableName,as.data.frame(dataf),row.names=FALSE,
#                field.types= fieldtypes)
#   
#   dbSendQuery(con,paste("ALTER TABLE `",tableName,"` ADD PRIMARY KEY (`Instance_uniqueID`)",sep=""))
#   
# })


setMethodS3("constructQuery","FeaturedElement", function(
  this,
  con,
  groupAttributes,
  join = NULL,
  selects =NULL,
  restrictionMainTable = NULL,
  typejoin = "LEFT",
  ...)
{ 



  mainTable <- groupAttributes$mainTable  
  mainColumns <- dbGetQuery(con,paste("SHOW COLUMNS FROM ",mainTable,sep="") )
  
  selectColumns <- paste(mainTable,".",mainColumns[,"Field"],sep="")                          
  
  fieldtypes <- as.list(mainColumns[,"Type"])
  names(fieldtypes) <- mainColumns[,"Field"]
  
  
  query <- mainTable   
  
  if(!is.null(restrictionMainTable))
  {
    query <- paste("(SELECT * FROM ",mainTable," WHERE ",restrictionMainTable,") ",mainTable,sep="")
    
  }
  
  if(!is.null(join) & length(join)>0)
  {
    for(leftjoinIndex in 1:length(join))
    {
      leftjoin <- join[[leftjoinIndex]]
      
      joinTable <- leftjoin$joinTable
      
      joinColumns <- dbGetQuery(con,paste("SHOW COLUMNS FROM ",joinTable,sep="") )
      
      
      joinTableSelectName <- joinTable
      joinColumnsSuffix <- ""
      
      if(joinTable == mainTable)
      {
        if(length(join)>1)
        {
          joinTableSelectName <- paste("joinTable_",leftjoinIndex,sep="")
          joinColumnsSuffix <- paste("_subset_",leftjoinIndex,sep="")          
        }
        else
        {
          joinTableSelectName <-"joinTable"
          joinColumnsSuffix <-"_subset" 
        }
        
      }
      
      
      #  joinByColumnsStg <- groupAttributes$joinby
      joinByColumns <-  leftjoin$joinbyJoinTable  #unlist(strsplit(joinByColumnsStg,","))
      nonJoinbyColumns <- setdiff(joinColumns[,"Field"],joinByColumns)
      
      
      joinby1 <- paste(mainTable,".",leftjoin$joinbyMainTable,sep="")
      joinby2 <- paste(joinTableSelectName,".",leftjoin$joinbyJoinTable,sep="")
      
      joinby <- paste(joinby1,"=",joinby2,sep="")
      joinbyStg <- paste(joinby,collapse=" AND ")
      
      joinfieldtypes <- as.list(joinColumns[joinColumns[,"Field"] %in% nonJoinbyColumns,"Type"]  )
      names(joinfieldtypes) <- paste(nonJoinbyColumns,joinColumnsSuffix,sep="") 
        
      
      fieldtypes <- c(fieldtypes,joinfieldtypes)
        
      selectJoinTable <- paste(joinTableSelectName,".",nonJoinbyColumns," AS ",nonJoinbyColumns,joinColumnsSuffix,sep="")                          
      selectColumns <- c(selectColumns,selectJoinTable)
      
      query <- paste(query," ",typejoin," JOIN ",joinTable," ",joinTableSelectName," ON ",
                     joinbyStg,sep="")
      
    }
  }
  
  if(is.null(selects))
  {
    select <- paste(selectColumns,collapse=",")
  }
  else
  {
    select <- paste(selects,collapse=",")
  }
  
  
  finalquery <- paste("SELECT ",select," FROM ",query,sep="")
  

  
  return(list("query"=finalquery,"fieldtypes"=fieldtypes))
  
  
})


setMethodS3("addPartitionFeatures","FeaturedElement", function(
  this,
  con, 
  mainTable,
  groupName,
  targetFieldName,
  join = NULL,
  groupby = NULL,
  subset= NULL,  
  ##list(fieldName = c(aggregation functions))
  features = list(),  
  ...)
{
  
  print("Starting...")
  
  objName <- this$getObjectClassName()
  tableName <- paste(objName,"_",groupName,sep="")  
  type <- "partition"
  
  groupAttributes <- list(name=groupName,
                          object=objName,
                          mainTable=mainTable,
                          type=type,
                          subset=subset,
                          targetFieldName=targetFieldName,
                          keepMainFeatures=0)
  
  
  if(!is.null(groupby))
  {
    groupAttributes$groupby <- paste(groupby,collapse=",")   
  }

  print("Constructing query....")
  queryList <- this$constructQuery(
    con,
    groupAttributes,
    join)
  
  query<-queryList[["query"]]
  
  solPKS <- dbGetQuery(con,paste("SHOW COLUMNS FROM ",mainTable,sep=""))
  
  pks <- solPKS[solPKS[,"Key"] == 'PRI',"Field"]  
  pkstype <- solPKS[solPKS[,"Key"] == 'PRI',"Type"]   
  
  primaryKeys <-as.list(pkstype)
  names(primaryKeys) <- pks
  
  
  if(!is.null(groupby))
  {
    pks <- intersect(solPKS[solPKS[,"Key"] == 'PRI',"Field"],groupby)   
    primaryKeys <- primaryKeys[pks]
  }
  
  mainFeats <- NULL
  mainFeatures <- list()
  
  limitquery <- paste(query," LIMIT 1")
  
  sollimitquery <- dbGetQuery(con,limitquery)
  
  ui <- sollimitquery[1,targetFieldName]
  
  
  
  iswhere <-grep("where",tolower(query))
  
  if(length(iswhere) == 0)
  {
    newquery <- paste(query," WHERE ")
  }
  else
  {
    newquery <- paste(query," AND ")    
  }
  
  
  newquery <- paste(newquery,mainTable,".",targetFieldName," LIKE '",ui,"'",sep="")      
  
  print("Getting data...")
  dataset <- dbGetQuery(con,newquery)
  allData <- NULL
  
  featFormula <- NULL
  
  print("Calculating features...")
  
  
  allData <- this$calculatePartitionFeatures(
    dataset,
    groupby = groupby,
    subset = subset,
    ##list(fieldName=c(aggregators))
    features = features)
  

  print("Features calculated!")
  
  fieldtypes <- primaryKeys  
  
  for(feat in features)
  {
    
    if(is.null(feat$name))
    {
      prefix <- feat$prefix
      
      if(length(prefix)>1)
      {
        prefix <- paste(prefix,collapse="_")
      }
      
      
      columnnames<-colnames(allData)
      indexs <- grep(paste("^",prefix,".",sep=""),columnnames)
      
      if(length(indexs)>0)
      {
        fieldtypes[columnnames[indexs]] <- rep(feat$type,length(indexs))           
      }
      
      
    }
    else
    {
      fieldtypes[[feat$name]] <- feat$type   
    }
      
  }
  
  print("Creating table..")
  browser()
  dbWriteTable(con,tableName,allData[,names(fieldtypes)],
               #append=TRUE,
               field.types= fieldtypes,
               row.names=FALSE)
  
  
  print("Adding PKs...")
  
  
  dbSendQuery(con,paste("ALTER TABLE `",tableName,"` ADD PRIMARY KEY (`",paste(pks,collapse="`,`"),"`)",sep=""))
  
  DBobjGroup<-DBFeaturesGroups()
  
  DBobjGroup$attributes <- groupAttributes
  
  if(!DBobjGroup$existsByAttributes(con))
  {
    print("Saving features groups..")
    DBobjGroup$save(con)  
    
  }
  
  DBobjExp<-DBFeatureExperiment()
  
  DBobjExp$attributes <- list(FeaturesGroups_name=groupName,
                              FeaturesGroups_object=objName)
  
  if(!DBobjExp$existsByAttributes(con))
  {
    print("Saving features groups..")
    DBobjExp$save(con)  
    
  }  
  
  
  
  
  if(!is.null(join))
  {
    for(leftjoin in join)
    {
      DBobjJoinGroup<-DBFeaturesGroupsJoinTables()
      
      DBobjJoinGroup$attributes <- list(FeaturesGroups_name=  groupName,
                                        FeaturesGroups_object=  this$getObjectClassName(),
                                        joinTable = leftjoin$joinTable,
                                        joinbyMainTable = paste(leftjoin$joinbyMainTable,collapse=","),
                                        joinbyJoinTable = paste(leftjoin$joinbyJoinTable,collapse=","))
      
      if(!DBobjJoinGroup$existsByAttributes(con))
      {
        print("Saving features groups join information..")
        DBobjJoinGroup$save(con)  
        
      }  
    }    
  }
  
  
  
  
  place <- 1
  
  
  for(featIndex in 1:length(features))
  {
    feat <- features[[featIndex]]
    
    DBobjFeat <- DBFeatures()
    
    
    DBobjFeat$attributes <- list(name = paste(feat[["prefix"]],collapse=","),
                                 type=  "numeric",
                                 FeaturesGroups_name=  groupName,
                                 FeaturesGroups_object=  this$getObjectClassName(),
                                 formula = paste(feat[["formula"]],collapse=","),
                                 aggregation=paste(lapply(feat[["partition"]],function(x)paste(x,collapse=",")),collapse=";"),
                                 tableOrder = place)
    
    
    if(!DBobjFeat$existsByAttributes(con))
    {
      print("Saving features..")
      DBobjFeat$save(con)          
      place <- place + 1
    }
    
    
    
    
  }
  
  
  exp <- ExperimentFramework()
  exp$connectionDB <- con
  exp$generateModels(file="./lib/MySQLInterface/DBModel.R")
  
  
})


setMethodS3("addFeatures","FeaturedElement", function(
  this,
  con, 
  analyseConnection = NULL,
  mainTable,
  groupName,
  targetFieldName,
  type,
  join = NULL,
  groupby = NULL,
  subset= NULL,  
  ##list(fieldName = c(aggregation functions))
  features = list(),    
  aggregationFeatures = NULL,
  keepMainFeatures = TRUE,
  restrictionMainTable = NULL,  
  ...)
{

  print("Starting...")
  
  objName <- this$getObjectClassName()
  tableName <- paste(objName,"_",groupName,sep="")  
  
  if(!is.null(aggregationFeatures))
  {
    for(aggFeatIndex in 1:length(aggregationFeatures))
    {
      aggFeat <- aggregationFeatures[[aggFeatIndex]]
      prefixs <- aggFeat$prefix
      suffixs <- aggFeat$suffix 
      formulas <- aggFeat$formula
      
      aggs <- aggFeat$aggregation
      
      for(g in 1:length(formulas))
      {
        prefix <- prefixs[g]
        suffix <- suffixs[g]
        form <- formulas[g]
        
        for(agg in aggs)
        {
          newFeat <- aggFeat
          newFeat$aggregation <- agg
          
          first<-toupper(substring(agg,1,1))
          aggName <- paste(first,substr(agg,2,nchar(agg)),sep="")
          
          newFeat$name <- paste(prefix,aggName,suffix,sep="")
          newFeat$formula <- form
          newFeat$suffix <- suffix          
          newFeat$prefix <- prefix
          
          features[[length(features)+1]] <- newFeat
        }
        
        
      }    
      
    }
    
  }

  
  
  
  
  groupAttributes <- list(name=groupName,
                          object=objName,
                          mainTable=mainTable,
                          type=type,
                          subset=subset,
                          targetFieldName=targetFieldName,
                          keepMainFeatures=as.numeric(keepMainFeatures),
                          restrictionMainTable =restrictionMainTable )


  if(!is.null(groupby))
  {
    groupAttributes$groupby <- paste(groupby,collapse=",")   
  }

  typejoin <- "LEFT"
  
  if(type=="formula")
  {
    typejoin <- ""
  }
  
  
  print("Constructing query....")
  queryList <- this$constructQuery(
    con,
    groupAttributes,
    join,
    restrictionMainTable=restrictionMainTable,
    typejoin = typejoin)
  
  
  query <- queryList[["query"]]
  allfieldtypes <- queryList[["fieldtypes"]]
  
  solPKS <- dbGetQuery(con,paste("SHOW COLUMNS FROM ",mainTable,sep=""))
  
  pks <- NULL
  
  if(is.null(groupby))
  {
    pks <- solPKS[solPKS[,"Key"] == 'PRI',"Field"]    
    
  }
  else
  {
    pks <- groupby
  }

  mainFeatures <- NULL
  
  if(keepMainFeatures)
  {
    mainFeatures <- solPKS[solPKS[,"Key"] != 'PRI',"Field"]    
  }

  
  limitquery <- paste(query," LIMIT 1")

  sollimitquery <- dbGetQuery(con,limitquery)
  
  ui <- sollimitquery[1,targetFieldName]
  

  
#   iswhere <-grep("where",tolower(query))
#   
#   if(length(iswhere) == 0 | ())
#   {
#     newquery <- paste(query," WHERE ")
#   }
#   else
#   {
#     newquery <- paste(query," AND ")    
#   }
  newquery <- paste(query," WHERE ")
 
  newquery <- paste(newquery,mainTable,".",targetFieldName," LIKE '",ui,"'",sep="")      

  print("Getting data...")
  dataset <- dbGetQuery(con,newquery)
  allData <- NULL
 
  featFormula <- NULL

  print("Calculating features...")
  if(type=="formula")
  {
    
    allData <-this$calculateFormulaFeatures(
      dataset,
      features = features)
    
  }

  if(type=="aggregation")
  {
    allData <- this$calculateAggregationFeatures(
      dataset,
      groupby = groupby,
      subset = subset,
      ##list(fieldName=c(aggregators))
      features = features,
      mainFeats = mainFeatures)
    
  }

  if(type=="simple")
  {

    allData <- eval(call(groupName,this,dataset))
        
   
    colNames <- setdiff(colnames(allData),c(pks,mainFeatures))
    
    features <- list()
    i <- 1
    
    for(col in colNames)
    {
      features[[i]] <-  list(name=col,type="DOUBLE")
      i <- i + 1
    }
    
  
  }
  
  if(type=="partition")
  {
    allData <- this$calculatePartitionFeatures(
      dataset,
      groupby = groupby,
      subset = subset,
      ##list(fieldName=c(aggregators))
      features = features)

  }
 
  print("Features calculated!")

  fieldtypes <- allfieldtypes[c(pks,mainFeatures)]
  
  
  for(feat in features)
  {
    
    if(is.null(feat$name))
    {
      prefix <- feat$prefix
      
      if(length(prefix)>1)
      {
        prefix <- paste(prefix,collapse="_")
      }
      
      
      columnnames<-colnames(allData)
      indexs <- grep(paste("^",prefix,".",sep=""),columnnames)
      
      if(length(indexs)>0)
      {
        fieldtypes[columnnames[indexs]] <- rep(feat$type,length(indexs))           
      }
      
      
    }
    else
    {
      fieldtypes[[feat$name]] <- feat$type   
    }
   
    
    
    
  }

  print("Creating table..")
  browser()
  dbWriteTable(analyseConnection,tableName,allData[,names(fieldtypes)],
               #append=TRUE,
               field.types= fieldtypes,
               row.names=FALSE)

  
  print("Adding PKs...")
  

  dbSendQuery(analyseConnection,paste("ALTER TABLE `",tableName,"` ADD PRIMARY KEY (`",paste(pks,collapse="`,`"),"`)",sep=""))

  DBobjGroup<-DBFeaturesGroups()
  
  DBobjGroup$attributes <- groupAttributes

  if(!DBobjGroup$existsByAttributes(con))
  {
    print("Saving features groups..")
    DBobjGroup$save(con)  
    
  }
  
  DBobjExp<-DBFeatureExperiment()
  
  DBobjExp$attributes <- list(FeaturesGroups_name=groupName,
                              FeaturesGroups_object=objName)
  
  if(!DBobjExp$existsByAttributes(con))
  {
    print("Saving features groups..")
    DBobjExp$save(con)  
    
  }  
  
  
  
  
  if(!is.null(join))
  {
    for(leftjoin in join)
    {
      DBobjJoinGroup<-DBFeaturesGroupsJoinTables()
      
      DBobjJoinGroup$attributes <- list(FeaturesGroups_name=  groupName,
                                        FeaturesGroups_object=  this$getObjectClassName(),
                                        joinTable = leftjoin$joinTable,
                                        joinbyMainTable = paste(leftjoin$joinbyMainTable,collapse=","),
                                        joinbyJoinTable = paste(leftjoin$joinbyJoinTable,collapse=","))

      if(!DBobjJoinGroup$existsByAttributes(con))
      {
        print("Saving features groups join information..")
        DBobjJoinGroup$save(con)  
        
      }  
    }    
  }
  
  
  
  
  place <- 1
  

  for(featIndex in 1:length(features))
  {
    feat <- features[[featIndex]]
    
    DBobjFeat <- DBFeatures()
    
   
    DBobjFeat$attributes <- list(name = feat[["name"]],
                                 type=  "numeric",
                                 FeaturesGroups_name=  groupName,
                                 FeaturesGroups_object=  this$getObjectClassName(),
                                 formula = feat[["formula"]],
                                 aggregation=feat[["aggregation"]],
                                 tableOrder = place)
    
 
    if(!DBobjFeat$existsByAttributes(con))
    {
      print("Saving features..")
      DBobjFeat$save(con)          
      place <- place + 1
    }
    
    
    
    
  }
  
  
  exp <- ExperimentFramework()
  exp$connectionDB <- con
  exp$generateModels(file="./lib/MySQLInterface/DBModel.R")
  

})



 setMethodS3("calculateFormulaFeatures","FeaturedElement", function(
   this,
   dataset,
   ##list(list(name=name,formula=formula)  
   features = list(),
   ...) {
  

      
   #attach(dataset)
     
   
   for(featIndex in 1:length(features))
   {
     
     feat <- features[[featIndex]]
     featName <- feat[["name"]]

     dataset[,featName] <- with(dataset,eval(parse(text=c(feat[["formula"]]))))
    
   }
      
   
   #detach(dataset)
   
   return(dataset)
 })

setMethodS3("calculateAggregationFeatures","FeaturedElement", function(
  this,
  dataset,
  groupby = NULL,
  subset = NULL,
  ##list(list(default,subset,formula = ,baseName=  ,   aggregation))
  features = list(),
  mainFeats = NULL,
  ...) {
  

  keepFeats <- c(groupby,mainFeats)
 
  if(length(keepFeats) == 1)
  {
    allDataset <- data.frame(unique(dataset[,keepFeats]))
    names(allDataset) <- keepFeats
  }
  else
  {
    allDataset <- unique(dataset[,keepFeats])    
  }


  
  for(featIndex in 1:length(features))
  {
    feat <- features[[featIndex]]
    
    field <- feat[["formula"]]
    agg<- feat[["aggregation"]]    
    
    defaultValue <- 0
    
    if(!is.null(feat[["defaultValue"]] ))
    {
      defaultValue <- feat[["defaultValue"]]           
    }
    
    
    featName <- feat[["name"]]
    
    if(is.null(featName))
    {
      featName <- feat[["prefix"]]      
    }
    
    print("Creating feature:")
    print(featName)
    
   
    
    

    if(is.null(subset) || is.na(subset))
    {

      aggData <- with(dataset,aggregate(as.formula(paste(field,"~",paste(groupby,collapse="+"))),
                                        data=dataset,
                                        agg))
      
    }
    else
    {
  
      aggData <- with(dataset,aggregate(as.formula(paste(field,"~",paste(groupby,collapse="+"))),
                                        data=dataset,
                                        agg,subset= eval(parse(text=c(subset)) )))      
      
    }
    

    
    fieldindex <- which(gsub(" ","",names(aggData)) == gsub(" ","",field))
    
    names(aggData)[fieldindex] <- featName
    
    allDataset <- merge(allDataset,aggData,by=groupby,all.x=TRUE)
    

    
    isna <- is.na(allDataset[,featName])

    if(any(isna))
    {
      allDataset[isna,featName] <- defaultValue
      
    }
  
  }
  

  return(allDataset)
  
})


setMethodS3("calculateCastFeatures","FeaturedElement", function(
  this,
  dataset,
  groupby = NULL,
  subset = NULL,
  ##list(list(default,subset,formula = ,baseName=  ,   aggregation))
  features = list(),
  mainFeats = NULL,
  ...) {
  
  keepFeats <- groupby
  
  if(length(keepFeats) == 1)
  {
    allDataset <- data.frame(unique(dataset[,keepFeats]))
    names(allDataset) <- keepFeats
  }
  else
  {
    allDataset <- unique(dataset[,keepFeats])    
  }
  
  
  
  for(featIndex in 1:length(features))
  {
    newdataset <- dataset
    newdataset$value <- rep(1,nrow(newdataset))
    
    feat <- features[[featIndex]]
    
    formulas <- feat[["formula"]]
    partitions<- feat[["partition"]]     
    prefixs <- feat[["prefix"]]   
    allPartitions <- list()
    
    prefixAllFields <- paste(prefixs,collapse="_")
    
    for(formulaIndex in 1:length(formulas))
    {
      form <- formulas[formulaIndex]
      partition <- partitions[[formulaIndex]]
      prefix <- prefixs[[formulaIndex]]
 
      newdataset[,prefix] <- with(newdataset,
                                  cut(eval(parse(text=form)),partition))
      
      allPartitions[[prefix]] <- levels(newdataset[,prefix])
      
      
    }
    
    if(length(formulas)>1)
    {
      
      newdataset[,prefixAllFields]<-do.call(paste,c(newdataset[,prefixs], sep = "_"))
      
    }
    
    
    castdataset <- cast(newdataset,as.formula(paste(paste(groupby,collapse="+"),"~",prefixAllFields,sep="")),length,value="value")
    allCombinations <- do.call(paste,c(expand.grid(allPartitions), sep = "_"))
  
    
    
    missingPartitions <-allCombinations[!allCombinations %in% colnames(castdataset)]
    
    for(missPart in missingPartitions)
    {
      castdataset[,missPart] <- rep(0,nrow(castdataset)) 
    }
    
    notgroupby <- !colnames(castdataset) %in% groupby
    
    
    
    
    colnames(castdataset)[notgroupby] <- paste(prefixAllFields,"_",   
                                               colnames(castdataset)[notgroupby],sep="")
 
    allDataset <- merge(allDataset,castdataset,by=groupby,all.x=TRUE) 
    
  }
  
  
  
  return(allDataset)
  
})


setMethodS3("calculatePartitionFeatures","FeaturedElement", function(
  this,
  dataset,
  groupby = NULL,
  subset = NULL,
  ##list(list(default,subset,formula = ,baseName=  ,   aggregation))
  features = list(),
  mainFeats = NULL,
  ...) {
  
  keepFeats <- groupby
  
  if(length(keepFeats) == 1)
  {
    allDataset <- data.frame(unique(dataset[,keepFeats]))
    names(allDataset) <- keepFeats
  }
  else
  {
    allDataset <- unique(dataset[,keepFeats])    
  }
  
  
  
  for(featIndex in 1:length(features))
  {
    newdataset <- dataset
    newdataset$value <- rep(1,nrow(newdataset))
    
    feat <- features[[featIndex]]
    
    formulas <- feat[["formula"]]
    partitions<- feat[["partition"]]     
    prefixs <- feat[["prefix"]]   
    allPartitions <- list()
    
    prefixAllFields <- paste(prefixs,collapse="_")
    
    for(formulaIndex in 1:length(formulas))
    {
      form <- formulas[formulaIndex]
      partition <- partitions[[formulaIndex]]
      prefix <- prefixs[[formulaIndex]]
      
      newdataset[,prefix] <- with(newdataset,
                                  cut(eval(parse(text=form)),partition))
      
      allPartitions[[prefix]] <- levels(newdataset[,prefix])
      
      
    }
    
    if(length(formulas)>1)
    {
      
      newdataset[,prefixAllFields]<-do.call(paste,c(newdataset[,prefixs], sep = "_"))
      
    }
    
    
    castdataset <- cast(newdataset,as.formula(paste(paste(groupby,collapse="+"),"~",prefixAllFields,sep="")),length,value="value")
    allCombinations <- do.call(paste,c(expand.grid(allPartitions), sep = "_"))
    
    
    
    missingPartitions <-allCombinations[!allCombinations %in% colnames(castdataset)]
    
    for(missPart in missingPartitions)
    {
      castdataset[,missPart] <- rep(0,nrow(castdataset)) 
    }
    
    notgroupby <- !colnames(castdataset) %in% groupby
    
    
    
    
    colnames(castdataset)[notgroupby] <- paste(prefixAllFields,"_",   
                                               colnames(castdataset)[notgroupby],sep="")
    
    allDataset <- merge(allDataset,castdataset,by=groupby,all.x=TRUE) 
    
  }
  
  
  
  return(allDataset)
  
})




setMethodS3("runCalculationOfFeatures","FeaturedElement", function(this,
                                                                   con,
                                                                   experimentID, 
                                                                   group,
                                                                   ...) {
  
  print("Features calculation beginning.")
  DBobjGroup<-DBFeaturesGroups()
  objectName <- this$getObjectClassName()
  groupName <- group
  DBobjGroup$attributes <- list(name = group,
                                object = objectName)
  
  
  DBobjGroup$getByAttributes(con)
  
  attrib <-  DBobjGroup$attributes
  
  type <- attrib[["type"]]
  
  
  objName <- this$getObjectClassName()
  tableName <- paste(objName,"_",group,sep="")  
  
  
  
  
  
  allColumns <- dbGetQuery(con,paste("SHOW COLUMNS FROM ",tableName,sep=""))
 

  fieldtypes <- allColumns[,"Type"]
  names(fieldtypes) <- allColumns[,"Field"]
  
  groupAttributes <- DBobjGroup$attributes
  
  mainTable <- groupAttributes[["mainTable"]] 
  type <- groupAttributes[["type"]] 
  targetFieldName <- groupAttributes[["targetFieldName"]] 
  groupby <-  groupAttributes[["groupby"]] 
  subset <-  groupAttributes[["subset"]] 
  keepMainFeatures <-  groupAttributes[["keepMainFeatures"]] 
  restrictionMainTable  <- groupAttributes[["restrictionMainTable"]]
  join <- list()
  
  DBobjJoinGroup<-DBFeaturesGroupsJoinTables()
  
  DBobjJoinGroup$attributes <- list(FeaturesGroups_name = groupName,
                                    FeaturesGroups_object = objName)
  
  allJoinObjs <- DBobjJoinGroup$getAllByAttributes(con)
  
  
  
  if(length(allJoinObjs)>0)
  {
    for(joinObj in allJoinObjs)
    {
      leftjoin <- joinObj$attributes
      
      join[[length(join)+1]]<- list(FeaturesGroups_name=  groupName,
                                    FeaturesGroups_object= objName,
                                    joinTable = leftjoin$joinTable,
                                    joinbyMainTable = unlist(strsplit(leftjoin$joinbyMainTable,",")),
                                    joinbyJoinTable = unlist(strsplit(leftjoin$joinbyJoinTable,",")))
      
    }    
  }
  
  features <- list()
  
  
  DBobjFeat <- DBFeatures()
  
  DBobjFeat$attributes <- list(FeaturesGroups_name=  groupName,
                               FeaturesGroups_object= objName)
  
  allDBobjFeat <- DBobjFeat$getAllByAttributes(con,orderby=" tableOrder ASC")  
  
  
  featNames <- NULL
  
  for(featObj in allDBobjFeat)
  {
    feat <-  featObj$attributes 
    featNames <- c(featNames,feat[["name"]])  
    features[[length(features)+1]]<- list(name = feat[["name"]],
                                          type=  feat[["type"]],
                                          FeaturesGroups_name=  groupName,
                                          FeaturesGroups_object=  objName,
                                          formula = feat[["formula"]],
                                          aggregation=feat[["aggregation"]],
                                          tableOrder = feat[["tableOrder"]])
    
  }
  
  
  
  
  
  
  if(!is.null(groupby) & !is.na(groupby))
  {
    groupby <- unlist(strsplit(groupby,","))   
  }
  
  
  
  targetIDsQuery <- paste("SELECT * FROM FeatureExperimentObjects WHERE status='",experimentID,"'",sep="") 
  targetIDsRes <- dbGetQuery(con,targetIDsQuery)
  
  
  restrictionQuery <- paste(targetFieldName," IN ('",paste(targetIDsRes[,"target"],collapse="','"),"')")
  
  if(!is.na(restrictionMainTable))
  {
    restrictionQuery <- paste(restrictionQuery," AND ",restrictionMainTable  )
    
    
  }
  
  typejoin <- "LEFT"
  
  if(type=="formula")
  {
    typejoin <- ""
  }
  
  
  print("Constructing query....")
  
  queryList <- this$constructQuery(
    con,
    groupAttributes,
    join,
    restrictionMainTable = restrictionQuery,
    typejoin=typejoin)

  
  query<-queryList[["query"]]
  
  ##datasetquery <- paste("SELECT m.* FROM (",query,") m,FEO WHERE m.",targetFieldName,"=FEO.target  ORDER BY FEO.target",sep="")   
  dataset <- dbGetQuery(con,query)
  
  print("Getting data...")
  allData <-NULL
  
  
  print("Calculating features...")
  if(type=="formula")
  {

    allData <-this$calculateFormulaFeatures(
      dataset,
      features = features)
    
  }
  
  if(type=="aggregation")
  {
    solPKS <- dbGetQuery(con,paste("SHOW COLUMNS FROM ",mainTable,sep=""))
    mainFeats <- NULL
    
    if(keepMainFeatures == 1)
    {
      mainFeats <- solPKS[solPKS[,"Key"] != 'PRI',"Field"]  
      mainFeatsType <- solPKS[solPKS[,"Key"] != 'PRI',"Type"]   
      
      mainFeatures <-as.list(mainFeatsType)
      names(mainFeatures) <- mainFeats  
      
    }
    
    allData <- this$calculateAggregationFeatures(
      dataset,
      groupby = groupby,
      subset = subset,
      features = features,
      mainFeats = mainFeats)
    
  }
  
  if(type=="simple")
  {
    
    allData <- eval(call(groupName,this,dataset))    
    
    colNames <- setdiff(colnames(allData),pks)
    
    features <- list()
    i <- 1
    for(col in colNames)
    {
      features[[i]] <-  list(name=col,type="DOUBLE")
      i <- i + 1
    }
    
    
  }
 
 
  print("Writing table..")
  dbWriteTable(con,tableName,allData[,names(fieldtypes)],
               field.types= fieldtypes,
               append=TRUE,
               row.names=FALSE)
  
})






# 
# 
# setMethodS3("scheduleAggregationFeaturesWithSQL","FeaturedElement", function(this,
#                                                                              con,
#                                                                              nr,
#                                                                              group,
#                                                                              ...) {
#   
#   DBobjGroup<-DBFeaturesGroups()
#   objectName <- this$getObjectClassName()
#   
#   DBobjGroup$attributes <- list(name = group,
#                                 object = objectName)
#   
#   
#   DBobjGroup$getByAttributes(con)
#   
#   attrib <-  DBobjGroup$attributes
#   
#   group <- attrib[["name"]]
#   dependentGroup <- attrib[["dependentGroup"]]
#   dependentObjectName <- attrib[["dependentObject"]]
#   #groupbystg <- attrib[["groupBy"]]
#   orderbystg <- attrib[["orderBy"]]  
#   #groupby <- unlist(strsplit(groupbystg,","))
#   orderby <- unlist(strsplit(orderbystg,","))  
# 
#   tableName <- this$calculateFeaturesTableName(group)
#   
#  # concatgroupby <- paste(paste("cast(",groupby," as CHAR)",sep=""),collapse=",'_',")
#   
#   
#   dependentObject <- eval(call(paste(dependentObjectName,"FeaturedElement",sep="")))
#   dependentObjectTable <- dependentObject$calculateFeaturesTableName(dependentGroup)
#   
#  # query <-paste("INSERT INTO FeatureExperimentObjects SELECT DISTINCT '",group,"' AS FeaturesGroups_name,'",objectName,"' AS FeaturesGroups_object,CONCAT(",concatgroupby,") AS target,'None' AS status FROM ",dependentObjectTable," HAVING target NOT IN (SELECT target FROM ",dependentObjectTable," ) AND target NOT IN (SELECT CONCAT(",concatgroupby,") FROM ",tableName,")  LIMIT ",nr,sep="")
#   query <-paste("INSERT INTO FeatureExperimentObjects SELECT DISTINCT '",group,"' AS FeaturesGroups_name,'",objectName,"' AS FeaturesGroups_object,",orderby," AS target,'None' AS status FROM ",dependentObjectTable," WHERE ",orderby," NOT IN (SELECT target FROM  FeatureExperimentObjects) AND ",orderby," NOT IN (SELECT ",orderby," FROM ",tableName,")  LIMIT ",nr,sep="")
#   
#   dbSendQuery(con,query)
# 
# })
#   
# setMethodS3("calculateAggregationFeaturesInR","FeaturedElement", function(this,
#                                                                           con,
#                                                                           experimentID,
#                                                                           group,
#                                                                           ...) {
#   
#   
#   
#   DBobjGroup<-DBFeaturesGroups()
#   objectName <- this$getObjectClassName()
#   
#   DBobjGroup$attributes <- list(name = group,
#                                 object = objectName)
#   
#   
#   DBobjGroup$getByAttributes(con)
#   
#   attrib <-  DBobjGroup$attributes
#   
#   group <- attrib[["name"]]
#   dependentGroup <- attrib[["dependentGroup"]]
#   dependentObjectName <- attrib[["dependentObject"]]
#   groupbystg <- attrib[["groupBy"]]
#   orderbystg <- attrib[["orderBy"]]  
#   groupby <- unlist(strsplit(groupbystg,","))
#   orderby <- unlist(strsplit(orderbystg,","))  
#   
#   dependentObject <- eval(call(paste(dependentObjectName,"FeaturedElement",sep="")))
#   
#   table <- this$getObjectClassName()
#   
#   newtableName <- paste(table,"_",group,sep="")  
#   
#   
#   DBobjFeat <- DBFeatures()
#   
#   DBobjFeat$attributes <- list(FeaturesGroups_name=  group,
#                                FeaturesGroups_object=  objectName)
#   
#   
#   allFeatObjs <- DBobjFeat$getAllByAttributes(con,orderby="tableOrder")
#   
#   select <- NULL
#   
#   featNames <- NULL
#   
#   for(featObj in allFeatObjs)
#   {
#     
#     attribFeat <- featObj$attributes 
#     name <- attribFeat[["name"]]
#     feat <- attribFeat[["dependentColumn"]] 
#     agg <- attribFeat[["aggregationFunction"]] 
#     featNames <- c(featNames,name)
#     
#     select <- c(select,feat)
#     
#   }
#   
#   dependentObjectTable <- dependentObject$calculateFeaturesTableName(dependentGroup)
#   
#   ##concatgroupby <- paste(paste("cast(",groupby," as CHAR)",sep=""),collapse=",'_',")
# 
#   tmpTable <- paste("tmp_",experimentID,sep="")
#   
#   tmpQuery <- paste("CREATE TABLE ",tmpTable," (SELECT target FROM FeatureExperimentObjects WHERE status='",experimentID,"' AND FeaturesGroups_name='",group,"' AND FeaturesGroups_object='",objectName,"')",sep="")
# 
#   dbSendQuery(con,tmpQuery)
#  
#   selectQuery <-paste("SELECT ",paste(groupby,collapse=","),",",paste(unique(select),collapse=",")," FROM ",dependentObjectTable," t RIGHT JOIN tmp_",experimentID," tmp ON t.",orderby,"=tmp.target",sep="")
#   
#   #query <- paste("INSERT INTO ",newtableName,selectQuery) 
#   
#   sol <- dbGetQuery(con,selectQuery)
# 
# 
#   allData <- NULL
#     
#     
#   for(featObjIndex in 1:length(allFeatObjs))    
#   {  
#     featObj<- allFeatObjs[[featObjIndex]]
#     
#       attribFeat <- featObj$attributes 
#       name <- attribFeat[["name"]]
#       feat <- attribFeat[["dependentColumn"]] 
#       agg <- attribFeat[["aggregationFunction"]] 
#       
#       newdata <- aggregate(as.formula(paste(feat,"~",paste(groupby,collapse="+"))),data=sol,agg)
#                            
#       aggindex <- which(setdiff(dimnames(newdata)[[2]],groupby) == dimnames(newdata)[[2]])
#       dimnames(newdata)[[2]][aggindex] <- name
#       
#       if(is.null(allData))
#       {
#         allData <- newdata
#       }
#      else
#        {
#          allData <- merge(allData,newdata,by=groupby)     
#        }
#   
#       
#     }
#     
#   
#   dbWriteTable(con,newtableName,allData,append=TRUE,row.names=FALSE)
#   dbSendQuery(con,paste("DROP TABLE ",tmpTable))
#   
#   
#   query1 <- paste("UPDATE FeatureExperimentObjects SET status='Done' WHERE status='",experimentID,"' AND FeaturesGroups_name='",group,"' AND FeaturesGroups_object='",objectName,"'",sep="")
#   res <- dbSendQuery(con,query1)    
#   
#   
#   
# })
# 
#   
# setMethodS3("calculateAggregationFeaturesWithSQL","FeaturedElement", function(this,
#                                                                            con,
#                                                                            group,
#                                                                            ...) {
#   
#   
#   
#   DBobjGroup<-DBFeaturesGroups()
#   objectName <- this$getObjectClassName()
#   
#   DBobjGroup$attributes <- list(name = group,
#                                 object = objectName)
#   
#   
#   DBobjGroup$getByAttributes(con)
#   
#   attrib <-  DBobjGroup$attributes
# 
#   group <- attrib[["name"]]
#   dependentGroup <- attrib[["dependentGroup"]]
#   dependentObjectName <- attrib[["dependentObject"]]
#   groupbystg <- attrib[["groupBy"]]
#   orderbystg <- attrib[["orderBy"]]  
#   groupby <- unlist(strsplit(groupbystg,","))
#   orderby <- unlist(strsplit(orderbystg,","))  
#   
#   dependentObject <- eval(call(paste(dependentObjectName,"FeaturedElement",sep="")))
#   
#   table <- this$getObjectClassName()
#   
#   newtableName <- paste(table,"_",group,sep="")  
# 
#   
#   DBobjFeat <- DBFeatures()
#   
#   DBobjFeat$attributes <- list(FeaturesGroups_name=  group,
#                                FeaturesGroups_object=	objectName)
#   
#   
#   allFeatObjs <- DBobjFeat$getAllByAttributes(con)
#   
#   select <- NULL
#   
#   for(featObj in allFeatObjs)
#   {
#  
#     attribFeat <- featObj$attributes 
#     name <- attribFeat[["name"]]
#     feat <- attribFeat[["dependentColumn"]] 
#     agg <- attribFeat[["aggregationFunction"]] 
#       
#     
#     select <- c(select,paste(agg,"(",feat,") AS ",name,sep=""))
#     
#   }
# 
#   dependentObjectTable <- dependentObject$calculateFeaturesTableName(dependentGroup)
#   
#   concatgroupby <- paste(paste("cast(",groupby," as CHAR)",sep=""),collapse=",'_',")
#   
# #   tmpDependentObjectTable <- paste("tmp_",dependentObjectTable,sep="")
# #   
# #   
# #   dbSendQuery(con,paste("DROP TEMPORARY TABLE IF EXISTS",tmpDependentObjectTable))
# #  
# #   
# #   queryTmpTable  <- paste("CREATE TEMPORARY TABLE ",tmpDependentObjectTable," SELECT DISTINCT CONCAT(",concatgroupby,") AS id FROM ",dependentObjectTable," WHERE CONCAT(",concatgroupby,") NOT IN (SELECT CONCAT(",concatgroupby,") FROM ",newtableName,") ",sep="")
# # 
# #   
# #   if(!is.null(orderby))
# #   {
# #     queryTmpTable  <- paste(queryTmpTable," ORDER BY ",paste(orderby,collapse=","),sep="")
# #   }
# #   
# #   queryTmpTable  <- paste(queryTmpTable," LIMIT ",nrRestrictionLimit,sep="")
# #   
# #   
# #   dbSendQuery(con,queryTmpTable)
# 
#   #selectQuery <-paste("SELECT ",paste(groupby,collapse=","),",",paste(select,collapse=",")," FROM ",dependentObjectTable," WHERE CONCAT(",concatgroupby,")  IN (SELECT target FROM ",tmpDependentObjectTable,") GROUP BY ",paste(groupby,collapse=","),sep="")
#   
#   selectQuery <-paste("SELECT ",paste(groupby,collapse=","),",",paste(select,collapse=",")," FROM ",dependentObjectTable," WHERE CONCAT(",concatgroupby,")  IN (SELECT target FROM FeatureExperimentObjects WHERE status='",experimentID,"' AND FeaturesGroups_name='",group,"' AND FeaturesGroups_object='",objectName,"') GROUP BY ",paste(groupby,collapse=","),sep="")
#   query <- paste("INSERT INTO ",newtableName,selectQuery) 
#  
#   dbSendQuery(con,query)
#   
# })

# 
# setMethodS3("calculateAggregate","FeaturedElement", function(this,
#                                                           con,
#                                                           dataset,
#                                                           joinby,
#                                                           groupby,
#                                                           restriction = NULL,
#                                                           features = list(),
#                                                           ...) {
#   
#   
#   finaldataset <- NULL
#   
#   mergedataset<-merge(dataset,dataset,by=joinby,suffixes = c("","_subset"))
#   
#   attach(mergedataset,name="calculateJoin")
#   
#   restrictedmergedataset <- mergedataset[restriction,]
#   detach(mergedataset,name="calculateJoin")
#   
#   
#   for(featName in names(features))
#   {
#     feat <- features[[featName]]
#     browser()
#     agg <- aggregate(as.formula(paste(feat,"~",paste(groupby,collapse="+"))),data=restrictedmergedataset)
#     aggNames <- dimnames(agg)[[2]]
#     featIndex <- which(setdiff(aggNames,groupby)==aggNames)
#     newAggNames[featIndex] <- feat
#     dimnames(agg)[[2]] <- newAggNames
#     
#     
#     if(is.null(finaldataset))
#     {   
#       finaldataset <- agg
#       
#     }
#     else
#     {
#       finaldataset <- merge(finaldataset,groupby)
#     }
#     
#     
#   }
#   return(finaldataset)
#   #aggregate(cbind(Precedence.x,Duration.x/Duration.y)~Instance_uniqueID+job+machine,rest,sum)
# })
# 
# setMethodS3("addJoinFeatures","FeaturedElement", function(this,
#                                                           con,
#                                                           
#                                                           experimentID,
#                                                           thisGroupDependent,
#                                                           joinObjectDependent,
#                                                           joinGroupDependent,
#                                                           newGroupName,
#                                                           
#                                                           
#                                                           mainDataset,
#                                                           joinDataset,
#                                                           joinby,
#                                                           groupby,
#                                                           features = list(),
#                                                           ...) {
#   
#   
#   dependentObject <- eval(call(paste(joinObjectDependent,"FeaturedElement",sep="")))
#   
#   allfeatures <- dependentObject$getFeaturesFromGroup(con,dependentGroup)
#   
#   thisObject <- this$getObjectClassName()
#   thisTable <- paste(thisObject,"_",thisGroupDependent,sep="")  
#   
#   
#   
#   
#   dependentTable <- paste(joinObjectDependent,"_",joinGroupDependent,sep="")  
#   
#   
#   
#   sol <- dbGetQuery(con,"SELECT Instance_uniqueID FROM ",thisTable," t,",dependentTable," d WHERE t.Instance_uniqueID=d.Instance_uniqueID LIMIT 1")
#   
#   
#   
#   ui <- sol[1,"Instance_uniqueID"]
#   
#   
#   mainDataset <- dbGetQuery(con,paste("SELECT * FROM ",thisTable," WHERE Instance_uniqueID='",ui,"'",sep=""))
#   joinDataset <- dbGetQuery(con,paste("SELECT * FROM ",dependentTable," WHERE Instance_uniqueID='",ui,"'",sep=""))  
#   
#   
#   resultData <- this$calculateJoin(con,
#                                    mainDataset,
#                                    joinDataset,
#                                    joinby,
#                                    groupby,
#                                    features)
#   
#   newtableName <- paste(table,"_",newGroupName,sep="") 
#   
#   dbWriteTable(con,newtableName,resultData,row.names=FALSE)
#   
#   paste("Adding PKs...")
#   dbSendQuery(con,paste("ALTER TABLE `",newtableName,"` ADD PRIMARY KEY (`",paste(groupby,collapse="`,`"),"`)",sep=""))
#   
#   
#   DBobjGroup<-DBFeaturesGroups()
#   
#   DBobjGroup$attributes <- list(name = group,
#                                 object = this$getObjectClassName(),
#                                 dependentGroup = dependentGroup,
#                                 dependentObject = dependentObjectName,
#                                 groupBy= paste(groupby,collapse=","),
#                                 orderBy= paste(orderby,collapse=","),
#                                 type="Aggregation")
#   
#   
#   if(!DBobjGroup$existsByAttributes(con))
#   {
#     paste("Saving features groups..")
#     DBobjGroup$save(con)  
#     
#   }
#   
#   
#   place <- 1
#   
#   for(feat in names(features))
#   {
#     aggFunc <- usedFeatures[[feat]]
#     
#     for(agg in aggFunc)
#     {
#       
#       DBobjFeat <- DBFeatures()
#       
#       DBobjFeat$attributes <- list(name = paste(table,agg,"Of",feat,sep=""),
#                                    type=  "numeric",
#                                    FeaturesGroups_name=  group,
#                                    FeaturesGroups_object=  this$getObjectClassName(),
#                                    dependentColumn= feat,
#                                    aggregationFunction=agg,
#                                    tableOrder = place)
#       
#       
#       if(!DBobjFeat$existsByAttributes(con))
#       {
#         paste("Saving features..")
#         DBobjFeat$save(con)          
#         place <- place + 1
#       }
#       
#       
#     }
#     
#   }
#   
#   
#   
#   
#   exp <- ExperimentFramework()
#   exp$connectionDB <- con
#   exp$generateModels(file="./lib/MySQLInterface/DBModel.R")
#   
#   
#   
# })
# 
# setMethodS3("calculateJoin","FeaturedElement", function(this,
#                                                         con,
#                                                         mainDataset,
#                                                         joinDataset,
#                                                         joinby,
#                                                         groupby,
#                                                         features = list(),
#                                                         ...) {
#   
#   
#   finaldataset <- mainDataset[,groupby]
#   
#   mergedataset<-merge(mainDataset,joinDataset,by=joinby,suffixes = c("",""),all.x=TRUE)
#   
#   
#   
#   attach(mergedataset,name="calculateSubset")
# 
# 
#   
#   
#   
#   for(featName in names(features))
#   {
#     formu <- features[[featName]]
#     
#     mergedataset[,featName] <- formu
#     
#     
#   }
#   
#   detach(mergedataset,name="calculateSubset")
#   #finaldataset[is.na(finaldataset)] <- defaultValue
#   
#   return(mergedataset)
# })
# 
# 
# 
# 
# 
# setMethodS3("calculateSubset","FeaturedElement", function(this,
#                                                           con,
#                                                           dataset,
#                                                           joinby,
#                                                           groupby,
#                                                           suffix="",
#                                                           restriction = NULL,
#                                                           features = list(),
#                                                           defaultValue = 0,
#                                                           
#                                                           ...) {
#   
#   
#   finaldataset <- dataset[,groupby]
#   
#   mergedataset<-merge(dataset,dataset,by=joinby,suffixes = c("","_subset"))
#   
#   attach(mergedataset,name="calculateJoin")
#   restrictedmergedataset <- mergedataset[restriction,]
#   detach(mergedataset,name="calculateJoin")
#   
#   
#   
#   for(featName in names(features))
#   {
#     aggregators <- features[[featName]]
#     
#     for(aggFunc in aggregators)
#     {
#       
#       agg <- aggregate(as.formula(paste(featName,"~",paste(groupby,collapse="+"))),data=restrictedmergedataset,aggFunc)
#       
#       aggNames <- dimnames(agg)[[2]]
#       featIndex <- which(setdiff(aggNames,groupby)==aggNames)
#       aggNames[featIndex] <- paste(aggFunc,"Of",unlist(strsplit(featName,"_subset")),suffix,sep="")
#       dimnames(agg)[[2]] <- aggNames
#       
#       
#       finaldataset <- merge(finaldataset,agg,all.x=TRUE)
#     }
#  
#   }
#   
#   finaldataset[is.na(finaldataset)] <- defaultValue
#   
#   
#   return(finaldataset)
#   #aggregate(cbind(Precedence.x,Duration.x/Duration.y)~Instance_uniqueID+job+machine,rest,sum)
# })
# 
# 
# setMethodS3("calculateAggregation","FeaturedElement", function(this,
#                                                           con,
#                                                           dataset,
#                                                           groupby,  
#                                                           features = list(),
#                                                           defaultValue = 0,
#                                                                suffix="",
#                                                           
#                                                           ...) {
#   
#   
#   allData <- NULL
#   
#   for(featIndex in 1:length(features))
#   {
#     featElmts <- features[[featIndex]] 
#     
#     fieldName <- featElmt[["name"]] 
#     aggFunc <- featElmt[["aggregators"]]
#     
#     
#     for(agg in aggFunc)
#     {
#             
#       featName <- paste(suffix,agg,"Of",feat,sep="")
#       
#       newdata <- aggregate(as.formula(paste(feat,"~",paste(groupby,collapse="+"))),data=sol,agg)
#       
#       aggindex <- which(setdiff(dimnames(newdata)[[2]],groupby) == dimnames(newdata)[[2]])
#       dimnames(newdata)[[2]][aggindex] <- name
#       
#       if(is.null(allData))
#       {
#         allData <- newdata
#       }
#       else
#       {
#         allData <- merge(allData,newdata,by=groupby)     
#       }
#       
#       
#     }
#   }
#   
# })
# 
# setMethodS3("addJoinFeaturesInDB","FeaturedElement", function(this,
#                                                               con,
#                                                               dependentGroup,
#                                                               dependentObjectName,
#                                                               joinby,
#                                                               groupby,
#                                                               restrictions = NULL,
#                                                               
#                                                               
#                                                               features = list(),
#                                                               addRestFeatures = TRUE,
#                                                               aggFunctionsRestFeatures = c("Avg","Sum"),
#                                                               ## list(featureOfDependent = c(Aggregation Functions))
#                                                               
#                                                               
#                                                               nrRestrictionLimit = 100,
#                                                               newGroupName =  paste("AggOf",dependentGroup,sep=""),
#                                                               orderby = NULL,
#                                                               ...) {
#   
#   dependentObject <- eval(call(paste(dependentObjectName,"FeaturedElement",sep="")))
#   dependentObjectTable <- dependentObject$calculateFeaturesTableName(dependentGroup)
#   
#   joinFirst <- paste("first.",joinby,sep="")
#   joinSecond <- paste("second.",joinby,sep="")  
#   
#   joinString <- paste(paste(joinFirst,joinSecond,sep="="),collapse=" AND ")
#   
#   #"SELECT first.*,sum(second.Duration)-first.Duration FROM ",dependentObjectTable," first,",dependentObjectTable," second WHERE ",joinString," AND first.precedence <= second.precedence GROUP BY first.Instance_uniqueID,first.machine,first.job"
#   
#   
#   
# })
# 
# 
# 
# 
# 
# 
# setMethodS3("addAggregationFeaturesInDBNew","FeaturedElement", function(this,
#                                                                      con,
#                                                                      dependentGroup,
#                                                                      dependentObjectName,
#                                                                      groupby,
#                                                                      features = list(),
#                                                                      addRestFeatures = TRUE,
#                                                                      aggFunctionsRestFeatures = c("mean","sum"),
#                                                                      ## list(featureOfDependent = c(Aggregation Functions))
#                                                                      
#                                                                      
#                                                                      nrRestrictionLimit = 100,
#                                                                      newGroupName =  paste("AggOf",dependentGroup,sep=""),
#                                                                      orderby = NULL,
#                                                                      ...) {
#   
#   dependentObject <- eval(call(paste(dependentObjectName,"FeaturedElement",sep="")))
#   
#   allfeatures <- dependentObject$getFeaturesFromGroup(con,dependentGroup)
#   
#   table <- this$getObjectClassName()
#   group <- newGroupName
#   newtableName <- paste(table,"_",group,sep="")  
#   
#   select <- NULL
#   
#   usedFeatures <- list()
#   
#   if(addRestFeatures)
#   {
#     missingAggFunctionsFeatures <- setdiff(allfeatures,names(features))
#     
#     if(length(missingAggFunctionsFeatures)>0)
#     {
#       for(feat in missingAggFunctionsFeatures)
#       {
#         for(agg in aggFunctionsRestFeatures)
#         {
#           
#           select <- c(select,feat)
#           usedFeatures[[feat]] <- c(usedFeatures[[feat]],agg)
#         }
#         
#       }
#     }
#   }
#   
#   for(feat in names(features))
#   {
#     aggFunc <- features[[feat]]
#     
#     for(agg in aggFunc)
#     {
#       select <- c(select,paste(agg,feat))
#       usedFeatures[[feat]] <- c(usedFeatures[[feat]],agg)
#     }   
#     
#   }
#   
#   dependentObjectTable <- dependentObject$calculateFeaturesTableName(dependentGroup)
#   tmpDependentObjectTable <- paste("tmp_",dependentObjectTable,sep="")
#   
#   dbSendQuery(con,paste("DROP TEMPORARY TABLE IF EXISTS",tmpDependentObjectTable))
#   concatgroupby <- paste(paste("cast(",groupby," as CHAR)",sep=""),collapse=",")
#   
#   queryTmpTable  <- paste("CREATE TABLE ",tmpDependentObjectTable," SELECT DISTINCT ",orderby," AS target FROM ",dependentObjectTable,sep="")
#   
# #   if(!is.null(orderby))
# #   {
# #     queryTmpTable  <- paste(queryTmpTable," ORDER BY ",paste(orderby,collapse=","),sep="")
# #   }
# #   
#   queryTmpTable  <- paste(queryTmpTable," LIMIT ",nrRestrictionLimit,sep="")
#   
#   
#   ##  queryTmpTable  <- paste("CREATE TEMPORARY TABLE ",tmpDependentObjectTable," SELECT DISTINCT ",groupRestrictionLimit," FROM ",dependentObjectTable," LIMIT ", nrRestrictionLimit ,sep="")
#   
#   dbSendQuery(con,queryTmpTable)
#   
#   ###############3new part##############3333
#   selectQuery <-paste("SELECT ",paste(groupby,collapse=","),",",paste(unique(select),collapse=",")," FROM ",dependentObjectTable," t RIGHT JOIN ",tmpDependentObjectTable," tmp ON t.",orderby,"=tmp.target",sep="")
#   
#   #query <- paste("INSERT INTO ",newtableName,selectQuery) 
#   
#   sol <- dbGetQuery(con,selectQuery)
#   
#   
# 
#   
#   dbWriteTable(con,newtableName,allData,row.names=FALSE)
#   
#   ###############################3333
# #   selectQuery <-paste("SELECT ",paste(groupby,collapse=","),",",paste(select,collapse=",")," FROM ",dependentObjectTable," WHERE CONCAT(",concatgroupby,")  IN (SELECT id FROM ",tmpDependentObjectTable,") GROUP BY ",paste(groupby,collapse=","),sep="")
# #   
# #   ##selectQuery <-paste("SELECT ",paste(groupby,collapse=","),",",paste(select,collapse=",")," FROM ",dependentObjectTable," WHERE ",groupRestrictionLimit," IN (SELECT ",groupRestrictionLimit," FROM ",tmpDependentObjectTable,") GROUP BY ",paste(groupby,collapse=","))
# #   paste("Creating table...")
# #   query  <- paste("CREATE TABLE ",newtableName,selectQuery)
# #   
# #   
# #   dbSendQuery(con,query)
#   paste("Adding PKs...")
#   dbSendQuery(con,paste("ALTER TABLE `",newtableName,"` ADD PRIMARY KEY (`",paste(groupby,collapse="`,`"),"`)",sep=""))
#   
#   
#   DBobjGroup<-DBFeaturesGroups()
#   
#   DBobjGroup$attributes <- list(name = group,
#                                 object = this$getObjectClassName(),
#                                 dependentGroup = dependentGroup,
#                                 dependentObject = dependentObjectName,
#                                 groupBy= paste(groupby,collapse=","),
#                                 orderBy= paste(orderby,collapse=","),
#                                 type="Aggregation")
#   
#   
#   if(!DBobjGroup$existsByAttributes(con))
#   {
#     paste("Saving features groups..")
#     DBobjGroup$save(con)  
#     
#   }
#   
#   
#   place <- 1
#   
#   for(feat in names(usedFeatures))
#   {
#     aggFunc <- usedFeatures[[feat]]
#     
#     for(agg in aggFunc)
#     {
#       
#       DBobjFeat <- DBFeatures()
#       
#       DBobjFeat$attributes <- list(name = paste(table,agg,"Of",feat,sep=""),
#                                    type=  "numeric",
#                                    FeaturesGroups_name=  group,
#                                    FeaturesGroups_object=	this$getObjectClassName(),
#                                    dependentColumn= feat,
#                                    aggregationFunction=agg,
#                                    tableOrder = place)
#       
#       
#       if(!DBobjFeat$existsByAttributes(con))
#       {
#         paste("Saving features..")
#         DBobjFeat$save(con)          
#         place <- place + 1
#       }
#       
#       
#     }
#     
#   }
#   
#   
#   
#   
#   exp <- ExperimentFramework()
#   exp$connectionDB <- con
#   exp$generateModels(file="./lib/MySQLInterface/DBModel.R")
#   
#   
#   
# })

# 
# setMethodS3("addAggregationFeaturesInDB","FeaturedElement", function(this,
#                                                                      con,
#                                                                      dependentGroup,
#                                                                      dependentObjectName,
#                                                                      groupby,
#                                                                      features = list(),
#                                                                      addRestFeatures = TRUE,
#                                                                      aggFunctionsRestFeatures = c("Avg","Sum"),
#                                                                      ## list(featureOfDependent = c(Aggregation Functions))
#                                                                      
#                                                                      
#                                                                      nrRestrictionLimit = 100,
#                                                                      newGroupName =  paste("AggOf",dependentGroup,sep=""),
#                                                                      orderby = NULL,
#                                                                      ...) {
# 
#   dependentObject <- eval(call(paste(dependentObjectName,"FeaturedElement",sep="")))
# 
#   allfeatures <- dependentObject$getFeaturesFromGroup(con,dependentGroup)
# 
#   table <- this$getObjectClassName()
#   group <- newGroupName
#   newtableName <- paste(table,"_",group,sep="")  
#   
#   select <- NULL
#   
#   usedFeatures <- list()
#   
#   if(addRestFeatures)
#   {
#     missingAggFunctionsFeatures <- setdiff(allfeatures,names(features))
#     
#     if(length(missingAggFunctionsFeatures)>0)
#     {
#       for(feat in missingAggFunctionsFeatures)
#       {
#         for(agg in aggFunctionsRestFeatures)
#         {
#           
#           select <- c(select,paste(agg,"(",feat,") AS ",table,agg,"Of",feat,sep=""))
#           usedFeatures[[feat]] <- c(usedFeatures[[feat]],agg)
#         }
#         
#       }
#     }
#   }
#   
#   for(feat in names(features))
#   {
#     aggFunc <- features[[feat]]
#     
#     for(agg in aggFunc)
#     {
#       select <- c(select,paste(agg,"(",feat,") AS ",table,agg,"Of",feat,sep=""))
#       usedFeatures[[feat]] <- c(usedFeatures[[feat]],agg)
#     }   
#     
#   }
#     
#   dependentObjectTable <- dependentObject$calculateFeaturesTableName(dependentGroup)
#   tmpDependentObjectTable <- paste("tmp_",dependentObjectTable,sep="")
#   
#   dbSendQuery(con,paste("DROP TEMPORARY TABLE IF EXISTS",tmpDependentObjectTable))
#   concatgroupby <- paste(paste("cast(",groupby," as CHAR)",sep=""),collapse=",")
#   
#   queryTmpTable  <- paste("CREATE TEMPORARY TABLE ",tmpDependentObjectTable," SELECT DISTINCT CONCAT(",concatgroupby,") AS id FROM ",dependentObjectTable,sep="")
#   
#   if(!is.null(orderby))
#   {
#     queryTmpTable  <- paste(queryTmpTable," ORDER BY ",paste(orderby,collapse=","),sep="")
#   }
#   
#   queryTmpTable  <- paste(queryTmpTable," LIMIT ",nrRestrictionLimit,sep="")
#   
# 
# ##  queryTmpTable  <- paste("CREATE TEMPORARY TABLE ",tmpDependentObjectTable," SELECT DISTINCT ",groupRestrictionLimit," FROM ",dependentObjectTable," LIMIT ", nrRestrictionLimit ,sep="")
#  
#   dbSendQuery(con,queryTmpTable)
#   
#   selectQuery <-paste("SELECT ",paste(groupby,collapse=","),",",paste(select,collapse=",")," FROM ",dependentObjectTable," WHERE CONCAT(",concatgroupby,")  IN (SELECT id FROM ",tmpDependentObjectTable,") GROUP BY ",paste(groupby,collapse=","),sep="")
#   
#   ##selectQuery <-paste("SELECT ",paste(groupby,collapse=","),",",paste(select,collapse=",")," FROM ",dependentObjectTable," WHERE ",groupRestrictionLimit," IN (SELECT ",groupRestrictionLimit," FROM ",tmpDependentObjectTable,") GROUP BY ",paste(groupby,collapse=","))
# paste("Creating table...")
#   query  <- paste("CREATE TABLE ",newtableName,selectQuery)
#  
# 
#   dbSendQuery(con,query)
#   paste("Adding PKs...")
#   dbSendQuery(con,paste("ALTER TABLE `",newtableName,"` ADD PRIMARY KEY (`",paste(groupby,collapse="`,`"),"`)",sep=""))
#   
#   
#   DBobjGroup<-DBFeaturesGroups()
#   
#   DBobjGroup$attributes <- list(name = group,
#                                 object = this$getObjectClassName(),
#                                 dependentGroup = dependentGroup,
#                                 dependentObject = dependentObjectName,
#                                 groupBy= paste(groupby,collapse=","),
#                                 orderBy= paste(orderby,collapse=","),
#                                 type="Aggregation")
#   
# 
#   if(!DBobjGroup$existsByAttributes(con))
#   {
#     paste("Saving features groups..")
#     DBobjGroup$save(con)  
#     
#   }
#   
#   
#   place <- 1
#   
#   for(feat in names(usedFeatures))
#   {
#     aggFunc <- usedFeatures[[feat]]
#     
#     for(agg in aggFunc)
#     {
#       
#       DBobjFeat <- DBFeatures()
#       
#       DBobjFeat$attributes <- list(name = paste(table,agg,"Of",feat,sep=""),
#                                    type=  "numeric",
#                                    FeaturesGroups_name=	group,
#                                    FeaturesGroups_object=	this$getObjectClassName(),
#                                    dependentColumn= feat,
#                                    aggregationFunction=agg,
#                                    tableOrder = place)
#       
#       
#       if(!DBobjFeat$existsByAttributes(con))
#       {
#         paste("Saving features..")
#         DBobjFeat$save(con)          
#         place <- place + 1
#       }
#       
#       
#     }
#     
#   }
#   
#   
#   
#   
#   exp <- ExperimentFramework()
#   exp$connectionDB <- con
#   exp$generateModels(file="./lib/MySQLInterface/DBModel.R")
#   
#   
#   
# })

setMethodS3("getAllDataset","FeaturedElement", function(this,
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


setMethodS3("calculateFeaturesTableName","FeaturedElement", function(this,
                                                               group,
                                                             ...) {  

  result <- this$featuresTableName 
  obj <- this$object
  
  
  if(is.null(result))
  {
    result <- class(obj)[1]    
  }
  
  final <- paste(result,"_",group,sep="")
  
  
  return(final)  
})

setMethodS3("getObjectClassName","FeaturedElement", function(this,
                                                             ...) {  
  result <- class(this$object)[1]
  return(result)  
})

setMethodS3("getObjectTableName","FeaturedElement", function(this,
                                                             ...) {  
  obj <- this$object

  result <- obj$getMainTable()

  
  return(result)  
})

setMethodS3("addTargetsInDB","FeaturedElement", function(this,
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

setMethodS3("cleanValuesFeaturesInDB","FeaturedElement", function(this,
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


setMethodS3("deleteFeaturesInDB","FeaturedElement", function(this,
                                                             con,
                                                             groups,
                                                             ...) {
  
  
  for(group in groups)
  {    
    featObj <- DBFeatures()
    
    featObj$attributes <- list("FeaturesGroups_name" = group,
                               "FeaturesGroups_object" = this$getObjectClassName())
    
    allfeat <- featObj$getAllByAttributes(con)
    
    query5 <- paste("DROP TABLE ",this$calculateFeaturesTableName(group))
    
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



setMethodS3("getFeaturesFromGroup","FeaturedElement", function(this,
                                                                con,
                                                                group,
                                                                ...) {
  
  
  query <- sprintf("SELECT * FROM Features WHERE FeaturesGroups_object = '%s'",
                   this$getObjectClassName())
  
  

    query <- paste(query," AND FeaturesGroups_name LIKE '",group,"'",sep="")
  
  
  
  
  sol <- dbGetQuery(con,query)
  
  return(unique(sol[,"name"]))
  
})

setMethodS3("getGroupsFromFeatures","FeaturedElement", function(this,
                                                                   con,
                                                                   features = NULL,
                                                                   ...) {

  
  featStg <- paste(features,collapse="','")
    
  
  query <- sprintf("SELECT * FROM Features WHERE FeaturesGroups_object = '%s'",
                   this$getObjectClassName())
  
  
  if(length(features)>0)
  {
    query <- paste(query," AND name IN ('",featStg,"')",sep="")
  }
  
  
  
  sol <- dbGetQuery(con,query)
  
  return(unique(sol[,"FeaturesGroups_name"]))
  
})


setMethodS3("addFeaturesInDB","FeaturedElement", function(this,
                                                      con,
                                                      groups,
                                                      ...) {
  
  
   table <- this$getObjectTableName()
# 
#   
#   query <- paste("SELECT uniqueID FROM ",table, " LIMIT 1")
#   
#   querysolution <- dbGetQuery(con,query)
#   
#  
#   
#   print("Obtaining object...")
# 
#   this$DBgetByObjectUniqueID(querysolution[1,"uniqueID"],con) 
#    
  
  this$DBgetRandomObject(con) 
  
  for(group in groups)
  {

    DBobjGroup<-DBFeaturesGroups()
    
    DBobjGroup$attributes <- list(name = group,
                                   object = this$getObjectClassName())
    

    if(!DBobjGroup$existsByAttributes(con))
    {
      DBobjGroup$save(con)  
          
    }
    
    tableFeat <- this$calculateFeaturesTableName(group)
  
    print("Creating group table...")

    queryPK <- paste("SHOW KEYS FROM ",table," WHERE Key_name = 'PRIMARY'")
    solPK <- dbGetQuery(con,queryPK)
    

    
    queryCreateTable <- paste("CREATE TABLE ",tableFeat," (SELECT * ,'None' AS status FROM ",table,")",sep="")
    dbSendQuery(con,queryCreateTable)
    
    dbSendQuery(con,paste("ALTER TABLE `",tableFeat,"` CHANGE COLUMN `status` `status` VARCHAR(20) CHARACTER SET 'latin1' NOT NULL DEFAULT ''",sep=""))

    dbSendQuery(con,paste("ALTER TABLE `",tableFeat,"` ADD PRIMARY KEY (`",paste(solPK[,"Column_name"],collapse="`,`"),"`)",sep=""))
   
    
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
                    typeVar <- "double"
                  }
                  print("Creating features field...")
                  dbGetQuery(con,paste("ALTER TABLE `",tableFeat,"` ADD COLUMN `",feat,"` ",typeVar," NULL",sep=""))
                  
                  
                }
        
      }

      
      
      
    }

    
    
  }
   
   exp <- ExperimentFramework()
   exp$connectionDB <- con
   exp$generateModels(file="./lib/MySQLInterface/DBModel.R")
})

# setMethodS3("addFeaturesInDB","FeaturedElement", function(this,
#                                                       con,
#                                                       features,
#                                                       group,
#                                                       ...) {
#   
# 
#   for(feat in 1:length(features))
#   {
#     DBobj1<-DBFeatures()
# 
#     DBobj1$attributes<-list(name = names(features)[feat],
#                              type = features[feat],
#                              group = group,
#                              object = this$getObjectClassName())
#       
# 
#     DBobj1$save(con)
#   }
#   
#   
# })
# 
# setMethodS3("getTargetsTableName","FeaturedElement", function(this,...) {
#   objString <- this$getObjectTableName()
#   return(objString)
# })
# 
# setMethodS3("calculateFeaturesTableName","FeaturedElement", function(this,...) {
#   objString <- this$getObjectTableName()
#   return(objString)
# })

setMethodS3("calculateTargets","FeaturedElement", function(this,
                                                            con = NULL,                                                            
                                                            ...) {
  
  targ <- this$targets(con)
  this$targets <- targ
  
  
})

setMethodS3("calculateFeatures","FeaturedElement", function(this,
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


setMethodS3("DBsaveTargets","FeaturedElement", function(this,                                                
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


setMethodS3("DBsaveFeatures","FeaturedElement", function(this,                                                
                                                         con,
                                                         ...) {
  
  obj <- this$object
  
  feats <- this$features

  groups <- this$getGroupsFromFeatures(con,names(this$features))

  
  ## save features
  
  for(group in groups)
  {
    featNames <- this$getFeaturesFromGroup(con,group)
    objString <- paste("DB",  this$calculateFeaturesTableName(group),sep="") 
    
    DBobj2 <- eval(call(objString))
    
    DBobj2$attributes <- obj$pks


    DBobj2$getByAttributes(con)
    

    DBobj2$attributes[["status"]] <- "Done"
    
 
    for(featName in names(feats))
    {
      DBobj2$attributes[[featName]] <- feats[featName]
      
    }
    DBobj2$save(con)      
    
  }
  
  
  ##}   
  
})


setMethodS3("DBgetRandomObject","FeaturedElement", function(this,
                                                            con,...) {
  
  
  obj <-this$object
  
  obj$getDBMainObject(con=con)  
  obj$constructObjectFromDBMainObject(con)
  
  this$object <- obj
  
})

setMethodS3("DBgetObjectUsingMainValues","FeaturedElement", function(this,
                                                        values,
                                                        con,...) {
  
  
  obj <-this$object

  obj$getDBMainObject(values=values,con=con)  

  obj$constructObjectFromDBMainObject(con)

  this$object <- obj
  
})


setMethodS3("DBgetByObjectUniqueID","FeaturedElement", function(this,
                                                                uniqueID = NULL,
                                                                con=NULL,...) {
  

  obj <-this$object
  

  obj$DBgetByUniqueID(uniqueID,con)

  this$object <- obj
 
  ##get features values
#   objclass <- this$getObjectTableName()
# 
#   objString <- paste("DB",objclass,sep="") 
# 
# 
#   DBobj<- eval(call(objString))
#   
#   if(!is.null(uniqueID))
#   {
#     DBobj$attributes[["uniqueID"]] <- uniqueID   
#   }
#   
#  
#   DBobj$getByAttributes(con) 
#     
#   attrib <- DBobj$attributes
#    uniqueID <- DBobj$attributes[["uniqueID"]]  
# 
#   this$features <- attrib[which(names(attrib) != "uniqueID")]
# 
#  
#   ##get targets values
#   targets <- list()
# 
#   objclass <- this$getObjectTableName()
#   
#   objString <- paste("DB",objclass,sep="") 
#   
#   
#   DBobj<- eval(call(objString))
# 
#   DBobj$attributes[["uniqueID"]] <- uniqueID
#   DBobj$getByAttributes(con) 
#   
#   attrib <- DBobj$attributes
#   
#   
#   this$targets <- attrib[which(names(attrib) != "uniqueID")]
  
  
})

