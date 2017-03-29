
setConstructorS3("PPLMutation",function(max_size)
{
  mut <- Mutation()
  mut$chromossomeClass <- "PPLChromosome"
  
  
  
  extend(mut,"PPLMutation",max_size)
  
})



setMethodS3("run","PPLMutation", function(this,chromosome = NULL,...) {
  
  individual <- chromosome$genes$priorityList
  nr.jobs   
  
  
  random_machine <- sample(1,1:length(individual))
  gene <- individual[[random_machine]]
  
  swap_or_size <- runif(1)
  new_gene<- NULL
  
  if(length(gene) == nr.jobs | swap_or_size < 0.5)
  {
    swp_jobs <- sample(2,length(gene))
    new_gene <- gene
    
    new_gene[swp_jobs[1]] <- gene[swp_jobs[2]]
    new_gene[swp_jobs[2]] <- gene[swp_jobs[1]] 
  }
  else
  {
    add_gene <- setdiff(1:nr.jobs,gene)[1]
    new_gene <- c(gene,add_gene)
  }
  
  new_individual <- individual
  new_individual[[random_machine]] <- new_gene
  
  novochrom <- PPLChromosome()
  novochrom$genes$priorityList <- new_individual
  
  return(novochrom)
})
