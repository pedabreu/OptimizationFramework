library("R.oo")

setConstructorS3("DomainComponent",function()
{
  ui <- paste(format(Sys.time(), "%y%m%d%H%M%S"),
              paste(sample(c(0:9, letters, LETTERS))[1:4],collapse=""),sep="")
  
  dad <- ExperimentFrameworkObject()
  
  dad$pks$uniqueID <- ui
  
  extend(dad,"DomainComponent",
         uniqueID = ui)
})

setConstructorS3("Instance",function()
{
  extend(DomainComponent(),"Instance",                    
         source = "unknown",
         seed = round(runif(1,min=1,max=999999999)),                    
         #         nrMachines = NULL,
         #        nrJobs = NULL,
         duration = NULL,
         precedence = NULL,
         machine = NULL)
})

setConstructorS3("Rule",function()
{
  father <- GTHeuristic()
  father$solutionType <- "Rule"        
  
  extend(father,"Rule",
         operationEvaluationFunction = "Duration",
         selectionFunction = "max")
})

setConstructorS3("Sequence",function()
{
  father <- GTHeuristic()
  father$solutionType <- "Sequence"   
  
  extend(father,"Sequence",
         sequence = NULL)
})


setConstructorS3("Operation",function()
{
  extend(ExperimentFrameworkObject(),"Operation",
         instance = NULL,
         machine=NA,
         job=NA)
  
})

setConstructorS3("FeasibleScheduleOperation",function()
{
  classe <- DomainComponent()
  
  extend(classe,"FeasibleScheduleOperation",
         schedule = NULL,
         machineID=NA,
         jobID=NA,
         scheduled=FALSE)
})

setConstructorS3("GTHeuristic",function()
{
  extend(Solution(),"GTHeuristic")
  
})
