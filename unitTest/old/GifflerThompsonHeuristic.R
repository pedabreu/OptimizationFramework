library("R.oo")
library("RMySQL")
library("R.utils")

rm(list = ls())

sourceDirectory(paste("./lib/Optimization/Problems/JSS/GifflerThompsonHeuristic/",sep=""))
sourceDirectory(paste("./lib/Optimization/Problems/JSS/base/",sep=""))

inst <- Instance()
inst$random.instance()

heuristicaRule1 <- Rule()

GTHeuristicAlgorithm <- GTHeuristicAlgorithm(inst,heuristicaRule1)

sched <- GTHeuristicAlgorithm$run()
sched$plotJobsGanttChart()
