
setConstructorS3("PLMutationSW",function()
           {
  mut <- Mutation()
  mut$chromossomeClass <- "PLChromosome"
 
  extend(mut,"PLMutationSW")
  
           }
           )



setMethodS3("run","PLMutationSW", function(this,chromosome = NULL,...) {

   individual <- chromosome$genes$priorityList

   dim.ind <- dim(individual)
   machine <- trunc(runif(1,min=1,max=dim.ind[2]+1))
   two.jobs <- trunc(runif(2,min=1,max=dim.ind[1]+1))
   
   job2 <- individual[two.jobs[2],machine]
   job1 <- individual[two.jobs[1],machine]
   
   individual[two.jobs[2],machine] <- job1
   individual[two.jobs[1],machine] <- job2
  
   novochrom <- chromosome$mutationInMachine(machine,job1,job2)
   
   
   return(novochrom)
})
