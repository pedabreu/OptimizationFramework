
countMachines <- function(maquinas)
{
  nrMachines <- length(levels(maquinas))
  count <- rep(0,nrMachines)
  names(count) <- levels(maquinas)
  countTable <- table(maquinas)
  
  count[names(countTable)] <- countTable
  
  return(count)
}




countDistinct <- function(maquinas)
{
  count <- countMachines(maquinas)
  
  return(length(which(count > 0)))  
}

countMax <- function(maquinas)
{
  count <- countMachines(maquinas)
  
  return(max(count))  
  
}

countMin <- function(maquinas)
{
  count <- countMachines(maquinas)
  
  return(min(count))  
}

countMean <- function(maquinas)
{
  count <- countMachines(maquinas)
  
  return(mean(count))  
}

countVar <- function(maquinas)
{
  count <- countMachines(maquinas)
  
  return(var(count))  
}
