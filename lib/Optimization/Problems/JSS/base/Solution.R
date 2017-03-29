setConstructorS3("Solution",function()
{
  extend(DomainComponent(),"Solution",
         seed = round(runif(1,min=1,max=999999999)),  
         source = NULL,
         solutionType = NULL,
         nrJobs = NULL,
         nrMachines = NULL)
  
})


setMethodS3("randomGeneration","Solution", function(this,instance,...) {
  
 
  set.seed(this$seed)
  this$source <- "random"
  
  
  # this$nrJobs <- instance$nrJobs
#  this$nrMachines <- instance$nrMachines  
})

setMethodS3("sameDBObject","Solution", function(this,pl,con=NULL,...) {
  
  same <- this$source == pl$source &
    this$uniqueID == pl$uniqueID
    
  return(same)
})


setMethodS3("getSchedule","Solution", function(this,instance,...) {
  
 
  
  
})

setMethodS3("DBsave","Solution", function(this,con=NULL,...) {
  
  
  DBObjSol<-DBSolution()    
  DBObjSol$attributes<-list(uniqueID = this$uniqueID,
                             "source" = this$source,
                             "seed" = this$seed,
                         #    "nrJobs" = this$nrJobs,
                        #     "nrMachines" = this$nrMachines,
                             "SolutionType_name" = this$solutionType)

  DBObjSol$save(con)
  
})

setMethodS3("DBgetByUniqueID","Solution", function(this,
                                                   uniqueID=NULL,
                                                   con=NULL,...) {
  

  
  DBObjSol<-DBSolution()  
  
  DBObjSol$attributes<-list("uniqueID" = uniqueID)

  DBObjSol$getByAttributes(con)
  
  attribSol <-  DBObjSol$attributes
  
  this$seed <- attribSol[["seed"]]
  this$source <- attribSol[["source"]]
  this$uniqueID <- uniqueID
 # this$nrJobs <- attribSol[["nrJobs"]]
#  this$nrMachines <- attribSol[["nrMachines"]]
#   
#   sched <- Schedule()
#   sched$DBgetByUniqueID( attribSol[["FeasibleSchedule_uniqueID"]],con)
#     
#   this$schedule <- sched  
  
})