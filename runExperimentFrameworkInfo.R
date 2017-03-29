library("DBI")
library("RMySQL")
library("R.utils")
library("R.oo")

if( any("con" == ls()))
{
  dbDisconnect(con)
}

rm(list = ls())




sourceDirectory("./lib/")


exp <- ExperimentFramework()

exp$hostDB <- "dbmlexp.fe.up.pt"## "localhost" ##"rank.inescporto.pt"
exp$userDB <- "grid" ##"pedabreu"
exp$passwordDB <- "mysqlGridUser170781" ##"mysqlrank0gCVcV30"
exp$nameDB <- "jss_dev"

con <- exp$simpleConnectDB()
exp$connectionDB <- con

#exp$inconsistenceData(deleteFromDB=FALSE)
#exp$generateModels()

exp$infoRun()
exp$infoFeatures()
exp$learningExperimentInfo()
##exp$cleanFeaturesExperimentObjects()
##exp$cleanRuns()

expOpt <- OptimizationExperiment()

exp$hostDB <- "dbmlexp.fe.up.pt"## "localhost" ##"rank.inescporto.pt"
exp$userDB <- "grid" ##"pedabreu"
exp$passwordDB <- "mysqlGridUser170781" ##"mysqlrank0gCVcV30"
exp$nameDB <- "jss_dev"

con <- expOpt$simpleConnectDB()
expOpt$connectionDB <- con


expOpt$winningDescription(algorithmParameterizedIDs=c("120726130343x2EL",
                                                      "120726130343pTIK"))



###Remove an algorithm 
##uniqueID_alg <- "130114144548XuQZ"
for(uniqueID_alg in dbGetQuery(con,paste("SELECT uniqueID FROM AlgorithmParameterized WHERE Algorithm_name LIKE 'GAPL'",sep=""))[,1])
{
  dbSendQuery(con,paste("DELETE FROM FeasibleSchedule WHERE AlgorithmParameterized_uniqueID ='",uniqueID_alg,"'",sep=""))
  dbSendQuery(con,paste("DELETE FROM IterationStatistics WHERE Run_uniqueID IN (SELECT uniqueID FROM Run WHERE AlgorithmParameterized_uniqueID ='",uniqueID_alg,"')",sep=""))
  dbSendQuery(con,paste("DELETE FROM Run WHERE AlgorithmParameterized_uniqueID ='",uniqueID_alg,"'",sep=""))
  #dbSendQuery(con,paste("DELETE FROM AlgorithmParameterizedParameters WHERE AlgorithmParameterized_uniqueID ='",uniqueID_alg,"'",sep=""))
  #dbSendQuery(con,paste("DELETE FROM AlgorithmParameterized WHERE uniqueID ='",uniqueID_alg,"'",sep=""))
}




mwrvalues <- dbGetQuery(con,"SELECT Instance_uniqueID,MWR FROM Instance_Targets_GifflerThompson ITG,Instance I WHERE I.uniqueID=ITG.Instance_uniqueID AND nrMachines=4 AND nrJobs=4 LIMIT 100")

distValues <- NULL
mwrDif <- NULL

for(inst1Index in 1:(nrow(mwrvalues)-1))
{
  print(inst1Index)
  inst1UI <- mwrvalues[inst1Index,"Instance_uniqueID"]
 

  inst1Obj <- Instance()
  inst1Obj$DBgetByUniqueID(list(uniqueID=inst1UI),con)
  mwr1 <- mwrvalues[inst1Index,"MWR"]
  
  for(inst2Index in (inst1Index + 1):nrow(mwrvalues))
  {
    print(inst2Index)
    inst2UI <- mwrvalues[inst2Index,"Instance_uniqueID"]
    inst2Obj <- Instance()
    inst2Obj$DBgetByUniqueID(list(uniqueID=inst2UI),con)
    mwr2 <- mwrvalues[inst2Index,"MWR"]
    
    distValues <- c(distValues,inst1Obj$distance(inst2Obj))
    mwrDif <- c(mwrDif,abs(mwr1-mwr2))  
  }  
  
  
}

plot(distValues,mwrDif)








