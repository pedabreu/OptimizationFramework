setConstructorS3("GAPL",function(stopCriterium = MaxNrIteration(),
                                 population.size = 2,                                       
                                 crossover = Crossover(),
                                 mutation = Mutation(),
                                 elitistQuantity = 1,
                                 ## elitistType - can be "relative" if elististQuantity is a percentage or "absolute" the exact number to select
                                 elitistType = "absolute")
{
  
  
  search <- PLSearch()
  
  alg <- GeneticAlgorithm()
  alg$algorithmName <- "GAPL"
  alg$search <- search
  
  
  
  alg$parameters <- list(   
    stopCriterium = stopCriterium,
    population.size = population.size,
    chromosomeClass = "PLChromosome",                                         
    crossover = crossover,
    mutation = mutation,
    elitistQuantity = elitistQuantity,
    elitistType = elitistType)
  
  
  
  extend(alg,"GAPL")
  
           }
           )


