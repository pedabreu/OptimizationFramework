setConstructorS3("SequenceChromosome",function()
{
  
  
  chrom <- HeuristicChromosome() 
  gene <- Sequence()
  chrom$genes <- gene
  
  extend(chrom,"SequenceChromosome")
  
}
                 )







