library("R.oo")
library("RMySQL")
library("R.utils")

rm(list = ls())

sourceDirectory(paste("./lib/Optimization/Problems/JSS/base/",sep=""))
sourceDirectory(paste("./lib/",version,"/Optimization/Meta-Algorithms/GeneticAlgorithm/",sep=""))
sourceDirectory(paste("./lib/",version,"/Optimization/Problems/JSS/GeneticAlgorithm/PriorityList/",sep=""))

inst <- Instance()
inst$random.instance()


