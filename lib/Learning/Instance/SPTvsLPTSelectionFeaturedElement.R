setConstructorS3("SPTvsLPTSelectionFeaturedElement",function()
{
  
  obj <- TwoAlgorithmsSelectionFeaturedElement()
  
  
  SPT <- AlgorithmParameterized()
  SPT$DBgetByUniqueID(uniqueID = '120726130343x2EL')
    
  LPT <- AlgorithmParameterized()
  LPT$DBgetByUniqueID(uniqueID = '120726130343pTIK')
  
  obj$algorithm1 <- SPT
  obj$algorithm2 <- LPT  
  
  
  extend(obj,"SPTvsLPTSelectionFeaturedElement")
})




