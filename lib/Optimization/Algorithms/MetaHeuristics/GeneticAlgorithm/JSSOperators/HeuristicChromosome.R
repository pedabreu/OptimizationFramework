setConstructorS3("HeuristicChromosome",function()
{
  extend(Chromosome(),"HeuristicChromosome")
  
})



setMethodS3("calculateFitness","HeuristicChromosome", function(this,instance,...) {
  
  ## sched <- Schedule()
  ##  sched <- sched$setInstance(instance)
  
  heuristicPL <-this$genes
  sched <- heuristicPL$generateSchedule(instance)
  
  
  ##sched$GT(heuristicPL)
  
  fit <- sched$makespan()
  this$fitness <- fit
  
  fit
  
})

setMethodS3("generateRandom","HeuristicChromosome", function(this,
                                                             instance,...) {
  
  ## nrjobs <- instance$nrJobs()
  ## gene <- array(1:nrjobs,dim=c(nrjobs,instance$nrMachines()))
  ## apply(gene,2,sample)
  
  gene <- this$genes # PartialPriorityList()
  randomGeneration(gene,instance)
  
  this$genes <- gene
})

# 
# setMethodS3("print","HeuristicChromosome", function(this,...) {
#   
#   print("Chromosome:\n")
#   
#   
# })


