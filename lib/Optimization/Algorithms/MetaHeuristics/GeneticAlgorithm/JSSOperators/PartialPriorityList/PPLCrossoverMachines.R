setConstructorS3("PPLCrossoverMachines",function()
{
  cross <- Crossover()
  cross$chromossomeClass <- "PPLChromosome"
  extend(cross,"PPLCrossoverMachines")
  
})

setMethodS3("run","PPLCrossoverMachines", function(this,
                                                   male = NULL,
                                                   female = NULL,...) {
  
  
  parent1 <- male$.genes$.priorityList
  parent2 <- female$.genes$.priorityList
  dimensions <- length(parent1)
  
  cut <- floor(dimensions/2)
  
  children1 <- c(parent1[1:cut],parent2[(cut+1):dimensions])
  children2 <- c(parent2[1:cut],parent1[(cut+1):dimensions])

  newChrom1 <- PLChromosome()
  newChrom2 <- PLChromosome()  
  
  newChrom1$.genes$.priorityList <- children1
  newChrom2$.genes$.priorityList <- children2  
  
  return(list(newChrom1,newChrom2))
})
