setConstructorS3("Population",function()
           {
             extend(Object(),"Population",
                    debug = FALSE,
                    chromosomeClass = "Chromosome",
                    nrEvaluatedSolutions = 0,
                    generation = 1,
                    instance = NULL,
                    parent = list(),
                    offspring = list(),
                    crossoverOperator = Crossover(),
                    mutationOperator = Mutation(),
                    orderFunctionFitness = function(x){sort(x,index.return = TRUE)$ix},
                    elitistQuantity = 1,
                    ## elitistType - can be "relative" if elististQuantity is a percentage or "absolute" the exact number to select
                    elitistType = "absolute")
  
           })

setMethodS3("parentFitness","Population", function(this,...) {
  
  individuals <- this$parent
  allfitness <- unlist(lapply(individuals,function(x)x$fitness))
  
  return(allfitness)  
})


setMethodS3("getBestIndividual","Population", function(this,...) {
  
  allpop <- c(this$parent,this$offspring)
  
  orderAllPop <- this$orderByFitness(allpop)
  
  return(orderAllPop[[1]])  
})


setMethodS3("orderByFitness","Population", function(this,individuals,...) {

  allfitness <- unlist(lapply(individuals,function(x)x$fitness))
  sortedInd <- eval(do.call(this$orderFunctionFitness,list(x=allfitness)))
 
  return(individuals[sortedInd])
})


setMethodS3("elitistValue","Population", function(this,...) {

  elitValue <- 1 
  size <- length(this$parent)+length(this$offspring)
  
  if(this$elitistType == "relative")
    {
      elitValue <-  this$elitistQuantity*size/100

    }

  if(this$elitistType == "absolute")
    {
      elitValue <- min(this$elitistQuantity,size)

    }
  
  return(elitValue)
  
})






setMethodS3("parentSize","Population", function(this,nr,...) {

  return(length(this$parent))
  
})

setMethodS3("offspringSize","Population", function(this,nr,...) {

  return(length(this$offspring))
  
})



setMethodS3("generateRandomParents","Population", function(this,nr,...) {

  if(this$debug)
  {
    print("Begin population generation")
    
  }
  
  for(i in 1:nr)
    {
    
      eval(parse(text=paste("ind<-",this$chromosomeClass,"()",sep="")))
      ind$generateRandom(this$instance)
      this$parent[[i]] <- ind
    } 
  
  if(this$debug)
  {
 
    print("End population generation")
  
    }
  
  
})

setMethodS3("increaseGeneration","Population", function(this,...) {

  this$generation <- this$generation + 1
 
})


setMethodS3("calculateAllFitness","Population", function(this,...) {
  
  if(this$debug)
  {
    print("Begin calculating parents fitness...")
    
  }
  
  

  for(i in 1:length(this$parent))
    {      
      ind <- this$parent[[i]]
      ind$calculateFitness(this$instance)
      this$parent[[i]] <- ind
    }
  
  if(this$debug)
  {
    print("End calculating parent fitness...")
    print("Begin calculating offspring fitness...")
   ## browser()    
  }
  

  if(length(this$offspring)>0)
  {
    for(i in 1:length(this$offspring))
      {      
  
     
      ind <- this$offspring[[i]]
  print(ind)
        ind$calculateFitness(this$instance)
        this$offspring[[i]] <- ind
      }
  }
  
  this$nrEvaluatedSolutions <- this$nrEvaluatedSolutions + length(this$offspring) + length(this$parent) 
  
  if(this$debug)
  {
    print("End calculating offspring fitness...")
    
  }
  
})

setMethodS3("crossover","Population", function(this,...) {


  if(this$debug)
  {
    print("Iniciou o crossover...")
    
  }
  
  crossoverOperator <- this$crossoverOperator
  offspring <- list()
  
  select.individual.females<-which(runif(this$parentSize())< crossoverOperator$probability)

  
  if(length(select.individual.females) > 0)
    {
      
      select.individual.lucky.guys<-c()
      
      for(female in select.individual.females)
        {
          select.individual.lucky.guys<-c(select.individual.lucky.guys,sample(setdiff(1:this$parentSize(),female),1))
        }
      
      if(length(select.individual.lucky.guys)>0)
      {
      for(i in 1:length(select.individual.females))
        {
    
         female <- this$parent[[select.individual.females[i]]]
         male <- this$parent[[select.individual.lucky.guys[i]]]
  
         offspring <- c(offspring,crossoverOperator$run(male,female))
          
          
        }
      }
    }
  
  if(this$debug)
  {
    
    print("Fim do crossover...")
    
  }
  
  this$offspring <- offspring
  
  
})


setMethodS3("mutation","Population", function(this,...) {

  
  if(this$debug)
  {
    print("Iniciou a mutation")

  }

  mutationOperator <- this$mutationOperator
  offspring <- this$offspring


  if(!is.null(offspring) & length(offspring)>0)
    {
      mutation.pop <- which(runif(length(offspring)) < mutationOperator$probability)

      if(length(mutation.pop)>0)
        {
          for(i in mutation.pop)
            {
       
             offspring[[i]] <- mutationOperator$run(offspring[[i]])
            }

        }
      
      
    }
  
  this$offspring <- offspring
  
  if(this$debug)
  {

    print("Fim  da mutation...")
    
  }
  

})




setMethodS3("selection","Population", function(this,...) {

  
  if(this$debug)
  {
    print("Begin selection")
    
  }
  
  elitistValue <- this$elitistValue()

  
  all.pop <- c(this$parent,this$offspring)
 
  orderedPop <- this$orderByFitness(all.pop)

  newpop <- orderedPop[1:elitistValue]
    
  if(elitistValue < this$parentSize())
    {
   
      for(k in 1:( this$parentSize()-elitistValue))
        {
          selected <- sort(sample((elitistValue + 1):this$parentSize(),2))

    
          newpop[[elitistValue + k]] <- orderedPop[[selected[1]]]

        }


    }
  
  
  if(this$debug)
  {
    print("End selection")
    
  }

  this$parent <- newpop
})
