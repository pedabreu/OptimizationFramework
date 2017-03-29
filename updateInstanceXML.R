
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



resultQuery <- dbGetQuery(con,"SELECT * FROM jss_dev.Instance WHERE xml is null")


for(i in 1:nrow(resultQuery))
{
  print(i)
  inst <- Instance()
  DBgetByUniqueID(inst,list(uniqueID=resultQuery[i,"uniqueID"]),con=con)
  

    tt <- inst$Instance2XML()
    
    texto<-toString(xmlRoot(tt))
    
    dbSendQuery(con,paste("UPDATE Instance SET xml='",texto,"' WHERE uniqueID='",resultQuery[i,"uniqueID"],"'",sep=""))
  
}