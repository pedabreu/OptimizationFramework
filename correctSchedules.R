
if( any("con" == ls()))
{
  dbDisconnect(con)
}

rm(list = ls())


library("DBI")
library("RMySQL")
library("R.utils")
library("R.oo")


sourceDirectory("./lib/")


exp <- ExperimentFramework()

exp$hostDB <- "localhost"##"rank.inescporto.pt"
exp$userDB <- "root"#"pedabreu"
exp$passwordDB <- "pedrito" #"abreu"
exp$nameDB <- "jss_dev"

con <- exp$simpleConnectDB()
exp$connectionDB <- con

querySched1 <- "SELECT DISTINCT FeasibleSchedule_uniqueID FROM (SELECT *,count(*) AS nrOperations FROM FeasibleScheduleOperation GROUP BY FeasibleSchedule_uniqueID,job,machine) T WHERE nrOperations > 1 LIMIT 10"
solSchedule1 <- dbGetQuery(con,querySched1)

for(schedUI in solSchedule1[,"FeasibleSchedule_uniqueID"])
{
  solRun <-  dbGetQuery(con,paste("SELECT * FROM Run WHERE FeasibleSchedule_uniqueID='",schedUI,"'",sep=""))
  
  instUI <- solRun[1,"Instance_uniqueID"]
  uniqueIDalg <- solRun[1,"AlgorithmParameterized_uniqueID"]
  schedUI <- solRun[1,"FeasibleSchedule_uniqueID"]  
  
  
  dbalg <- DBAlgorithmParameterized()
  dbalg$attributes <- list("uniqueID" = uniqueIDalg )
  dbalg$getByAttributes(con) 
  
  
  
  
  alg <- eval(parse(text=paste(dbalg$attributes[["Algorithm_name"]],"()",sep="")))
  alg$DBgetByUniqueID(uniqueIDalg,con)
  
##  runObj <- Run()
##  runObj$DBgetByUniqueID(solRun[1,"uniqueID"],con)
 
  
#  rule <- Rule()
#  rule$operationEvaluationFunction <- "EndTime"
#  rule$selectionFunction <- "min"
  
  inst <- Instance()
  inst$DBgetByUniqueID(list(uniqueID=instUI),con)
  
  search <- alg$run(inst)
  newsched <- search$schedule
#  sched <- rule$generateSchedule(inst)
#  sched$DBsave(con)
  
  prevsched <- Schedule()
  prevsched$DBgetByUniqueID("130906105654EH2M",con)
  
  browser()  
}



