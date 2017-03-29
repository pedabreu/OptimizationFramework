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


exp$hostDB <- "dbmlexp.fe.up.pt"## "localhost" ##"rank.inescporto.pt"
exp$userDB <- "grid" ##"pedabreu"
exp$passwordDB <- "mysqlGridUser170781" ##"mysqlrank0gCVcV30"
exp$nameDB <- "jss_dev"

con <- exp$simpleConnectDB()
exp$.connectionDB <- con

nrInstances <- 5000
nrJobs <- 4
nrMachines <- 4
#allalg <- c('120726130343pTIK','120726130342Znat','131127175150m4BR')
allalg <- c('120726130343pTIK')
allalg <- c('131127175150m4BR')
allalg <- c('131128144042NO3W')
allalg <- c('120726130342Znat')

for(alg in allalg)
{
exp$scheduleOptimizationExperiments(nrInstances,nrJobs,nrMachines,alg)
}

nrInstances <- 20000
nrJobs <- 6
nrMachines <- 6
allalg <- c('120726130343x2EL','120726130343pTIK','120726130342Znat','131127175150m4BR')

for(alg in allalg)
{
  exp$scheduleOptimizationExperiments(nrInstances,nrJobs,nrMachines,alg)
}

nrInstances <- 10000
nrJobs <- 20
nrMachines <- 10
allalg <- c('120726130343x2EL','120726130343pTIK','120726130342Znat','131127175150m4BR')

for(alg in allalg)
{
  exp$scheduleOptimizationExperiments(nrInstances,nrJobs,nrMachines,alg)
}





###Genetic Algorithm################################
solInstance <- dbGetQuery(con,"SELECT DISTINCT Instance_uniqueID FROM Run WHERE AlgorithmParameterized_uniqueID IN (SELECT uniqueID FROM AlgorithmParameterized WHERE Algorithm_name='GAPL')")
solInstance <- dbGetQuery(con,"SELECT DISTINCT uniqueID FROM Instance WHERE nrJobs=4 AND nrMachines=4")

sol <- dbGetQuery(con,"SELECT uniqueID FROM AlgorithmParameterized WHERE Algorithm_name='GAPL'")

allalg <- sol



exp$scheduleOptimizationExperimentsByUniqueIDs(solInstance[,1],
                                               allalg[,1])

prevAlg <- sol[1,1]

for(alg in allalg)
{
  
  exp$scheduleOptimizationExperiments(1000,nrJobs,nrMachines,alg,
                                      repeatRuns=FALSE,
                                      sameInstancesThanAlgorithm=prevAlg)
  
  

  
}