
library("R.oo")
library("RMySQL")
library("R.utils")

if( any("con" == ls()))
{
  dbDisconnect(con)
}

rm(list = ls())
sourceDirectory(paste("./lib/Optimization/",sep=""))
sourceDirectory(paste("./lib/MySQLInterface/",sep=""))
sourceDirectory(paste("./DBModels/",sep=""))

m<-dbDriver("MySQL")

##con <- dbConnect(m,host="localhost",user="root",password="pedrito",dbname="JSS")
con <- dbConnect(m,host="127.0.0.1",user="pedabreu",password="abreu",
                 dbname="JSS",port=3307)



######################
##Create experiments##
######################
exp <- Experiment()

exp$scheduleExperiments(con,
                        repetition = 1,                                              
                        nrJobs = c(3),
                        nrMachines = c(3),
                        algorithmName = c("GAPL"))

exp$setScheduledExperimentsDB(con)

exp$execute(con)

exp$experimentInfo(con,c("GAPL"),
                   repeatitions = 2,
                   ficheiro = "/home/pedabreu/teste.csv")



