library("R.oo")
library("RMySQL")
library("R.utils")

rm(list = ls())

sourceDirectory(paste("./lib/Optimization/Problems/JSS/base/",sep=""))
sourceDirectory(paste("./lib/Optimization/Meta-Algorithms/GeneticAlgorithm/",sep=""))

inst <- Instance()
inst$random.instance()

GA1 <- GeneticAlgorithm(instance = inst)
pop <- GA1$run()
