setConstructorS3("PPLChromosome",function(max_size)
{
  
  chrom <- HeuristicChromosome() 
  gene <- PartialPriorityList()
  chrom$genes <- gene
  
  extend(chrom,"PPLChromosome",
         max_size = max_size)
  
})

