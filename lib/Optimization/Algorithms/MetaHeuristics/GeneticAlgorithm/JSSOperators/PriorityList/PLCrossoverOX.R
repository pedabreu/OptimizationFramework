setConstructorS3("PLCrossoverOX",function()
           {
  cross <- Crossover()
  cross$chromossomeClass <- "PLChromosome"
             extend(cross,"PLCrossoverOX")
  
           }
           )

setMethodS3("run","PLCrossoverOX", function(this,maleChromosome = NULL,femaleChromosome = NULL,...) {

  parents <- list(maleChromosome$genes$priorityList,
                  femaleChromosome$genes$priorityList)
  
  dimensions <- dim(parents[[1]])
  
  substring.order<-sort(sample(1:dimensions[1],2))

  children1 <- array(dim=dimensions)
  children2 <- array(dim=dimensions)
  
  children1[substring.order[1]:substring.order[2],]<-parents[[1]][substring.order[1]:substring.order[2],]
  children2[substring.order[1]:substring.order[2],]<-parents[[2]][substring.order[1]:substring.order[2],]
  

  if(substring.order[1] > 1 | substring.order[2] < dimensions[1])
  {
    
    for(machine.number in 1:dimensions[2]){
      children1[-(substring.order[1]:substring.order[2]),
               machine.number]<-setdiff(parents[[2]][,machine.number],children1[,machine.number])}
  
    
    for(machine.number in 1:dimensions[2]){
      children2[-(substring.order[1]:substring.order[2]),
                machine.number]<-setdiff(parents[[1]][,machine.number],children2[,machine.number])}
    
    
    
    }
  
  newChrom1 <- PLChromosome() 
  newChrom1$genes$priorityList <- children1
  
  newChrom2 <- PLChromosome() 
  newChrom2$genes$priorityList <- children2
  
  
  return(list(newChrom1,newChrom2))
  
})






