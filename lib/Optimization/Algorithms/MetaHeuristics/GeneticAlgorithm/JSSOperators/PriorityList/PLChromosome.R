setConstructorS3("PLChromosome",function()
           {

 
            chrom <- HeuristicChromosome() 
            gene <- PriorityList()
            chrom$genes <- gene
            
            extend(chrom,"PLChromosome")
  
           }
           )



setMethodS3("mutationInMachine","PLChromosome", function(this,machine,job1,job2,...) {
    
  genes <- this$genes$priorityList
  this$fitness <- NULL
  
  prevPriority1 <- genes[job1,machine] 
  prevPriority2 <- genes[job2,machine]   
  
  genes[job1,machine] <- prevPriority2
  genes[job2,machine] <- prevPriority1
  
  newchrom <- PLChromosome()  
  newchrom$genes$priorityList <- genes
  
  return(newchrom)
})

setMethodS3("crossoverWithCuts","PLChromosome", function(this,male,cut1,cut2,...) {
  
  thisGenes <- this$genes$priorityList
  maleGenes <- male$genes$priorityList
  dimensions <- dim(thisGenes)
  
  this$fitness <- NULL
  
  
  children <- array(dim=dimensions)
  
  children[cut1:cut2,] <- thisGenes[cut1:cut2,]
  
  

    for(machine.number in 1:dimensions[2])
    {
      children[-(cut1:cut2),machine.number] <- setdiff(maleGenes[,machine.number],
                                                  thisGenes[cut1:cut2,machine.number])
    }
  
  newchrom <- PLChromosome()  
  newchrom$genes$priorityList <- children
      
  return(newchrom)
})

# setMethodS3("print","PLChromosome", function(this,...) {
#   
#   print("Chromosome:\n")
#   
#   
# })


