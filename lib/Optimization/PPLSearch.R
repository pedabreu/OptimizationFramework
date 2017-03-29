setConstructorS3("PPLSearch",function()                 
{
  
  s <- MetaHeuristicSearch()
  s$solution <- PartialPriorityList()
  
  extend(s,"PPLSearch")
})
