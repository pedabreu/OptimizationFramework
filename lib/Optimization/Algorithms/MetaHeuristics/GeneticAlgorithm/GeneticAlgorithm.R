setConstructorS3("GeneticAlgorithm",function(stopCriterium = MaxNrIteration(),
                                             population.size = 2,
                                             chromosomeClass = "Chromosome",                                         
                                             crossover = Crossover(),
                                             mutation = Mutation(),
                                             elitistQuantity = 1,
                                             ## elitistType - can be "relative" if elististQuantity is a percentage or "absolute" the exact number to select
                                             elitistType = "absolute")
           {

  extend(MetaheuristicAlgorithm(),"GeneticAlgorithm",
                    population = NULL)  
           })



setMethodS3("sameDBObject","GeneticAlgorithm", function(this,ga,con=NULL,...) {
  
  thisParam <- this$parameters
  gaParam <- ga$parameters
  
  same <- this$name == ga$name &
    all(class(thisParam[["stopCriterium"]]) ==  class(gaParam[["stopCriterium"]])) &
    all(class(thisParam[["crossover"]]) ==  class(gaParam[["crossover"]])) &
    all(class(thisParam[["mutation"]]) ==  class(gaParam[["mutation"]])) &
    thisParam[["chromosomeClass"]] == gaParam[["chromosomeClass"]] &
    thisParam[["population.size"]] == gaParam[["population.size"]] &
    thisParam[["elitistQuantity"]] == gaParam[["elitistQuantity"]] &
    thisParam[["elitistType"]] == gaParam[["elitistType"]]   
  
    return(same)
})


setMethodS3("prerun","GeneticAlgorithm", function(this,instance,...) {
  
  param <- this$parameters
  
  population <- Population()
  population$instance <- instance
  population$chromosomeClass <- param[["chromosomeClass"]]
  population$crossoverOperator <- param[["crossover"]]
  population$mutationOperator <- param[["mutation"]]
  population$orderFunctionFitness <- function(x){sort(x,index.return = TRUE)$ix} 
  population$elitistQuantity <- param[["elitistQuantity"]]
  population$elitistType <- param[["elitistType"]] 
  
  

  resultReturn <- TRUE
  this$population <- population
  chromClass <- param$chromosomeClass
  mut <- param$mutation

  if(mut$chromossomeClass != chromClass)
  {
    resultReturn <- FALSE 
    print("Mutation component is not compatible for Chromosome type")
  }
  
  cross <- param$crossover

  if(cross$chromossomeClass != chromClass)
  {
    resultReturn <- FALSE 
    print("Crossover component is not compatible for Chromosome type")
  }
  
  
  
  
  
  return(resultReturn)
})

setMethodS3("run","GeneticAlgorithm", function(this,instance,...) {
  
  print("run GeneticAlgorithm")
  param <- this$parameters
  search <- this$search
  population <- this$population  
  ##population$debug <- TRUE
  print (search$historicalFitnessInfo)
  if(population$debug)
  {
    print("Beginning search...")
    print(paste("Instance UI: ",instance$uniqueID))
    print(paste("Algorithm UI: ",this$uniqueID))    
    
    
  }
  
  
  stopCrit <- param$stopCriterium
  
  
  population$generateRandomParents(as.numeric(param[["population.size"]]))
  
  stopCrit$maxNrEvaluatedSolutions<-as.numeric(stopCrit$maxNrEvaluatedSolutions)
  
  while(stopCrit$continue(population))
  {
    
    print(paste("---New Iteration: ",population$generation,"---------------------------------"))
    print(paste("---Crossover---------------------"))
    population$crossover()
    print(paste("---Mutation-----------------------"))
    population$mutation()
    
    print(paste("---Fitness-----------------------"))
    population$calculateAllFitness()
    print(paste("---Selection-----------------------"))
    population$selection()
    print(paste("---Add Information-----------------"))
  #  browser()
    search$addIterationInformation(population)
    print(paste("---Increase generation-------------"))
    population$increaseGeneration()
    
    if(population$debug)
    {
      print("Adicionando historico...")
      
      
      
    }
    
    
    #  print("---End Iteration-----------------------------------")
  }
  print(paste("---Writing final information-------------"))
  search$finalInformation(population)
  
  if(population$debug)
  {
    print("End search...")
    
  }
  
  
  
  bestInd <- population$getBestIndividual()
  bestGenes <- bestInd$genes
  
  
  sched <- bestGenes$generateSchedule(instance)
  
  
  search$schedule <- sched
  search$solution <- bestGenes
  
  
  return(search) 
  
})