setConstructorS3("MaxNrIteration",function(nrMaxIter = 10)
           {
             extend(StopCriterium(),"MaxNrIteration",
                    nrMaxIteration = nrMaxIter)
  
           }
           )



setMethodS3("maxIterations","MaxNrIteration", function(this,nrMaxIteration,...) {
  this$nrMaxIteration <- nrMaxIteration
})


setMethodS3("continue","MaxNrIteration", function(this,population,...) {
return(population$generation < this$nrMaxIteration)
})

