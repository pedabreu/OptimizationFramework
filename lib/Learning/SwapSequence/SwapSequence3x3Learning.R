setConstructorS3("SwapSequence3x3Learning",function()
{
  
  obj <- LearningExperiment()
  obj$featureElement <- SwapSequence3x3FeaturedElement() 
  extend(obj,"SwapSequence3x3Learning")
  
})

