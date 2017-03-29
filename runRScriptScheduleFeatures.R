
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


exp$hostDB <- "localhost"# "rank.inescporto.pt"
exp$userDB <- "root"
exp$passwordDB <- "pedrito" # "abreu"
exp$nameDB <- "jss_dev"

con <- exp$simpleConnectDB()
exp$connectionDB <- con

nrJobs <- 4
nrMachines <- 4
objName <- "Instance"
group <- "MinEndTimevsMWR_4x4_1"


exp$scheduleFeaturesExperiments(nrJobs,nrMachines,objName,group)


nrJobs <- 4
nrMachines <- 4
objName <- "Instance"
group <- "AggOfOperationBasic"


exp$scheduleFeaturesExperiments(nrJobs,nrMachines,objName,group)


nrJobs <- 4
nrMachines <- 4
objName <- "Instance"
group <- "SPTvsLPT"


exp$scheduleFeaturesExperiments(nrJobs,nrMachines,objName,group)


nrJobs <- 4
nrMachines <- 4
objName <- "Instance"
group <- "SPTvsLPT_4x4_1"


exp$scheduleFeaturesExperiments(nrJobs,nrMachines,objName,group)


nrJobs <- 4
nrMachines <- 4
objName <- "Instance"
group <- "SPTvsMWR"


exp$scheduleFeaturesExperiments(nrJobs,nrMachines,objName,group)

nrJobs <- 4
nrMachines <- 4
objName <- "Instance"
group <- "LPTvsMWR"


exp$scheduleFeaturesExperiments(nrJobs,nrMachines,objName,group)

nrJobs <- 4
nrMachines <- 4
objName <- "Instance"
group <- "MinWRvsMWR"


exp$scheduleFeaturesExperiments(nrJobs,nrMachines,objName,group)

nrJobs <- 4
nrMachines <- 4
objName <- "Instance"
group <- "RelativeSPTvsLPT"


exp$scheduleFeaturesExperiments(nrJobs,nrMachines,objName,group)

nrJobs <- 4
nrMachines <- 4
objName <- "Instance"
group <- "Relative15PercentageSPTvsLPT"


exp$scheduleFeaturesExperiments(nrJobs,nrMachines,objName,group)



nrJobs <- 4
nrMachines <- 4
objName <- "Instance"
group <- "RelativeGifflerThompson"


exp$scheduleFeaturesExperiments(nrJobs,nrMachines,objName,group)


nrJobs <- 4
nrMachines <- 4
objName <- "Instance"
group <- "AggOfJobAggOfOperationBasic"


exp$scheduleFeaturesExperiments(nrJobs,nrMachines,objName,group)

nrJobs <- 4
nrMachines <- 4
objName <- "Instance"
group <- "AggOfMachineAggOfOperationBasic"


exp$scheduleFeaturesExperiments(nrJobs,nrMachines,objName,group)


nrJobs <- 4
nrMachines <- 4
objName <- "Instance"
group <- "AggOfPrecedenceAggOfOperationBasic"


exp$scheduleFeaturesExperiments(nrJobs,nrMachines,objName,group)

nrJobs <- 4
nrMachines <- 4
objName <- "Instance"
group <- "StandMomentsOfMachineAggOfOperationBasic"


exp$scheduleFeaturesExperiments(nrJobs,nrMachines,objName,group)

nrJobs <- 4
nrMachines <- 4
objName <- "Instance"
group <- "StandMomentsOfJobAggOfOperationBasic"


exp$scheduleFeaturesExperiments(nrJobs,nrMachines,objName,group)

nrJobs <- 4
nrMachines <- 4
objName <- "Instance"
group <- "AggOfMachineAggOfWorkDone"


exp$scheduleFeaturesExperiments(nrJobs,nrMachines,objName,group)


nrJobs <- 4
nrMachines <- 4
objName <- "Instance"
group <- "AggOfMachineAggOfWorkRemaining"


exp$scheduleFeaturesExperiments(nrJobs,nrMachines,objName,group)
#############MACHINE################################
nrJobs <- 4
nrMachines <- 4
objName <- "Machine"
group <- "AggOfOperationWorkBeingDone"


exp$scheduleFeaturesExperiments(nrJobs,nrMachines,objName,group)


nrJobs <- 4
nrMachines <- 4
objName <- "Machine"
group <- "AggOfOperationWorkDone"


exp$scheduleFeaturesExperiments(nrJobs,nrMachines,objName,group)


nrJobs <- 4
nrMachines <- 4
objName <- "Machine"
group <- "AggOfOperationWorkRemaining"


exp$scheduleFeaturesExperiments(nrJobs,nrMachines,objName,group)


nrJobs <- 4
nrMachines <- 4
objName <- "Machine"
group <- "AggOfRestMachineAggOfOperationBasic"


exp$scheduleFeaturesExperiments(nrJobs,nrMachines,objName,group)

nrJobs <- 4
nrMachines <- 4
objName <- "Machine"
group <- "AggOfOperationBasic"


exp$scheduleFeaturesExperiments(nrJobs,nrMachines,objName,group)

nrJobs <- 4
nrMachines <- 4
objName <- "Job"
group <- "AggOfOperationBasic"


exp$scheduleFeaturesExperiments(nrJobs,nrMachines,objName,group)


nrJobs <- 4
nrMachines <- 4
objName <- "Job"
group <- "AggOfRestJobAggOfOperationBasic"


exp$scheduleFeaturesExperiments(nrJobs,nrMachines,objName,group)







nrJobs <- 4
nrMachines <- 4
objName <- "Precedence"
group <- "AggOfOperationBasic"


exp$scheduleFeaturesExperiments(nrJobs,nrMachines,objName,group)

nrJobs <- 4
nrMachines <- 4
objName <- "Operation"
group <- "WorkDone"


exp$scheduleFeaturesExperiments(nrJobs,nrMachines,objName,group)


nrJobs <- 4
nrMachines <- 4
objName <- "Operation"
group <- "WorkRemaining"


exp$scheduleFeaturesExperiments(nrJobs,nrMachines,objName,group)

nrJobs <- 4
nrMachines <- 4
objName <- "Operation"
group <- "WorkBeingDone"


exp$scheduleFeaturesExperiments(nrJobs,nrMachines,objName,group)

nrJobs <- 4
nrMachines <- 4
objName <- "Operation"
group <- "ICS"


exp$scheduleFeaturesExperiments(nrJobs,nrMachines,objName,group)
