setConstructorS3("PLSearch",function()                 
{
  
  s <- MetaHeuristicSearch()
  s$solution <- PriorityList()
  
  extend(s,"PLSearch")
})
