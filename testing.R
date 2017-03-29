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


exp$hostDB <- "localhost" ##"rank.inescporto.pt"
exp$userDB <-  "root"## "pedabreu"
exp$passwordDB <- "pedrito" ##"abreu"
exp$nameDB <- "jss_dev"

con <- exp$simpleConnectDB()
exp$.connectionDB <- con

inst <- Instance()
inst$DBgetByUniqueID(list(uniqueID='120722005147nHk3'),con)

alg <- GifflerThompson()
alg$evaluation <- "StartTime"
alg$selection <- "min"

sear<- alg$run(inst)
sched <- sear$schedule

sched$DBsave(con)






