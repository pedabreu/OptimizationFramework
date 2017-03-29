setConstructorS3("Run",function()
{
  extend(Object(),"Run",
         uniqueID = NULL,
         seed = NULL,         
         startTime = NULL,     
         systemTime = NULL,
         userTime = NULL,
         elapsedTime = NULL,
         memory = NULL,
         instance = NULL, 
         algorithmParameterized = NULL,
         search = NULL,
         schedule = NULL,
         machine = NULL)
  
  })

setMethodS3("sameDBObject","Run", function(this,run,con=NULL,...) {
  
  sameInst <- this$instance$sameDBObject(run$instance,con) 
  sameSchedule <- this$schedule$sameDBObject(run$schedule,con)      
  sameAlg <- this$algorithmParameterized$sameDBObject(run$algorithmParameterized,con)    
  sameSearch <- this$search$sameDBObject(run$search,con)    
   
  same <- this$uniqueID == run$uniqueID &
    this$seed == run$seed &
    this$startTime == run$startTime &
    this$systemTime == run$systemTime &
    this$userTime == run$userTime &
    this$elapsedTime == run$elapsedTime &
    ##this$memory == run$memory &
    sameInst &
    sameSchedule &
    sameAlg


  
  return(same)
})

setMethodS3("setRun","Run", function(this,
                                     algorithmParam = NULL,
                                     instance = NULL,...) {
  
  this$instance <- instance
  this$algorithmParameterized <- algorithmParam
  
  eval(parse(text=paste("this$search<-", algorithmParam$searchClass,"()",sep="")))
  #this$search <- algorithmParam$search  
})




setMethodS3("go","Run", function(this,...) {
  
  #print("Method:Run$go")
  this$seed <- round(runif(1,min=1,max=999999999))
  
  this$search <- NULL
  this$schedule <- NULL
  this$machine <- NULL
  


  
  set.seed(this$seed)
  
  
  alg <- this$algorithmParameterized 
  alg$instance <- this$instance
  
  this$startTime <- format(Sys.time(), "%Y-%m-%d %H:%M:%S",tz="GMT")
  
  pr <- alg$prerun(this$instance)
  finalResult <- FALSE
  
  if(pr)
  {   
    eval(parse(text=paste("alg$search <- ", alg$searchClass,"()",sep="")))
    s<-system.time(this$search <- alg$run(this$instance), gcFirst = TRUE)
    alg$posrun(this$instance)

    search <- this$search
    search$run <- this$uniqueID
    
    sched <- search$schedule
    
 
    
    this$schedule <- sched
    this$search <- search
    
    this$userTime <- round(s[[1]],2)
    this$systemTime <- round(s[[2]],2)
    this$elapsedTime <- round(s[[3]],2)
    
    
    finalResult <- list(uniqueID = this$uniqueID,
                        seed = this$seed,
                        startTime = this$startTime,     
                        systemTime = this$systemTime,
                        userTime = this$userTime,
                        elapsedTime = this$elapsedTime,
                        memory = NULL,
                        schedule = this$schedule,
                        search = this$search)
    
  }
  
  return(finalResult)
  
})



setMethodS3("DBgetByUniqueID","Run", function(this,uniqueID,con=NULL,...) {
  
  
  print("Get run...")
  DBobj<-DBRun()
  
  DBobj$attributes <- list("uniqueID" = uniqueID )
  DBobj$getByAttributes(con) 
  
  attribObj<-DBobj$attributes
  
  uniqueIDinst <- attribObj[["Instance_uniqueID"]]
  uniqueIDsched <- attribObj[["FeasibleSchedule_uniqueID"]]  
  uniqueIDalg <- attribObj[["AlgorithmParameterized_uniqueID"]]
  
  
  this$uniqueID <- uniqueID
  this$seed <- attribObj[["seed"]]  
  this$startTime <- attribObj[["start_time"]]      
  this$systemTime <- attribObj[["systemTime"]]  
  this$userTime <- attribObj[["userTime"]]  
  this$elapsedTime <- attribObj[["elapsedTime"]]  
  this$memory <- attribObj[["memory"]]  
  print("Done")
  
  print("Get schedule...")
  sched <- Schedule()
  sched$DBgetByUniqueID(uniqueIDsched,con,nrJobs=inst$neJobs(),nrMachines=inst$nrMachines())
  this$schedule <- sched  
  print("Done")
  
  print("Get instance...")
  inst <- Instance()
  inst$DBgetByUniqueID(list(uniqueID=uniqueIDinst),con)
  this$instance <- inst
  print("Done")
  
  print("Get algorithm...")
  dbalg <- DBAlgorithmParameterized()
  dbalg$attributes <- list("uniqueID" = uniqueIDalg )
  dbalg$getByAttributes(con) 
  
  
  
  
  alg <- eval(parse(text=paste(dbalg$attributes[["Algorithm_name"]],"()",sep="")))
  alg$DBgetByUniqueID(uniqueIDalg,con)
  this$algorithmParameterized <- alg
  print("Done")
  
  print("Get search.....")
  search <- alg$search
  DBgetByRunUniqueID(search,uniqueID,con)
  this$search <- search
  print("Done")
  




  
})

setMethodS3("DBsave","Run", function(this,con,...) {
  
  sched <- this$schedule
  instance <- this$instance
  alg <- this$algorithmParameterized
  
  sched$AlgorithmParameterized_uniqueID <- alg$uniqueID
  
  print("Saving schedule ...")
  print(paste("uniqueID:",sched$uniqueID))
  sched$DBsave(con)
  print("Done")

  DBobj<-DBRun()
  
  
  

  DBobj$attributes <- list("uniqueID" = this$uniqueID,
                            seed =  this$seed,
                            start_time =  this$startTime,     
                            systemTime =  this$systemTime,
                            userTime =  this$userTime,
                            elapsedTime =  this$elapsedTime,
                            memory =  NULL,
                            Instance_uniqueID =  instance$uniqueID, 
                            AlgorithmParameterized_uniqueID =  alg$uniqueID,
                            FeasibleSchedule_uniqueID = sched$uniqueID,
                            status = "Finished")
 
 
  print("Saving run...")
  DBobj$save(con)
  print("Done")
  
  search <- this$search
  
  print("Saving search statistics...")

  DBsave(search,con)
  print("Done")  
  
  
  
  
})
  