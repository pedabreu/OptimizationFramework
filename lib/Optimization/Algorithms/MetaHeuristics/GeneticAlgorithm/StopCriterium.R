setConstructorS3("StopCriterium",function()
           {
             extend(Object(),"StopCriterium")
  
           }
           )



setMethodS3("continue","StopCriterium", function(this,population,...) {
return(10 > population$generation)
})

