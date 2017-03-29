setConstructorS3("SwapSequence",function()
{
  extend(Object(),"SwapSequence",
         uniqueID = paste(format(Sys.time(), "%y%m%d%H%M%S"),paste(sample(c(0:9, letters, LETTERS))[1:4],collapse=""),sep=""),
         sequence = Sequence(),
         index1 = NULL,
         index2 = NULL,
         instance = NULL)  
})




setMethodS3("DBsave","SwapSequence", function(this,con=NULL,...) {
  
  DBobj<-DBSwapSequence()
    
  seqObj <- this$sequence
  
  inst <- this$instance

  DBobj$attributes<-list("uniqueID" = this$uniqueID,
                          "Instance_uniqueID" = inst$uniqueID,
                          "sequence" = seqObj$getSequenceString(),
                          "swapIndex1" = this$index1,
                          "swapIndex2" = this$index2)

  DBobj$save(con)
  
})


setMethodS3("DBgetByUniqueID","SwapSequence", function(this,uniqueID = NULL,con=NULL,...) {
  
  

   
    
    # sourceDirectory(paste("./lib/MySQLInterface/",sep=""))
    DBobj<-DBSwapSequence()
    
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

setMethodS3("DBgetAllByAttributes","SwapSequence", function(this,attributes = list(),con=NULL,...) {
  
  
    
    # sourceDirectory(paste("./lib/MySQLInterface/",sep=""))
    DBobj<-DBSwapSequence()
    
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

