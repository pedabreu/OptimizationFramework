
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
# 
# exp$hostDB <- "localhost"##"rank.inescporto.pt"
# exp$userDB <- "root"##"pedabreu"
# exp$passwordDB <- "pedrito"##"mysqlrank0gCVcV30"
# exp$nameDB <- "jss_dev"
# 
# # 
# exp$hostDB <- "rank.inescporto.pt"
# exp$userDB <- "pedabreu"
# exp$passwordDB <-"mysqlrank0gCVcV30"
# exp$nameDB <- "jss_dev"



con2 <- dbConnect(drv,
                  host = "dbmlexp.fe.up.pt",
                  user = "grid",
                  password = "mysqlGridUser170781",
                  dbname = "jss_dev")


con <- exp$simpleConnectDB()
exp$connectionDB <- con2

##9 Julho 2012
exp$populateDBInstances(nrMachines =  c(3,7,10,15,20),
                        nrJobs =  c(3,7,10,15,20),
                        repetitions= 10)


exp$populateDBHeuristicAlgorithms( selections = c("max","min"),
evaluations = c("WorkRemaining","OperationsRemaining","ProcessingTime"))

##Agosto 2014
exp$populateDBHeuristicAlgorithms( selections = c("median"),
                                   evaluations = c("ProcessingTime"))
                                                       

exp$populateDBGAAlgorithms(
  populationSize = c(10,30),
#   crossover = list(PLCrossoverC1(),PLCrossoverOX(),
#                    PLCrossoverNabel(),PLCrossoverPedro()),
  crossover = list(PLCrossoverC1()),
  crossoverProb = c(0.2,0.8),
  mutation = list(PLMutationSW()),
  mutationProb =  c(0.2,0.8),
  stopCriterium = MaxNrEvaluatedSolutions(1000),
  elitistQt = 1,
  elitistType = "absolute")


exp$scheduleExperiments(
  repetition = 1,                                              
  nrJobs = c(5),
  nrMachines = c(5),
  algorithmName = c("GifflerThompson"))

exp$setScheduledExperimentsDB()

exp$scheduleExperiments(
  repetition = 1,                                              
  nrJobs = c(3,7,10,15,20),
  nrMachines = c(3,7,10,15,20),
  algorithmName = c("GifflerThompson"))

exp$setScheduledExperimentsDB()

exp$scheduleExperiments(
  repetition = 5,                                              
  nrJobs = c(4),
  nrMachines = c(4),
  algorithmName = c("GAPL"))

exp$setScheduledExperimentsDB()

exp$populateDBInstances(nrMachines =  c(15),
                        nrJobs =  c(15),
                        repetitions= 1000)



exp$populateDBInstances(nrMachines =  c(4),
                        nrJobs =  c(4),
                        repetitions= 15000)

exp$populateDBInstances(nrMachines =  c(6),
                        nrJobs =  c(6),
                        repetitions= 25000)
####################

##ainda nao corrido, corrigir codigo
# exp$scheduleExperiments(
#   repetition = 5,                                              
#   nrJobs = c(3,7,10,15,20),
#   nrMachines = c(3,7,10,15,20),
#   algorithmName = c("GAPPL","GASequence"))
# 
# exp$setScheduledExperimentsDB()


q <- "SELECT uniqueID FROM Instance WHERE nrJobs=4 AND nrMachines=4 "

sol <- dbGetQuery(con,q)

  
exp$scheduleExperimentsByUniqueIDs(sol[,"uniqueID"],"141113182212LJi4")
exp$scheduleExperimentsByUniqueIDs(sol[,"uniqueID"],"120726130343pTIK")
  





