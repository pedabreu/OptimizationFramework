library("R.oo")
library("RMySQL")
library("R.utils")

rm(list = ls())

sourceDirectory(paste("./lib/Optimization/Problems/JSS/base/",sep=""))
sourceDirectory(paste("./lib/MySQLInterface/",sep=""))
sourceDirectory(paste("./DBModels/",sep=""))
m<-dbDriver("MySQL")

con <- dbConnect(m,host="localhost",user="root",password="pedrito",dbname="JSS")

inst <- Instance()
inst$random.instance()

##save inst in DB
inst$DBsave(con)
uniqueIDinst <- inst$.uniqueID

##get from DB by inst  uniqueID
inst1<- Instance()
inst1$DBgetByUniqueID(uniqueIDinst,con)

inst1$.duration-inst$.duration
inst1$.precedence-inst$.precedence

###################
##Test heuristics##
###################

##Rule Heuristic
heuristicaRule1 <- Rule()
randomGeneration(heuristicaRule1,inst)
DBsave(heuristicaRule1,con)

heuristicaRule2 <- Rule()
uniqueIDheuristicaRule1 <- heuristicaRule1$.uniqueID
DBgetByUniqueID(heuristicaRule2,uniqueIDheuristicaRule1,con)

heuristicaRule1$.operationEvaluationFunction == heuristicaRule2$.operationEvaluationFunction
heuristicaRule1$.selectionFunction == heuristicaRule2$.selectionFunction 


schedRule1 <- heuristicaRule1$getSchedule(inst)
schedRule1$plotJobsGanttChart()

##Priority List Heuristic
heuristicaPL1 <- PriorityList()
randomGeneration(heuristicaPL1,inst)
DBsave(heuristicaPL1,con)

heuristicaPL2 <- PriorityList()
uniqueIDheuristicaPL1 <- heuristicaPL1$.uniqueID
DBgetByUniqueID(heuristicaPL2,uniqueIDheuristicaPL1,con)

heuristicaPL1$.uniqueID == heuristicaPL2$.uniqueID 
heuristicaPL1$.priorityList == heuristicaPL2$.priorityList 


schedPL1 <- heuristicaPL1$getSchedule(inst)
schedPL1$plotJobsGanttChart()

##Partial Priority List Heuristic
heuristicaPPL1 <- PartialPriorityList()
randomGeneration(heuristicaPPL1,inst)
DBsave(heuristicaPPL1,con)

heuristicaPPL2 <- PartialPriorityList()
uniqueIDheuristicaPPL1 <- heuristicaPPL1$.uniqueID
DBgetByUniqueID(heuristicaPPL2,uniqueIDheuristicaPPL1,con)

heuristicaPPL1$.uniqueID == heuristicaPPL2$.uniqueID 
heuristicaPPL1$.id == heuristicaPPL2$.id
heuristicaPPL1$.defaultRule$.operationEvaluationFunction == heuristicaPPL2$.defaultRule$.operationEvaluationFunction
heuristicaPPL1$.defaultRule$.selectionFunction == heuristicaPPL2$.defaultRule$.selectionFunction
heuristicaPPL1$.priorityList == heuristicaPPL2$.priorityList 


schedPPL1 <-  heuristicaPPL1$getSchedule(inst)
schedPPL1$plotJobsGanttChart()

##Sequence 
sequence1 <- Sequence()
randomGeneration(sequence1,inst)
DBsave(sequence1,con)

sequence2 <- Sequence()
uniqueIDsequence1 <- sequence1$.uniqueID
DBgetByUniqueID(sequence2,uniqueIDsequence1,con)

heuristicaPPL1$.uniqueID == heuristicaPPL2$.uniqueID 
heuristicaPPL1$.sequence == heuristicaPPL2$.sequence


schedSequence1 <-  sequence1$getSchedule(inst)
sequence1$plotJobsGanttChart()







