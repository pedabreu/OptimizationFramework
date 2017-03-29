library("R.oo")

setConstructorS3("MetaheuristicAlgorithm",function()
{
  
  alg <- AlgorithmParameterized()
  ##alg$search <- MetaHeuristicSearch()
  alg$searchClass <- "MetaHeuristicSearch"
  
  extend(alg,"MetaheuristicAlgorithm")
  
  
})


setMethodS3("searchHeuristic","MetaheuristicAlgorithm", function(this,instance,...) {
  
  

})

