setConstructorS3("PLCrossoverC1",function()
           {
  cross <- Crossover()
  cross$chromossomeClass <- "PLChromosome"
             extend(cross,"PLCrossoverC1")
  
           }
           )

setMethodS3("run","PLCrossoverC1", function(this,male = NULL,female = NULL,...) {


  parent1 <- male$genes$priorityList
  parent2 <- female$genes$priorityList
  dimensions <- dim(parent1)
  
  children1 <- array(dim=c(dimensions[1:2]))
  children2 <- array(dim=c(dimensions[1:2])) 
  
  
  substring.order <- sample(2:(dimensions[1]-1),1)
  
  children1[1:substring.order,] <- parent1[1:substring.order,]
  children2[1:substring.order,] <- parent2[1:substring.order,]
  
  ##Insert the rest of child
  for(machine.number in 1:dimensions[2])
    {
      children1[(substring.order + 1):dimensions[1],machine.number] <- setdiff(parent2[,machine.number],children1[,machine.number])
      children2[(substring.order + 1):dimensions[1],machine.number] <- setdiff(parent1[,machine.number],children2[,machine.number])
    }
  
  newChrom1 <- PLChromosome()
  newChrom2 <- PLChromosome()  
  
  newChrom1$genes$priorityList <- children1
  newChrom2$genes$priorityList <- children2  
  
  return(list(newChrom1,newChrom2))
  
})






