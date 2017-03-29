setConstructorS3("MaxNrEvaluatedSolutions",function(nrMax = 10)
           {
             extend(StopCriterium(),"MaxNrEvaluatedSolutions",
                    maxNrEvaluatedSolutions = nrMax)
  
           }
           )



setMethodS3("maxIterations","MaxNrEvaluatedSolutions", function(this,nrMax,...) {
  this$maxNrEvaluatedSolutions <- nrMax
  })


setMethodS3("continue","MaxNrEvaluatedSolutions", function(this,population,...) {
return(population$nrEvaluatedSolutions < this$maxNrEvaluatedSolutions)
})

