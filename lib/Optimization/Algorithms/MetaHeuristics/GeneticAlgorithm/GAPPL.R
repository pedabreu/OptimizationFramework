setConstructorS3("GAPPL",function(stopCriterium = MaxNrIteration(),
                                             population.size = 2,                                       
                                             crossover = Crossover(),
                                             mutation = Mutation(),
                                             elitistQuantity = 1,
                                             ## elitistType - can be "relative" if elististQuantity is a percentage or "absolute" the exact number to select
                                             elitistType = "absolute")
           {
  
 
  search <- PPLSearch()
  
  alg <- GeneticAlgorithm()
  alg$algorithmName <- "GAPPL"
  alg$search <- search

  
  
  alg$parameters <- list(   
    stopCriterium = stopCriterium,
    population.size = population.size,
    chromosomeClass = "PPLChromosome",                                         
    crossover = crossover,
    mutation = mutation,
    elitistQuantity = elitistQuantity,
    elitistType = elitistType)
  
  
  
  extend(alg,"GAPPL")
  
           }
           )


