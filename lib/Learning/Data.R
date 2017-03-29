setConstructorS3("ExperimentTables",function()
{
  extend(DomainComponent(),"ExperimentTables",
         targetName = NULL,
         targetGroup = NULL,
         ##list(featureName)
         features = list(),
         dataset = data.frame())
})

