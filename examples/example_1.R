
if( any("con" == ls()))
{
  dbDisconnect(con)
}

rm(list = ls())

library("DBI")
library("RMySQL")
library("R.utils")
library("R.oo")
library("moments")
library("XML")

sourceDirectory("/home/pabreu/MEOCloud/Trabalho/Domain/R/dev/lib/")
drv <- dbDriver("MySQL")

con <- dbConnect(drv,
                 host = "localhost",##"rank.fep.up.pt",
                 user= "root",##"pedabreu",
                 password= "pedrito",##"abreu",
                 dbname= "jss_dev_datamining",
                 client.flag = CLIENT_MULTI_STATEMENTS)

con2 <- dbConnect(drv,
                  host = "dbmlexp.fe.up.pt",
                  user = "grid",
                  password = "mysqlGridUser170781",
                  dbname = "jss_dev")

############################################################
##Cria uma instancia aleatoria 3x3##########################
############################################################
instance <- Instance() 
instance$DBgetByUniqueIDXML(uniqueID = "1211261851290pb2",con2)

instance$random.instance(nr.jobs=5,nr.machines=5)
######################################
LPT <- Rule()
LPT$operationEvaluationFunction <- "ProcessingTime"
LPT$selectionFunction <- "max"

schedLPT <- LPT$generateSchedule(instance)

SPT <- Rule()
SPT$operationEvaluationFunction <- "ProcessingTime"
SPT$selectionFunction <- "min"

schedSPT <- SPT$generateSchedule(instance)

critical.path <- schedSPT$getCriticalPath()

critical.path[[1]]$path

layout(matrix(c(1,2), 1, 2),widths=c(1,1))
schedLPT$plotJobsGanttChart(withCriticalPath = TRUE)
schedSPT$plotJobsGanttChart(withCriticalPath = TRUE)
#############################################################3
###Exemplo de plot de um schedule na base de dados
###########################################################
sched1 <- Schedule()
sched1$DBgetByUniqueIDXML(uniqueID = "140322071038ea27",con2)
sched1$plotJobsGanttChart( withCriticalPath = TRUE)

sched2 <- Schedule()
sched2$DBgetByUniqueIDXML(uniqueID = "140322115942jcp2",con2)
sched2$plotJobsGanttChart( withCriticalPath = TRUE)

############################################################
##ILP explanation##########################
############################################################
instance <- Instance() 

instance$random.instance(nr.jobs=10,nr.machines=10)
######################################
LPT <- Rule()
LPT$operationEvaluationFunction <- "ProcessingTime"
LPT$selectionFunction <- "max"


schedLPT <- LPT$generateSchedule(instance)
schedLPT$plotJobsGanttChart(withCriticalPath = TRUE)
LPT$ILCriticalPathConstraints(schedLPT)
############################################################
##Get Path##########################
############################################################
instance <- Instance() 

instance$random.instance(nr.jobs=4,nr.machines=4)
######################################
LPT <- Rule()
LPT$operationEvaluationFunction <- "ProcessingTime"
LPT$selectionFunction <- "max"


schedLPT <- LPT$generateSchedule(instance)
schedLPT$plotJobsGanttChart()
##Path until job 1 machine 1
p1 <- schedLPT$getPath(data.frame(1,1))
p1[[1]]$path
p2 <- schedLPT$getPath(data.frame(2,3))
p2[[1]]$path
############################################################
##Cria uma instancia de id 121126185121vZTx##########################
############################################################
instance <- Instance() 
instance$DBgetByUniqueIDXML(pks = list("uniqueID" = "1211261904443inb"),con = con2)

######################################
LPT <- Rule()
LPT$operationEvaluationFunction <- "ProcessingTime"
LPT$selectionFunction <- "max"

schedLPT <- LPT$generateSchedule(instance)

SPT <- Rule()
SPT$operationEvaluationFunction <- "ProcessingTime"
SPT$selectionFunction <- "min"

schedSPT <- SPT$generateSchedule(instance)

critical.path <- schedSPT$getCriticalPath()

critical.path[[1]]$path

layout(matrix(c(1,2), 1, 2),widths=c(1,1))
schedLPT$plotJobsGanttChart(withCriticalPath = TRUE)
schedSPT$plotJobsGanttChart(withCriticalPath = TRUE)
#####################################################
instance <- Instance() 

instance$random.instance(nr.jobs=10,nr.machines=10)


gappl <- GAPPL(stopCriterium = MaxNrEvaluatedSolutions(100),         
              population.size = 10,                                       
              crossover = PPLCrossoverMachines(),
              mutation = PPLMutation(10),
              elitistQuantity = 20,
              ## elitistType - can be "relative" if elististQuantity is a percentage or "absolute" the exact number to select
              elitistType = "relative")


runalg <- Run()


runalg$setRun(gappl,instance)

runalg$go()



