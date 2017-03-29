library("R.oo")
# 
# 

setMethodS3("distance","Instance", function(this,instance,...){
  

  dist <- Inf
  
  allperm <- permn(1:this$nrJobs())
  
  
  for(permIndex in 1:length(allperm))
  {

    perm <- allperm[[permIndex]]    
    permDist <- 0
    
    for(precedenceValue in this$nrMachines():1)
    {
      for(jobValue in 1:this$nrJobs())
      {
        permJobValue <- perm[jobValue]
        thisMachineValue <- which(this$precedence[jobValue,] == precedenceValue)
        instanceMachineValue <- which(instance$precedence[permJobValue,] == precedenceValue)   
        
        thisDurationValue <- this$duration[jobValue,thisMachineValue]
        instanceDurationValue <- this$duration[permJobValue,instanceMachineValue]      
        
        
        if(thisMachineValue == instanceMachineValue)
        {
          permDist <- permDist + abs(thisDurationValue - instanceDurationValue)^(this$nrMachines()-precedenceValue + 1)
        }
        else
        {
          permDist <- permDist + thisDurationValue^(this$nrMachines()-precedenceValue + 1) + instanceDurationValue^(this$nrMachines()-precedenceValue + 1)
        }      
      }
      
      
      
      
    }
    
    if(permDist < dist)
    {
      dist <- permDist
    }
    
  }
  
  
  
  return(dist)  
  
})

setMethodS3("getICS","Instance", function(this,...){
   
   sched <- Schedule()
   sched$addInstance(this)
   
   sched$ICS()
      
   return(sched)  
   
 })




setMethodS3("XML2Instance","Instance", function(this,texto,...){
  
    doc <- xmlRoot(xmlTreeParse(texto,asText=TRUE))
    
    instanceAttrib <- doc$attributes
    
    nr.jobs <- as.integer(instanceAttrib["nJobs"])
    nr.machines <- as.integer(instanceAttrib["nMachines"])
    
    
    this$uniqueID <- instanceAttrib["id"]
    
    duration <- array(dim=c(nr.jobs,nr.machines))
    precedence <- array(dim=c(nr.jobs,nr.machines))
    
    for(i in 1:length(doc))
    {
      operationXML <- doc[[i]]
      operationAttrib <- operationXML$attributes
      
      j <- as.integer(operationAttrib["job"])
      m <- as.integer(operationAttrib["machine"])
      
      duration[j,m] <- as.integer(xmlValue(operationXML[["Duration"]]))
      precedence[j,m] <- as.integer(xmlValue(operationXML[["OrderInJob"]]))
      
    }
    
    this$duration <- duration
    this$precedence <- precedence
    
  
  
  
})

setMethodS3("readXML","Instance", function(this,file=NULL,...){
  
  
  if(!is.null(file))
  {
    doc <- xmlRoot(xmlTreeParse(file))
    
    instanceAttrib <- doc$attributes
    
    nr.jobs <- as.integer(instanceAttrib["nJobs"])
    nr.machines <- as.integer(instanceAttrib["nMachines"])
    
    
    this$uniqueID <- instanceAttrib["id"]
    
    duration <- array(dim=c(nr.jobs,nr.machines))
    precedence <- array(dim=c(nr.jobs,nr.machines))
    
    for(i in 1:length(doc))
    {
      operationXML <- doc[[i]]
      operationAttrib <- operationXML$attributes
      
      j <- as.integer(operationAttrib["job"])
      m <- as.integer(operationAttrib["machine"])
      
      duration[j,m] <- as.integer(xmlValue(operationXML[["Duration"]]))
      precedence[j,m] <- as.integer(xmlValue(operationXML[["OrderInJob"]]))
      
    }
    
    this$duration <- duration
    this$precedence <- precedence
    
  }
  
  
})
  
setMethodS3("writeFile","Instance", function(this,file=paste("./",this$uniqueID,sep=""),...){
  
  
  towrite <- paste(this$nrJobs()," ",this$nrMachines(),sep="")
  
  
  for(j in 1:this$nrJobs())
  {
    machineOrder <- sort(this$precedence[j,],index.return=TRUE)$ix
    machineDuration <- this$duration[j,machineOrder]
    
    towrite <- c(towrite,paste(paste(machineOrder,machineDuration,sep=" "),collapse=" "))
  }

  write(towrite,file=file) 
  
  ##  sink(file) 
  ##  sink() 
  
})


setMethodS3("Instance2XML","Instance", function(this,...){
  
  
  tt <- xmlHashTree()
  instanceNode <- addNode(xmlNode("Instance",attrs=c("id" = this$uniqueID,"nJobs"=this$nrJobs(),"nMachines"=this$nrMachines())), 
                          character(), tt)
  
  
  for(j in 1:this$nrJobs())
  {
    for(m in 1:this$nrMachines())
    {
      
      
      operationNode <- addNode(xmlNode("Operation",attrs=c("job" = j,"machine" = m)), 
                               instanceNode, tt)     
      
      durationNode <- addNode(xmlNode("Duration"), operationNode, tt)
      orderNode <- addNode(xmlNode("OrderInJob"), operationNode, tt) 
      
      addNode(xmlTextNode(this$duration[j,m]),durationNode,tt)
      addNode(xmlTextNode(this$precedence[j,m]),orderNode,tt)                              
      
      
      
    }    
  }
  
  return(tt)  
  
})



setMethodS3("writeXML","Instance", function(this,file=paste("./",this$uniqueID,".xml",sep=""),...){
  
  
  tt <- this$Instance2XML()  
  
  sink(file) 
  print(tt) 
  sink() 
  
})



# 
# setMethodS3("upFeatureGenerator","Instance", function(this,con=NULL,
#                                                       job,
#                                                       machine,
#                                                       levelStop = 2,
#                                                       classes = c("job","machine"),
#                                                       attributes = c("duration","precedence"),
#                                                       aggregators = c("max","min","avg","sum"),
#                                                       ...) {
#   
#   
#   elements <- list()
#   
#   
#   
# #   for(agg in aggregators)
# #   {
# #     newelm <- FeaturedElement()   
# #     newelm$features <- list(paste(agg,"duration",sep="") = eval(call(agg,this$duration[job,])),
# #                              paste(agg,"precedence",sep="") = eval(call(agg,this$precedence[job,])))
# #     
# #     newelm$nameClass = "job"
# #    #newelm$valueClass = job
# #     newelm$level = 1
# #     
# #     elements[[1]] <- c(elements[[1]],
# #                        newelm)
# #   }
# #   
# #   for(agg in aggregators)
# #   {
# #     newelm <- FeaturedElement()      
# #     newelm$features <- list(paste(agg,"duration",sep="") = eval(call(agg,this$duration[,machine])),
# #                              paste(agg,"precedence",sep="") = eval(call(agg,this$precedence[,machine])))
# #     
# #     newelm$nameClass = "machine"
# #    #newelm$valueClass = machine
# #     newelm$level = 1
# #     
# #     elements[[1]] <- c(elements[[1]],
# #                        newelm)
# #   }
#   
#   
#   
#   
#   
#   
#   
#   for(j in 1:this$nrJobs())
#   {
#     for(agg in aggregators)
#     {
#       newelm <- FeaturedElement()   
#       newelm$features <- list(paste(agg,"duration",sep="") = eval(call(agg,this$duration[j,])),
#                                paste(agg,"precedence",sep="") = eval(call(agg,this$precedence[j,])))
#   
#       newelm$nameClass = "job"
#       newelm$valueClass = j
#       newelm$level = 1
#       newelm$type = "notRelated"
#       
#       if(j == job)
#       {
#         newelm$type = "related"        
#       }
#       
#       
#       
#       elements[[1]] <- c(elements[[1]],
#                          newelm)
#     }
#   }
#   
#   for(m in 1:this$nrMachines())
#   {      
#     for(agg in aggregators)
#     {
#       newelm <- FeaturedElement()      
#       newelm$features <- list(paste(agg,"duration",sep="") = eval(call(agg,this$duration[,m])),
#                                paste(agg,"precedence",sep="") = eval(call(agg,this$precedence[,m])))
#       
#       newelm$nameClass = "machine"
#       newelm$valueClass = m
#       newelm$level = 1
#       newelm$type = "notRelated"
#       
#       if(m == machine)
#       {
#         newelm$type = "related"        
#       }
#       
#       elements[[1]] <- c(elements[[1]],
#                          newelm)
#     }
#   }
#   
#   
#   
#   if(lev > 1)
#   {
#     for(lev in 2:levelStop)
#     {
#       currentElmts <- elements[[lev - 1]]
#       
#       currentFeatures <- names(currentElmts[[1]]$features)
#       
#       
#       ## For each feature, order
#       for(feat in currentFeatures)
#       {
#         valueElemts <- NULL
#       
#         for(elmt in currentElmts)
#         {
#           valueElemts <- c(valueElemts,
#                            elmt$features[[feat]])
#           
#           
#         }
#         
#         sortValuesElemts <- sort(valueElemts, 
#                                  index.return = TRUE)
#         
#         orderElemts <- currentElmts[sortValuesElemts$ix]
#         
#         
#         
#         
#         
#         
#         
#       }
#       
#       
#       
#     }
#   
#   }
#   
#   
#   
# })
# 


setMethodS3("precedenceIndex","Instance", function(this,...) {
  

  return(t(apply(this$precedence, 1, order)))
  
})


setMethodS3("sameDBObject","Instance", function(this,instance,con=NULL,...) {
  
  same <- all(this$precedence == instance$precedence) &
    all(this$duration == instance$duration) &
    this$nrJobs() == instance$nrJobs() &
    this$nrMachines() == instance$nrMachines() &
    this$uniqueID == instance$uniqueID &
    this$seed == instance$seed &
    this$source == instance$source
  
  return(same)
})



setMethodS3("DBsave","Instance", function(this,con=NULL,...) {

  
  
  DBobj<-DBInstance()
  
  tt <- this$Instance2XML()
  texto<-toString(xmlRoot(tt))
  
  DBobj$attributes<-list("uniqueID"=this$uniqueID,
                         "source" = this$source,
                         "seed" = this$seed,
                         "nrJobs"=this$nrJobs(),
                         "nrMachines" = this$nrMachines(),
                         "xml" = texto)
  
  DBobj$save(con)
  # 
  # nrJobs <- this$nrJobs()
  # nrMachines <- this$nrMachines()
  # 
  # for(j in 1:nrJobs)
  # {
  #   for(m in 1:nrMachines)
  #   {
  #     DBobj1<-DBOperation()
  #     
  #     DBobj1$attributes<-list(#uniqueID = paste(format(Sys.time(), "%y%m%d%H%M%S"),paste(sample(c(0:9, letters, LETTERS))[1:4],collapse=""),sep=""),
  #                             machine = m,
  #                             job = j,
  #                             duration = this$duration[j,m],
  #                             precedence = this$precedence[j,m],
  #                             Instance_uniqueID = this$uniqueID,
  #                             Instance_size=paste(nrJobs,"x",nrMachines,sep=""))
  #     DBobj1$save(con)
  #     
  #   }
  # }
  
})

setMethodS3("constructObjectFromDBMainObject",
            "Instance", function(this,
                                 con= NULL,
                                 ...) {
     
              DBobj <- this$mainDBObject
              uniqueID <- this$pks["uniqueID"]           
           
              attrib <- DBobj$attributes
              
              nrJobs <- attrib[["nrJobs"]]
              nrMachines <- attrib[["nrMachines"]]   
              
              this$uniqueID <- uniqueID
        #      this$nrJobs <- nrJobs
        #      this$nrMachines <- nrMachines
              this$seed <- attrib[["seed"]]
              this$source <- attrib[["source"]]    
              
              
              DBobjOp<-DBOperation()
              
              DBobjOp$attributes[["Instance_uniqueID"]] <- uniqueID
      
              allDBOp <- DBobjOp$getAllByAttributes(con)    
              
              this$precedence <- array(dim=c(nrJobs,nrMachines))
              this$duration <- array(dim=c(nrJobs,nrMachines))
              
              for(i in 1:length(allDBOp))
              {
                currentDBOp <- allDBOp[[i]]
                
                attribCurrentDBOp <- currentDBOp$attributes
                
                j <- attribCurrentDBOp[["job"]]
                m <- attribCurrentDBOp[["machine"]]
                
                this$precedence[j,m] <- attribCurrentDBOp[["precedence"]]
                this$duration[j,m] <- attribCurrentDBOp[["duration"]]
                
              }
              
              
            })



setMethodS3("constructObjectFromDBMainObjectXML",
            "Instance", function(this,
                                 con= NULL,
                                 ...) {
     
              DBobj <- this$mainDBObject
              uniqueID <- this$pks["uniqueID"]           
              
              attrib <- DBobj$attributes
              
              nrJobs <- attrib[["nrJobs"]]
              nrMachines <- attrib[["nrMachines"]]   
              
              this$uniqueID <- uniqueID
              #      this$nrJobs <- nrJobs
              #      this$nrMachines <- nrMachines
              this$seed <- attrib[["seed"]]
              this$source <- attrib[["source"]]    
              textXML <- attrib[["xml"]]
               
              this$XML2Instance(textXML)
            })

setMethodS3("DBgetByUniqueID","Instance", function(this,
                                                   pks,
                                                   con,...) {
  
   ##print("Get main object")
  
  this$getDBMainObject(values=pks,con=con)
    ##print("Construct Object")
  this$constructObjectFromDBMainObject(con)  
  
  
})

setMethodS3("DBgetByUniqueIDXML","Instance", function(this,
                                                   pks,
                                                   con,...) {
  
  ##print("Get main object")
  
  this$getDBMainObject(values=pks,con=con)
  ##print("Construct Object")
  this$constructObjectFromDBMainObjectXML(con)  
  
  
})

setMethodS3("random.instance","Instance", function(this,
                                                   nr.jobs = round(runif(1,min=3,max=10)),
                                                   nr.machines = round(runif(1,min=3,max=10)),
                                                   correlation = "no",
                                                   same.job.same.dist = FALSE,
                                                   minDuration=1,
                                                   maxDuration=99,
                                                   parameter.1.int =c(1,1),
                                                   parameter.2.int =c(1,1),
                                                   order.parameter = 99999999999,...) {


  this$source <- "random"

  
  if(!is.null(this$nrMachines()))
  {
    nr.machines=this$nrMachines()
    
  }

  if(!is.null(this$nrJobs()))
  {
    nr.jobs=this$nrJobs()
  }
  
  this$nrMachines = nr.machines
  this$nrJobs = nr.jobs

  
  seed <- this$seed
  set.seed(seed)
  
  #######################################################################


   duration.int=c(minDuration,maxDuration)


   
  order <- array(dim=c(nr.jobs,nr.machines))
  order.number <- trunc(runif(nr.jobs,max = order.parameter))
 
  for(j in 1:nr.jobs)
    {

      if(j > 1 & any(order.number[j]==order.number[1:(j-1)]))
        {
          order[j,] <- order[which(order.number[j]==order.number[1:(j-1)])[1],] 
        }
      else
        {
          order[j,] <- sample(1:nr.machines)
        }
    }
  
  ########################################################################
  
  duration <- array(dim=c(nr.jobs,nr.machines))
  all.parameter.1 <- NULL
  all.parameter.2 <- NULL
  
  if(correlation=="job")
    {
      all.parameter.1 <- runif(nr.jobs,min = parameter.1.int[1],max = parameter.1.int[2])
      all.parameter.2 <- runif(nr.jobs,min = parameter.2.int[1],max = parameter.2.int[2])

      for(j in 1:nr.jobs)
        {
          if(j > 1 & any(order.number[j] == order.number[1:(j-1)]) & same.job.same.dist)
            {
              same.j <- which(order.number[j]==order.number[1:(j-1)])[1]
              values <- rbeta(nr.machines,all.parameter.1[same.j],all.parameter.2[same.j])
              duration[j,] <- trunc(duration.int[1] + duration.int[2]*values)                       
            }
          else
            {
              values <- rbeta(nr.machines,all.parameter.1[j],all.parameter.2[j])
              duration[j,]<- trunc(duration.int[1] + duration.int[2]*values)
              
            }
        } 
    }
  
  if(correlation=="machine")
    {
      
      all.parameter.1 <- runif(nr.machines,min = parameter.1.int[1],max = parameter.1.int[2])
      all.parameter.2 <- runif(nr.machines,min = parameter.2.int[1],max = parameter.2.int[2])

      for(m in 1:nr.machines)
        {
          values <- rbeta(nr.jobs,all.parameter.1[m],all.parameter.2[m])
          duration[,m]<- trunc(duration.int[1] + duration.int[2]*values)
         
        }
    }
  
  if(correlation=="no")
    {
      all.parameter.1 <- runif(1,min = parameter.1.int[1],max = parameter.1.int[2])
      all.parameter.2 <- runif(1,min = parameter.2.int[1],max = parameter.2.int[2])

      values <- rbeta(nr.jobs*nr.machines,all.parameter.1,all.parameter.2)
      duration <- array(trunc(duration.int[1] + duration.int[2]*values),dim=c(nr.jobs,nr.machines))
      
    }


   this$randomFeatures <-   list(seed = seed,
                                  correlation = correlation,
                                  same.job.same.dist = same.job.same.dist,
                                  parameter.1.int = parameter.1.int,
                                  parameter.2.int = parameter.2.int,
                                  parameter.beta.1 =  all.parameter.1,
                                  parameter.beta.2 =  all.parameter.2,
                                  order.parameter = order.parameter)    
   this$duration <- duration
   this$precedence <- order

})



setMethodS3("nrMachines","Instance", function(this,...) {
  d <- dim(this$duration)
  
  return(d[2]) 
})

setMethodS3("nrJobs","Instance", function(this,...) {
  d <- dim(this$duration)
  
  return(d[1]) 
})

# 
# setMethodS3("getDuration","Instance", function(this,jobID = NA,machineID = NA,...) {
#   return(this$duration[jobID,machineID])
# })
# 
# setMethodS3("getPrecedence","Instance", function(this,jobID = NA,machineID = NA,...) {
#   return(this$precedence[jobID,machineID]) 
# })
# 
# setMethodS3("setDuration","Instance", function(this,duration= NA,jobID = NA,machineID = NA,...) {
#   this$duration[jobID,machineID] <- duration
# })
# 
# setMethodS3("setPrecedence","Instance", function(this,precedence=NA,jobID = NA,machineID = NA,...) {
#   this$precedence[jobID,machineID] <- precedence
# })
# 
# setMethodS3("getMachine","Instance", function(this,jobID = NA,precedence = NA,...) {
# 
#   if(is.null(this$machine))
#     {
#       this$machine <- t(apply(this$precedence, 1, order))
#     }
# 
#   
#   return(this$machine[jobID,precedence])
# })


setMethodS3("getOperation","Instance", function(this,machineID = NA,jobID = NA,...) {

  operation <- Operation()
  
  operation$machineID <- machineID
  operation$jobID <- jobID
## operation$precedence <- this$getPrecedence(jobID,machineID)
##  operation$duration <- this$getDuration(jobID,machineID)
  
  return(operation)
})

setMethodS3("getOperationSameMachine","Instance", function(this,machineID = NA,...) {

  operations <- list()

  for(i in 1:this$nrJobs())
    {
      
      operations[[i]] <- this$getOperation(machineID,i)
    }

  
  return(operations)
})

setMethodS3("getOperationSameJob","Instance", function(this,jobID = NA,...) {

  operations <- list()

  for(i in 1:this$nrMachines())
    {
      operations[[i]] <- this$getOperation(i,jobID)
    }

  
  return(operations)
})

setMethodS3("getOperationSamePrecedence","Instance", function(this,precedence = NA,...) {

   operations <- list()

  for(i in 1:this$nrJobs())
    {
      machineID <- this$getMachine(i,precedence)    
      
      operations[[i]] <- this$getOperation(machineID,i)
    }

  
  return(operations)
})




