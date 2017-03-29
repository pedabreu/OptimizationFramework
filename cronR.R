args <- commandArgs(trailingOnly = TRUE)


tempo <- Sys.time()
duracaoTotal <- as.integer(args[1])
periodo <- 60*30#args[2]
qtJobs <- 5 #args[3]

comando <- paste("sh run.sh ",qtJobs," OptimizationAlgorithm")

system(comando)

lastlaunch <- tempo


while(Sys.time() < (tempo + duracaoTotal))
{
  if(Sys.time() > (lastlaunch + periodo))
  {
   system(comando)
   lastlaunch <- Sys.time()
  } 
}