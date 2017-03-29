setConstructorS3("SequenceSearch",function()                 
{
  
  s <- MetaHeuristicSearch()
  s$solution <- Sequence()
  
  extend(s,"SequenceSearch")
})
