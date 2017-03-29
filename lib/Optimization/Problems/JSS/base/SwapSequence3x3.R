setConstructorS3("SwapSequence3x3",function()
{
  extend(SwapSequence(),"SwapSequence3x3")  
})




setMethodS3("DBsave","SwapSequence3x3", function(this,con=NULL,...) {
  
  DBobj<-DBSwapSequence3x3()
    
  seqObj <- this$sequence
  
  inst <- this$instance

  DBobj$attributes<-list("uniqueID" = this$uniqueID,
                          "Instance_uniqueID" = inst$uniqueID,
                          "sequence" = seqObj$getSequenceString(),
                          "swapIndex1" = this$index1,
                          "swapIndex2" = this$index2)

  DBobj$save(con)
  
})


setMethodS3("DBgetByUniqueID","SwapSequence3x3", function(this,uniqueID = NULL,con=NULL,...) {
  
  

    this$uniqueID <- uniqueID
    
    # sourceDirectory(paste("./lib/MySQLInterface/",sep=""))
    DBobj<-DBSwapSequence3x3()
    
    if(!is.null(uniqueID))
    {
      DBobj$attributes[["uniqueID"]] <- uniqueID   
    }
        
    DBobj$getByAttributes(con)
    
    attrib <- DBobj$attributes
    uniqueID <- attrib[["uniqueID"]]     
    this$uniqueID <- uniqueID    
    
    this$index1 <- attrib[["swapIndex1"]]
    this$index2 <- attrib[["swapIndex2"]]    
  
    inst <- Instance()
    inst$DBgetByUniqueID(attrib[["Instance_uniqueID"]],con)
    
    
    
    this$instance <- inst
    
    seq <- Sequence()
    seq$setSequenceFromString(attrib[["sequence"]])
    this$sequence <- seq
    
    
  
  
})

setMethodS3("DBgetAllByAttributes","SwapSequence3x3", function(this,attributes = list(),con=NULL,...) {
  
  
    
    # sourceDirectory(paste("./lib/MySQLInterface/",sep=""))
    DBobj<-DBSwapSequence3x3()
    
    DBobj$attributes <- attributes
    
    allDBobj <- DBobj$getAllByAttributes(con)
    
    allobjs <- list()
    
    for(obj in allDBobj)
    {
      attrib <- obj$attributes  
      
      swpseq <- SwapSequence()
      
      swpseq$index1 <- attrib[["swapIndex1"]]
      swpseq$index2 <- attrib[["swapIndex2"]]    
      
      inst <- Instance()
      inst$DBgetByUniqueID(attrib[["Instance_uniqueID"]],con)      
      
      
      swpseq$instance <- inst
      
      seq <- Sequence()
      seq$setSequenceFromString(attrib[["sequence"]])
      swpseq$sequence <- seq      
      
      allobjs <- c(allobjs,
                   list(swpseq))
      
    }
    
    
    return(allobjs)

})

