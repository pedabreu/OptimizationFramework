begintime <- Sys.time()
currenttime <- Sys.time()
ultimorun <- currenttime
system("sh run.sh 10 OptimizationAlgorithm")

while(  as.numeric(difftime(currenttime,begintime,units="mins")) < 14*60)
{ 
  if(as.numeric(difftime(currenttime,ultimorun,units="mins")) > 60 )
  {
    system("sh run.sh 10 OptimizationAlgorithm")
    ultimorun <- Sys.time()
  }
  currenttime <- Sys.time()
  
}