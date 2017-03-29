setConstructorS3("PLCrossoverNabel",function()
           {
  cross <- Crossover()
  cross$chromossomeClass <- "PLChromosome"
             extend(cross,"PLCrossoverNabel")
  
           }
           )

setMethodS3("run","PLCrossoverNabel", function(this,
                                               maleChromosome = NULL,
                                               femaleChromosome = NULL,...) {

  parent1 <- maleChromosome$genes$priorityList
  parent2 <- femaleChromosome$genes$priorityList
            
  dimensions <- dim(parent1)
  childrens <- list()
  
  children1 <- array(dim=c(dimensions))
  children2 <- array(dim=c(dimensions))   
  
  for(i in 1:dimensions[2])
    {
      children1[,i] <- parent1[parent2[,i],i]
      children2[,i] <- parent2[parent1[,i],i]
    }
  
  
  newChrom1 <- PLChromosome()
  newChrom2 <- PLChromosome()  
  
  newChrom1$genes$priorityList <- children1
  newChrom2$genes$priorityList <- children2  

  return(list(newChrom1,newChrom2))
  

})






