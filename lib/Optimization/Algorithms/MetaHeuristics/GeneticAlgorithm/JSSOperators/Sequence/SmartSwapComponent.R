setConstructorS3("SmartSwapComponent",function()
{
  extend(GAComponent(),"SmartSwapComponent")
  
})


setMethodS3("generateDatasetSandeep","SmartSwapComponent", function(this,
                                                                    instance,
                                                                    nrPermutations=NULL,
                                                                    add = NULL,...) {
  
  library("combinat")
  
  
  
  j <- instance$nrJobs()
  m <- instance$nrMachines()
  
  initialSeq <- rep(1:j,m)
  
  allSeqPerm<-permn(initialSeq)
  uniqueAllSeqPerm <- unique(allSeqPerm)
  
  if(!is.null(nrPermutations))
  {
    uniqueAllSeqPerm <-   uniqueAllSeqPerm[1:nrPermutations]    
    
    
  }
  

#   s <- lapply(uniqueAllSeqPerm,
#               function(x){  allperm <- expand.grid(1:length(x),1:length(x));                        
#                             allpermWithoutRepetition <- allperm[allperm[,1] < allperm[,2]  ,];
#                 cbind(matrix(rep(x,dim(allpermWithoutRepetition)[1]),ncol=length(x),byrow=TRUE),
#                       allpermWithoutRepetition)    } )
#   s1<-do.call("rbind",s)


  
  ##all permutation possible
  allperm <- expand.grid(1:length(initialSeq),1:length(initialSeq))
  
  ##remove repeated permutation
  
  allpermWithoutRepetition <- allperm[allperm[,1] < allperm[,2]  ,] 
  
  alldata <- NULL
  
  for(seq in uniqueAllSeqPerm)
  {
  
  data <- matrix(seq,nrow=dim(allpermWithoutRepetition)[1],
                 ncol=length(seq),byrow=TRUE)  
  
  
  data <- cbind(as.data.frame(data),allpermWithoutRepetition)
  
  seqObj <- Sequence()
  seqObj$sequence <- seq
 ## thisSched <- seqObj$getScheduleSandeep(instance2)

  ##seqFitness  <- thisSched$makespan()
  seqFitness  <- seqObj$fitnessSandeep(instance)
  fitnessData <- array(0,dim=c(dim(data)[1],
                               2))
  
  for(i in 1:dim(data)[1])
  {
    changedSeq <- seq
    changedSeq[allpermWithoutRepetition[i,1]] <- seq[allpermWithoutRepetition[i,2]] 
    changedSeq[allpermWithoutRepetition[i,2]] <- seq[allpermWithoutRepetition[i,1]] 
    
    newseq <- Sequence()
    newseq$sequence <- changedSeq
    
    
    ##newSched <- newseq$getScheduleSandeep(instance2)
   
 ##   newfit <-   newSched$makespan()
    newfit  <- seqObj$fitnessSandeep(instance)
    
    fitnessData[i,1] <- seqFitness
    fitnessData[i,2] <- seqFitness - newfit    
    
  }
  
  
  
  problem <- list(order = instance$precedence,
                  times = instance$duration)
  
  
  data <- cbind(data,as.data.frame(fitnessData))  
  mach.time<-array(dim=c(m,j))
  
  data<-cbind(data,J1=  apply(data,1,function(d){ d[d[j*m + 1]] })) #Job1
  data<-cbind(data,J2=  apply(data,1,function(d){ d[d[j*m + 2]] })) #Job2
  data<-cbind(data,O1=  apply(data,1,function(d){ which(which(d[1:(j*m)]==d[d[j*m +1]])==d[j*m+1]) })) #Order of machine in the job 1
  data<-cbind(data,O2=  apply(data,1,function(d){ which(which(d[1:(j*m)]==d[d[j*m +2]])==d[j*m+2]) })) #Order of machine in job 2
  data<-cbind(data,M1=  apply(data,1,function(d){ problem$order[d["J1"],d["O1"]] })) #Machine of job1
  data<-cbind(data,M2=	apply(data,1,function(d){ problem$order[d["J2"],d["O2"]] })) #Machine of job2
  data<-cbind(data,D1=	apply(data,1,function(d){ problem$times[d["J1"],d["M1"]] })) #Execution time for operation 1
  data<-cbind(data,D2=	apply(data,1,function(d){ problem$times[d["J2"],d["M2"]] })) #Execution time for operation 2
  data<-cbind(data,MOJ=	apply(data,1,function(d){ min(d["J1"],d["J2"]) })) # Minimum of the two jobs
  data<-cbind(data,NTJAB1=apply(data,1,function(d){ length(which(d[1:(d[j*m+1]-1)]==d["J2"])) })) #Number of times Job 1 has appeared before
  data<-cbind(data,NTJAB2=apply(data,1,function(d){ length(which(d[1:(d[j*m+2]-1)]==d["J2"])) })) #Number of times Job 2 has appeared before
  data<-cbind(data,SM=	apply(data,1,function(d){ ifelse(d["M1"]==d["M2"],1,0) })) #If they share the same machine
  data<-cbind(data,DBP=	apply(data,1,function(d){ d[j*m +  1]-d[j*m + 2] })) #Difference between the positions
  data<-cbind(data,TMJ1=	apply(data,1,function(d){ sum(problem$times[,d["M1"]]) })) #Total execution time of Machine of Job 1
  data<-cbind(data,TMJ2=	apply(data,1,function(d){ sum(problem$times[,d["M2"]]) })) #Total Execution time of machine of Job 2
  data<-cbind(data,TTBMTMJ1=apply(data,1,function(d){ d["TMJ1"]/max(colSums(problem$times)) })) #Total time for mach for job 1/max execution time by any machine
  data<-cbind(data,TTBMTMJ2=apply(data,1,function(d){ d["TMJ2"]/max(colSums(problem$times)) })) #Total time for mach for job 2/max execution time by any machine
  data<-cbind(data,NM1=	apply(data,1,function(d){ nd<-d;tmp<-nd[nd[j*m+1]];nd[nd[j*m+1]]<-nd[nd[j*m+2]];nd[nd[j*m+2]]<-tmp;problem$order[nd[nd[j*m +2]],which(which(nd[1:(j*m)]==nd[nd[j*m +2]])==nd[j*m+2])] })) #New machine for job 1
  data<-cbind(data,NM2=	apply(data,1,function(d){ nd<-d;tmp<-nd[nd[j*m+1]];nd[nd[j*m+1]]<-nd[nd[j*m+2]];nd[nd[j*m+2]]<-tmp;problem$order[nd[nd[j*m +1]],which(which(nd[1:(j*m)]==nd[nd[j*m +1]])==nd[j*m+1])] })) #New machine for job 2
  data<-cbind(data,SNM=	apply(data,1,function(d){ ifelse(d["NM1"]==d["NM2"],1,0) })) #If the new machines are same or not
  data<-cbind(data,TTOMBTTNMJ1=apply(data,1,function(d){ d["TMJ1"]/sum(problem$times[,d["NM1"]]) })) #Execution time of old machine/execution time by new machine of job 2
  data<-cbind(data,TTOMBTTNMJ2=apply(data,1,function(d){ d["TMJ2"]/sum(problem$times[,d["NM2"]]) })) #Execution time of old macihne/execution time by new machine of job 2
  data<-cbind(data,RJMPJ1=apply(data,1,function(d){ X<-rbind(d[1:(j*m)],((rank(d[1:(j*m)], ties="first") - 1)%% m) + 1)
                                                    for(i in 1:(j*m)){mach.time[problem$order[X[1,i],X[2,i]],X[1,i]]<-i}  
                                                    length(1:(which(sort(mach.time[d["M1"],])==mach.time[d["M1"],d["J1"]])))/length((which(sort(mach.time[d["M1"],])==mach.time[d["M1"],d["J1"]])):j)
  })) #Ratio of jobs on machine of Job 1 before the job and the jobs afterwards(including the job1 too)
  data<-cbind(data,RJMPJ2=apply(data,1,function(d){ X<-rbind(d[1:(j*m)],((rank(d[1:(j*m)], ties="first") - 1)%% m) + 1)
                                                    for(i in 1:(j*m)){mach.time[problem$order[X[1,i],X[2,i]],X[1,i]]<-i} 
                                                    length(1:(which(sort(mach.time[d["M2"],])==mach.time[d["M2"],d["J2"]])))/length((which(sort(mach.time[d["M2"],])==mach.time[d["M2"],d["J2"]])):j)
  })) #Ratio of jobs on machine of Job 1 before the job and the jobs afterwards(including the job1 too)
  data<-cbind(data,NSOB1=apply(data,1,function(d){length(which(d[d[j*m+1]:d[j*m+2]]==d["J1"])) })) #Number of same operations as Job 1 between the swap jobs
  data<-cbind(data,NSOB2=apply(data,1,function(d){length(which(d[d[j*m+1]:d[j*m+2]]==d["J2"]))})) #Number of same operations as JOb 2 between the swap jobs
  data<-cbind(data,DPM=apply(data,1,function(d){ X<-rbind(d[1:(j*m)],((rank(d[1:(j*m)], ties="first") - 1)%% m) + 1)
                                                 for(i in 1:(j*m)){mach.time[problem$order[X[1,i],X[2,i]],X[1,i]]<-i} 
                                                 which(sort(mach.time[d["M1"],])==mach.time[d["M1"],d["J1"]]) - which(sort(mach.time[d["M2"],])==mach.time[d["M2"],d["J2"]])
  })) #Difference between the positions of the jobs on corresponding machines
  data<-cbind(data,TPJMJ1=apply(data,1,function(d){ X<-rbind(d[1:(j*m)],((rank(d[1:(j*m)], ties="first") - 1)%% m) + 1)
                                                    for(i in 1:(j*m)){mach.time[problem$order[X[1,i],X[2,i]],X[1,i]]<-i}
                                                    sum(problem$times[sort.int(mach.time[d["M1"],],index.return=TRUE)$ix[1:(which(sort(mach.time[d["M1"],])==mach.time[d["M1"],d["J1"]]))],d["M1"]])
  })) #Execution time of the jobs before the job 1
  data<-cbind(data,TPJMJ2=apply(data,1,function(d){ X<-rbind(d[1:(j*m)],((rank(d[1:(j*m)], ties="first") - 1)%% m) + 1)
                                                    for(i in 1:(j*m)){mach.time[problem$order[X[1,i],X[2,i]],X[1,i]]<-i} 
                                                    sum(problem$times[sort.int(mach.time[d["M2"],],index.return=TRUE)$ix[1:(which(sort(mach.time[d["M2"],])==mach.time[d["M2"],d["J2"]]))],d["M2"]])
  })) #Execution time of the jops before the job 2
  data<-cbind(data,MAOJ=	apply(data,1,function(d){ max(d["J1"],d["J2"]) })) # Maximum of the two jobs
  data<-cbind(data,MC=apply(data,1,function(d){ X<-rbind(d[1:(j*m)],((rank(d[1:(j*m)], ties="first") - 1)%% m) + 1)
                                                for(i in 1:(j*m)){mach.time[problem$order[X[1,i],X[2,i]],X[1,i]]<-i} 
                                                for(i in 1:m){mach.time[i,]<-sort.int(mach.time[i,],index.return=TRUE)$ix}
                                                mean(cor(t(mach.time)))
  }))
  
  
  alldata <- rbind(alldata,data)
  
  
  }
  
  return(alldata)
  
})




setMethodS3("generateDataset","SmartSwapComponent", function(this,instance,nrPermutations=NULL,...) {
  
  library("combinat")

  j <- instance$nrJobs()
  m <- instance$nrMachines()
  
  initialSeq <- rep(1:j,m)
  
  allSeqPerm<-permn(initialSeq)
  uniqueAllSeqPerm <- unique(allSeqPerm)
  
  if(!is.null(nrPermutations))
  {
    uniqueAllSeqPerm <-   uniqueAllSeqPerm[1:nrPermutations]        
  }
  
  
  #   s <- lapply(uniqueAllSeqPerm,
  #               function(x){  allperm <- expand.grid(1:length(x),1:length(x));                        
  #                             allpermWithoutRepetition <- allperm[allperm[,1] < allperm[,2]  ,];
  #                 cbind(matrix(rep(x,dim(allpermWithoutRepetition)[1]),ncol=length(x),byrow=TRUE),
  #                       allpermWithoutRepetition)    } )
  #   s1<-do.call("rbind",s)
  
  
  
  ##all permutation possible
  allperm <- expand.grid(1:length(initialSeq),1:length(initialSeq))
  
  ##remove repeated permutation
  
  allpermWithoutRepetition <- allperm[allperm[,1] < allperm[,2]  ,] 
  
  alldata <- NULL
  
  for(seq in uniqueAllSeqPerm)
  {
    
#     data <- matrix(seq,nrow=dim(allpermWithoutRepetition)[1],
#                    ncol=length(seq),byrow=TRUE)  
#     
#     
#     data <- cbind(as.data.frame(data),allpermWithoutRepetition)
    
    seqObj <- Sequence()
    seqObj$sequence <- seq
    thisSched <- seqObj$getSchedule(instance)
    
    seqFitness  <- thisSched$makespan()
    
  
    for(i in 1:dim(allpermWithoutRepetition)[1])
    {
      changedSeq <- seq
      changedSeq[allpermWithoutRepetition[i,1]] <- seq[allpermWithoutRepetition[i,2]] 
      changedSeq[allpermWithoutRepetition[i,2]] <- seq[allpermWithoutRepetition[i,1]] 
      
      if(!all(changedSeq == seq))
      {
      newseq <- Sequence()
      newseq$sequence <- changedSeq
      
      
      newSched <- newseq$getSchedule(instance)
      
      newfit <- newSched$makespan()

    
      featuresSandeep <- seqObj$featuresSandeep(instance,
                                                allpermWithoutRepetition[i,1],
                                                allpermWithoutRepetition[i,2])
    
    
      newdata<- c(Sequence = paste(seq,collapse=""),
                  seq,
                  allpermWithoutRepetition[i,],
                  Fitness = seqFitness,
                  V13 = seqFitness - newfit,
                 featuresSandeep
                  )
      
      #browser()
      
      alldata <- rbind(alldata,
                       data.frame(lapply(newdata,function(x){x})))
      }
      
      
    
    }
  }
  
  return(as.data.frame(alldata))
  
})



setMethodS3("simpleDataset","SmartSwapComponent", function(this,instance,
                                                           nrPermutations=NULL,
                                                           generalDataset=NULL,...) {  

  
  featuresDataset <- data.frame()
  seq <- unlist(generalDataset[1,2:10])
  seqObj <- Sequence()       
  seqObj$sequence <- seq  
  
  for(i in 1:nrow(generalDataset))    
  {    

    
    features <- seqObj$simpleFeatures(instance,
                                      generalDataset[i,"Var1"],
                                      generalDataset[i,"Var2"])
    
    
  
    featuresDataset <- rbind(featuresDataset,
                     data.frame(lapply(features,function(x){x})))
    
    
  }

  alldata <- cbind(generalDataset,
                   featuresDataset)
  
  
   
  return(as.data.frame(alldata))
  
})

setMethodS3("myGenerateDataset","SmartSwapComponent", function(this,instance,nrPermutations=NULL,...) {
  
  library("combinat")
  
  j <- instance$nrJobs()
  m <- instance$nrMachines()
  
  initialSeq <- rep(1:j,m)
  
  allSeqPerm<-permn(initialSeq)
  uniqueAllSeqPerm <- unique(allSeqPerm)
  
  if(!is.null(nrPermutations))
  {
    uniqueAllSeqPerm <-   uniqueAllSeqPerm[1:nrPermutations]        
  }

  
  
  ##all permutation possible
  allperm <- expand.grid(1:length(initialSeq),1:length(initialSeq))
  
  ##remove repeated permutation
  
  allpermWithoutRepetition <- allperm[allperm[,1] < allperm[,2]  ,] 
  
  alldata <- NULL
  
  for(seq in uniqueAllSeqPerm)
  {
    
    seqObj <- Sequence()
    seqObj$sequence <- seq
    thisSched <- seqObj$getSchedule(instance)
    
    seqFitness  <- thisSched$makespan()
    
    
    for(i in 1:dim(allpermWithoutRepetition)[1])
    {
      changedSeq <- seq
      changedSeq[allpermWithoutRepetition[i,1]] <- seq[allpermWithoutRepetition[i,2]] 
      changedSeq[allpermWithoutRepetition[i,2]] <- seq[allpermWithoutRepetition[i,1]] 
      
      if(!all(changedSeq == seq))
      {
      newseq <- Sequence()
      newseq$sequence <- changedSeq
      
      
      newSched <- newseq$getSchedule(instance)
      
      newfit <- newSched$makespan()
      
      
      featuresSandeep <- seqObj$myFeatures(instance,
                                                allpermWithoutRepetition[i,1],
                                                allpermWithoutRepetition[i,2])
      
      

        
        
        newdata<- c(Sequence = paste(seq,collapse=""),
                    seq,
                    allpermWithoutRepetition[i,],
                    Fitness = seqFitness,
                    V13 = seqFitness - newfit,
                    featuresSandeep
                    )
 
        
        alldata <- rbind(alldata,
                         data.frame(lapply(newdata,function(x){x})))
      }
      
      
      
    }
  }
  
  return(as.data.frame(alldata))
  
})
