setConstructorS3("PLCrossoverPedro",function()
           {
  cross <- Crossover()
  cross$chromossomeClass <- "PLChromosome"
             extend(cross,"PLCrossoverPedro")
  
           }
           )

setMethodS3("run","PLCrossoverPedro", function(this,maleChromosome = NULL,femaleChromosome = NULL,...) {

  pesos <-  c(0.5,0.5)
  
  parent1 <- maleChromosome$genes$priorityList
  parent2 <- femaleChromosome$genes$priorityList
  d<-dim(parent1)
  
  nr.machines <- d[2]
  nr.jobs <- d[1]
  new.solution <- array(dim=d)
  
  for(m in 1:nr.machines)
    {
      job.sum.order <- c()
      
      for(j in 1:nr.jobs)
        {
          job.sum.order[j] <- which(parent1[,m] == j)*pesos[1] + which(parent2[,m] == j)*pesos[2]
          
        }
      
      new.solution[,m] <- order(job.sum.order)
      
      }
  
  newChrom <- PLChromosome()
  
  
  newChrom$genes$priorityList <- new.solution
  
  return(list(newChrom))
})






