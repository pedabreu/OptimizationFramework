
if( any("con" == ls()))
{
  dbDisconnect(con)
}

rm(list = ls())


library("DBI")
library("RMySQL")
library("R.utils")
library("R.oo")
library("combinat")
library("XML")

sourceDirectory("./lib/")


exp <- ExperimentFramework()


exp$hostDB <- "rank.inescporto.pt"
exp$userDB <- "pedabreu"
exp$passwordDB <-"mysqlrank0gCVcV30"
exp$nameDB <- "jss_dev"

exp$hostDB <- "localhost"##"rank.inescporto.pt"
exp$userDB <- "root"#"pedabreu"
exp$passwordDB <- "pedrito" #"abreu"
exp$nameDB <- "jss_dev"

con <- exp$simpleConnectDB()
exp$connectionDB <- con
# 
#   
# rule <- Rule()
# rule$operationEvaluationFunction <- "ProcessingTime"
# rule$selectionFunction <- "min"
# 
# inst <- Instance()
# inst$random.instance()
# 
# 
# sched <- rule$generateSchedule(inst)
# sched$DBsave(con)


resultQuery <- dbGetQuery(con,"SELECT * FROM jss_dev.FeasibleSchedule WHERE start_times_xml is null")


for(i in 1:nrow(resultQuery))
{
  print(i)
  sched <- Schedule()
  sched$DBgetByUniqueID(uniqueID=resultQuery[i,"uniqueID"],con=con)
  
  if(!is.null(sched$operationStartTime))
  {
    print("ok")
    tt <- sched$StartTime2XML()
    
    texto<-toString(xmlRoot(tt))
    
    dbSendQuery(con,paste("UPDATE FeasibleSchedule SET start_times_xml='",texto,"' WHERE uniqueID='",resultQuery[i,"uniqueID"],"'",sep=""))
  }
}

# 
# resultQuery <- dbGetQuery(con,"SELECT * FROM FeasibleSchedule_20x10 WHERE start_times_xml is null")
# 
# 
# for(i in 1:nrow(resultQuery))
# {
#   print(i)
#   sched <- Schedule()
#   sched$DBgetByUniqueID(uniqueID=resultQuery[i,"uniqueID"],con=con)
#   
#   tt <- sched$StartTime2XML()
#   
#   texto<-toString(xmlRoot(tt))
#   
#   dbSendQuery(con,paste("UPDATE FeasibleSchedule_20x10 SET start_times_xml='",texto,"' WHERE uniqueID='",resultQuery[i,"uniqueID"],"'",sep=""))
#   
# }
# 
# query1Result <- dbGetQuery(con,paste("SELECT DISTINCT nrJobs,nrMachines FROM jss_dev.Instance",sep=""))
# 
# 
# for(index in 1:nrow(query1Result))
# {
#   dbSendQuery(con,paste("CREATE TABLE Operation_",query1Result[index,"nrJobs"],"x",query1Result[index,"nrMachines"]," (SELECT O.* FROM Operation O,Instance I WHERE I.uniqueID=O.Instance_uniqueID AND nrJobs=",query1Result[index,"nrJobs"]," AND nrMachines=",query1Result[index,"nrMachines"],")",sep=""))
#               
#               
# }
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
