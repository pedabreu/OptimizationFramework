library("R.oo")
library("RMySQL")
library("R.utils")
library("rpart")

system("ssh -fNn -L 3307:rank.fep.up.pt:3306 pedabreu@rank.fep.up.pt &")

if( any("con" == ls()))
{
dbDisconnect(con)
}


rm(list = ls())
sourceDirectory(paste("./lib/",sep=""))
## sourceDirectory(paste("./lib/MySQLInterface/",sep=""))
## sourceDirectory(paste("./DBModels/",sep=""))


allexp <- EnsembleLearningExperiment(featureElement = SwapSequence3x3FeaturedElement(),
                                     targets = c("DiffFitness","RacioFitness"))


allexp$getDataFromDB(featuresGroups = c("OriginalSequenceFitness","OperationIndexBased3x3","JobMachineOrderIndexBased3x3","Sandeep"),                 
                     moreFeatures = NULL,
                     exceptions = NULL,
                     limit = 28000)

exp1 <- allexp$runExperiment(name = "Experiment-1",
                             featuresGroups = c("OperationIndexBased3x3","JobMachineOrderIndexBased3x3")   ,                                   
                             moreFeatures = NULL,
                             exceptions = NULL,                            
                             models = list(Model("lm"),
                                           Model("rpart")),                  
                             target = "DiffFitness")
#exp1$analysisModelPlot(index=2)
exp2 <- allexp$runExperiment(name = "Experiment-2",
                             featuresGroups = c("OriginalSequenceFitness","OperationIndexBased3x3","JobMachineOrderIndexBased3x3")   ,                                   
                             moreFeatures = NULL,
                             exceptions = NULL,                            
                             models = list(Model("lm"),
                                           Model("rpart")),                  
                             target = "DiffFitness")

#exp2$analysisModelPlot(index=2)
exp3 <- allexp$runExperiment(name = "Experiment-3",
                             featuresGroups = c("OriginalSequenceFitness","Sandeep")   ,                                   
                             moreFeatures = NULL,
                             exceptions = NULL,                            
                             models = list(Model("lm"),
                                           Model("rpart")),                  
                             target = "DiffFitness")

#exp3$analysisModelPlot(index=2)
                       
exp4 <- allexp$runExperiment(name = "Experiment-4",
                             featuresGroups = c("OriginalSequenceFitness","OperationIndexBased3x3","JobMachineOrderIndexBased3x3","Sandeep")   ,                                   
                             moreFeatures = NULL,
                             exceptions = NULL,                            
                             models = list(Model("lm"),
                                           Model("rpart")),                  
                             target = "DiffFitness")

#exp4$analysisModelPlot(index=2)
allexp$resume()





exp1 <- allexp$runExperiment(name = "Experiment-5",
                             featuresGroups = c("OperationIndexBased3x3","JobMachineOrderIndexBased3x3")   ,                                   
                             moreFeatures = NULL,
                             exceptions = NULL,                            
                             models = list(Model("lm"),
                                           Model("rpart")),                  
                             target = "RacioFitness")
#exp1$analysisModelPlot(index=2)
exp2 <- allexp$runExperiment(name = "Experiment-6",
                             featuresGroups = c("OriginalSequenceFitness","OperationIndexBased3x3","JobMachineOrderIndexBased3x3")   ,                                   
                             moreFeatures = NULL,
                             exceptions = NULL,                            
                             models = list(Model("lm"),
                                           Model("rpart")),                  
                             target = "RacioFitness")

#exp2$analysisModelPlot(index=2)
exp3 <- allexp$runExperiment(name = "Experiment-7",
                             featuresGroups = c("OriginalSequenceFitness","Sandeep")   ,                                   
                             moreFeatures = NULL,
                             exceptions = NULL,                            
                             models = list(Model("lm"),
                                           Model("rpart")),                  
                             target = "RacioFitness")

#exp3$analysisModelPlot(index=2)

exp4 <- allexp$runExperiment(name = "Experiment-8",
                             featuresGroups = c("OriginalSequenceFitness","OperationIndexBased3x3","JobMachineOrderIndexBased3x3","Sandeep")   ,                                   
                             moreFeatures = NULL,
                             exceptions = NULL,                            
                             models = list(Model("lm"),
                                           Model("rpart")),                  
                             target = "RacioFitness")

#exp4$analysisModelPlot(index=2)
allexp$resume()



exp <- SwapSequence3x3Learning()
con <- exp$simpleConnectDB()
exp$.connectionDB <- con

##Generate Model to DB connection
##exp$generateModels()

exp$addFeaturesFromGroups(c("OperationIndexBased3x3"))

exp$.target <- "DiffFitness"
exp$.models <- list(Model("lm"),Model("rpart"))


##exp$getAllDataset(limit=15000)
##exp$crossvalidation()
##exp$execute()
##exp$calculatePerformance()

exp$calculateTargetsToDB()
exp$calculateFeaturesToDB(limit=5000)



exp$disconnectDB()


##Add new features and targets

swpSeqFeatured <- SwapSequence3x3FeaturedElement()
swpSeqFeatured$addFeaturesInDB(con,  c("OperationIndexBased3x3"))
#swpSeqFeatured$addFeaturesInDB(con,  c("OperationIndexBased3x3",
#                                       "JobMachineOrderIndexBased3x3",
#                                       "Sandeep",
#                                       "OriginalSequenceFitness" ))

swpSeqFeatured$addTargetsInDB(con)



inst <- Instance()
inst$random.instance()

##save inst in DB
inst$DBsave(con)
uniqueIDinst <- inst$.uniqueID

##get from DB by inst  uniqueID
inst1<- Instance()
inst1$DBgetByUniqueID(uniqueIDinst,con)

inst1$.duration-inst$.duration
inst1$.precedence-inst$.precedence

########################
##Heuristics Solutions##
########################

##Rule Heuristic
heuristicaRule1 <- Rule()
randomGeneration(heuristicaRule1,inst)
DBsave(heuristicaRule1,con)

heuristicaRule2 <- Rule()
uniqueIDheuristicaRule1 <- heuristicaRule1$.uniqueID
DBgetByUniqueID(heuristicaRule2,uniqueIDheuristicaRule1,con)

heuristicaRule1$.operationEvaluationFunction == heuristicaRule2$.operationEvaluationFunction
heuristicaRule1$.selectionFunction == heuristicaRule2$.selectionFunction 


schedRule1 <- heuristicaRule1$getSchedule(inst)

schedRule1$plotJobsGanttChart()

##Priority List Heuristic
heuristicaPL1 <- PriorityList()
randomGeneration(heuristicaPL1,inst)
DBsave(heuristicaPL1,con)

heuristicaPL2 <- PriorityList()
uniqueIDheuristicaPL1 <- heuristicaPL1$.uniqueID
DBgetByUniqueID(heuristicaPL2,uniqueIDheuristicaPL1,con)

heuristicaPL1$.uniqueID == heuristicaPL2$.uniqueID 
heuristicaPL1$.priorityList == heuristicaPL2$.priorityList 


schedPL1 <- heuristicaPL1$getSchedule(inst)
schedPL1$plotJobsGanttChart()

##Partial Priority List Heuristic
heuristicaPPL1 <- PartialPriorityList()
randomGeneration(heuristicaPPL1,inst)
DBsave(heuristicaPPL1,con)

heuristicaPPL2 <- PartialPriorityList()
uniqueIDheuristicaPPL1 <- heuristicaPPL1$.uniqueID
DBgetByUniqueID(heuristicaPPL2,uniqueIDheuristicaPPL1,con)

heuristicaPPL1$.uniqueID == heuristicaPPL2$.uniqueID 
heuristicaPPL1$.id == heuristicaPPL2$.id
heuristicaPPL1$.defaultRule$.operationEvaluationFunction == heuristicaPPL2$.defaultRule$.operationEvaluationFunction
heuristicaPPL1$.defaultRule$.selectionFunction == heuristicaPPL2$.defaultRule$.selectionFunction
heuristicaPPL1$.priorityList == heuristicaPPL2$.priorityList 


schedPPL1 <-  heuristicaPPL1$getSchedule(inst)
schedPPL1$plotJobsGanttChart()

##Sequence 
sequence1 <- Sequence()
randomGeneration(sequence1,inst)
DBsave(sequence1,con)

sequence2 <- Sequence()
uniqueIDsequence1 <- sequence1$.uniqueID
DBgetByUniqueID(sequence2,uniqueIDsequence1,con)

heuristicaPPL1$.uniqueID == heuristicaPPL2$.uniqueID 
heuristicaPPL1$.sequence == heuristicaPPL2$.sequence


schedSequence1 <-  sequence1$getSchedule(inst)
schedSequence1$plotJobsGanttChart()


##########################
##GT Heutistic Algorithm##
##########################
gtalg <- GTHeuristicAlgorithm()
gtalg$DBsave(con)
gtalguniqueID <- gtalg$.uniqueID
gtalg2 <- GTHeuristicAlgorithm()
DBgetByUniqueID(gtalg2,gtalguniqueID,con)

gtalg$.heuristic$.operationEvaluationFunction == gtalg2$.heuristic$.operationEvaluationFunction 
gtalg$.heuristic$.selectionFunction == gtalg2$.heuristic$.selectionFunction 
gtalg$.uniqueID == gtalg2$.uniqueID


  
rungtalg <- Run()
rungaalg1$setRun(gtalg,inst)
rungaalg1$go()


rungtalg$DBsave(con)


schedresultgtalg<- rungtalg$.schedule
schedresultgtalg$plotJobsGanttChart()
#########################################
##Priority Lists crossover AND mutation##
#########################################
plchrom1<-PLChromosome()
plchrom1$generateRandom(inst)


pl1 <- plchrom1$.genes$.priorityList
plchrom1mut <- plchrom1$mutationInMachine(1,2,4)
plmut <- plchrom1mut$.genes$.priorityList

pl1==plmut



plchrom2<-PLChromosome()
plchrom2$generateRandom(inst)


motherPL1 <- plchrom1$.genes$.priorityList
fatherPL1 <- plchrom2$.genes$.priorityList

cut1 <- 2
cut2 <- 4

child <- plchrom1$crossoverWithCuts(plchrom2,cut1,cut2)
childPL1 <- child$.genes$.priorityList

apply(childPL1,2,function(x){any(duplicated(x))})

logical <- motherPL1==childPL1
all(logical[cut1:cut2,])















#########################################
##Genetic Algorithm with Priority Lists##
#########################################
gaalg1 <- GAPL(stopCriterium = MaxNrEvaluatedSolutions(30),         
               population.size = 10,                                       
               crossover = PLCrossoverOX(),
               mutation = PLMutationSW(),
               elitistQuantity = 3,
                           ## elitistType - can be "relative" if elististQuantity is a percentage or "absolute" the exact number to select
               elitistType = "absolute")

gaalg1$DBsave(con)
gaalguniqueID1 <- gaalg1$.uniqueID
gaalg2 <- GAPL()
DBgetByUniqueID(gaalg2,gaalguniqueID1,con)


gaalg1$.uniqueID == gaalg2$.uniqueID
parameters1 <- gaalg1$.parameters
parameters2 <- gaalg2$.parameters
parameters2$stopCriterium$nrMaxIteration == parameters1$stopCriterium$nrMaxIteration
parameters2$chromosomeClass == parameters1$chromosomeClass
parameters2$elitistQuantity == parameters1$elitistQuantity
parameters2$population.size == parameters1$population.size


rungaalg1 <- Run()
rungaalg1$setRun(gaalg1,inst)
rungaalg1$go()

rungaalg1UniqueID <- rungaalg1$.uniqueID
DBsave(rungaalg1,con)

rungaalg2 <- Run()
DBgetByUniqueID(rungaalg2,rungaalg1UniqueID,con)

rungaalg2$sameDBObject(rungaalg1,con)

