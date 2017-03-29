setConstructorS3("Mutation",function()
           {
  GAComp <- GAComponent()
  GAComp$chromossomeClass <- "Chromossome"
             extend(GAComp,"Mutation")
  
           }
           )



setMethodS3("run","Mutation", function(this,chromosome= NULL,...) {
  return(chromosome)
  
})
