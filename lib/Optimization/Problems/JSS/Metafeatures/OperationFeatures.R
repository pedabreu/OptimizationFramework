setConstructorS3("OperationFeatures",function()
{
  extend(FeaturedElement(),"OperationFeatures",
         job = NULL,
         machine = NULL)
  
})





setMethodS3("RankDurationFeatures","OperationFeatures", function(this,
                                                             aggregators = c("min","mean","sum","max"),                                                                                             
                                                             ...) {
  inst <- this$instance
  
  for(agg in aggregators)
  {
    featJobs <- apply(inst$duration,1,function(x){eval(call(agg,x))})
    sortFeatJobs <- sort(featJobs,index.return=TRUE)
    
    
    this$features[[paste(agg,"DurationRankInJob",sep="")]] <- sortFeatJobs$ix[this$job]
 
    
    featMachines <- apply(inst$duration,2,function(x){eval(call(agg,x))})
    sortFeatMachines <- sort(featMachines,index.return=TRUE)
    
    
    this$features[[paste(agg,"DurationRankInMachine",sep="")]] <- sortFeatMachines$ix[this$machine]
    
    
  }
  
})




setMethodS3("DurationFeatures","OperationFeatures", function(this,
                                                               aggregators = c("min","mean","sum","max"),                                                                                             
                                                               ...) {
  inst <- this$instance
    
  for(agg in aggregators)
  {
    this$features[[paste(agg,"DurationInMachine",sep="")]] <- eval(call(agg,inst$duration[,this$machine]))
    this$features[[paste(agg,"DurationInJob",sep="")]] <- eval(call(agg,inst$duration[this$job,]))    
  }
    
})


setMethodS3("PrecedenceFeatures","OperationFeatures", function(this,
                                                             aggregators = c("min","mean","sum","max"),                                                                                             
                                                             ...) {
  inst <- this$instance
  
  for(agg in aggregators)
  {
    this$features[[paste(agg,"PrecedenceInMachine",sep="")]] <- eval(call(agg,inst$precedence[,this$machine]))
#    this$features[[paste(agg,"PrecedenceInJob",sep="")]] <- eval(call(agg,inst$precedence[this$job,]))    
  }
  
})