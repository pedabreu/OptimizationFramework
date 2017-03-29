setConstructorS3("Crossover",function()
           {
  GAComp <- GAComponent()
            GAComp$chromossomeClass <- "Chromossome"
             extend(GAComp,"Crossover")
  
           }
           )

setMethodS3("run","Crossover", function(this,male = NULL,female = NULL,...) {
  return(male)
})


