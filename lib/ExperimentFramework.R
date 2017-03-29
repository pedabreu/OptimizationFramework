
setConstructorS3("ExperimentFramework",function()
{
  extend(DBConnection(),"ExperimentFramework",
         id = paste(format(Sys.time(), "%y%m%d%H%M%S"),
                    paste(sample(c(0:9, letters, LETTERS))[1:6],collapse=""),sep=""))
  
})



setMethodS3("cleanFeaturesExperimentObjects","ExperimentFramework", 
            function(this,                   
                     ...) {
              
              con <- this$connectionDB    
             
              query1 <- "DELETE FROM FeatureExperimentObjects WHERE status='Finished'"
              dbSendQuery(con,query1)
              
              query2 <- "UPDATE FeatureExperimentObjects SET status='None' WHERE status <> 'None'"
              dbSendQuery(con,query2)  
              
              
              
            })

setMethodS3("cleanRuns","ExperimentFramework", 
            function(this,                   
                     ...) {
              
              con <- this$connectionDB    
                        
              query2 <- "UPDATE Run SET status='None' WHERE status <> 'Finished'"
              dbSendQuery(con,query2)  
              
              
              
            })
# 
# 
# 
# setMethodS3("writeILPComponentData_new","ExperimentFramework", 
#             function(this,
#                      featureTable,
#                      component,
#                      allValuesSelectFunction,
#                      path,
#                      debug = FALSE,
#                      modeRecall = "*",
#                      ...)
#             { 
#               print(paste("Writing ",component," Data..."))
#               
#               fileInstanceBKName <- NULL
#               fileAuxBKName <- NULL
#               
#               ui <- "Instance_uniqueID"
#               uis <- c("Instance_uniqueID","Machine","Job","id")
#               
#               
#               
#               allDomainValues <- list()
#               
#               if(!is.null(featureTable))
#               {
#                 predicate <- paste(component,"Features",sep="")
#                 
#                 fileInstanceBKName <- paste(predicate,".b",sep="")
#                 fileAuxBKName <- paste(predicate,"Aux.b",sep="")  
#                 
#                 
#                 fileInstanceBK <- paste(path,fileInstanceBKName,sep="")
#                 fileAuxBK <- paste(path,fileAuxBKName,sep="")  
#                 
#                 features <- setdiff(colnames(featureTable),uis)
#                
#                 
#                 if(debug)
#                 {
#                   features <- features[1:2]
#                 }
#                 
#                 
#                 if(file.exists(fileInstanceBK))
#                   file.remove(fileInstanceBK)
#                 
#                 if(file.exists(fileAuxBK))
#                   file.remove(fileAuxBK)
#                 
#                 
#                 
#                 for(featIndex in 1:length(features))
#                 {
#                   featName <- features[featIndex]
#                   v <- rep("_",length(features))
#                   v[featIndex] <- "X"
#                   
#                   if(is.null(allValuesSelectFunction[[featName]]))
#                   {
#                     valuesSelectFunction <- allValuesSelectFunction[["default"]]                         
#                   }
#                   else
#                   {
#                     valuesSelectFunction <- allValuesSelectFunction[[featName]]  
#                   }
#                   
#                   selectValues <- unique(eval(call(valuesSelectFunction,featureTable[,featName])))
#                   allDomainValues[[featName]] <- selectValues
#                   
#                   stg1 <- paste(component,"LowerEqual(Uniqueid,'",featName,"',Y,PercentilIndex,NrDomains):-",predicate,"(Uniqueid,",paste(v,collapse=","),"),number(X),",component,featName,"Domain(Y,PercentilIndex,NrDomains), number(Y),X =< Y." ,sep=""  )   
#                   
#                   write(stg1,file=fileInstanceBK,append=TRUE)                
#                   stg1 <- paste(component,"LowerEqual(Uniqueid,'",featName,"',Y,0,",length(selectValues),"):-",predicate,"(Uniqueid,",paste(v,collapse=","),"),var(Y),!,X = Y." ,sep=""  )   
#                   
#                   write(stg1,file=fileInstanceBK,append=TRUE)
#                   
#                   
#                   stg2 <- paste(component,"HigherEqual(Uniqueid,'",featName,"',Y,PercentilIndex,NrDomains):-",predicate,"(Uniqueid,",paste(v,collapse=","),"),",component,featName,"Domain(Y,PercentilIndex,NrDomains), number(Y),X >= Y." ,sep=""  )   
#                   
#                   write(stg2,file=fileInstanceBK,append=TRUE)
#                   
#                   
#                   stg2 <- paste(component,"HigherEqual(Uniqueid,'",featName,"',Y,0,",length(selectValues),"):-",predicate,"(Uniqueid,",paste(v,collapse=","),"),var(Y),X = Y." ,sep=""  )   
#                   
#                   write(stg2,file=fileInstanceBK,append=TRUE)
#                   
#                   
#                   
#                   
#                   allvaluesStg <- paste(component,featName,"Domain(",selectValues,",",1:length(selectValues),",",length(selectValues),").",sep="")
#                   write(allvaluesStg,file=fileInstanceBK,append=TRUE)   
#                 }
#                 
#                 apply(featureTable,1,function(x)
#                 {  
#                   stg <- paste(predicate,"(",x["id"],",",paste(x[features],collapse=","),").",sep="")
#                   write(stg,file=fileInstanceBK,append=TRUE)
#                 })
#                 
#                 
#                 stgDetermination <-  paste(":- determination(instanceJSS/1,",component,"LowerEqual/5).",sep="")
#                 write(stgDetermination,file=fileAuxBK,append=TRUE)
#                 
#                 stgDetermination <-  paste(":- determination(instanceJSS/1,",component,"HigherEqual/5).",sep="")
#                 write(stgDetermination,file=fileAuxBK,append=TRUE)
#                 
#                 #               stgDetermination <-  paste(":- determination(instance/1,",tolower(features),"domain/1).",sep="")
#                 #               write(stgDetermination,file=fileAuxBK,append=TRUE)             
#                 
#                 stgModeb <-  paste(":- modeb(",modeRecall,",",component,"LowerEqual(+",component,"JSSID,#featureName,#",component,"domain,#",component,"PercentilIndex,#",component,"TotalValues)).",sep="")    
#                 write(stgModeb,file=fileAuxBK,append=TRUE)
#                 
#                 stgModeb <-  paste(":- modeb(",modeRecall,",",component,"HigherEqual(+",component,"JSSID,#featureName,#",component,"domain,#",component,"PercentilIndex,#",component,"TotalValues)).",sep="")    
#                 write(stgModeb,file=fileAuxBK,append=TRUE)    
#               }
# 
# 
# 
#               return(list("files" = c(fileInstanceBKName,fileAuxBKName),
#                           "domainValues" = allDomainValues))
# 
#             })
# 
# 
# 
# setMethodS3("writeILPComponentData","ExperimentFramework", 
#             function(this,
#                      featureTable,
#                      component,
#                      allValuesSelectFunction,
#                      path,
#                      debug = FALSE,
#                      modeRecall = "*",
#                      ...)
#             { 
#               print(paste("Writing ",component," Data..."))
#               
#               fileInstanceBKName <- NULL
#               fileAuxBKName <- NULL
#               
#               ui <- "Instance_uniqueID"
#               uis <- c("Instance_uniqueID","Machine","Job","id")
#               
#               
#               
#               allDomainValues <- list()
#               
#               if(!is.null(featureTable))
#               {
#                 predicate <- paste(component,"Features",sep="")
#                 
#                 fileInstanceBKName <- paste(predicate,".b",sep="")
#                 fileAuxBKName <- paste(predicate,"Aux.b",sep="")  
#                 
#                 
#                 fileInstanceBK <- paste(path,fileInstanceBKName,sep="")
#                 fileAuxBK <- paste(path,fileAuxBKName,sep="")  
#                 
#                 features <- setdiff(colnames(featureTable),uis)
#                 
#                 
#                 if(debug)
#                 {
#                   features <- features[1:2]
#                 }
#                 
#                 
#                 if(file.exists(fileInstanceBK))
#                   file.remove(fileInstanceBK)
#                 
#                 if(file.exists(fileAuxBK))
#                   file.remove(fileAuxBK)
#                 
#                 
#                 
#                 for(featIndex in 1:length(features))
#                 {
#                   featName <- features[featIndex]
#                   v <- rep("_",length(features))
#                   v[featIndex] <- "X"
#                   
#                   if(is.null(allValuesSelectFunction[[featName]]))
#                   {
#                     valuesSelectFunction <- allValuesSelectFunction[["default"]]                         
#                   }
#                   else
#                   {
#                     valuesSelectFunction <- allValuesSelectFunction[[featName]]  
#                   }
#                   
#                   selectValues <- unique(eval(call(valuesSelectFunction,featureTable[,featName])))
#                   allDomainValues[[featName]] <- selectValues
#                   
#                   stg1 <- paste(component,"LowerEqual",featName,"(Uniqueid,Y,PercentilIndex,NrDomains):-",predicate,"(Uniqueid,",paste(v,collapse=","),"),number(X),",component,featName,"Domain(Y,PercentilIndex,NrDomains), number(Y),X =< Y." ,sep=""  )   
#                   
#                   write(stg1,file=fileInstanceBK,append=TRUE)                
#                   stg1 <- paste(component,"LowerEqual",featName,"(Uniqueid,Y,0,",length(selectValues),"):-",predicate,"(Uniqueid,",paste(v,collapse=","),"),var(Y),!,X = Y." ,sep=""  )   
#                   
#                   write(stg1,file=fileInstanceBK,append=TRUE)
#                   
#                   
#                   stg2 <- paste(component,"HigherEqual",featName,"(Uniqueid,Y,PercentilIndex,NrDomains):-",predicate,"(Uniqueid,",paste(v,collapse=","),"),",component,featName,"Domain(Y,PercentilIndex,NrDomains), number(Y),X >= Y." ,sep=""  )   
#                   
#                   write(stg2,file=fileInstanceBK,append=TRUE)
#                   
#                   
#                   stg2 <- paste(component,"HigherEqual",featName,"(Uniqueid,Y,0,",length(selectValues),"):-",predicate,"(Uniqueid,",paste(v,collapse=","),"),var(Y),X = Y." ,sep=""  )   
#                   
#                   write(stg2,file=fileInstanceBK,append=TRUE)
#                   
#                   
#                   
#                   
#                   allvaluesStg <- paste(component,featName,"Domain(",selectValues,",",1:length(selectValues),",",length(selectValues),").",sep="")
#                   write(allvaluesStg,file=fileInstanceBK,append=TRUE)   
#                 }
#                 
#                 apply(featureTable,1,function(x)
#                 {  
#                   stg <- paste(predicate,"(",x["id"],",",paste(x[features],collapse=","),").",sep="")
#                   write(stg,file=fileInstanceBK,append=TRUE)
#                 })
#                 
#                 
#                 stgDetermination <-  paste(":- determination(instanceJSS/1,",component,"LowerEqual",features,"/4).",sep="")
#                 write(stgDetermination,file=fileAuxBK,append=TRUE)
#                 
#                 stgDetermination <-  paste(":- determination(instanceJSS/1,",component,"HigherEqual",features,"/4).",sep="")
#                 write(stgDetermination,file=fileAuxBK,append=TRUE)
#                 
#                 #               stgDetermination <-  paste(":- determination(instance/1,",tolower(features),"domain/1).",sep="")
#                 #               write(stgDetermination,file=fileAuxBK,append=TRUE)             
#                 
#                 stgModeb <-  paste(":- modeb(",modeRecall,",",component,"LowerEqual",features,"(+",component,"JSSID,#",component,features,"domain,#",component,features,"PercentilIndex,#",component,features,"TotalValues)).",sep="")    
#                 write(stgModeb,file=fileAuxBK,append=TRUE)
#                 
#                 stgModeb <-  paste(":- modeb(",modeRecall,",",component,"HigherEqual",features,"(+",component,"JSSID,#",component,features,"domain,#",component,features,"PercentilIndex,#",component,features,"TotalValues)).",sep="")    
#                 write(stgModeb,file=fileAuxBK,append=TRUE)    
#               }
#               
#               
#               
#               return(list("files" = c(fileInstanceBKName,fileAuxBKName),
#                           "domainValues" = allDomainValues))
#               
#             })


# 
# setMethodS3("generateILPComponentData_original","ExperimentFramework", 
#             function(this,
#                      target,
#                      experimentName = NULL,
#                      kfoldcrossvalidation = NA,
#                      instanceFeatureTableName = NA,
#                      machineFeatureTableName = NA,
#                      jobFeatureTableName = NA,
#                      operationFeatureTableName = NA,
#                      positiveValue = "LPT",
#                      negativeValue = NA,
#                      modeRecall= "*",
#                      instanceValuesSelectFunction = list("default" = function(x){unique(x)}),
#                      machineValuesSelectFunction = list("default" = function(x){unique(x)}),
#                      jobValuesSelectFunction = list("default" = function(x){unique(x)}),
#                      operationValuesSelectFunction = list("default" = function(x){unique(x)}),
#                      marteladaFunction = NULL,
#                      singleMachineByIndex,
#                      singleJobByIndex,
#                      singleOperationByIndex,
#                      singleOperationFromMachineByIndex,
#                      singleOperationFromJobByIndex,
#                      experimentUI = ifelse(is.null(experimentName),format(Sys.time(), "%y%m%d%H%M%S"),experimentName),
#                      path = paste("./Experiments/Experiment_",experimentUI,"/",sep=""),
#                      local = TRUE, 
#                      debug=FALSE,
#                      refine=FALSE,
#                      settings = list(list(minacc=0.25,minpos=10,depth=2000,noise=20,clauselength=20)),
#                      ...) {              
#               
#               con <- this$connectionDB  
#               
#               
#               refineText <- "No"
#               
#               if(refine)
#               {
#                 refineText <- "Yes"
#               }
#               
#               
#               experiment.df <- data.frame(uniqueID = experimentUI,
#                                           instanceFeatures = instanceFeatureTableName, 
#                                           machineFeatures  = machineFeatureTableName,
#                                           jobFeatures  = jobFeatureTableName,
#                                           operationFeatures= operationFeatureTableName,
#                                           target = target,
#                                           positiveValue = positiveValue,
#                                           negativeValue = negativeValue,
#                                           modeRecall= modeRecall,
#                                           refine = refineText)
#               
#               dbWriteTable(con,name="ILP_experiment",experiment.df,append=TRUE,row.names=FALSE)
#               
#               
#               
#               instanceFeatureTable <- NULL
#               machineFeatureTable <- NULL
#               jobFeatureTable <- NULL
#               operationFeatureTable <- NULL
#               
#               settings.df <- do.call("rbind",lapply(settings,function(x)do.call("data.frame",x)))
#               settings.df$run_index <- 1:nrow(settings.df)
#               
#               
#               
#               
#               experimentName <- "jss"##paste(featureTable,"_",target,sep="")
#               
#               
#               # open the connection using user, passsword, etc., as
#               # specified in the file \file{\$HOME/.my.cnf}
#               
#               trainTableName <- paste("Target_",target,sep="")              
#               
#               trainTable <- dbReadTable(con,trainTableName) 
#               
#               ##      uis <- c("Instance_uniqueID","Machine","Job")
#               ui <- "Instance_uniqueID"
#               
#               allTargetsUIs <- trainTable[,ui]
#               
#               dir.create(path, showWarnings = FALSE)
#               
#               intersectedUIs <- allTargetsUIs
#               filesBGK <- NULL
#               
#               
#               if(!is.na(instanceFeatureTableName))
#               {
#                 instanceFeatureTableName <- paste("Features_",instanceFeatureTableName,sep="")
#                 instanceFeatureTable <- dbReadTable(con,instanceFeatureTableName)                  
#                 intersectedUIs <- intersect(intersectedUIs,instanceFeatureTable[,ui])
#               }
#               
#               if(!is.na(jobFeatureTableName))
#               {
#                 jobFeatureTableName <- paste("JobFeatures_",jobFeatureTableName,sep="")
#                 jobFeatureTable <- dbReadTable(con,jobFeatureTableName)  
#                 colnames(jobFeatureTable)[which(colnames(jobFeatureTable)=="job")]<-"Job"
#                 
#                 ##jobFeatureTable[,-which(colnames(jobFeatureTable) == "job")]   
#                 intersectedUIs <- intersect(intersectedUIs,unique(jobFeatureTable[,ui]))
#               } 
#               
#               
#               
#               if(!is.na(machineFeatureTableName))
#               { 
#                 machineFeatureTableName <- paste("MachineFeatures_",machineFeatureTableName,sep="")              
#                 
#                 machineFeatureTable <- dbReadTable(con,machineFeatureTableName)  
#                 colnames(machineFeatureTable)[which(colnames(machineFeatureTable)=="machine")]<-"Machine"
#                 
#                 ##machineFeatureTable[,-which(colnames(machineFeatureTable) == "machine")]  
#                 intersectedUIs <- intersect(intersectedUIs,unique(machineFeatureTable[,ui]))
#               } 
#               
#               if(!is.na(operationFeatureTableName))
#               {
#                 operationFeatureTableName <- paste("OperationFeatures_",operationFeatureTableName,sep="")       
#                 operationFeatureTable <- dbReadTable(con,operationFeatureTableName)  
#                 
#                 colnames(machineFeatureTable)[which(colnames(machineFeatureTable)=="machine")]<-"Machine"
#                 colnames(jobFeatureTable)[which(colnames(jobFeatureTable)=="job")]<-"Job"
#                 
#                 ##operationFeatureTable[,-which(colnames(operationFeatureTable) == "job" | colnames(operationFeatureTable) == "machine" )]  
#                 intersectedUIs <- intersect(intersectedUIs,unique(operationFeatureTable[,ui]))
#               } 
#               
#               trainTable <- trainTable[trainTable[,ui] %in% intersectedUIs, ]
#               
#               
#               if(!is.na(instanceFeatureTableName))
#               {
#                 instanceFeatureTable <- instanceFeatureTable[instanceFeatureTable[,ui] %in% intersectedUIs, ]
#               }
#               
#               if(!is.na(jobFeatureTableName))
#               {
#                 jobFeatureTable <- jobFeatureTable[jobFeatureTable[,ui] %in% intersectedUIs, ]
#               }
#               
#               if(!is.na(machineFeatureTableName))
#               {
#                 machineFeatureTable <- machineFeatureTable[machineFeatureTable[,ui] %in% intersectedUIs, ]
#               }
#               
#               if(!is.na(operationFeatureTableName))
#               {
#                 operationFeatureTable <- operationFeatureTable[operationFeatureTable[,ui] %in% intersectedUIs, ]
#               }
#               
#               if(!is.na(instanceFeatureTableName))
#               {
#                 ## instanceFeatureTable[,ui] <- paste("i_",instanceFeatureTable[,ui],sep="")
#                 instanceFeatureTable$id <- paste("i_",instanceFeatureTable[,ui],sep="")
#               }
#               if(!is.na(jobFeatureTableName))
#               {
#                 ## jobFeatureTable[,ui] <- paste("i_",jobFeatureTable[,ui],sep="")
#                 jobFeatureTable$id <- paste("i_",jobFeatureTable[,ui],"_",jobFeatureTable[,"Job"],sep="")
#               }
#               
#               if(!is.na(machineFeatureTableName))
#               {
#                 ##  machineFeatureTable[,ui] <- paste("i_",machineFeatureTable[,ui],sep="")
#                 machineFeatureTable$id <- paste("i_",machineFeatureTable[,ui],"_",machineFeatureTable[,"Machine"],sep="")
#               }
#               
#               if(!is.na(operationFeatureTableName))
#               {
#                 ##operationFeatureTable[,ui] <- paste("i_",operationFeatureTable[,ui],sep="")
#                 operationFeatureTable[,ui] <- paste("i_",operationFeatureTable[,ui],"_",operationFeatureTable[,"Job"],"_",operationFeatureTable[,"Machine"],sep="")
#               }
#               
#               targetName <- "target"##colnames(sol)[-which(colnames(sol)==ui)]
#               
#               
#               positiveFileName <- paste(experimentName,"_all.f",sep="")
#               positiveFile <- paste(path,positiveFileName,sep="")
#               if(file.exists(positiveFile))
#                 file.remove(positiveFile)
#               
#               negativeFileName <- paste(experimentName,"_all.n",sep="")
#               negativeFile <- paste(path,negativeFileName,sep="")
#               if(file.exists(negativeFile))
#                 file.remove(negativeFile)
#               
#               if(!is.null(marteladaFunction))
#               {
#                 martelada <- eval(call(marteladaFunction,
#                                        trainTable,
#                                        instanceFeatureTable,
#                                        machineFeatureTable,
#                                        jobFeatureTable,
#                                        operationFeatureTable))
#                 
#                 trainTable <- martelada$target
#                 instanceFeatureTable <- martelada$instanceFeatureTable
#                 machineFeatureTable <- martelada$machineFeatureTable
#                 jobFeatureTable <- martelada$jobFeatureTable
#                 operationFeatureTable <- martelada$operationFeatureTable
#               }
#               
#               
#               
#               positivesol <- trainTable[trainTable[,targetName]==positiveValue,ui]
#               write(paste("instanceJSS(i_",positivesol,").",sep=""),file=positiveFile,append=TRUE) 
#               
#               
#               if(is.na(negativeValue))
#               {
#                 negativesol <- trainTable[trainTable[,targetName] != positiveValue,ui]                
#               }
#               else
#               {
#                 negativesol <- trainTable[trainTable[,targetName] == negativeValue,ui]                 
#               }
#               
#               write(paste("instanceJSS(i_",negativesol,").",sep=""),file=negativeFile,append=TRUE)                      
#               
#               crossvalidation.df <- data.frame(train_pos_file = positiveFileName,
#                                                train_neg_file  = negativeFileName,
#                                                test_pos_file = NA,
#                                                test_neg_file	= NA,
#                                                train_neg_instances = paste(negativesol,collapse=","),
#                                                test_neg_file_instances = NA,
#                                                test_pos_file_instances = NA,
#                                                train_pos_file_instances	= paste(positivesol,collapse=","),                                       
#                                                fold_index	= NA,
#                                                kfoldcrossvalidation	= NA)
#               
#               
#               
#               
#               
#               
#               
#               if(!is.na(kfoldcrossvalidation))
#               {
#                 testsubsetindex <- 1
#                 newsettings <- NULL
#                 nrTrainTable <- nrow(trainTable)
#                 nrfolds <- ceiling(nrTrainTable/kfoldcrossvalidation)
#                 
#                 
#                 while(testsubsetindex <= nrfolds)
#                 {
#                   testsubset <- testsubsetindex:min(kfoldcrossvalidation*testsubsetindex,nrTrainTable)
#                   
#                   positiveFileName <- paste(experimentName,"_",testsubsetindex,".f",sep="")
#                   positiveFile <- paste(path,positiveFileName,sep="")
#                   
#                   if(file.exists(positiveFile))
#                     file.remove(positiveFile)
#                   
#                   negativeFileName <- paste(experimentName,"_",testsubsetindex,".n",sep="")
#                   negativeFile <- paste(path,negativeFileName,sep="")
#                   if(file.exists(negativeFile))
#                     file.remove(negativeFile)
#                   
#                   
#                   ##training file
#                   positivesol <- trainTable[trainTable[-testsubset,targetName]==positiveValue,ui]
#                   write(paste("instanceJSS(i_",positivesol,").",sep=""),file=positiveFile,append=TRUE) 
#                   
#                   
#                   if(is.na(negativeValue))
#                   {
#                     negativesol <- trainTable[trainTable[-testsubset,targetName]!=positiveValue,ui]                
#                   }
#                   else
#                   {
#                     negativesol <- trainTable[trainTable[-testsubset,targetName]==negativeValue,ui]                 
#                   }
#                   
#                   write(paste("instanceJSS(i_",negativesol,").",sep=""),file=negativeFile,append=TRUE)  
#                   
#                   ##test file
#                   testFilePosName <- paste(experimentName,"_",testsubsetindex,".test_pos",sep="")
#                   testFilePos <- paste(path,testFilePosName,sep="")
#                   
#                   if(file.exists(testFilePos))
#                     file.remove(testFilePos)                 
#                   
#                   testFileNegName <- paste(experimentName,"_",testsubsetindex,".test_neg",sep="")
#                   testFileNeg <- paste(path,testFileNegName,sep="")
#                   
#                   if(file.exists(testFileNeg))
#                     file.remove(testFileNeg) 
#                   
#                   
#                   ## settings[["test_pos"]] <- testFilePos##paste(experimentName,".test_pos",sep="")
#                   ##  settings[["test_neg"]] <- testFileNeg ##paste(experimentName,".test_neg",sep="")                
#                   
#                   #               }
#                   #               else
#                   #               {
#                   #                 testFilePos <- positiveFile                
#                   #                 testFileNeg <- negativeFile
#                   #                 
#                   #               }
#                   
#                   positivesolTest <- trainTable[trainTable[testsubset,targetName]==positiveValue,ui]
#                   write(paste("instanceJSS(i_",positivesolTest,").",sep=""),file=testFilePos,append=TRUE) 
#                   
#                   if(is.na(negativeValue))
#                   {
#                     negativesolTest <- trainTable[trainTable[testsubset,targetName]!=positiveValue,ui]                
#                   }
#                   else
#                   {
#                     negativesolTest <- trainTable[trainTable[testsubset,targetName]==negativeValue,ui]                 
#                   }
#                   
#                   write(paste("instanceJSS(i_",negativesolTest,").",sep=""),file=testFileNeg,append=TRUE) 
#                   
#                   crossvalidation.df <- rbind(crossvalidation.df,
#                                               data.frame(train_pos_file = positiveFileName,
#                                                          train_neg_file	= negativeFileName,
#                                                          test_pos_file = testFilePosName,
#                                                          test_neg_file	= testFileNegName,
#                                                          train_neg_instances = paste(negativesol,collapse=","),
#                                                          test_neg_file_instances	= paste(negativesolTest,collapse=","),
#                                                          test_pos_file_instances= paste(positivesolTest,collapse=","),
#                                                          train_pos_file_instances	= paste(positivesol,collapse=","),                                       
#                                                          fold_index	= testsubsetindex,
#                                                          kfoldcrossvalidation	= kfoldcrossvalidation))
#                   
#                   
#                   
#                   
#                   testsubsetindex <- testsubsetindex + 1  
#                 }
#                 
#                 
#                 
#               }
#               
#               
#               
#               run.df <- merge(crossvalidation.df,settings.df)
#               run.df$status <- rep("None",nrow(run.df))
#               run.df$experiment_uniqueID   <- rep(experimentUI,nrow(run.df))
#               
#               runName <-paste(experimentUI,run.df$run_index,run.df$fold_index,sep="_")
#               runName <- sub(pattern="_NA","_all",runName)
#               run.df$run_file <- runName
#               
#               dbWriteTable(con,"ILP_run",run.df,append = TRUE,row.names=FALSE)
#               
#               ################################################################################
#               ##features definitions##########################################################
#               ################################################################################
#               
#               
#               instanceWriteResults <- this$writeILPComponentData_new(instanceFeatureTable,"instance",instanceValuesSelectFunction,path,modeRecall=modeRecall)
#               
#               machineWriteResults <- this$writeILPComponentData_new(machineFeatureTable,"machine",machineValuesSelectFunction,path,modeRecall=modeRecall)
#               
#               jobWriteResults <- this$writeILPComponentData_new(jobFeatureTable,"job",machineValuesSelectFunction,path,modeRecall=modeRecall)
#               
#               operationWriteResults <-  this$writeILPComponentData_new(operationFeatureTable,"operation",operationValuesSelectFunction,path,modeRecall=modeRecall)
#               
#               files <- c(instanceWriteResults$files,machineWriteResults$files,jobWriteResults$files,operationWriteResults$files)        
#               
#               
#               
#               
#               
#               
#               
#               #########################################
#               ###Generate Run Bash Script##############
#               #########################################
#               
#               nrsettings <- length(settings)
#               
#               #               datafiles <- c("all")
#               #               
#               #               if(!is.null(kcrossvalidation))
#               #               {
#               #                 datafiles <- c(datafiles,1:testsubsetindex)
#               #                 
#               #               }
#               #               
#               #               for(datafilename in datafiles)
#               #               {
#               
#               
#               settingsNames <- unique(names(unlist(settings)))
#               
#               for(i in 1:nrow(run.df))
#               {
#                 set <- run.df[i,settingsNames]
#                 
#                 bText <- paste("
#                                :-['",paste(files,collapse="','"),"'].                      
#                                
#                                :- modeh(1,instanceJSS(+instanceJSSID)).","
#                                
#                                :-set(train_pos,'",run.df[i,"train_pos_file"],"').\n
#                                :-set(train_neg,'",run.df[i,"train_neg_file"],"').\n",sep="")
#                 
#                 
#                 if(!is.na(run.df[i,"test_pos_file"]))
#                 {
#                   bText <- paste(bText,"
#                                  :-set(test_pos,'",run.df[i,"test_pos_file"],"').\n
#                                  :-set(test_neg,'",run.df[i,"test_neg_file"],"').\n",sep="") 
#                   
#                 }
#                 
#                 if(refine)
#                 {
#                   bText <- paste(bText,"
#                                  :-set(refine,user).\n",sep="")            
#                 }
#                 
#                 
#                 
#                 
#                 
#                 
#                 bText <- paste(bText,paste(paste(":-set(",names(set),",",set,").
#                                                  ",sep=""),collapse=""),"
#                                
#                                ",sep="")
#                 
#                 
#                 
#                 
#                 if(!is.na(machineFeatureTableName) && singleMachineByIndex )
#                 { 
#                   bText <- paste(bText,"
#                                  :- modeb(*,singleMachineByIndex(+instanceJSSID,-machineJSSID)).
#                                  :- determination(instanceJSS/1,singleMachineByIndex/2).
#                                  
#                                  singleMachineByIndex(InstanceID,MachineID):- var(InstanceID),!.
#                                  ",paste("singleMachineByIndex(InstanceID,MachineID):- atomic_list_concat([InstanceID,",1:max(machineFeatureTable[,"Machine"]),"],'_',MachineID).",collapse="\n"),sep="")
#                   
#                   
#                 }
#                 
#                 if(!is.na(jobFeatureTableName) && singleJobByIndex)
#                 { 
#                   bText <- paste(bText,"
#                                  :- modeb(*,singleJobByIndex(+instanceJSSID,-jobJSSID)).
#                                  :- determination(instanceJSS/1,singleJobByIndex/2).
#                                  
#                                  singleJobByIndex(InstanceID,JobID):- var(InstanceID),!.
#                                  ",paste("singleJobByIndex(InstanceID,JobID):- atomic_list_concat([InstanceID,",1:max(jobFeatureTable[,"Job"]),"],'_',JobID).
#                                          ",collapse=""),sep="")
#                   
#                   
#                 }
#                 
#                 if(!is.na(operationFeatureTableName))
#                 { 
#                   if(singleOperationByIndex)
#                   {
#                     bText <- paste(bText,"
#                                    :- modeb(*,singleOperationByIndex(+instanceJSSID,-operationJSSID)).
#                                    :- determination(instanceJSS/1,singleOperationByIndex/2).
#                                    
#                                    singleOperationByIndex(InstanceID,OperationID):- var(InstanceID),!.
#                                    ",paste("singleOperationByIndex(InstanceID,OperationID):- atomic_list_concat([InstanceID,",1:max(operationFeatureTableName[,"Job"]),",",1:max(operationFeatureTableName[,"Machine"]),"],'_',OperationID).
#                                            ",collapse=""),sep="")  
#                   }
#                   
#                   if(!is.na(machineFeatureTableName) && singleOperationFromMachineByIndex)
#                   { 
#                     bText <- paste(bText,"
#                                    :- modeb(*,singleOperationFromMachineByIndex(+machineJSSID,-operationJSSID)).
#                                    :- determination(instanceJSS/1,singleOperationFromMachineByIndex/2).
#                                    
#                                    singleOperationFromMachineByIndex(MachineID,OperationID):- var(MachineID),!.
#                                    ",paste("singleOperationFromMachineByIndex(MachineID,OperationID):- atomic_list_concat([i,InstanceUI,Machine],'_',MachineID),atomic_list_concat([i,InstanceUI,",1:max(operationFeatureTableName[,"Job"]),",Machine],'_',OperationID).
#                                            ",collapse=""),sep="")
#                   }
#                   
#                   if(!is.na(jobFeatureTableName) && singleOperationFromJobByIndex)
#                   { 
#                     bText <- paste(bText,"
#                                    :- modeb(*,singleOperationFromJobByIndex(+jobJSSID,-operationJSSID)).
#                                    :- determination(instanceJSS/1,singleOperationFromJobByIndex/2).
#                                    
#                                    singleOperationFromJobByIndex(JobID,OperationID):- var(JobID),!.
#                                    ",paste("singleOperationFromJobByIndex(JobID,OperationID):- atomic_list_concat([i,InstanceUI,Job],'_',JobID),atomic_list_concat([i,InstanceUI,Job,",1:max(operationFeatureTableName[,"Machine"]),"],'_',OperationID).
#                                            ",collapse=""),sep="")
#                   }
#                   
#                   
#                   
#                   
#                   }
#                 
#                 
#                 
#                 if(refine)
#                 {
#                   bText <- paste(bText,"
#                                  refine(false,instanceJSS(X)):- !.
#                                  
#                                  refine(instanceJSS(X),Clause):-
#                                  Clause=(instanceJSS(X) :- instanceHigherEqual(X,_,_,_,_)).
#                                  
#                                  refine(instanceJSS(X),Clause):-
#                                  Clause=(instanceJSS(X) :- instanceLowerEqual(X,_,_,_,_)).
#                                  
#                                  refine(instanceJSS(X),Clause):-
#                                  Clause=(instanceJSS(X) :- singleMachineByIndex(X,M),machineHigherEqual(M,_,_,_,_)).
#                                  
#                                  
#                                  refine(instanceJSS(X),Clause):-
#                                  Clause=(instanceJSS(X) :- singleMachineByIndex(X,M),machineLowerEqual(M,_,_,_,_)).
#                                  
#                                  refine(instanceJSS(X),Clause):-
#                                  Clause=(instanceJSS(X) :- singleJobByIndex(X,M),jobHigherEqual(M,_,_,_,_)).
#                                  
#                                  refine(instanceJSS(X),Clause):-
#                                  Clause=(instanceJSS(X) :- singleJobByIndex(X,M),jobLowerEqual(M,_,_,_,_)).
#                                  
#                                  
#                                  %%%%
#                                  
#                                  refine((instanceJSS(X):-instanceHigherEqual(X,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- instanceHigherEqual(X,A,B,C,D),singleMachineByIndex(X,M),machineHigherEqual(M,_,_,_,_)).
#                                  
#                                  refine((instanceJSS(X):-instanceHigherEqual(X,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- instanceHigherEqual(X,A,B,C,D),singleMachineByIndex(X,M),machineLowerEqual(M,_,_,_,_)).
#                                  
#                                  
#                                  refine((instanceJSS(X):-instanceLowerEqual(X,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- instanceLowerEqual(X,A,B,C,D),singleMachineByIndex(X,M),machineHigherEqual(M,_,_,_,_)).
#                                  
#                                  refine((instanceJSS(X):-instanceLowerEqual(X,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- instanceLowerEqual(X,A,B,C,D),singleMachineByIndex(X,M),machineLowerEqual(M,_,_,_,_)).
#                                  
#                                  %%%%%%%%%%%%%%%%%%%%                                 
#                                  
#                                  refine((instanceJSS(X):-instanceHigherEqual(X,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- instanceHigherEqual(X,A,B,C,D),singleJobByIndex(X,M),jobHigherEqual(M,_,_,_,_)).
#                                  
#                                  refine((instanceJSS(X):-instanceHigherEqual(X,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- instanceHigherEqual(X,A,B,C,D),singleJobByIndex(X,M),jobLowerEqual(M,_,_,_,_)).
#                                  
#                                  refine((instanceJSS(X):-instanceLowerEqual(X,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- instanceLowerEqual(X,A,B,C,D),singleJobByIndex(X,M),jobHigherEqual(M,_,_,_,_)).
#                                  
#                                  refine((instanceJSS(X):-instanceLowerEqual(X,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- instanceLowerEqual(X,A,B,C,D),singleJobByIndex(X,M),jobLowerEqual(M,_,_,_,_)).
#                                  
#                                  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#                                  
#                                  refine((instanceJSS(X):-instanceHigherEqual(X,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- instanceHigherEqual(X,A,B,C,D),instanceLowerEqual(X,A,_,_,_)).
#                                  
#                                  refine((instanceJSS(X):-instanceHigherEqual(X,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- instanceHigherEqual(X,A,B,C,D),instanceLowerEqual(X,A1,_,_,_),A\\==A1).
#                                  
#                                  refine((instanceJSS(X):-instanceHigherEqual(X,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- instanceHigherEqual(X,A,B,C,D),instanceHigherEqual(X,_,_,_,_)).
#                                  
#                                  
#                                  %%Repitacao???                               
#                                  refine((instanceJSS(X):-instanceLowerEqual(X,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- instanceLowerEqual(X,A,B,C,D),instanceHigherEqual(X,A,_,_,_)).
#                                  
#                                  refine((instanceJSS(X):-instanceLowerEqual(X,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- instanceLowerEqual(X,A,B,C,D),instanceLowerEqual(X,_,_,_,_)).                                 
#                                  
#                                  
#                                  
#                                  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#                                  refine((instanceJSS(X):-singleMachineByIndex(X,M),machineHigherEqual(M,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- singleMachineByIndex(X,M),machineHigherEqual(M,A,B,C,D),singleJobByIndex(X,J),jobHigherEqual(J,_,_,_,_)).
#                                  
#                                  refine((instanceJSS(X):-singleMachineByIndex(X,M),machineHigherEqual(M,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- singleMachineByIndex(X,M),machineHigherEqual(M,A,B,C,D),singleJobByIndex(X,J),jobLowerEqual(J,_,_,_,_)).
#                                  
#                                  
#                                  refine((instanceJSS(X):-singleMachineByIndex(X,M),machineHigherEqual(M,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- singleMachineByIndex(X,M),machineHigherEqual(M,A,B,C,D),singleMachineByIndex(X,M1),M\\==M1,machineHigherEqual(M1,_,_,_,_)).
#                                  
#                                  
#                                  refine((instanceJSS(X):-singleMachineByIndex(X,M),machineHigherEqual(M,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- singleMachineByIndex(X,M),machineHigherEqual(M,A,B,C,D),singleMachineByIndex(X,M1),M\\==M1,machineLowerEqual(M1,_,_,_,_)).
#                                  
#                                  refine((instanceJSS(X):-singleMachineByIndex(X,M),machineHigherEqual(M,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- singleMachineByIndex(X,M),machineHigherEqual(M,A,B,C,D),machineLowerEqual(M,A,_,_,_)).
#                                  
#                                  refine((instanceJSS(X):-singleMachineByIndex(X,M),machineHigherEqual(M,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- singleMachineByIndex(X,M),machineHigherEqual(M,A,B,C,D),machineHigherEqual(M,_,_,_,_)).
#                                  
#                                  refine((instanceJSS(X):-singleMachineByIndex(X,M),machineHigherEqual(M,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- singleMachineByIndex(X,M),machineHigherEqual(M,A,B,C,D),machineLowerEqual(M,A1,_,_,_),A1\\==A).
#                                  
#                                  
#                                  
#                                  
#                                  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#                                  
#                                  refine((instanceJSS(X):-singleJobByIndex(X,M),jobHigherEqual(M,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- singleJobByIndex(X,M),jobHigherEqual(M,A,B,C,D),singleJobByIndex(X,M1),M\\==M1,jobHigherEqual(M1,_,_,_,_)).
#                                  
#                                  refine((instanceJSS(X):-singleJobByIndex(X,M),jobHigherEqual(M,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- singleJobByIndex(X,M),jobHigherEqual(M,A,B,C,D),singleJobByIndex(X,M1),M\\==M1,jobLowerEqual(M1,_,_,_,_)).
#                                  
#                                  refine((instanceJSS(X):-singleJobByIndex(X,M),jobHigherEqual(M,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- singleJobByIndex(X,M),jobHigherEqual(M,A,B,C,D),jobLowerEqual(M,A,_,_,_)).
#                                  
#                                  refine((instanceJSS(X):-singleJobByIndex(X,M),jobHigherEqual(M,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- singleJobByIndex(X,M),jobHigherEqual(M,A,B,C,D),jobHigherEqual(M,_,_,_,_)).
#                                  
#                                  refine((instanceJSS(X):-singleJobByIndex(X,M),jobHigherEqual(M,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- singleJobByIndex(X,M),jobHigherEqual(M,A,B,C,D),jobLowerEqual(M,A1,_,_,_),A1\\==A).
#                                  
#                                  
#                                  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#                                  refine((instanceJSS(X):-singleMachineByIndex(X,M),machineLowerEqual(M,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- singleMachineByIndex(X,M),machineLowerEqual(M,A,B,C,D),singleJobByIndex(X,J),jobHigherEqual(J,_,_,_,_)).
#                                  
#                                  refine((instanceJSS(X):-singleMachineByIndex(X,M),machineLowerEqual(M,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- singleMachineByIndex(X,M),machineLowerEqual(M,A,B,C,D),singleJobByIndex(X,J),jobLowerEqual(J,_,_,_,_)).
#                                  
#                                  
#                                  refine((instanceJSS(X):-singleMachineByIndex(X,M),machineLowerEqual(M,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- singleMachineByIndex(X,M),machineLowerEqual(M,A,B,C,D),singleMachineByIndex(X,M1),M\\==M1,machineLowerEqual(M1,_,_,_,_)).
#                                  
#                                  refine((instanceJSS(X):-singleMachineByIndex(X,M),machineLowerEqual(M,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- singleMachineByIndex(X,M),machineLowerEqual(M,A,B,C,D),singleMachineByIndex(X,M1),M\\==M1,machineHigherEqual(M1,_,_,_,_)).
#                                  
#                                  refine((instanceJSS(X):-singleMachineByIndex(X,M),machineLowerEqual(M,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- singleMachineByIndex(X,M),machineLowerEqual(M,A,B,C,D),machineHigherEqual(M,A,_,_,_)).
#                                  
#                                  refine((instanceJSS(X):-singleMachineByIndex(X,M),machineLowerEqual(M,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- singleMachineByIndex(X,M),machineLowerEqual(M,A,B,C,D),machineLowerEqual(M,_,_,_,_)).
#                                  
#                                  refine((instanceJSS(X):-singleMachineByIndex(X,M),machineLowerEqual(M,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- singleMachineByIndex(X,M),machineLowerEqual(M,A,B,C,D),machineHigherEqual(M,A1,_,_,_),A1\\==A).
#                                  
#                                  
#                                  
#                                  
#                                  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#                                  
#                                  refine((instanceJSS(X):-singleJobByIndex(X,M),jobLowerEqual(M,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- singleJobByIndex(X,M),jobLowerEqual(M,A,B,C,D),singleJobByIndex(X,M1),M\\==M1,jobLowerEqual(M1,_,_,_,_)).
#                                  
#                                  refine((instanceJSS(X):-singleJobByIndex(X,M),jobLowerEqual(M,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- singleJobByIndex(X,M),jobLowerEqual(M,A,B,C,D),singleJobByIndex(X,M1),M\\==M1,jobLowerEqual(M1,_,_,_,_)).
#                                  
#                                  refine((instanceJSS(X):-singleJobByIndex(X,M),jobLowerEqual(M,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- singleJobByIndex(X,M),jobLowerEqual(M,A,B,C,D),jobHigherEqual(M,A,_,_,_)).
#                                  
#                                  refine((instanceJSS(X):-singleJobByIndex(X,M),jobLowerEqual(M,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- singleJobByIndex(X,M),jobLowerEqual(M,A,B,C,D),jobLowerEqual(M,_,_,_,_)).
#                                  
#                                  refine((instanceJSS(X):-singleJobByIndex(X,M),jobLowerEqual(M,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- singleJobByIndex(X,M),jobLowerEqual(M,A,B,C,D),jobHigherEqual(M,A1,_,_,_),A1\\==A).",sep="")
#                   
#                 }
#                 
#                 
#                 
#                 
#                 write(bText,file=paste(path,experimentName,"_",run.df[i,"run_file"],".b",sep=""))
#                 
#                 
#                 
#                 runStg <- paste("#!/bin/csh
#                                 
#                                 yap <<+
#                                 use_module(library(lists)).
#                                 use_module(library(system)).
#                                 
#                                 working_directory(CWD,'",path,"').
#                                 
#                                 ['../../../../aleph.pl'].
#                                 ['../../../../pedabreu.pl'].
#                                 
#                                 read_all('",experimentName,"_",run.df[i,"run_file"],"').\n
#                                 
#                                 
#                                 induce.
#                                 write_rules_xml('results_",run.df[i,"run_file"],".xml').
#                                 halt.
#                                 +",sep="")
#                 
#                 write(runStg,file=paste(path,"run_",run.df[i,"run_file"],sep="") )   
#                 
#                 
#                 
#                 
#                   }
#               ##}
#               #########################################
#               #########################################
#               
#               
#               
#               
#               
#               #########################################
#               ##save parameters in XML#################
#               #########################################
#               #               tt <- xmlHashTree()
#               #               parameterNode <- addNode(xmlNode("parameters"), character(), tt)
#               # 
#               #               
#               #               instancefeaturesGroupValueNode <- addNode(xmlNode("instanceFeaturesGroup"), parameterNode, tt)              
#               #               addNode(xmlTextNode(instanceFeatureTableName), instancefeaturesGroupValueNode, tt)
#               #              
#               #               jobfeaturesGroupValueNode <- addNode(xmlNode("jobFeaturesGroup"), parameterNode, tt)              
#               #               addNode(xmlTextNode(jobFeatureTableName), jobfeaturesGroupValueNode, tt)
#               #               
#               #               machinefeaturesGroupValueNode <- addNode(xmlNode("machineFeaturesGroup"), parameterNode, tt)              
#               #               addNode(xmlTextNode(machineFeatureTableName), machinefeaturesGroupValueNode, tt)
#               #               
#               #               operationfeaturesGroupValueNode <- addNode(xmlNode("operationFeaturesGroup"), parameterNode, tt)              
#               #               addNode(xmlTextNode(operationFeatureTableName), operationfeaturesGroupValueNode, tt)
#               #               
#               #               
#               #               targetValueNode <- addNode(xmlNode("target"), parameterNode, tt)              
#               #               addNode(xmlTextNode(target), targetValueNode, tt)
#               #               
#               #               positiveValueNode <- addNode(xmlNode("positiveValue"), parameterNode, tt)              
#               #               addNode(xmlTextNode(positiveValue), positiveValueNode, tt)
#               #               
#               #               negativeValueNode <- addNode(xmlNode("negativeValue"), parameterNode, tt)              
#               #               addNode(xmlTextNode( negativeValue),negativeValueNode, tt)              
#               #               
#               #               modeRecallNode <- addNode(xmlNode("modeRecall"), parameterNode, tt)              
#               #               addNode(xmlTextNode(modeRecall),  modeRecallNode, tt)                
#               # 
#               #               alephNode <- addNode(xmlNode("aleph"), parameterNode, tt) 
#               #               
#               #               for(setIndex in 1:length(settings))
#               #               { 
#               #                 set <- settings[[setIndex]]
#               #                 
#               #                 setNode <- addNode(xmlNode(paste("run-",setIndex,sep="")), alephNode, tt)
#               #                 ##addNode(xmlTextNode(set[[settingName]]), setNode, tt)  
#               #                 
#               #                 for(settingName in names(set))
#               #                 {
#               #                   node <- addNode(xmlNode(settingName), setNode, tt)
#               #                   addNode(xmlTextNode(set[[settingName]]), node, tt)                                
#               #                 }       
#               # 
#               #               }
#               
#               domain.df <- data.frame()
#               
#               # instanceDomainNode <- addNode(xmlNode("instanceDomain"), parameterNode, tt) 
#               allDomainValues <- instanceWriteResults$domainValues 
#               
#               for(valueSelName in names(allDomainValues))
#               {                
#                 #  node <- addNode(xmlNode(valueSelName), instanceDomainNode, tt)
#                 #  addNode(xmlTextNode(paste(allDomainValues[[valueSelName]],collapse=";")), node, tt) 
#                 
#                 domain.df <- rbind(domain.df,
#                                    data.frame(experiment_uniqueID = experimentUI,
#                                               feature = valueSelName,
#                                               component = "instance",
#                                               domainValues	= paste(allDomainValues[[valueSelName]],collapse=";")))
#                 
#                 
#               }
#               
#               ## machineDomainNode <- addNode(xmlNode("machineDomain"), parameterNode, tt) 
#               allDomainValues <- machineWriteResults$domainValues 
#               
#               for(valueSelName in names(allDomainValues))
#               {                
#                 ## node <- addNode(xmlNode(valueSelName), machineDomainNode, tt)
#                 ##  addNode(xmlTextNode(paste(allDomainValues[[valueSelName]],collapse=";")), node, tt)   
#                 
#                 domain.df <- rbind(domain.df,
#                                    data.frame(experiment_uniqueID = experimentUI,
#                                               feature = valueSelName,
#                                               component = "machine",
#                                               domainValues  = paste(allDomainValues[[valueSelName]],collapse=";")))
#                 
#               }
#               
#               ##  jobDomainNode <- addNode(xmlNode("jobDomain"), parameterNode, tt) 
#               allDomainValues <- jobWriteResults$domainValues 
#               
#               for(valueSelName in names(allDomainValues))
#               {                
#                 ##  node <- addNode(xmlNode(valueSelName), jobDomainNode, tt)
#                 ##  addNode(xmlTextNode(paste(allDomainValues[[valueSelName]],collapse=";")), node, tt)     
#                 
#                 domain.df <- rbind(domain.df,
#                                    data.frame(experiment_uniqueID = experimentUI,
#                                               feature = valueSelName,
#                                               component = "job",
#                                               domainValues  = paste(allDomainValues[[valueSelName]],collapse=";")))
#                 
#                 
#               }
#               
#               ##  operationDomainNode <- addNode(xmlNode("jobDomain"), parameterNode, tt) 
#               allDomainValues <- operationWriteResults$domainValues 
#               
#               for(valueSelName in names(allDomainValues))
#               {                
#                 ##  node <- addNode(xmlNode(valueSelName),operationDomainNode, tt)
#                 ## addNode(xmlTextNode(paste(allDomainValues[[valueSelName]],collapse=";")), node, tt)   
#                 
#                 domain.df <- rbind(domain.df,
#                                    data.frame(experiment_uniqueID = experimentUI,
#                                               feature = valueSelName,
#                                               component = "operation",
#                                               domainValues  = paste(allDomainValues[[valueSelName]],collapse=";")))
#                 
#               }
#               
#               
#               dbWriteTable(con,"ILP_domain",domain.df,append=TRUE,row.names=FALSE)
#               
#               
#               #               
#               #               sink(paste(path,"parameters.xml",sep=""))
#               #               print(tt)
#               #               sink() 
#               ##########################################
#               
#                   })
# 
# setMethodS3("generateILPComponentDataMartelated","ExperimentFramework", 
#             function(this,
#                      target,
#                      experimentName = NULL,
#                      kfoldcrossvalidation = NA,
#                      instanceFeatureTableName = NA,
#                      machineFeatureTableName = NA,
#                      jobFeatureTableName = NA,
#                      operationFeatureTableName = NA,
#                      positiveValue = "LPT",
#                      negativeValue = NA,
#                      modeRecall= "*",
#                      instanceValuesSelectFunction = list("default" = function(x){unique(x)}),
#                      machineValuesSelectFunction = list("default" = function(x){unique(x)}),
#                      jobValuesSelectFunction = list("default" = function(x){unique(x)}),
#                      operationValuesSelectFunction = list("default" = function(x){unique(x)}),
#                      marteladaFunction = "martelada_1",
#                      
#                      singleMachineByIndex,
#                      singleJobByIndex,
#                      singleOperationByIndex,
#                      singleOperationFromMachineByIndex,
#                      singleOperationFromJobByIndex,
#                      experimentUI = ifelse(is.null(experimentName),format(Sys.time(), "%y%m%d%H%M%S"),experimentName),
#                      path = paste("./Experiments/Experiment_",experimentUI,"/",sep=""),
#                      local = TRUE, 
#                      debug=FALSE,
#                      refine=FALSE,
#                      settings = list(list(minacc=0.25,minpos=10,depth=2000,noise=20,clauselength=20)),
#                      ...) {              
#               
#               con <- this$connectionDB  
#               
#               
#               refineText <- "No"
#               
#               if(refine)
#               {
#                 refineText <- "Yes"
#               }
#               
#               
#               experiment.df <- data.frame(uniqueID = experimentUI,
#                                           instanceFeatures = instanceFeatureTableName, 
#                                           machineFeatures  = machineFeatureTableName,
#                                           jobFeatures  = jobFeatureTableName,
#                                           operationFeatures= operationFeatureTableName,
#                                           target = target,
#                                           positiveValue = positiveValue,
#                                           negativeValue = negativeValue,
#                                           modeRecall= modeRecall,
#                                           refine = refineText)
#               
#               dbWriteTable(con,name="ILP_experiment",experiment.df,append=TRUE,row.names=FALSE)
#               
#               
#               
#               instanceFeatureTable <- NULL
#               machineFeatureTable <- NULL
#               jobFeatureTable <- NULL
#               operationFeatureTable <- NULL
#               
#               settings.df <- do.call("rbind",lapply(settings,function(x)do.call("data.frame",x)))
#               settings.df$run_index <- 1:nrow(settings.df)
#               
#               
#               
#               
#               experimentName <- "jss"##paste(featureTable,"_",target,sep="")
#               
#               
#               # open the connection using user, passsword, etc., as
#               # specified in the file \file{\$HOME/.my.cnf}
#               
#               trainTableName <- paste("Target_",target,sep="")              
#               
#               trainTable <- dbReadTable(con,trainTableName) 
#               
#               ##      uis <- c("Instance_uniqueID","Machine","Job")
#               ui <- "Instance_uniqueID"
#               
#               allTargetsUIs <- trainTable[,ui]
#               
#               dir.create(path, showWarnings = FALSE)
#               
#               intersectedUIs <- allTargetsUIs
#               filesBGK <- NULL
#               
#               
#               if(!is.na(instanceFeatureTableName))
#               {
#                 instanceFeatureTableName <- paste("Features_",instanceFeatureTableName,sep="")
#                 instanceFeatureTable <- dbReadTable(con,instanceFeatureTableName)                  
#                 intersectedUIs <- intersect(intersectedUIs,instanceFeatureTable[,ui])
#               }
#               
#               if(!is.na(jobFeatureTableName))
#               {
#                 jobFeatureTableName <- paste("JobFeatures_",jobFeatureTableName,sep="")
#                 jobFeatureTable <- dbReadTable(con,jobFeatureTableName)  
#                 colnames(jobFeatureTable)[which(colnames(jobFeatureTable)=="job")]<-"Job"
#                 
#                 ##jobFeatureTable[,-which(colnames(jobFeatureTable) == "job")]   
#                 intersectedUIs <- intersect(intersectedUIs,unique(jobFeatureTable[,ui]))
#               } 
#               
#               
#               
#               if(!is.na(machineFeatureTableName))
#               { 
#                 machineFeatureTableName <- paste("MachineFeatures_",machineFeatureTableName,sep="")              
#                 
#                 machineFeatureTable <- dbReadTable(con,machineFeatureTableName)  
#                 colnames(machineFeatureTable)[which(colnames(machineFeatureTable)=="machine")]<-"Machine"
#                 
#                 ##machineFeatureTable[,-which(colnames(machineFeatureTable) == "machine")]  
#                 intersectedUIs <- intersect(intersectedUIs,unique(machineFeatureTable[,ui]))
#               } 
#               
#               if(!is.na(operationFeatureTableName))
#               {
#                 operationFeatureTableName <- paste("OperationFeatures_",operationFeatureTableName,sep="")       
#                 operationFeatureTable <- dbReadTable(con,operationFeatureTableName)  
#                 
#                 colnames(machineFeatureTable)[which(colnames(machineFeatureTable)=="machine")]<-"Machine"
#                 colnames(jobFeatureTable)[which(colnames(jobFeatureTable)=="job")]<-"Job"
#                 
#                 ##operationFeatureTable[,-which(colnames(operationFeatureTable) == "job" | colnames(operationFeatureTable) == "machine" )]  
#                 intersectedUIs <- intersect(intersectedUIs,unique(operationFeatureTable[,ui]))
#               } 
#               
#               trainTable <- trainTable[trainTable[,ui] %in% intersectedUIs, ]
#               
#               
#               if(!is.na(instanceFeatureTableName))
#               {
#                 instanceFeatureTable <- instanceFeatureTable[instanceFeatureTable[,ui] %in% intersectedUIs, ]
#               }
#               
#               if(!is.na(jobFeatureTableName))
#               {
#                 jobFeatureTable <- jobFeatureTable[jobFeatureTable[,ui] %in% intersectedUIs, ]
#               }
#               
#               if(!is.na(machineFeatureTableName))
#               {
#                 machineFeatureTable <- machineFeatureTable[machineFeatureTable[,ui] %in% intersectedUIs, ]
#               }
#               
#               if(!is.na(operationFeatureTableName))
#               {
#                 operationFeatureTable <- operationFeatureTable[operationFeatureTable[,ui] %in% intersectedUIs, ]
#               }
#               
#               if(!is.na(instanceFeatureTableName))
#               {
#                 ## instanceFeatureTable[,ui] <- paste("i_",instanceFeatureTable[,ui],sep="")
#                 instanceFeatureTable$id <- paste("i_",instanceFeatureTable[,ui],sep="")
#               }
#               if(!is.na(jobFeatureTableName))
#               {
#                 ## jobFeatureTable[,ui] <- paste("i_",jobFeatureTable[,ui],sep="")
#                 jobFeatureTable$id <- paste("i_",jobFeatureTable[,ui],"_",jobFeatureTable[,"Job"],sep="")
#               }
#               
#               if(!is.na(machineFeatureTableName))
#               {
#                 ##  machineFeatureTable[,ui] <- paste("i_",machineFeatureTable[,ui],sep="")
#                 machineFeatureTable$id <- paste("i_",machineFeatureTable[,ui],"_",machineFeatureTable[,"Machine"],sep="")
#               }
#               
#               if(!is.na(operationFeatureTableName))
#               {
#                 ##operationFeatureTable[,ui] <- paste("i_",operationFeatureTable[,ui],sep="")
#                 operationFeatureTable[,ui] <- paste("i_",operationFeatureTable[,ui],"_",operationFeatureTable[,"Job"],"_",operationFeatureTable[,"Machine"],sep="")
#               }
#               
#               targetName <- "target"##colnames(sol)[-which(colnames(sol)==ui)]
#               
#               
#               positiveFileName <- paste(experimentName,"_all.f",sep="")
#               positiveFile <- paste(path,positiveFileName,sep="")
#               if(file.exists(positiveFile))
#                 file.remove(positiveFile)
#               
#               negativeFileName <- paste(experimentName,"_all.n",sep="")
#               negativeFile <- paste(path,negativeFileName,sep="")
#               if(file.exists(negativeFile))
#                 file.remove(negativeFile)
#               
#              
#               martelada <- eval(call(marteladaFunction,
#                                      trainTable,
#                                      instanceFeatureTable,
#                                      machineFeatureTable,
#                                      jobFeatureTable,
#                                      operationFeatureTable))
#               
#               trainTable <- martelada$target
#               instanceFeatureTable <- martelada$instanceFeatureTable
#               machineFeatureTable <- martelada$machineFeatureTable
#               jobFeatureTable <- martelada$jobFeatureTable
#               operationFeatureTable <- martelada$operationFeatureTable
#               
#               
#               
#               positivesol <- trainTable[trainTable[,targetName]==positiveValue,ui]
#               write(paste("instanceJSS(i_",positivesol,").",sep=""),file=positiveFile,append=TRUE) 
#               
#               
#               if(is.na(negativeValue))
#               {
#                 negativesol <- trainTable[trainTable[,targetName] != positiveValue,ui]                
#               }
#               else
#               {
#                 negativesol <- trainTable[trainTable[,targetName] == negativeValue,ui]                 
#               }
#               
#               write(paste("instanceJSS(i_",negativesol,").",sep=""),file=negativeFile,append=TRUE)                      
#               
#               crossvalidation.df <- data.frame(train_pos_file = positiveFileName,
#                                                train_neg_file  = negativeFileName,
#                                                test_pos_file = NA,
#                                                test_neg_file	= NA,
#                                                train_neg_instances = paste(negativesol,collapse=","),
#                                                test_neg_file_instances = NA,
#                                                test_pos_file_instances = NA,
#                                                train_pos_file_instances	= paste(positivesol,collapse=","),                                       
#                                                fold_index	= NA,
#                                                kfoldcrossvalidation	= NA)
#               
#               
#               
#               
#               
#               
#               
#               if(!is.na(kfoldcrossvalidation))
#               {
#                 testsubsetindex <- 1
#                 newsettings <- NULL
#                 nrTrainTable <- nrow(trainTable)
#                 nrfolds <- ceiling(nrTrainTable/kfoldcrossvalidation)
#                 
#                 
#                 while(testsubsetindex <= nrfolds)
#                 {
#                   testsubset <- testsubsetindex:min(kfoldcrossvalidation*testsubsetindex,nrTrainTable)
#                   
#                   positiveFileName <- paste(experimentName,"_",testsubsetindex,".f",sep="")
#                   positiveFile <- paste(path,positiveFileName,sep="")
#                   
#                   if(file.exists(positiveFile))
#                     file.remove(positiveFile)
#                   
#                   negativeFileName <- paste(experimentName,"_",testsubsetindex,".n",sep="")
#                   negativeFile <- paste(path,negativeFileName,sep="")
#                   if(file.exists(negativeFile))
#                     file.remove(negativeFile)
#                   
#                   
#                   ##training file
#                   positivesol <- trainTable[trainTable[-testsubset,targetName]==positiveValue,ui]
#                   write(paste("instanceJSS(i_",positivesol,").",sep=""),file=positiveFile,append=TRUE) 
#                   
#                   
#                   if(is.na(negativeValue))
#                   {
#                     negativesol <- trainTable[trainTable[-testsubset,targetName]!=positiveValue,ui]                
#                   }
#                   else
#                   {
#                     negativesol <- trainTable[trainTable[-testsubset,targetName]==negativeValue,ui]                 
#                   }
#                   
#                   write(paste("instanceJSS(i_",negativesol,").",sep=""),file=negativeFile,append=TRUE)  
#                   
#                   ##test file
#                   testFilePosName <- paste(experimentName,"_",testsubsetindex,".test_pos",sep="")
#                   testFilePos <- paste(path,testFilePosName,sep="")
#                   
#                   if(file.exists(testFilePos))
#                     file.remove(testFilePos)                 
#                   
#                   testFileNegName <- paste(experimentName,"_",testsubsetindex,".test_neg",sep="")
#                   testFileNeg <- paste(path,testFileNegName,sep="")
#                   
#                   if(file.exists(testFileNeg))
#                     file.remove(testFileNeg) 
#                   
#                   
#                   ## settings[["test_pos"]] <- testFilePos##paste(experimentName,".test_pos",sep="")
#                   ##  settings[["test_neg"]] <- testFileNeg ##paste(experimentName,".test_neg",sep="")                
#                   
#                   #               }
#                   #               else
#                   #               {
#                   #                 testFilePos <- positiveFile                
#                   #                 testFileNeg <- negativeFile
#                   #                 
#                   #               }
#                   
#                   positivesolTest <- trainTable[trainTable[testsubset,targetName]==positiveValue,ui]
#                   write(paste("instanceJSS(i_",positivesolTest,").",sep=""),file=testFilePos,append=TRUE) 
#                   
#                   if(is.na(negativeValue))
#                   {
#                     negativesolTest <- trainTable[trainTable[testsubset,targetName]!=positiveValue,ui]                
#                   }
#                   else
#                   {
#                     negativesolTest <- trainTable[trainTable[testsubset,targetName]==negativeValue,ui]                 
#                   }
#                   
#                   write(paste("instanceJSS(i_",negativesolTest,").",sep=""),file=testFileNeg,append=TRUE) 
#                   
#                   crossvalidation.df <- rbind(crossvalidation.df,
#                                               data.frame(train_pos_file = positiveFileName,
#                                                          train_neg_file	= negativeFileName,
#                                                          test_pos_file = testFilePosName,
#                                                          test_neg_file	= testFileNegName,
#                                                          train_neg_instances = paste(negativesol,collapse=","),
#                                                          test_neg_file_instances	= paste(negativesolTest,collapse=","),
#                                                          test_pos_file_instances= paste(positivesolTest,collapse=","),
#                                                          train_pos_file_instances	= paste(positivesol,collapse=","),                                       
#                                                          fold_index	= testsubsetindex,
#                                                          kfoldcrossvalidation	= kfoldcrossvalidation))
#                   
#                   
#                   
#                   
#                   testsubsetindex <- testsubsetindex + 1  
#                 }
#                 
#                 
#                 
#               }
#               
#               
#               
#               run.df <- merge(crossvalidation.df,settings.df)
#               run.df$status <- rep("None",nrow(run.df))
#               run.df$experiment_uniqueID   <- rep(experimentUI,nrow(run.df))
#               
#               runName <-paste(experimentUI,run.df$run_index,run.df$fold_index,sep="_")
#               runName <- sub(pattern="_NA","_all",runName)
#               run.df$run_file <- runName
#               
#               dbWriteTable(con,"ILP_run",run.df,append = TRUE,row.names=FALSE)
#               
#               ################################################################################
#               ##features definitions##########################################################
#               ################################################################################
#               
#               
#               instanceWriteResults <- this$writeILPComponentData_new(instanceFeatureTable,"instance",instanceValuesSelectFunction,path,modeRecall=modeRecall)
#               
#               machineWriteResults <- this$writeILPComponentData_new(machineFeatureTable,"machine",machineValuesSelectFunction,path,modeRecall=modeRecall)
#               
#               jobWriteResults <- this$writeILPComponentData_new(jobFeatureTable,"job",machineValuesSelectFunction,path,modeRecall=modeRecall)
#               
#               operationWriteResults <-  this$writeILPComponentData_new(operationFeatureTable,"operation",operationValuesSelectFunction,path,modeRecall=modeRecall)
#               
#               files <- c(instanceWriteResults$files,machineWriteResults$files,jobWriteResults$files,operationWriteResults$files)        
#               
#               
#               
#               
#               
#               #########################################
#               ###Generate Run Bash Script##############
#               #########################################
#               
#               nrsettings <- length(settings)
#               
#               #               datafiles <- c("all")
#               #               
#               #               if(!is.null(kcrossvalidation))
#               #               {
#               #                 datafiles <- c(datafiles,1:testsubsetindex)
#               #                 
#               #               }
#               #               
#               #               for(datafilename in datafiles)
#               #               {
#               
#               
#               settingsNames <- unique(names(unlist(settings)))
#               
#               for(i in 1:nrow(run.df))
#               {
#                 set <- run.df[i,settingsNames]
#                 
#                 bText <- paste("
#                                :-['",paste(files,collapse="','"),"'].                      
#                                
#                                :- modeh(1,instanceJSS(+instanceJSSID)).","
#                                
#                                :-set(train_pos,'",run.df[i,"train_pos_file"],"').\n
#                                :-set(train_neg,'",run.df[i,"train_neg_file"],"').\n",sep="")
#                 
#                 
#                 if(!is.na(run.df[i,"test_pos_file"]))
#                 {
#                   bText <- paste(bText,"
#                                  :-set(test_pos,'",run.df[i,"test_pos_file"],"').\n
#                                  :-set(test_neg,'",run.df[i,"test_neg_file"],"').\n",sep="") 
#                   
#                 }
#                 
#                 if(refine)
#                 {
#                   bText <- paste(bText,"
#                                  :-set(refine,user).\n",sep="")            
#                 }
#                 
#                 
#                 
#                 
#                 
#                 
#                 runStg <- paste(bText,paste(paste(":-set(",names(set),",",set,").
#                                                   ",sep=""),collapse=""),"
#                                 
#                                 ",sep="")
#                 
#                 
#                 
#                 
#                 if(!is.na(machineFeatureTableName) && singleMachineByIndex )
#                 { 
#                   bText <- paste(bText,"
#                                  :- modeb(*,singleMachineByIndex(+instanceJSSID,-machineJSSID)).
#                                  :- determination(instanceJSS/1,singleMachineByIndex/2).
#                                  
#                                  singleMachineByIndex(InstanceID,MachineID):- var(InstanceID),!.
#                                  ",paste("singleMachineByIndex(InstanceID,MachineID):- atomic_list_concat([InstanceID,",1:max(machineFeatureTable[,"Machine"]),"],'_',MachineID).",collapse="\n"),sep="")
#                   
#                   
#                 }
#                 
#                 if(!is.na(jobFeatureTableName) && singleJobByIndex)
#                 { 
#                   bText <- paste(bText,"
#                                  :- modeb(*,singleJobByIndex(+instanceJSSID,-jobJSSID)).
#                                  :- determination(instanceJSS/1,singleJobByIndex/2).
#                                  
#                                  singleJobByIndex(InstanceID,JobID):- var(InstanceID),!.
#                                  ",paste("singleJobByIndex(InstanceID,JobID):- atomic_list_concat([InstanceID,",1:max(jobFeatureTable[,"Job"]),"],'_',JobID).
#                                          ",collapse=""),sep="")
#                   
#                   
#                 }
#                 
#                 if(!is.na(operationFeatureTableName))
#                 { 
#                   if(singleOperationByIndex)
#                   {
#                     bText <- paste(bText,"
#                                    :- modeb(*,singleOperationByIndex(+instanceJSSID,-operationJSSID)).
#                                    :- determination(instanceJSS/1,singleOperationByIndex/2).
#                                    
#                                    singleOperationByIndex(InstanceID,OperationID):- var(InstanceID),!.
#                                    ",paste("singleOperationByIndex(InstanceID,OperationID):- atomic_list_concat([InstanceID,",1:max(operationFeatureTableName[,"Job"]),",",1:max(operationFeatureTableName[,"Machine"]),"],'_',OperationID).
#                                            ",collapse=""),sep="")  
#                   }
#                   
#                   if(!is.na(machineFeatureTableName) && singleOperationFromMachineByIndex)
#                   { 
#                     bText <- paste(bText,"
#                                    :- modeb(*,singleOperationFromMachineByIndex(+machineJSSID,-operationJSSID)).
#                                    :- determination(instanceJSS/1,singleOperationFromMachineByIndex/2).
#                                    
#                                    singleOperationFromMachineByIndex(MachineID,OperationID):- var(MachineID),!.
#                                    ",paste("singleOperationFromMachineByIndex(MachineID,OperationID):- atomic_list_concat([i,InstanceUI,Machine],'_',MachineID),atomic_list_concat([i,InstanceUI,",1:max(operationFeatureTableName[,"Job"]),",Machine],'_',OperationID).
#                                            ",collapse=""),sep="")
#                   }
#                   
#                   if(!is.na(jobFeatureTableName) && singleOperationFromJobByIndex)
#                   { 
#                     bText <- paste(bText,"
#                                    :- modeb(*,singleOperationFromJobByIndex(+jobJSSID,-operationJSSID)).
#                                    :- determination(instanceJSS/1,singleOperationFromJobByIndex/2).
#                                    
#                                    singleOperationFromJobByIndex(JobID,OperationID):- var(JobID),!.
#                                    ",paste("singleOperationFromJobByIndex(JobID,OperationID):- atomic_list_concat([i,InstanceUI,Job],'_',JobID),atomic_list_concat([i,InstanceUI,Job,",1:max(operationFeatureTableName[,"Machine"]),"],'_',OperationID).
#                                            ",collapse=""),sep="")
#                   }
#                   
#                   
#                   
#                   
#                   }
#                 
#                 
#                 
#                 if(refine)
#                 {
#                   bText <- paste(bText,"
#                                  refine(false,instanceJSS(X)):- !.
#                                  
#                                  refine(instanceJSS(X),Clause):-
#                                  Clause=(instanceJSS(X) :- instanceHigherEqual(X,_,_,_,_)).
#                                  
#                                  refine(instanceJSS(X),Clause):-
#                                  Clause=(instanceJSS(X) :- instanceLowerEqual(X,_,_,_,_)).
#                                  
#                                  refine(instanceJSS(X),Clause):-
#                                  Clause=(instanceJSS(X) :- singleMachineByIndex(X,M),machineHigherEqual(M,_,_,_,_)).
#                                  
#                                  
#                                  refine(instanceJSS(X),Clause):-
#                                  Clause=(instanceJSS(X) :- singleMachineByIndex(X,M),machineLowerEqual(M,_,_,_,_)).
#                                  
#                                  refine(instanceJSS(X),Clause):-
#                                  Clause=(instanceJSS(X) :- singleJobByIndex(X,M),jobHigherEqual(M,_,_,_,_)).
#                                  
#                                  refine(instanceJSS(X),Clause):-
#                                  Clause=(instanceJSS(X) :- singleJobByIndex(X,M),jobLowerEqual(M,_,_,_,_)).
#                                  
#                                  
#                                  %%%%
#                                  
#                                  refine((instanceJSS(X):-instanceHigherEqual(X,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- instanceHigherEqual(X,A,B,C,D),singleMachineByIndex(X,M),machineHigherEqual(M,_,_,_,_)).
#                                  
#                                  refine((instanceJSS(X):-instanceHigherEqual(X,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- instanceHigherEqual(X,A,B,C,D),singleMachineByIndex(X,M),machineLowerEqual(M,_,_,_,_)).
#                                  
#                                  
#                                  refine((instanceJSS(X):-instanceLowerEqual(X,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- instanceLowerEqual(X,A,B,C,D),singleMachineByIndex(X,M),machineHigherEqual(M,_,_,_,_)).
#                                  
#                                  refine((instanceJSS(X):-instanceLowerEqual(X,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- instanceLowerEqual(X,A,B,C,D),singleMachineByIndex(X,M),machineLowerEqual(M,_,_,_,_)).
#                                  
#                                  %%%%%%%%%%%%%%%%%%%%                                 
#                                  
#                                  refine((instanceJSS(X):-instanceHigherEqual(X,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- instanceHigherEqual(X,A,B,C,D),singleJobByIndex(X,M),jobHigherEqual(M,_,_,_,_)).
#                                  
#                                  refine((instanceJSS(X):-instanceHigherEqual(X,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- instanceHigherEqual(X,A,B,C,D),singleJobByIndex(X,M),jobLowerEqual(M,_,_,_,_)).
#                                  
#                                  refine((instanceJSS(X):-instanceLowerEqual(X,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- instanceLowerEqual(X,A,B,C,D),singleJobByIndex(X,M),jobHigherEqual(M,_,_,_,_)).
#                                  
#                                  refine((instanceJSS(X):-instanceLowerEqual(X,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- instanceLowerEqual(X,A,B,C,D),singleJobByIndex(X,M),jobLowerEqual(M,_,_,_,_)).
#                                  
#                                  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#                                  
#                                  refine((instanceJSS(X):-instanceHigherEqual(X,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- instanceHigherEqual(X,A,B,C,D),instanceLowerEqual(X,A,_,_,_)).
#                                  
#                                  refine((instanceJSS(X):-instanceHigherEqual(X,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- instanceHigherEqual(X,A,B,C,D),instanceLowerEqual(X,A1,_,_,_),A\\==A1).
#                                  
#                                  refine((instanceJSS(X):-instanceHigherEqual(X,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- instanceHigherEqual(X,A,B,C,D),instanceHigherEqual(X,_,_,_,_)).
#                                  
#                                  
#                                  %%Repitacao???                               
#                                  refine((instanceJSS(X):-instanceLowerEqual(X,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- instanceLowerEqual(X,A,B,C,D),instanceHigherEqual(X,A,_,_,_)).
#                                  
#                                  refine((instanceJSS(X):-instanceLowerEqual(X,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- instanceLowerEqual(X,A,B,C,D),instanceLowerEqual(X,_,_,_,_)).                                 
#                                  
#                                  
#                                  
#                                  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#                                  refine((instanceJSS(X):-singleMachineByIndex(X,M),machineHigherEqual(M,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- singleMachineByIndex(X,M),machineHigherEqual(M,A,B,C,D),singleJobByIndex(X,J),jobHigherEqual(J,_,_,_,_)).
#                                  
#                                  refine((instanceJSS(X):-singleMachineByIndex(X,M),machineHigherEqual(M,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- singleMachineByIndex(X,M),machineHigherEqual(M,A,B,C,D),singleJobByIndex(X,J),jobLowerEqual(J,_,_,_,_)).
#                                  
#                                  
#                                  refine((instanceJSS(X):-singleMachineByIndex(X,M),machineHigherEqual(M,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- singleMachineByIndex(X,M),machineHigherEqual(M,A,B,C,D),singleMachineByIndex(X,M1),M\\==M1,machineHigherEqual(M1,_,_,_,_)).
#                                  
#                                  
#                                  refine((instanceJSS(X):-singleMachineByIndex(X,M),machineHigherEqual(M,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- singleMachineByIndex(X,M),machineHigherEqual(M,A,B,C,D),singleMachineByIndex(X,M1),M\\==M1,machineLowerEqual(M1,_,_,_,_)).
#                                  
#                                  refine((instanceJSS(X):-singleMachineByIndex(X,M),machineHigherEqual(M,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- singleMachineByIndex(X,M),machineHigherEqual(M,A,B,C,D),machineLowerEqual(M,A,_,_,_)).
#                                  
#                                  refine((instanceJSS(X):-singleMachineByIndex(X,M),machineHigherEqual(M,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- singleMachineByIndex(X,M),machineHigherEqual(M,A,B,C,D),machineHigherEqual(M,_,_,_,_)).
#                                  
#                                  refine((instanceJSS(X):-singleMachineByIndex(X,M),machineHigherEqual(M,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- singleMachineByIndex(X,M),machineHigherEqual(M,A,B,C,D),machineLowerEqual(M,A1,_,_,_),A1\\==A).
#                                  
#                                  
#                                  
#                                  
#                                  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#                                  
#                                  refine((instanceJSS(X):-singleJobByIndex(X,M),jobHigherEqual(M,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- singleJobByIndex(X,M),jobHigherEqual(M,A,B,C,D),singleJobByIndex(X,M1),M\\==M1,jobHigherEqual(M1,_,_,_,_)).
#                                  
#                                  refine((instanceJSS(X):-singleJobByIndex(X,M),jobHigherEqual(M,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- singleJobByIndex(X,M),jobHigherEqual(M,A,B,C,D),singleJobByIndex(X,M1),M\\==M1,jobLowerEqual(M1,_,_,_,_)).
#                                  
#                                  refine((instanceJSS(X):-singleJobByIndex(X,M),jobHigherEqual(M,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- singleJobByIndex(X,M),jobHigherEqual(M,A,B,C,D),jobLowerEqual(M,A,_,_,_)).
#                                  
#                                  refine((instanceJSS(X):-singleJobByIndex(X,M),jobHigherEqual(M,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- singleJobByIndex(X,M),jobHigherEqual(M,A,B,C,D),jobHigherEqual(M,_,_,_,_)).
#                                  
#                                  refine((instanceJSS(X):-singleJobByIndex(X,M),jobHigherEqual(M,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- singleJobByIndex(X,M),jobHigherEqual(M,A,B,C,D),jobLowerEqual(M,A1,_,_,_),A1\\==A).
#                                  
#                                  
#                                  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#                                  refine((instanceJSS(X):-singleMachineByIndex(X,M),machineLowerEqual(M,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- singleMachineByIndex(X,M),machineLowerEqual(M,A,B,C,D),singleJobByIndex(X,J),jobHigherEqual(J,_,_,_,_)).
#                                  
#                                  refine((instanceJSS(X):-singleMachineByIndex(X,M),machineLowerEqual(M,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- singleMachineByIndex(X,M),machineLowerEqual(M,A,B,C,D),singleJobByIndex(X,J),jobLowerEqual(J,_,_,_,_)).
#                                  
#                                  
#                                  refine((instanceJSS(X):-singleMachineByIndex(X,M),machineLowerEqual(M,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- singleMachineByIndex(X,M),machineLowerEqual(M,A,B,C,D),singleMachineByIndex(X,M1),M\\==M1,machineLowerEqual(M1,_,_,_,_)).
#                                  
#                                  refine((instanceJSS(X):-singleMachineByIndex(X,M),machineLowerEqual(M,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- singleMachineByIndex(X,M),machineLowerEqual(M,A,B,C,D),singleMachineByIndex(X,M1),M\\==M1,machineHigherEqual(M1,_,_,_,_)).
#                                  
#                                  refine((instanceJSS(X):-singleMachineByIndex(X,M),machineLowerEqual(M,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- singleMachineByIndex(X,M),machineLowerEqual(M,A,B,C,D),machineHigherEqual(M,A,_,_,_)).
#                                  
#                                  refine((instanceJSS(X):-singleMachineByIndex(X,M),machineLowerEqual(M,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- singleMachineByIndex(X,M),machineLowerEqual(M,A,B,C,D),machineLowerEqual(M,_,_,_,_)).
#                                  
#                                  refine((instanceJSS(X):-singleMachineByIndex(X,M),machineLowerEqual(M,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- singleMachineByIndex(X,M),machineLowerEqual(M,A,B,C,D),machineHigherEqual(M,A1,_,_,_),A1\\==A).
#                                  
#                                  
#                                  
#                                  
#                                  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#                                  
#                                  refine((instanceJSS(X):-singleJobByIndex(X,M),jobLowerEqual(M,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- singleJobByIndex(X,M),jobLowerEqual(M,A,B,C,D),singleJobByIndex(X,M1),M\\==M1,jobLowerEqual(M1,_,_,_,_)).
#                                  
#                                  refine((instanceJSS(X):-singleJobByIndex(X,M),jobLowerEqual(M,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- singleJobByIndex(X,M),jobLowerEqual(M,A,B,C,D),singleJobByIndex(X,M1),M\\==M1,jobLowerEqual(M1,_,_,_,_)).
#                                  
#                                  refine((instanceJSS(X):-singleJobByIndex(X,M),jobLowerEqual(M,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- singleJobByIndex(X,M),jobLowerEqual(M,A,B,C,D),jobHigherEqual(M,A,_,_,_)).
#                                  
#                                  refine((instanceJSS(X):-singleJobByIndex(X,M),jobLowerEqual(M,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- singleJobByIndex(X,M),jobLowerEqual(M,A,B,C,D),jobLowerEqual(M,_,_,_,_)).
#                                  
#                                  refine((instanceJSS(X):-singleJobByIndex(X,M),jobLowerEqual(M,A,B,C,D)),Clause):-
#                                  Clause=(instanceJSS(X) :- singleJobByIndex(X,M),jobLowerEqual(M,A,B,C,D),jobHigherEqual(M,A1,_,_,_),A1\\==A).",sep="")
#                   
#                 }
#                 
#                 
#                 
#                 
#                 write(bText,file=paste(path,experimentName,"_",run.df[i,"run_file"],".b",sep=""))
#                 
#                 
#                 
#                 runStg <- paste("#!/bin/csh
#                                 
#                                 yap <<+
#                                 use_module(library(lists)).
#                                 use_module(library(system)).
#                                 
#                                 working_directory(CWD,'",path,"').
#                                 
#                                 ['../../../../aleph.pl'].
#                                 ['../../../../pedabreu.pl'].
#                                 
#                                 read_all('",experimentName,"_",run.df[i,"run_file"],"').\n
#                                 
#                                 
#                                 induce.
#                                 write_rules_xml('results_",run.df[i,"run_file"],".xml').
#                                 halt.
#                                 +",sep="")
#                 
#                 write(runStg,file=paste(path,"run_",run.df[i,"run_file"],sep="") )   
#                 
#                 
#                 
#                 
#                   }
#               ##}
#               #########################################
#               #########################################
#               
#               
#               
#               
#               
#               #########################################
#               ##save parameters in XML#################
#               #########################################
#               #               tt <- xmlHashTree()
#               #               parameterNode <- addNode(xmlNode("parameters"), character(), tt)
#               # 
#               #               
#               #               instancefeaturesGroupValueNode <- addNode(xmlNode("instanceFeaturesGroup"), parameterNode, tt)              
#               #               addNode(xmlTextNode(instanceFeatureTableName), instancefeaturesGroupValueNode, tt)
#               #              
#               #               jobfeaturesGroupValueNode <- addNode(xmlNode("jobFeaturesGroup"), parameterNode, tt)              
#               #               addNode(xmlTextNode(jobFeatureTableName), jobfeaturesGroupValueNode, tt)
#               #               
#               #               machinefeaturesGroupValueNode <- addNode(xmlNode("machineFeaturesGroup"), parameterNode, tt)              
#               #               addNode(xmlTextNode(machineFeatureTableName), machinefeaturesGroupValueNode, tt)
#               #               
#               #               operationfeaturesGroupValueNode <- addNode(xmlNode("operationFeaturesGroup"), parameterNode, tt)              
#               #               addNode(xmlTextNode(operationFeatureTableName), operationfeaturesGroupValueNode, tt)
#               #               
#               #               
#               #               targetValueNode <- addNode(xmlNode("target"), parameterNode, tt)              
#               #               addNode(xmlTextNode(target), targetValueNode, tt)
#               #               
#               #               positiveValueNode <- addNode(xmlNode("positiveValue"), parameterNode, tt)              
#               #               addNode(xmlTextNode(positiveValue), positiveValueNode, tt)
#               #               
#               #               negativeValueNode <- addNode(xmlNode("negativeValue"), parameterNode, tt)              
#               #               addNode(xmlTextNode( negativeValue),negativeValueNode, tt)              
#               #               
#               #               modeRecallNode <- addNode(xmlNode("modeRecall"), parameterNode, tt)              
#               #               addNode(xmlTextNode(modeRecall),  modeRecallNode, tt)                
#               # 
#               #               alephNode <- addNode(xmlNode("aleph"), parameterNode, tt) 
#               #               
#               #               for(setIndex in 1:length(settings))
#               #               { 
#               #                 set <- settings[[setIndex]]
#               #                 
#               #                 setNode <- addNode(xmlNode(paste("run-",setIndex,sep="")), alephNode, tt)
#               #                 ##addNode(xmlTextNode(set[[settingName]]), setNode, tt)  
#               #                 
#               #                 for(settingName in names(set))
#               #                 {
#               #                   node <- addNode(xmlNode(settingName), setNode, tt)
#               #                   addNode(xmlTextNode(set[[settingName]]), node, tt)                                
#               #                 }       
#               # 
#               #               }
#               
#               domain.df <- data.frame()
#               
#               # instanceDomainNode <- addNode(xmlNode("instanceDomain"), parameterNode, tt) 
#               allDomainValues <- instanceWriteResults$domainValues 
#               
#               for(valueSelName in names(allDomainValues))
#               {                
#                 #  node <- addNode(xmlNode(valueSelName), instanceDomainNode, tt)
#                 #  addNode(xmlTextNode(paste(allDomainValues[[valueSelName]],collapse=";")), node, tt) 
#                 
#                 domain.df <- rbind(domain.df,
#                                    data.frame(experiment_uniqueID = experimentUI,
#                                               feature = valueSelName,
#                                               component = "instance",
#                                               domainValues	= paste(allDomainValues[[valueSelName]],collapse=";")))
#                 
#                 
#               }
#               
#               ## machineDomainNode <- addNode(xmlNode("machineDomain"), parameterNode, tt) 
#               allDomainValues <- machineWriteResults$domainValues 
#               
#               for(valueSelName in names(allDomainValues))
#               {                
#                 ## node <- addNode(xmlNode(valueSelName), machineDomainNode, tt)
#                 ##  addNode(xmlTextNode(paste(allDomainValues[[valueSelName]],collapse=";")), node, tt)   
#                 
#                 domain.df <- rbind(domain.df,
#                                    data.frame(experiment_uniqueID = experimentUI,
#                                               feature = valueSelName,
#                                               component = "machine",
#                                               domainValues  = paste(allDomainValues[[valueSelName]],collapse=";")))
#                 
#               }
#               
#               ##  jobDomainNode <- addNode(xmlNode("jobDomain"), parameterNode, tt) 
#               allDomainValues <- jobWriteResults$domainValues 
#               
#               for(valueSelName in names(allDomainValues))
#               {                
#                 ##  node <- addNode(xmlNode(valueSelName), jobDomainNode, tt)
#                 ##  addNode(xmlTextNode(paste(allDomainValues[[valueSelName]],collapse=";")), node, tt)     
#                 
#                 domain.df <- rbind(domain.df,
#                                    data.frame(experiment_uniqueID = experimentUI,
#                                               feature = valueSelName,
#                                               component = "job",
#                                               domainValues  = paste(allDomainValues[[valueSelName]],collapse=";")))
#                 
#                 
#               }
#               
#               ##  operationDomainNode <- addNode(xmlNode("jobDomain"), parameterNode, tt) 
#               allDomainValues <- operationWriteResults$domainValues 
#               
#               for(valueSelName in names(allDomainValues))
#               {                
#                 ##  node <- addNode(xmlNode(valueSelName),operationDomainNode, tt)
#                 ## addNode(xmlTextNode(paste(allDomainValues[[valueSelName]],collapse=";")), node, tt)   
#                 
#                 domain.df <- rbind(domain.df,
#                                    data.frame(experiment_uniqueID = experimentUI,
#                                               feature = valueSelName,
#                                               component = "operation",
#                                               domainValues  = paste(allDomainValues[[valueSelName]],collapse=";")))
#                 
#               }
#               
#               
#               dbWriteTable(con,"ILP_domain",domain.df,append=TRUE,row.names=FALSE)
#               
#               
#               #               
#               #               sink(paste(path,"parameters.xml",sep=""))
#               #               print(tt)
#               #               sink() 
#               ##########################################
#               
#                   })
# # 
# # setMethodS3("generateILPData","ExperimentFramework", 
# #             function(this,
# #                      target,
# #                      featureTable,
# #                      positiveValue = "LPT",
# #                      negativeValue = "SPT",
# #                      valuesSelectFunction = function(x){unique(x)},
# #                      test = FALSE,
# #                      path = paste("./",featureTable,"_",target,"/",sep=""),
# #                      local = TRUE, 
# #                      ...) {              
# #               
# #               experimentName <- paste(featureTable,"_",target,sep="")
# #               
# #               con <- this$connectionDB               
# #               # open the connection using user, passsword, etc., as
# #               # specified in the file \file{\$HOME/.my.cnf}
# #               
# #               
# #               trainTable <- paste("Target_",target,sep="") 
# #               testTable <- NULL
# #               
# #               if(test)
# #               {
# #                 trainTable <- paste(trainTable,"_train",sep="") 
# #                 testTable <- paste(trainTable,"_test",sep="") 
# #               }
# #               
# #               
# #               
# #               ui <- "Instance_uniqueID"
# #               
# #               dir.create(path, showWarnings = FALSE)
# #               ##dir.create(paste("./Experiment-",exp,"/Data",sep=""), showWarnings = FALSE)
# #               
# #               
# #               ## path <- paste("./Experiment-",exp,"/Data/",sep="")
# #               positiveFile <- paste(path,experimentName,".f",sep="")
# #               if(file.exists(positiveFile))
# #                 file.remove(positiveFile)
# #               
# #               negativeFile <- paste(path,experimentName,".n",sep="")
# #               if(file.exists(negativeFile))
# #                 file.remove(negativeFile)
# #               
# #               featTable <- paste("Features_",featureTable,sep="")
# #      
# #               if(local)
# #               {
# #                 solFeatures<- read.csv(file=paste("../../../../Domain/CSV/",featTable,sep=""),sep=";")
# #               }
# #               else
# #               {
# #                 solFeatures <- dbReadTable(con,featTable)
# #               }
# #               
# #               
# #               if(local)
# #               {
# #                 sol<- read.csv(file=paste("../../../../Domain/CSV/",trainTable,sep=""),sep=";")
# #               }
# #               else
# #               {
# #                 sol <- dbReadTable(con,trainTable)
# #               }
# #                         
# #               instancesUI <- intersect(solFeatures[,ui],sol[,ui])
# #               
# #               
# #               sol <- sol[sol[,ui] %in% instancesUI,]
# #               solFeatures <- solFeatures[solFeatures[,ui] %in% instancesUI,]   
# #               
# #               
# #               
# #               
# #               targetName <- colnames(sol)[-which(colnames(sol)==ui)]
# #              
# #                 
# #               positivesol <- sol[sol[,targetName]==positiveValue,ui]
# #               write(paste("instance(",positivesol,").",sep=""),file=positiveFile,append=TRUE) 
# #               
# #               
# #               negativesol <- sol[sol[,targetName]==negativeValue,ui]
# #               write(paste("instance(",negativesol,").",sep=""),file=negativeFile,append=TRUE) 
# #               
# #               
# #               
# #               
# #               
# #               if(test)
# #               {
# #                 
# #                 if(local)
# #                 {
# #                   solTest<- read.csv(file=paste("../../../../Domain/CSV/",testTable,sep=""),sep=";")
# #                 }
# #                 else
# #                 {
# #                   solTest <- dbReadTable(con,testTable)
# #                 }
# #                 
# #                 
# #                 positiveTestFile <- paste(path,experimentName,"_test.f",sep="")
# #                 if(file.exists(positiveTestFile))
# #                   file.remove(positiveTestFile)
# #                 
# #                 for(problemClass in classes)
# #                 {
# #                   problemClassValue <- tolower(problemClass)
# #                   
# #                   positivesol <- solTest[solTest[,targetName]==problemClass,ui]
# #                   write(paste("class(",positivesol,",",problemClassValue,").",sep=""),file=positiveTestFile,append=TRUE) 
# #                   
# #                   
# #                   
# #                   
# #                 }
# #                 
# #                 
# #                 
# #               }
# #               
# #               
# #               
# #               
# #               
# #               
# #               ################################################################################
# #               ##features definitions##########################################################
# #               ################################################################################
# #               
# #               bText <- paste(":-['instances.b','bk-aux.b'].
# #                              
# # 
# # :- determination(instance/1,lteq/2).
# # :- determination(instance/1,hteq/2).
# # :- modeh(1,instance(+instanceJSS)).
# #                              
# # :- set(minpos,10).
# # :- set(depth,2000).
# # :- set(noise,20).
# # :- set(clauselength,6).
# #                              
# #                              
# # lteq(X,Y):-
# # var(Y), !,
# # X = Y.
# # 
# # lteq(X,Y):-
# # number(X), number(Y),
# # X =< Y.
# # 
# # hteq(X,Y):-
# # var(Y), !,
# # X = Y.
# # 
# # hteq(X,Y):-
# # number(X), number(Y),
# # X >= Y.",sep="")
# #               
# #               bFile <- paste(path,experimentName,".b",sep="")
# #               write(bText,file=bFile)
# #               
# #               
# #               
# #               features <- colnames(solFeatures)
# #               features <- setdiff(features,c(ui))
# #               
# #               fileInstanceBK <-  paste(path,"instances.b",sep="")
# #               fileAuxBK <-  paste(path,"bk-aux.b",sep="")
# #               
# #               if(file.exists(fileInstanceBK))
# #                 file.remove(fileInstanceBK)
# #               
# #               if(file.exists(fileAuxBK))
# #                 file.remove(fileAuxBK)
# #               
# #               for(featIndex in 1:length(features))
# #               {
# #                 featName <- features[featIndex]
# #                 v <- rep("_",length(features))
# #                 v[featIndex] <- "X"
# #                 
# #                 stg <- paste(tolower(featName),"(Uniqueid,X):-instancesFeatures(Uniqueid,",paste(v,collapse=","),")." ,sep=""  )   
# #                 
# #                 write(stg,file=fileInstanceBK,append=TRUE)
# #                 
# #                 selectValues <- eval(call(valuesSelectFunction,solFeatures[,featName]))
# #                 
# #                 allvaluesStg <- paste(tolower(featName),"value(",selectValues,").",sep="")
# #                 write(allvaluesStg,file=fileInstanceBK,append=TRUE)   
# #                 
# #                 
# #               }
# #               
# #               apply(solFeatures,1,function(x)
# #               {  
# #                 stg <- paste("instancesFeatures(",x[ui],",",paste(x[features],collapse=","),").",sep="")
# #                 write(stg,file=fileInstanceBK,append=TRUE)
# #               })
# #               
# #               if(test)
# #               {
# #                 apply(solTest,1,function(x)
# #                 {  
# #                   stg <- paste("instancesFeatures(",x[ui],",",paste(x[features],collapse=","),").",sep="")
# #                   write(stg,file=fileInstanceBK,append=TRUE)
# #                 })
# #               }
# #               
# #               stgDetermination <-  paste(":- determination(instance/1,",tolower(features),"/2).",sep="")
# #               write(stgDetermination,file=fileAuxBK,append=TRUE)
# #               
# #               stgModeb <-  paste(":- modeb(3,",tolower(features),"(+instanceJSS,-",tolower(features),"value)).",sep="")    
# #               write(stgModeb,file=fileAuxBK,append=TRUE)
# #               
# #               stgModeb <-  paste(":- modeb(3, lteq(+",tolower(features),"value,#",tolower(features),"value)).",sep="")    
# #               write(stgModeb,file=fileAuxBK,append=TRUE)
# #               
# #               stgModeb <-  paste(":- modeb(3, hteq(+",tolower(features),"value,#",tolower(features),"value)).",sep="")    
# #               write(stgModeb,file=fileAuxBK,append=TRUE)
# #               
# #             })
# # 



setMethodS3("generateExperimentTable","ExperimentFramework", 
            function(this,
                     id,
                     nr,
                     nrjobs,
                     nrmachines,
                     featuresGroups,
                     targetGroup,
                     target,
                     ...) {              
              
              
              ui <- paste(format(Sys.time(), "%y%m%d%H%M%S"),
                          paste(sample(c(0:9, letters, LETTERS))[1:4],collapse=""),sep="")
              name <- paste("Data_",nrjobs,"x",nrmachines,"_",nr,"_",targetGroup,"_",id,sep="")
              
              
              features <- NULL
              #targets <- NULL
              insertquery <- NULL
              for(featGroup in featuresGroups)
              {
                solFeat <- dbGetQuery(con,paste("SHOW COLUMNS FROM ",featGroup,sep=""))
                
                features <- c(features,solFeat[solFeat[,"Key"] != "PRI","Field"]) 

               ## insertquery <- c(insertquery,paste("('",ui,"','",,")",sep="")  )
                
              }
              
              solTarget <- dbGetQuery(con,paste("SHOW COLUMNS FROM ",targetGroup,sep=""))
              
              targets <- solTarget[solTarget[,"Key"] != "PRI","Field"]    
              
              
              con <- this$connectionDB    
              leftjoin <- paste(paste(" JOIN ",c(featuresGroups,targetGroup)," ON I.uniqueID=",c(featuresGroups,targetGroup),".Instance_uniqueID",sep=""),collapse="  ")
              
              dbSendQuery(con,paste("DROP TABLE IF EXISTS ",name,sep=""))
              query <- paste("SELECT I.uniqueID,",paste(c(features,targets),collapse=","),"  FROM (SELECT uniqueID FROM Instance WHERE nrJobs=",nrjobs," AND nrMachines=",nrmachines,") I ",leftjoin," ORDER BY RAND() LIMIT ",nr,sep="")
#              query <- paste("SELECT I.uniqueID,",paste(c(features,target),collapse=","),"  FROM (SELECT uniqueID FROM Instance WHERE nrJobs=",nrjobs," AND nrMachines=",nrmachines,") I ",leftjoin," ORDER BY RAND() LIMIT ",nr,sep="")
 
              soloriginal <- dbGetQuery(con,query)
                sol <- soloriginal
#               features <- features[apply(soloriginal[,features], 2, var, na.rm=TRUE) != 0]
#               sol <- soloriginal[,c("uniqueID",features,targets)]
#               
#               corsol <- cor(sol[,features])
#               removecol <- NULL
#               
#               for(feat in features)
#               {
#                 
#                 corTofeat <-setdiff(colnames(corsol)[corsol[feat,]==1],feat)
#                 
#                 removecol <- c(which(colnames(sol) %in% corTofeat))
#                 
#                 sol <- sol[,]
#                 
#               }
              
            
        
              
              
              
              dbWriteTable(conn=con,name=name,value=sol,overwrite=TRUE, row.names = FALSE)
              write.csv(sol,file=paste("../../CSV/",name,sep=""), row.names = FALSE)
              
#               DBExpTableObj <- DBExperimentTables()
#               
#               
#               DBExpTableObj$attributes <- list(uniqueID=ui,
#                                                targetGroup  = targetGroup,
#                                                target = target,
#                                                targetType = class(sol[,target]))
#               
#               
#               DBExpTableObj$save()
              
            })
              
setMethodS3("infoRun","ExperimentFramework", 
            function(this,...) {
              
              con <- this$connectionDB
              
              
              print("##Run Done#########################3")
              
              q<-"SELECT AP.name,AlgorithmParameterized_uniqueID,nrJobs,nrMachines,count(*) FROM jss_dev.Run R,Instance I, AlgorithmParameterized AP WHERE AP.uniqueID=R.AlgorithmParameterized_uniqueID AND status='Finished' AND I.uniqueID=R.Instance_uniqueID GROUP BY AlgorithmParameterized_uniqueID,nrJobs,nrMachines"
              sol <- dbGetQuery(con,q)
              print(sol)
              print("##Run Scheduled#########################3")
              
              q1<-"SELECT AP.name,AlgorithmParameterized_uniqueID,nrJobs,nrMachines,count(*) FROM jss_dev.Run R,Instance I, AlgorithmParameterized AP   WHERE AP.uniqueID=R.AlgorithmParameterized_uniqueID AND status='None'  AND I.uniqueID=R.Instance_uniqueID GROUP BY AlgorithmParameterized_uniqueID,nrJobs,nrMachines"
              sol1 <- dbGetQuery(con,q1)
              print(sol1)
              
              print("##Running#########################3")
              
              q1<-"SELECT AP.name,AlgorithmParameterized_uniqueID,nrJobs,nrMachines,count(*) FROM jss_dev.Run R,Instance I, AlgorithmParameterized AP   WHERE AP.uniqueID=R.AlgorithmParameterized_uniqueID AND status NOT IN ('None','Finished')  AND I.uniqueID=R.Instance_uniqueID GROUP BY AlgorithmParameterized_uniqueID,nrJobs,nrMachines"
              sol1 <- dbGetQuery(con,q1)
              print(sol1)
            })


setMethodS3("infoFeatures","ExperimentFramework", 
            function(this,...) {
              
              con <- this$connectionDB
              
              queryFeatGroup <- "SELECT * FROM FeaturesGroups"              
              solFeatGroup <- dbGetQuery(con,queryFeatGroup)
              
              for(featGroupIndex in 1:nrow(solFeatGroup))
              {
                obj <- solFeatGroup[featGroupIndex,"object"]
                name <- solFeatGroup[featGroupIndex,"name"]             
                print(paste(name,obj))
                
                queryFeatGroupTable <- paste("SELECT count(DISTINCT Instance_uniqueID) AS nr FROM ",obj,"_",name,sep="")
                solFeatGroupTable <- dbGetQuery(con,queryFeatGroupTable)
     
                print(paste("Number instances ",solFeatGroupTable[1,"nr"]))
                
                
                
                
                
                print("########################################################")      
              }
              
              
              query1 <- "SELECT FeaturesGroups_name,FeaturesGroups_object,status,count(*) AS nr FROM jss_dev.FeatureExperimentObjects GROUP BY FeaturesGroups_name,FeaturesGroups_object,status;"
              sol1 <- dbGetQuery(con,query1)
              
              print("Status:None")
              
              print(sol1[which(sol1[,"status"]=="None"),])
              
              print("Status:Running in GRID") 
              sol2 <- sol1[-which(sol1[,"status"]=="None" | sol1[,"status"]=="Finished"),]     
         
              print(aggregate(nr~FeaturesGroups_name+FeaturesGroups_object,sol2,sum))
              
              
              
            })


setMethodS3("inconsistenceData","ExperimentFramework", 
            function(this,deleteFromDB=FALSE,...) {
              
              con <- this$connectionDB
              
              queryInstance <- "SELECT I.uniqueID,nrJobs*nrMachines AS size,nrOperations FROM (SELECT *,count(*) AS nrOperations FROM Operation GROUP BY Instance_uniqueID) O,Instance I WHERE O.Instance_uniqueID=I.uniqueID HAVING nrOperations<>size"              
          
              solInstance <- dbGetQuery(con,queryInstance)
              
              if(dim(solInstance)[1]>0)
              {
                inconsistenceInstances <- solInstance[,"uniqueID"]
                uiString <- paste("('",paste(inconsistenceInstances,collapse="','"),"')",sep="")
                print("Inconsistence Instances")
                #print(inconsistenceInstances)
                print(length(inconsistenceInstances))
                solSchedFromInst <- dbGetQuery(con,paste("SELECT uniqueID FROM FeasibleSchedule WHERE Instance_uniqueID IN ",uiString,sep=""))
                
                
                
                inconsistenceSchedFromInconsistenceInstance <-solSchedFromInst[,"uniqueID"]
                print("Inconsistence Schedule From Inconsistence Instances")
                print(inconsistenceSchedFromInconsistenceInstance)
                dim(length(inconsistenceSchedFromInconsistenceInstance))
                inconsistenceSchedFromInconsistenceInstanceString <- paste("('",paste(inconsistenceSchedFromInconsistenceInstance,collapse="','"),"')",sep="")              
                
                if(deleteFromDB)
                {
                  
                  dbSendQuery(con,paste("DELETE FROM Run WHERE Instance_uniqueID IN ",uiString,sep=""))
                  
                  dbSendQuery(con,paste("DELETE FROM FeasibleScheduleOperation WHERE FeasibleSchedule_uniqueID IN ",inconsistenceSchedFromInconsistenceInstanceString,sep=""))                
                  dbSendQuery(con,paste("DELETE FROM Operation WHERE Instance_uniqueID IN ",uiString,sep=""))
                  
                  
                  
                  dbSendQuery(con,paste("DELETE FROM FeasibleSchedule WHERE uniqueID IN ",inconsistenceSchedFromInconsistenceInstanceString,sep=""))
                  dbSendQuery(con,paste("DELETE FROM Instance WHERE uniqueID IN ",uiString,sep=""))
                  
                  
                  
                }
                
              }
              else{
                print("There isn't any instance inconsistence")
              }
              
              querySchedule <- "SELECT FS.uniqueID,nrJobs*nrMachines AS size,nrOperations FROM Instance I,(SELECT* FROM FeasibleSchedule WHERE start_times_xml IS NULL) FS,(SELECT *,count(*) AS nrOperations FROM FeasibleScheduleOperation GROUP BY FeasibleSchedule_uniqueID) FSO WHERE I.uniqueID=FS.Instance_uniqueID AND FS.uniqueID=FSO.FeasibleSchedule_uniqueID GROUP BY FS.uniqueID HAVING size<>nrOperations"
              querySched1 <- "SELECT DISTINCT FeasibleSchedule_uniqueID FROM (SELECT *,count(*) AS nrOperations FROM FeasibleScheduleOperation GROUP BY FeasibleSchedule_uniqueID,job,machine) T WHERE nrOperations > 1"
              
              solSchedule <- dbGetQuery(con,querySchedule)
              solSchedule1 <- dbGetQuery(con,querySched1)
              
              if(nrow(solSchedule)>0)
              {
                
                inconsistenceSchedule <- solSchedule[,"uniqueID"]
                
              }
              
              if(nrow(solSchedule1)>0)
              {
                inconsistenceSchedule <- c(inconsistenceSchedule,
                                           solSchedule1[,"FeasibleSchedule_uniqueID"])
                
              }
              
              
         
              
              if(length(inconsistenceSchedule) > 0)
              {
                
                inconsistenceSchedule <- unique(inconsistenceSchedule)
                
                print("Inconsistence Schedule")
                
                
                #print(solSchedule[,"uniqueID"])
                schedInconsistenceString <- paste("('",paste(inconsistenceSchedule,collapse="','"),"')",sep="")              
                
                solNrSchedules <- dbGetQuery(con,paste("SELECT AlgorithmParameterized_uniqueID,count(*) AS nrSchedules FROM Run  WHERE FeasibleSchedule_uniqueID IN ",schedInconsistenceString," GROUP BY AlgorithmParameterized_uniqueID",sep=""))
                
                print(solNrSchedules)
                
                
                if(deleteFromDB)
                {
                  dbSendQuery(con,paste("UPDATE Run SET status='None',start_time=NULL,seed=NULL,systemTime=NULL,userTime=NULL,elapsedTime=NULL,FeasibleSchedule_uniqueID=NULL  WHERE FeasibleSchedule_uniqueID IN ",schedInconsistenceString,sep="")) 
                 
                  dbSendQuery(con,paste("DELETE FROM FeasibleScheduleOperation WHERE FeasibleSchedule_uniqueID IN ",schedInconsistenceString,sep=""))                
                  dbSendQuery(con,paste("DELETE FROM FeasibleSchedule WHERE uniqueID IN ",schedInconsistenceString,sep=""))
                }
                
              }
              else{
                print("There isn't any schedule inconsistence")
              }
              
              
              ###Missing schedules 
              queryRunMissingSchedule <- "SELECT FeasibleSchedule_uniqueID FROM Run R WHERE R.FeasibleSchedule_uniqueID NOT IN (SELECT uniqueID FROM FeasibleSchedule)"
              solRunMissingSchedule <- dbGetQuery(con,queryRunMissingSchedule)
              
              print("Number of missing schedules from runs")
              print(length(solRunMissingSchedule[,1]))
              
              
              if(deleteFromDB)
              {
                dbSendQuery(con,"DELETE FROM Run WHERE FeasibleSchedule_uniqueID NOT IN (SELECT uniqueID FROM FeasibleSchedule)")                
              }
              
           
            })



setMethodS3("runLearningExperiments","ExperimentFramework", 
            function(this,nr,...) {
              
              con <- this$connectionDB
              
              
            })


setMethodS3("lockOptimizationExperiments","ExperimentFramework", 
            function(this,nr,...) {
              
              con <- exp$simpleConnectDB()
                                          
              dbSendQuery(con,paste("UPDATE Run SET status='",this$id,"' WHERE status='None' LIMIT ",nr,sep=""))
              
              dbDisconnect(con)
              
              
            })

setMethodS3("runOptimizationExperiments","ExperimentFramework", 
            function(this,...) {
              
              #con <- this$connectionDB
              con <- this$simpleConnectDB()
              
              experiments <- dbGetQuery(con,paste("SELECT * FROM Run WHERE status='",this$id,"'",sep=""))
              dbDisconnect(con)
              
              d <- dim(experiments)
              previousAlgorithmUI <- NULL
              
              for(exp in 1:d[1])
              {
              
                uniqueIDRun <- experiments[exp,"uniqueID"]
                uniqueIDinst <- experiments[exp,"Instance_uniqueID"]
                uniqueIDAlg <- experiments[exp,"AlgorithmParameterized_uniqueID"]    
              
                print(paste("Getting data for Instance: ",uniqueIDinst," and Algorithm:", uniqueIDAlg,sep=""))
                
                con <- this$simpleConnectDB()
                inst <- Instance()
                print("Getting Instance")
                inst$DBgetByUniqueID(list(uniqueID=uniqueIDinst),con)
       
                algDB <- DBAlgorithmParameterized()
            
                if(is.null(previousAlgorithmUI) || previousAlgorithmUI != uniqueIDAlg)
                {
                  previousAlgorithmUI <- uniqueIDAlg
                  algDB$attributes[["uniqueID"]] <- uniqueIDAlg
                  print("Getting algorithm attributes") 
                  algDB$getByAttributes(con)
                  
                  
                  algName <- algDB$attributes[["Algorithm_name"]]
                  
                  eval(parse(text=paste("alg<-",algName,"()",sep="")))
                  print("Getting Algorithm")
            
                  alg$DBgetByUniqueID(uniqueIDAlg,con)
                }
                

          
                runalg <- Run()
                
                runalg$uniqueID <- uniqueIDRun
                
                runalg$setRun(alg,inst)
                dbDisconnect(con)
                
                runalg$go()
                
                con <- this$simpleConnectDB()
                
                DBsave(runalg,con)
                dbDisconnect(con)
                
              }
              
            
              
              
            })





setMethodS3("multiCoreRunExperiment","ExperimentFramework", 
            function(this,x,...) {
              
              con <- this$connectionDB
              
                              
          
                
                uniqueIDRun <- x["uniqueID"]
                uniqueIDinst <- x["Instance_uniqueID"]
                uniqueIDAlg <- x["AlgorithmParameterized_uniqueID"]    
                
                # print(paste("Getting data for Instance: ",uniqueIDinst," and Algorithm:", uniqueIDAlg,sep=""))
                
              #  browser()
                inst <- Instance()
                #print("Getting Instance")
                inst$DBgetByUniqueID(list(uniqueID=uniqueIDinst),con)
                
                algDB <- DBAlgorithmParameterized()
                
                
                algDB$attributes[["uniqueID"]] <- uniqueIDAlg
                #  print("Getting algorithm attributes") 
                algDB$getByAttributes(con)
                
                
                algName <- algDB$attributes[["Algorithm_name"]]
                
                eval(parse(text=paste("alg<-",algName,"()",sep="")))
                # print("Getting Algorithm")
                alg$DBgetByUniqueID(uniqueIDAlg,con)
                
                
                
                
                runalg <- Run()
                
                runalg$uniqueID <- uniqueIDRun
                
                runalg$setRun(alg,inst)
                
                runalg$go()
                
                DBsave(runalg,con)
                
              
              
            })



setMethodS3("runMultiCoreOptimizationExperiments","ExperimentFramework", 
            function(this,nrcores,...) {
              
              con <- this$connectionDB
              
              experiments <- dbGetQuery(con,paste("SELECT * FROM Run WHERE status='",this$id,"'",sep=""))
              
              d <- dim(experiments)
              previousAlgorithmUI <- NULL
              listExperiments <- apply(experiments,1,list)[[1]]
              
              mclapply(listExperiments,function(x)this$multiCoreRunExperiment(x),
                       mc.cores = nrcores)
              
              dbDisconnect(con)
              
              
            })


setMethodS3("scheduleOptimizationExperimentsByUniqueIDs","ExperimentFramework", 
            function(this,instanceUIs,algorithmUIs                   
                     ,...) {
              
              con <- this$connectionDB
    
              sol <- expand.grid(instanceUIs,algorithmUIs)
              colnames(sol) <-c("Instance_uniqueID","AlgorithmParameterized_uniqueID")
              
              
              sol$status <- "None"
      
              dbWriteTable(con,"Run",sol,append=TRUE,row.names=FALSE) 
              
            })



setMethodS3("scheduleOptimizationExperiments","ExperimentFramework", 
            function(this,nr,nrJobs,nrMachines,algorithmUniqueID,repeatRuns=FALSE,
                     sameInstancesThanAlgorithm=NULL,...) {
              
          
              
              con <- this$connectionDB
              
              algParamObj <- DBAlgorithmParameterized()
              algParamObj$attributes <- list(uniqueID=algorithmUniqueID)
            
              algParamObj$getByAttributes(con)
              
              algName <- algParamObj$attributes$Algorithm_name
              
              algObj <- DBAlgorithm()
              algObj$attributes <- list(name=algName)
              
              algObj$getByAttributes(con)
              
              algType <- algObj$attributes$type              
              
              query <- paste("SELECT R.uniqueID,start_time,R.seed,systemTime,userTime, elapsedTime,memory,'",algorithmUniqueID,"' AS AlgorithmParameterized_uniqueID,FeasibleSchedule_uniqueID,I.uniqueID AS Instance_uniqueID,'None' AS status,IF(nrRuns IS NULL,0,nrRuns) AS nrRuns FROM Instance I LEFT JOIN (SELECT *,count(*) AS nrRuns FROM Run WHERE AlgorithmParameterized_uniqueID='",algorithmUniqueID,"' GROUP BY Instance_uniqueID) R ON R.Instance_uniqueID=I.uniqueID WHERE nrJobs=",nrJobs," AND nrMachines=",nrMachines,"   ORDER BY nrRuns ASC LIMIT ",nr,sep="")
          
              sol <- dbGetQuery(con,query)
              
            
              if(algType == "deterministic")
              {
                sol <- sol[sol[,"nrRuns"]==0,]              
              }

              if(repeatRuns)
              {
                sol <- sol[sol[,"nrRuns"] > 0,]              
              }
              
              sol <- sol[,-which(colnames(sol)=="nrRuns")]

              sol[,c("uniqueID","start_time","seed","systemTime","userTime","elapsedTime","memory","FeasibleSchedule_uniqueID")]<- NA
              
              dbWriteTable(con,"Run",sol,append=TRUE,row.names=FALSE)    
              
              
            })




setMethodS3("scheduleFeaturesExperiments","ExperimentFramework", 
            function(this,nrJobs,nrMachines,objName,group,...) {
              
              con <- this$connectionDB
                            
              featObj <- eval(call(paste(objName,"FeaturedElement",sep=""))) 
              #featObj$scheduleCalculationOfFeatures(con,this$id,group,nrJobs,nrMachines)
              
   
              
              DBobjGroup<-DBFeaturesGroups()
              objectName <- featObj$getObjectClassName()
              
              DBobjGroup$attributes <- list(name = group,
                                            object = objectName)
              
           
              DBobjGroup$getByAttributes(con)
              
              groupAttributes <-  DBobjGroup$attributes

             
              tableName <- paste(objName,"_",group,sep="")  
              
              
              restrictionMainTable <- groupAttributes$restrictionMainTable
              
              mainTable <- groupAttributes$mainTable
              targetFieldName  <- groupAttributes$targetFieldName
              
              restrictionQuery <- ""
           
              if(!is.null(restrictionMainTable) && !is.na(restrictionMainTable))
                {
                restrictionQuery <-paste(" WHERE ",restrictionMainTable,sep="")
              }
              
              
              query <- paste("INSERT IGNORE INTO FeatureExperimentObjects SELECT DISTINCT '",group,"' AS FeaturesGroups_name,'",objName,"' AS FeaturesGroups_object,I.uniqueID AS target,'None' AS status FROM Instance I,(SELECT * FROM ",mainTable,restrictionQuery," ) mainTable WHERE I.uniqueID=mainTable.",targetFieldName," AND I.nrJobs=",nrJobs," AND I.nrMachines=",nrMachines," AND I.uniqueID NOT IN (SELECT Instance_uniqueID FROM ",tableName,")",sep="")            
  browser()
              dbSendQuery(con,query)
              })





setMethodS3("runFeaturesCalculation","ExperimentFramework", 
            function(this,nr=10,duration = 10,...) {
              
              con <- this$connectionDB
              inicio <- Sys.time()
                          
              
              query <- paste("SELECT * FROM FeatureExperiment ORDER BY priority ASC")
              sol <- dbGetQuery(con,query)               
              
              continua <- TRUE
              
              i <- 1
              
              while(continua)
              {                              
                objName <- sol[i,"FeaturesGroups_object"]
                group <- sol[i,"FeaturesGroups_name"]
             
                # tableName <- featObj$calculateFeaturesTableName(group)
             
                print(paste("Calculating ",group," features group for ",objName,sep=""))
                
                queryCount <- paste("SELECT count(*) AS nrDisponiveis FROM FeatureExperimentObjects WHERE FeaturesGroups_name='",group,"' AND FeaturesGroups_object='",objName,"' AND status='None'",sep="")
                solCount <- dbGetQuery(con,queryCount)               
                
                
                
                
                if(solCount[1,"nrDisponiveis"] > 0)
                {
                  print("Found features to calculate....")
                  continua <- FALSE
                  ##print(paste("Getting objects from ",tableName,sep=""))
                  # query1 <- paste("CALL get_featuresExperiments(",nr,",'",tableName,"')",sep="")
                  query1 <- paste("UPDATE FeatureExperimentObjects SET status='",this$id,"' WHERE FeaturesGroups_name='",group,"' AND FeaturesGroups_object='",objName,"'  AND status='None' LIMIT ",nr,sep="")
                  res <- dbSendQuery(con,query1)    
                  
                  print("Instance to calculated reserved")
                  
                  featObj <- eval(call(paste(objName,"FeaturedElement",sep=""))) 
                 
                  print("Calculation prepared!")
                  featObj$runCalculationOfFeatures(con,this$id,group)
                 
                  query2 <- paste("UPDATE FeatureExperimentObjects SET status='Finished' WHERE FeaturesGroups_name='",group,"' AND FeaturesGroups_object='",objName,"'  AND status='",this$id,"' LIMIT ",nr,sep="")
                  res <- dbSendQuery(con,query2)    
                  
                  
                  
                }              
                else
                {
                  i <- i+1
                }
                
                
                continua <- i <= nrow(sol) & difftime(Sys.time(),inicio,units="mins") < duration
                
              }
              
              
              dbDisconnect(con)
              
            })
# 
# 
# setMethodS3("runFeaturesCalculation","ExperimentFramework", 
#             function(this,nr=10,duration = 10,...) {
#               
#               con <- this$connectionDB
#               inicio <- Sys.time()
#               query <- paste("SELECT * FROM FeatureExperiment ORDER BY priority ASC LIMIT",nr)
#               sol <- dbGetQuery(con,query)               
#               
#               continua <- TRUE
#               
#               i <- 1
#               
#               while(continua)
#               {               
#          
#                 objName <- sol[i,"FeaturesGroups_object"]
#                 group <- sol[i,"FeaturesGroups_name"]
#                 featObj <- eval(call(paste(objName,"FeaturedElement",sep=""))) 
#                 tableName <- featObj$calculateFeaturesTableName(group)
#                      
#                 print(paste("Calculating ",group," features group for ",objName,sep=""))
#                 
#                 queryCount <- paste("SELECT count(*) AS nrDisponiveis FROM ",tableName," WHERE status='None'")
#                 solCount <- dbGetQuery(con,queryCount)               
#                 
#                 
#                 if(solCount[1,"nrDisponiveis"] > 0)
#                 {
#                   continua <- FALSE
#                   print(paste("Getting objects from ",tableName,sep=""))
#                  # query1 <- paste("CALL get_featuresExperiments(",nr,",'",tableName,"')",sep="")
#                   query1 <- paste("UPDATE ",tableName," SET status='",this$id,"' WHERE status='None' LIMIT ",nr,sep="")
#                   res <- dbSendQuery(con,query1)    
#                   
#                   query2 <- paste("SELECT * FROM ",tableName," WHERE status='",this$id,"' LIMIT ",nr,sep="")
#                   sol2 <- dbGetQuery(con,query2)    
#                   
#                   
#                 #  sol2 <- fetch(res,n=-1)
#                   
#                   if(nrow(sol2)>0)
#                   {
#                     
#                     for(j in 1:nrow(sol2))
#                     {
#                   
#                       #ui <- sol2[j,"object_uniqueID"]
#                       #print(paste("UI: ",print(ui)))
#                       
#                       featObj$features <- list()
#                       #featObj$DBgetObjectUsingMainValues(restrictions=list("status"=this$id),con=con)
#                       
#                       featObj$DBgetObjectUsingMainValues(values=sol2[j,],con=con)
#                       #featObj$DBgetByObjectUniqueID(ui,con)  
#                       print(paste("Calcular features"))
#                       
#                       
#                       featObj$calculateFeatures(con,groups = c(group)) 
#                       
#                 
#                 
#                       print("Gravar na DB")
#                       featObj$DBsaveFeatures(con) 
#                       
#                     }
#                     
#                   }
#                   
#                   
#                 }              
#                 else
#                 {
#                   i <- i+1
#                 }
#                               
#                 
#                 continua <- i < nrow(sol) & difftime(Sys.time(),inicio,units="mins") < duration
#               
#               }
#               
#               
#               
#               
#             })
# 



setMethodS3("generateModels","ExperimentFramework", function(this,
                                                    file="./lib/MySQLInterface/DBModel.R",
                                                     ...) {
  con <- this$connectionDB
  
  coninfo <- dbGetInfo(con)
  
  schemaName <- coninfo$dbname
  
  cat("##Automatic \n",file=file)
  tables <- dbGetQuery(con,"SHOW TABLES")
  tablesIndex <- paste("Tables_in_",schemaName,sep="")
  
  for(tableName in tables[,tablesIndex])
  {
  
    query <- paste("SHOW COLUMNS FROM ",tableName,sep="")
    sol <- dbGetQuery(con,query)
    
    
    fields <- NULL
    
    for(i in 1:nrow(sol))
    {
      name <- sol[i,"Field"]
      type <- "varchar"
      
      if(sol[i,"Type"] == "int" | sol[i,"Type"] == "double")
      {
        type <- sol[i,"Type"]
      }
      
      fields <- c(fields,
                  paste("\"",name,"\"=Column(type =\"", type,"\",\n","primaryKey =", sol[i,"Key"] == "PRI",")\n",sep=""))
      
    }
    
    stg <- paste("setConstructorS3(\"DB",tableName,"\",function()
    {  
      extend(DBModel(tableName = \"",tableName,"\",
                     columns = list(",paste(fields,collapse=","),")
                     ),\"DB",tableName,"\")  
    })\n\n",sep="")
    
    
    cat(stg,file=file,append=TRUE)
    
  }
  
  
  
})





setMethodS3("populateDB","ExperimentFramework", function(this,...) {
  
  this$populateDBInstances()
  this$populateDBSwapSequences3x3()
  this$populateDBHeuristicAlgorithms()
  
  })

  
setMethodS3("populateDBInstances","ExperimentFramework", function(this,    
                                                         nrMachines =  c(3,4),
                                                         nrJobs =  c(3,4),
                                                         repetitions= 3,
                                               ...) {

  con <- this$connectionDB
  for(nrM in nrMachines)
  {
    for(nrJ in nrJobs)
    {
      for(rep in 1:repetitions)
      {
        inst <- Instance()
        inst$random.instance(nr.jobs = nrJ,                                                                      
                             nr.machines = nrM,                                                                      
                             correlation = "no",                                                                       
                             same.job.same.dist = FALSE,                                                                      
                             minDuration = 1,                                                                      
                             maxDuration = 99,                                                                      
                             parameter.1.int = c(1,1),                                                                      
                             parameter.2.int = c(1,1),                                                                       
                             order.parameter = 99999999999) 
     
   
        inst$DBsave(con)          
      }
    }    
  }
  
})


setMethodS3("populateDBSwapSequences3x3","ExperimentFramework", function(this,
                                                             instanceUniqueID = NULL,
                                                         ...) {
  con <- this$connectionDB
  instID <- instanceUniqueID
  
  
  if(is.null(instanceUniqueID))
  {
    instObj <- DBInstance()
    
    instObj$attributes <- list(nrJobs = 3,
                                nrMachines = 3)
    
    allinst <- instObj$getAllByAttributes(con,
                                          limit = 1,
                                          orderby = "RAND()")
    
    inst <- allinst[[1]]
    instID <- inst$attributes[["uniqueID"]]
    
  }
  
  instance <- Instance()
  instance$DBgetByUniqueID(instID,con)
  
  library("combinat")
  
  j <- instance$nrJobs()
  m <- instance$nrMachines()
  
  initialSeq <- rep(1:j,m)
  
  allSeqPerm<-permn(initialSeq)
  uniqueAllSeqPerm <- unique(allSeqPerm)
  
  ##all permutation possible
  allperm <- expand.grid(1:length(initialSeq),1:length(initialSeq))
  
  ##remove repeated permutation
  
  allpermWithoutRepetition <- allperm[allperm[,1] < allperm[,2]  ,] 
  
  
  
  for(seq in uniqueAllSeqPerm)
  {
    
    #     data <- matrix(seq,nrow=dim(allpermWithoutRepetition)[1],
    #                    ncol=length(seq),byrow=TRUE)  
    #     
    #     
    #     data <- cbind(as.data.frame(data),allpermWithoutRepetition)
    
    seqObj <- Sequence()
    seqObj$sequence <- seq
    ## thisSched <- seqObj$getSchedule(instance)
    
    ##  seqFitness  <- thisSched$makespan()
    
    
    for(i in 1:dim(allpermWithoutRepetition)[1])
    {
      changedSeq <- seq
      changedSeq[allpermWithoutRepetition[i,1]] <- seq[allpermWithoutRepetition[i,2]] 
      changedSeq[allpermWithoutRepetition[i,2]] <- seq[allpermWithoutRepetition[i,1]] 
      
      if(!all(changedSeq == seq))
      {   
        swpSeq <- SwapSequence3x3()
        
        swpSeq$sequence <- seqObj
        swpSeq$instance <- instance
        swpSeq$index1 <- allpermWithoutRepetition[i,1]
        swpSeq$index2 <- allpermWithoutRepetition[i,2]
 
        swpSeq$DBsave(con)        
      }    
      
    }
  }
  
  
  
  
})


setMethodS3("populateDBSwapSequences2","ExperimentFramework", function(this,
                                                             instanceUniqueID = NULL,
                                                             nrJobs = 3,
                                                             nrMachines = 3,
                                                             ...) {
  con <- this$connectionDB
  instID <- instanceUniqueID
  
  
  if(is.null(instanceUniqueID))
  {
    instObj <- DBInstance()
    
    instObj$attributes <- list(nrJobs = nrJobs,
                                nrMachines = nrMachines)
    
    allinst <- instObj$getAllByAttributes(con,
                                          limit = 1,
                                          orderby = "RAND()")
    
    inst <- allinst[[1]]
    instID <- inst$attributes[["uniqueID"]]
    
  }
  
  instance <- Instance()
  instance$DBgetByUniqueID(instID,con)
  
  library("combinat")
  
  j <- instance$nrJobs()
  m <- instance$nrMachines()
  
  initialSeq <- rep(1:j,m)
  
  
  allSeqPerm<-permn(initialSeq)
  uniqueAllSeqPerm <- unique(allSeqPerm)
  
  ##all permutation possible
  allperm <- expand.grid(1:length(initialSeq),1:length(initialSeq))
  
  ##remove repeated permutation
  
  allpermWithoutRepetition <- allperm[allperm[,1] < allperm[,2]  ,] 
  
  
  
  for(seq in uniqueAllSeqPerm)
  {
    
    #     data <- matrix(seq,nrow=dim(allpermWithoutRepetition)[1],
    #                    ncol=length(seq),byrow=TRUE)  
    #     
    #     
    #     data <- cbind(as.data.frame(data),allpermWithoutRepetition)
    
    seqObj <- Sequence()
    seqObj$sequence <- seq
    ## thisSched <- seqObj$getSchedule(instance)
    
    ##  seqFitness  <- thisSched$makespan()
    
    
    for(i in 1:dim(allpermWithoutRepetition)[1])
    {
      changedSeq <- seq
      changedSeq[allpermWithoutRepetition[i,1]] <- seq[allpermWithoutRepetition[i,2]] 
      changedSeq[allpermWithoutRepetition[i,2]] <- seq[allpermWithoutRepetition[i,1]] 
      
      if(!all(changedSeq == seq))
      {   
        swpSeq <- SwapSequence()
        
        swpSeq$sequence <- seqObj
        swpSeq$instance <- instance
        swpSeq$index1 <- allpermWithoutRepetition[i,1]
        swpSeq$index2 <- allpermWithoutRepetition[i,2]
        
        swpSeq$DBsave(con)        
      }    
      
    }
  }
  
  
  
  
})

setMethodS3("populateDBHeuristicAlgorithms","ExperimentFramework", function(this,
                                                                   selections = c("max","min"),
                                                                   evaluations = c("WorkRemaining","OperationsRemaining","ProcessingTime"),
                                                         ...) {
  for(sel in selections)
  {
    for(evalua in evaluations)
    {    
      gtalg <- GifflerThompson(evaluation = evalua,selection=sel)
     
      gtalg$DBsave(con)      
    }    
  }
  
})



setMethodS3("populateDBGAAlgorithms","ExperimentFramework", function(this,
                                                            populationSize = c(10,15,30),
                                                            crossover = list(PLCrossoverC1(),PLCrossoverOX(),
                                                                             PLCrossoverNabel(),PLCrossoverPedro()),
                                                            crossoverProb = c(0.3,0.8),
                                                            mutation = list(PLMutationSW()),
                                                            mutationProb =  c(0.3,0.8),
                                                            stopCriterium = MaxNrEvaluatedSolutions(5000),
                                                            elitistQt = 1,
                                                            elitistType = "relative",
                                                            ...) {



  
  for(popsize in populationSize)
  {    
    for(crossClass in crossover)
    {    
      for(crossProb in crossoverProb)
      {
        crossClass$probability <- crossProb
        
        for(mutClass in mutation )
        {    
          for(mutProb in mutationProb)
          {
            mutClass$probability <- mutProb
            
            gaalg <- GAPL(stopCriterium = stopCriterium,         
                          population.size = popsize,                                       
                          crossover = crossClass,
                          mutation = mutClass,
                          elitistQuantity = elitistQt,
                          ## elitistType - can be "relative" if elististQuantity is a percentage or "absolute" the exact number to select
                          elitistType = elitistType)
            
            gaalg$DBsave(con)      
            
          }}}}}


})


  
