##Automatic 
setConstructorS3("DBAlgorithm",function()
    {  
      extend(DBModel(tableName = "Algorithm",
                     columns = list("name"=Column(type ="varchar",
primaryKey =TRUE)
,"type"=Column(type ="varchar",
primaryKey =FALSE)
,"class"=Column(type ="varchar",
primaryKey =FALSE)
,"source"=Column(type ="varchar",
primaryKey =FALSE)
,"description"=Column(type ="varchar",
primaryKey =FALSE)
)
                     ),"DBAlgorithm")  
    })

setConstructorS3("DBAlgorithmParameterized",function()
    {  
      extend(DBModel(tableName = "AlgorithmParameterized",
                     columns = list("uniqueID"=Column(type ="varchar",
primaryKey =TRUE)
,"Algorithm_name"=Column(type ="varchar",
primaryKey =FALSE)
,"name"=Column(type ="varchar",
primaryKey =FALSE)
)
                     ),"DBAlgorithmParameterized")  
    })

setConstructorS3("DBAlgorithmParameterizedParameters",function()
    {  
      extend(DBModel(tableName = "AlgorithmParameterizedParameters",
                     columns = list("AlgorithmParameterized_uniqueID"=Column(type ="varchar",
primaryKey =FALSE)
,"parameter"=Column(type ="varchar",
primaryKey =FALSE)
,"value"=Column(type ="varchar",
primaryKey =FALSE)
,"attribute"=Column(type ="varchar",
primaryKey =FALSE)
,"type"=Column(type ="varchar",
primaryKey =FALSE)
)
                     ),"DBAlgorithmParameterizedParameters")  
    })

setConstructorS3("DBConflits",function()
    {  
      extend(DBModel(tableName = "Conflits",
                     columns = list("machine"=Column(type ="varchar",
primaryKey =FALSE)
,"winnerJob"=Column(type ="varchar",
primaryKey =FALSE)
,"looserJob"=Column(type ="varchar",
primaryKey =FALSE)
,"FeasibleSchedule_uniqueID"=Column(type ="varchar",
primaryKey =FALSE)
)
                     ),"DBConflits")  
    })

setConstructorS3("DBCriticalPath",function()
    {  
      extend(DBModel(tableName = "CriticalPath",
                     columns = list("FeasibleSchedule_uniqueID"=Column(type ="varchar",
primaryKey =TRUE)
,"order"=Column(type ="varchar",
primaryKey =TRUE)
,"machine"=Column(type ="varchar",
primaryKey =FALSE)
,"job"=Column(type ="varchar",
primaryKey =FALSE)
)
                     ),"DBCriticalPath")  
    })

setConstructorS3("DBFact_Makespan",function()
    {  
      extend(DBModel(tableName = "Fact_Makespan",
                     columns = list("Instance_uniqueID"=Column(type ="varchar",
primaryKey =TRUE)
,"LPT"=Column(type ="double",
primaryKey =FALSE)
,"MinEndTime"=Column(type ="double",
primaryKey =FALSE)
,"MWR"=Column(type ="double",
primaryKey =FALSE)
,"SPT"=Column(type ="double",
primaryKey =FALSE)
)
                     ),"DBFact_Makespan")  
    })

setConstructorS3("DBFeasibleSchedule",function()
    {  
      extend(DBModel(tableName = "FeasibleSchedule",
                     columns = list("Instance_uniqueID"=Column(type ="varchar",
primaryKey =FALSE)
,"makespan"=Column(type ="varchar",
primaryKey =FALSE)
,"uniqueID"=Column(type ="varchar",
primaryKey =TRUE)
)
                     ),"DBFeasibleSchedule")  
    })

setConstructorS3("DBFeasibleScheduleOperation",function()
    {  
      extend(DBModel(tableName = "FeasibleScheduleOperation",
                     columns = list("startTime"=Column(type ="varchar",
primaryKey =FALSE)
,"job"=Column(type ="varchar",
primaryKey =FALSE)
,"machine"=Column(type ="varchar",
primaryKey =FALSE)
,"FeasibleSchedule_uniqueID"=Column(type ="varchar",
primaryKey =FALSE)
,"uniqueID"=Column(type ="varchar",
primaryKey =TRUE)
,"Instance_uniqueID"=Column(type ="varchar",
primaryKey =FALSE)
,"size"=Column(type ="varchar",
primaryKey =FALSE)
)
                     ),"DBFeasibleScheduleOperation")  
    })

setConstructorS3("DBFeasibleSchedule_20x10",function()
    {  
      extend(DBModel(tableName = "FeasibleSchedule_20x10",
                     columns = list("Instance_uniqueID"=Column(type ="varchar",
primaryKey =FALSE)
,"makespan"=Column(type ="varchar",
primaryKey =FALSE)
,"uniqueID"=Column(type ="varchar",
primaryKey =FALSE)
,"AlgorithmParameterized_uniqueID"=Column(type ="varchar",
primaryKey =FALSE)
,"start_times_xml"=Column(type ="varchar",
primaryKey =FALSE)
)
                     ),"DBFeasibleSchedule_20x10")  
    })

setConstructorS3("DBFeasibleSchedule_4x4",function()
    {  
      extend(DBModel(tableName = "FeasibleSchedule_4x4",
                     columns = list("Instance_uniqueID"=Column(type ="varchar",
primaryKey =FALSE)
,"makespan"=Column(type ="varchar",
primaryKey =FALSE)
,"uniqueID"=Column(type ="varchar",
primaryKey =FALSE)
,"AlgorithmParameterized_uniqueID"=Column(type ="varchar",
primaryKey =FALSE)
,"start_times_xml"=Column(type ="varchar",
primaryKey =FALSE)
)
                     ),"DBFeasibleSchedule_4x4")  
    })

setConstructorS3("DBFeasibleSchedule_old",function()
    {  
      extend(DBModel(tableName = "FeasibleSchedule_old",
                     columns = list("Instance_uniqueID"=Column(type ="varchar",
primaryKey =FALSE)
,"makespan"=Column(type ="varchar",
primaryKey =FALSE)
,"uniqueID"=Column(type ="varchar",
primaryKey =TRUE)
)
                     ),"DBFeasibleSchedule_old")  
    })

setConstructorS3("DBFeatureExperiment",function()
    {  
      extend(DBModel(tableName = "FeatureExperiment",
                     columns = list("priority"=Column(type ="varchar",
primaryKey =FALSE)
,"id"=Column(type ="varchar",
primaryKey =TRUE)
,"FeaturesGroups_name"=Column(type ="varchar",
primaryKey =FALSE)
,"FeaturesGroups_object"=Column(type ="varchar",
primaryKey =FALSE)
)
                     ),"DBFeatureExperiment")  
    })

setConstructorS3("DBFeatureExperimentObjects",function()
    {  
      extend(DBModel(tableName = "FeatureExperimentObjects",
                     columns = list("FeaturesGroups_name"=Column(type ="varchar",
primaryKey =TRUE)
,"FeaturesGroups_object"=Column(type ="varchar",
primaryKey =TRUE)
,"target"=Column(type ="varchar",
primaryKey =TRUE)
,"status"=Column(type ="varchar",
primaryKey =FALSE)
)
                     ),"DBFeatureExperimentObjects")  
    })

setConstructorS3("DBFeatures",function()
    {  
      extend(DBModel(tableName = "Features",
                     columns = list("name"=Column(type ="varchar",
primaryKey =TRUE)
,"type"=Column(type ="varchar",
primaryKey =FALSE)
,"description"=Column(type ="varchar",
primaryKey =FALSE)
,"FeaturesGroups_name"=Column(type ="varchar",
primaryKey =TRUE)
,"FeaturesGroups_object"=Column(type ="varchar",
primaryKey =TRUE)
,"aggregation"=Column(type ="varchar",
primaryKey =FALSE)
,"formula"=Column(type ="varchar",
primaryKey =FALSE)
,"tableOrder"=Column(type ="varchar",
primaryKey =FALSE)
)
                     ),"DBFeatures")  
    })

setConstructorS3("DBFeaturesGroups",function()
    {  
      extend(DBModel(tableName = "FeaturesGroups",
                     columns = list("name"=Column(type ="varchar",
primaryKey =TRUE)
,"object"=Column(type ="varchar",
primaryKey =TRUE)
,"groupby"=Column(type ="varchar",
primaryKey =FALSE)
,"type"=Column(type ="varchar",
primaryKey =FALSE)
,"subset"=Column(type ="varchar",
primaryKey =FALSE)
,"targetFieldName"=Column(type ="varchar",
primaryKey =FALSE)
,"mainTable"=Column(type ="varchar",
primaryKey =FALSE)
,"query"=Column(type ="varchar",
primaryKey =FALSE)
,"keepMainFeatures"=Column(type ="varchar",
primaryKey =FALSE)
,"restrictionMainTable"=Column(type ="varchar",
primaryKey =FALSE)
,"description"=Column(type ="varchar",
primaryKey =FALSE)
)
                     ),"DBFeaturesGroups")  
    })

setConstructorS3("DBFeaturesGroupsJoinTables",function()
    {  
      extend(DBModel(tableName = "FeaturesGroupsJoinTables",
                     columns = list("FeaturesGroups_name"=Column(type ="varchar",
primaryKey =FALSE)
,"FeaturesGroups_object"=Column(type ="varchar",
primaryKey =FALSE)
,"joinTable"=Column(type ="varchar",
primaryKey =FALSE)
,"joinbyMainTable"=Column(type ="varchar",
primaryKey =FALSE)
,"joinbyJoinTable"=Column(type ="varchar",
primaryKey =FALSE)
)
                     ),"DBFeaturesGroupsJoinTables")  
    })

setConstructorS3("DBFeatures_AggAndStandMomentsOfAllOpBasicAndDone",function()
    {  
      extend(DBModel(tableName = "Features_AggAndStandMomentsOfAllOpBasicAndDone",
                     columns = list("SkewnessOfSumOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfSumOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"SkewnessOfMinOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfMinOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"SkewnessOfMaxOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfMaxOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"SkewnessOfVarOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfVarOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"SkewnessOfSumOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfSumOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SkewnessOfMinOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfMinOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SkewnessOfMaxOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfMaxOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SkewnessOfVarOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfVarOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SkewnessOfSumOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfSumOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SkewnessOfMinOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfMinOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SkewnessOfMaxOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfMaxOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SkewnessOfVarOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfVarOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfSumOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MinOfSumOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfSumOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"VarOfSumOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMinOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMinOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMaxOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMaxOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMaxOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"SumOfVarOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfVarOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MinOfSumOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfSumOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfSumOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMinOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMaxOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMaxOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfVarOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfVarOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfSumOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfSumOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfSumOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfSumOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMinOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMaxOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMaxOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfVarOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfSumOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfSumOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfSumOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfSumOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMinOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMaxOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMaxOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMaxOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfVarOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfVarOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfSumOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfSumOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfSumOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMinOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMaxOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMaxOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMaxOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfVarOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfVarOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfSumOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfSumOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfSumOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfSumOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMinOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMaxOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMaxOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMaxOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfVarOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfVarOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfSumOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfSumOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfSumOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfSumOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMaxOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMaxOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMaxOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfVarOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfVarOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfSumOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfSumOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfSumOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfSumOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMinOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMaxOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMaxOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfVarOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"Instance_uniqueID"=Column(type ="varchar",
primaryKey =TRUE)
)
                     ),"DBFeatures_AggAndStandMomentsOfAllOpBasicAndDone")  
    })

setConstructorS3("DBFeatures_AggAndStandMomentsOfAllOperationBasic",function()
    {  
      extend(DBModel(tableName = "Features_AggAndStandMomentsOfAllOperationBasic",
                     columns = list("SkewnessOfSumOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfSumOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"SkewnessOfMinOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfMinOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"SkewnessOfMaxOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfMaxOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"SkewnessOfVarOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfVarOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"SkewnessOfSumOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfSumOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SkewnessOfMinOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfMinOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SkewnessOfMaxOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfMaxOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SkewnessOfVarOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfVarOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SkewnessOfSumOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfSumOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SkewnessOfMinOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfMinOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SkewnessOfMaxOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfMaxOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SkewnessOfVarOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfVarOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfSumOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MinOfSumOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfSumOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"VarOfSumOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMinOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMinOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMaxOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMaxOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMaxOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"SumOfVarOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfVarOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MinOfSumOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfSumOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfSumOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMinOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMaxOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMaxOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfVarOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfVarOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfSumOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfSumOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfSumOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfSumOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMinOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMaxOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMaxOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfVarOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"Instance_uniqueID"=Column(type ="varchar",
primaryKey =TRUE)
)
                     ),"DBFeatures_AggAndStandMomentsOfAllOperationBasic")  
    })

setConstructorS3("DBFeatures_AggOfAllOperationBasic",function()
    {  
      extend(DBModel(tableName = "Features_AggOfAllOperationBasic",
                     columns = list("SumOfDuration"=Column(type ="double",
primaryKey =FALSE)
,"MinOfDuration"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfDuration"=Column(type ="double",
primaryKey =FALSE)
,"VarOfDuration"=Column(type ="double",
primaryKey =FALSE)
,"MinOfSumOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfSumOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"VarOfSumOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMinOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMaxOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMaxOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"SumOfVarOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfVarOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MinOfSumOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfSumOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfSumOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMinOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMaxOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMaxOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfVarOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfVarOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfSumOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfSumOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfSumOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfSumOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMinOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMaxOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMaxOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfVarOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"Instance_uniqueID"=Column(type ="varchar",
primaryKey =TRUE)
)
                     ),"DBFeatures_AggOfAllOperationBasic")  
    })

setConstructorS3("DBFeatures_AggOfMacJobPrecOpBasicAndDone",function()
    {  
      extend(DBModel(tableName = "Features_AggOfMacJobPrecOpBasicAndDone",
                     columns = list("SumOfSumOfDurationSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MinOfSumOfDurationSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfSumOfDurationSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"VarOfSumOfDurationSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMinOfDurationSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMinOfDurationSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinOfDurationSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinOfDurationSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMaxOfDurationSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMaxOfDurationSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMaxOfDurationSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxOfDurationSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"SumOfVarOfDurationSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarOfDurationSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfVarOfDurationSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarOfDurationSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"SumOfCountDistinctOfMachineSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MinOfCountDistinctOfMachineSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfCountDistinctOfMachineSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"VarOfCountDistinctOfMachineSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"SumOfCountMaxOfMachineSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfCountMaxOfMachineSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"VarOfCountMaxOfMachineSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"SumOfCountMinOfMachineSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MinOfCountMinOfMachineSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"VarOfCountMinOfMachineSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfSumOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfSumOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfSumOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfSumOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMinOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMaxOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMaxOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMaxOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfVarOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfVarOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfSumOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfSumOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfSumOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMinOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMaxOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMaxOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMaxOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfVarOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfVarOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfSumOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfSumOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfSumOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfSumOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMinOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMaxOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMaxOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMaxOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfVarOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfVarOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfSumOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfSumOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfSumOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfSumOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMaxOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMaxOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMaxOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfVarOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfVarOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfSumOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfSumOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfSumOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfSumOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMinOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMaxOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMaxOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfVarOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfSumOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfSumOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"VarOfSumOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMinOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMaxOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMaxOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"SumOfVarOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfVarOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MinOfSumOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfSumOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfSumOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMinOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMaxOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMaxOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfVarOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfVarOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfSumOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfSumOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfSumOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfSumOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMinOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMaxOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMaxOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfVarOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"Instance_uniqueID"=Column(type ="varchar",
primaryKey =TRUE)
)
                     ),"DBFeatures_AggOfMacJobPrecOpBasicAndDone")  
    })

setConstructorS3("DBFeatures_AggOfMachJobPrecOperationBasic",function()
    {  
      extend(DBModel(tableName = "Features_AggOfMachJobPrecOperationBasic",
                     columns = list("SumOfSumOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MinOfSumOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfSumOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"VarOfSumOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMinOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMinOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMaxOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMaxOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMaxOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"SumOfVarOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfVarOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MinOfSumOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfSumOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfSumOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMinOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMaxOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMaxOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfVarOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfVarOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfSumOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfSumOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfSumOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfSumOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMinOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMaxOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMaxOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfVarOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfDuration"=Column(type ="double",
primaryKey =FALSE)
,"MinOfSumOfDurationSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfSumOfDurationSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"VarOfSumOfDurationSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMinOfDurationSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinOfDurationSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinOfDurationSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMaxOfDurationSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMaxOfDurationSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxOfDurationSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"SumOfVarOfDurationSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarOfDurationSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfVarOfDurationSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarOfDurationSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"SumOfCountDistinctOfMachineSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MinOfCountDistinctOfMachineSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfCountDistinctOfMachineSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"VarOfCountDistinctOfMachineSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"SumOfCountMaxOfMachineSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfCountMaxOfMachineSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"VarOfCountMaxOfMachineSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"SumOfCountMinOfMachineSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MinOfCountMinOfMachineSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"VarOfCountMinOfMachineSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"Instance_uniqueID"=Column(type ="varchar",
primaryKey =TRUE)
)
                     ),"DBFeatures_AggOfMachJobPrecOperationBasic")  
    })

setConstructorS3("DBFeatures_AggOfMachineAggOfWorkDone",function()
    {  
      extend(DBModel(tableName = "Features_AggOfMachineAggOfWorkDone",
                     columns = list("MeanOfSumOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfSumOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfSumOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfSumOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMinOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMaxOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMaxOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMaxOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfVarOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfVarOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfSumOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfSumOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfSumOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMinOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMaxOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMaxOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMaxOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfVarOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfVarOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfSumOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfSumOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfSumOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfSumOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMinOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMaxOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMaxOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMaxOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfVarOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfVarOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfSumOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfSumOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfSumOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfSumOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMaxOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMaxOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMaxOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfVarOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfVarOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfSumOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfSumOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfSumOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfSumOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMinOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMaxOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMaxOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfVarOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"Instance_uniqueID"=Column(type ="varchar",
primaryKey =TRUE)
)
                     ),"DBFeatures_AggOfMachineAggOfWorkDone")  
    })

setConstructorS3("DBFeatures_AggOfMachineAggOfWorkDoneGASelection",function()
    {  
      extend(DBModel(tableName = "Features_AggOfMachineAggOfWorkDoneGASelection",
                     columns = list("VarOfSumOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMaxOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfSumOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"Instance_uniqueID"=Column(type ="varchar",
primaryKey =TRUE)
)
                     ),"DBFeatures_AggOfMachineAggOfWorkDoneGASelection")  
    })

setConstructorS3("DBFeatures_AggOfMachineAggOfWorkRemainingAndDone",function()
    {  
      extend(DBModel(tableName = "Features_AggOfMachineAggOfWorkRemainingAndDone",
                     columns = list("MeanOfSumOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfSumOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfSumOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfSumOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMinOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMaxOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMaxOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMaxOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfVarOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfVarOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfSumOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfSumOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfSumOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMinOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMaxOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMaxOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMaxOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfVarOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfVarOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfSumOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfSumOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfSumOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfSumOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMinOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMaxOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMaxOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMaxOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfVarOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfVarOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfSumOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfSumOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfSumOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfSumOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMaxOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMaxOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMaxOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfVarOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfVarOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfSumOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfSumOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfSumOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfSumOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMinOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMaxOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMaxOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfVarOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfSumOfSumWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfSumOfSumWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfSumOfSumWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfSumOfSumWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMinOfSumWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinOfSumWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinOfSumWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMaxOfSumWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMaxOfSumWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMaxOfSumWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxOfSumWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfVarOfSumWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarOfSumWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfVarOfSumWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarOfSumWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfSumOfMeanWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfSumOfMeanWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfSumOfMeanWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMinOfMeanWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinOfMeanWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinOfMeanWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMaxOfMeanWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMaxOfMeanWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMaxOfMeanWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxOfMeanWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfVarOfMeanWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarOfMeanWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfVarOfMeanWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarOfMeanWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfSumOfMinWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfSumOfMinWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfSumOfMinWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfSumOfMinWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMinOfMinWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinOfMinWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinOfMinWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMaxOfMinWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMaxOfMinWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMaxOfMinWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxOfMinWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfVarOfMinWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarOfMinWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfVarOfMinWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarOfMinWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfSumOfMaxWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfSumOfMaxWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfSumOfMaxWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfSumOfMaxWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinOfMaxWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinOfMaxWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMaxOfMaxWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMaxOfMaxWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMaxOfMaxWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxOfMaxWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfVarOfMaxWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarOfMaxWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfVarOfMaxWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarOfMaxWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfSumOfVarWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfSumOfVarWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfSumOfVarWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfSumOfVarWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMinOfVarWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinOfVarWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMaxOfVarWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMaxOfVarWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxOfVarWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfVarOfVarWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarOfVarWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarOfVarWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"Instance_uniqueID"=Column(type ="varchar",
primaryKey =TRUE)
)
                     ),"DBFeatures_AggOfMachineAggOfWorkRemainingAndDone")  
    })

setConstructorS3("DBFeatures_AggOfOperationBasic",function()
    {  
      extend(DBModel(tableName = "Features_AggOfOperationBasic",
                     columns = list("SumOfDuration"=Column(type ="double",
primaryKey =FALSE)
,"MinOfDuration"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfDuration"=Column(type ="double",
primaryKey =FALSE)
,"VarOfDuration"=Column(type ="double",
primaryKey =FALSE)
,"Instance_uniqueID"=Column(type ="varchar",
primaryKey =TRUE)
)
                     ),"DBFeatures_AggOfOperationBasic")  
    })

setConstructorS3("DBGRID",function()
    {  
      extend(DBModel(tableName = "GRID",
                     columns = list("name"=Column(type ="varchar",
primaryKey =TRUE)
,"elapsedTime"=Column(type ="double",
primaryKey =FALSE)
,"waitTime"=Column(type ="double",
primaryKey =FALSE)
,"currentWaiting"=Column(type ="varchar",
primaryKey =FALSE)
,"runned"=Column(type ="varchar",
primaryKey =FALSE)
)
                     ),"DBGRID")  
    })

setConstructorS3("DBGTHeuristicParameters",function()
    {  
      extend(DBModel(tableName = "GTHeuristicParameters",
                     columns = list("AlgorithmParameterized_uniqueID"=Column(type ="varchar",
primaryKey =FALSE)
,"evaluation"=Column(type ="varchar",
primaryKey =FALSE)
,"selection"=Column(type ="varchar",
primaryKey =FALSE)
,"name"=Column(type ="varchar",
primaryKey =FALSE)
,"description"=Column(type ="varchar",
primaryKey =FALSE)
)
                     ),"DBGTHeuristicParameters")  
    })

setConstructorS3("DBILP_domain",function()
    {  
      extend(DBModel(tableName = "ILP_domain",
                     columns = list("experiment_uniqueID"=Column(type ="varchar",
primaryKey =FALSE)
,"feature"=Column(type ="varchar",
primaryKey =FALSE)
,"component"=Column(type ="varchar",
primaryKey =FALSE)
,"domainValues"=Column(type ="varchar",
primaryKey =FALSE)
)
                     ),"DBILP_domain")  
    })

setConstructorS3("DBILP_experiment",function()
    {  
      extend(DBModel(tableName = "ILP_experiment",
                     columns = list("uniqueID"=Column(type ="varchar",
primaryKey =TRUE)
,"instanceFeatures"=Column(type ="varchar",
primaryKey =FALSE)
,"machineFeatures"=Column(type ="varchar",
primaryKey =FALSE)
,"jobFeatures"=Column(type ="varchar",
primaryKey =FALSE)
,"operationFeatures"=Column(type ="varchar",
primaryKey =FALSE)
,"target"=Column(type ="varchar",
primaryKey =FALSE)
,"positiveValue"=Column(type ="varchar",
primaryKey =FALSE)
,"negativeValue"=Column(type ="varchar",
primaryKey =FALSE)
,"modeRecall"=Column(type ="varchar",
primaryKey =FALSE)
,"refine"=Column(type ="varchar",
primaryKey =FALSE)
)
                     ),"DBILP_experiment")  
    })

setConstructorS3("DBILP_rule",function()
    {  
      extend(DBModel(tableName = "ILP_rule",
                     columns = list("rule"=Column(type ="varchar",
primaryKey =FALSE)
,"pos_cover_number"=Column(type ="varchar",
primaryKey =FALSE)
,"neg_cover_number"=Column(type ="varchar",
primaryKey =FALSE)
,"neg_cover_instances"=Column(type ="varchar",
primaryKey =FALSE)
,"pos_cover_instances"=Column(type ="varchar",
primaryKey =FALSE)
,"run_id"=Column(type ="varchar",
primaryKey =FALSE)
)
                     ),"DBILP_rule")  
    })

setConstructorS3("DBILP_run",function()
    {  
      extend(DBModel(tableName = "ILP_run",
                     columns = list("train_pos_file"=Column(type ="varchar",
primaryKey =FALSE)
,"train_neg_file"=Column(type ="varchar",
primaryKey =FALSE)
,"test_pos_file"=Column(type ="varchar",
primaryKey =FALSE)
,"test_neg_file"=Column(type ="varchar",
primaryKey =FALSE)
,"train_neg_instances"=Column(type ="varchar",
primaryKey =FALSE)
,"test_neg_file_instances"=Column(type ="varchar",
primaryKey =FALSE)
,"test_pos_file_instances"=Column(type ="varchar",
primaryKey =FALSE)
,"train_pos_file_instances"=Column(type ="varchar",
primaryKey =FALSE)
,"theory"=Column(type ="varchar",
primaryKey =FALSE)
,"id"=Column(type ="varchar",
primaryKey =TRUE)
,"minacc"=Column(type ="double",
primaryKey =FALSE)
,"noise"=Column(type ="varchar",
primaryKey =FALSE)
,"clauselength"=Column(type ="varchar",
primaryKey =FALSE)
,"depth"=Column(type ="varchar",
primaryKey =FALSE)
,"minposfrac"=Column(type ="double",
primaryKey =FALSE)
,"minpos"=Column(type ="varchar",
primaryKey =FALSE)
,"experiment_uniqueID"=Column(type ="varchar",
primaryKey =FALSE)
,"run_index"=Column(type ="varchar",
primaryKey =FALSE)
,"fold_index"=Column(type ="varchar",
primaryKey =FALSE)
,"kfoldcrossvalidation"=Column(type ="varchar",
primaryKey =FALSE)
,"status"=Column(type ="varchar",
primaryKey =FALSE)
,"run_file"=Column(type ="varchar",
primaryKey =FALSE)
,"allsettings"=Column(type ="varchar",
primaryKey =FALSE)
,"result_content_xml"=Column(type ="varchar",
primaryKey =FALSE)
,"refine"=Column(type ="varchar",
primaryKey =FALSE)
,"nodes"=Column(type ="varchar",
primaryKey =FALSE)
,"percentagesamplesize"=Column(type ="varchar",
primaryKey =FALSE)
)
                     ),"DBILP_run")  
    })

setConstructorS3("DBInstance",function()
    {  
      extend(DBModel(tableName = "Instance",
                     columns = list("uniqueID"=Column(type ="varchar",
primaryKey =TRUE)
,"nrJobs"=Column(type ="varchar",
primaryKey =FALSE)
,"nrMachines"=Column(type ="varchar",
primaryKey =FALSE)
,"seed"=Column(type ="varchar",
primaryKey =FALSE)
,"source"=Column(type ="varchar",
primaryKey =FALSE)
,"xml"=Column(type ="varchar",
primaryKey =FALSE)
)
                     ),"DBInstance")  
    })

setConstructorS3("DBInstanceCodificationExperiment",function()
    {  
      extend(DBModel(tableName = "InstanceCodificationExperiment",
                     columns = list("id"=Column(type ="varchar",
primaryKey =TRUE)
,"name"=Column(type ="varchar",
primaryKey =FALSE)
,"tableData"=Column(type ="varchar",
primaryKey =FALSE)
)
                     ),"DBInstanceCodificationExperiment")  
    })

setConstructorS3("DBInstanceCodificationLinearFeatures",function()
    {  
      extend(DBModel(tableName = "InstanceCodificationLinearFeatures",
                     columns = list("id"=Column(type ="varchar",
primaryKey =TRUE)
,"feature"=Column(type ="varchar",
primaryKey =FALSE)
,"InstanceCodificationExperiment_id"=Column(type ="varchar",
primaryKey =FALSE)
,"aggregator"=Column(type ="varchar",
primaryKey =FALSE)
,"nrPartitions"=Column(type ="varchar",
primaryKey =FALSE)
)
                     ),"DBInstanceCodificationLinearFeatures")  
    })

setConstructorS3("DBInstanceCodificationNonLinearFeatures",function()
    {  
      extend(DBModel(tableName = "InstanceCodificationNonLinearFeatures",
                     columns = list("id"=Column(type ="varchar",
primaryKey =TRUE)
,"name"=Column(type ="varchar",
primaryKey =FALSE)
,"InstanceCodificationExperiment_id"=Column(type ="varchar",
primaryKey =FALSE)
,"aggregator"=Column(type ="varchar",
primaryKey =FALSE)
,"features"=Column(type ="varchar",
primaryKey =FALSE)
,"nrPartitions"=Column(type ="varchar",
primaryKey =FALSE)
)
                     ),"DBInstanceCodificationNonLinearFeatures")  
    })

setConstructorS3("DBInstanceGenerationParameter",function()
    {  
      extend(DBModel(tableName = "InstanceGenerationParameter",
                     columns = list("name"=Column(type ="varchar",
primaryKey =TRUE)
)
                     ),"DBInstanceGenerationParameter")  
    })

setConstructorS3("DBInstance_AggOfJobAggOfOperationBasic",function()
    {  
      extend(DBModel(tableName = "Instance_AggOfJobAggOfOperationBasic",
                     columns = list("Instance_uniqueID"=Column(type ="varchar",
primaryKey =TRUE)
,"SumOfSumOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfSumOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MinOfSumOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfSumOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"VarOfSumOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMeanOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMeanOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMeanOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMeanOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMeanOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMinOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMinOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMinOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMaxOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMaxOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMaxOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMaxOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"SumOfVarOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfVarOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfVarOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
)
                     ),"DBInstance_AggOfJobAggOfOperationBasic")  
    })

setConstructorS3("DBInstance_AggOfMachineAggOfOperationBasic",function()
    {  
      extend(DBModel(tableName = "Instance_AggOfMachineAggOfOperationBasic",
                     columns = list("Instance_uniqueID"=Column(type ="varchar",
primaryKey =TRUE)
,"SumOfSumOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfSumOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfSumOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfSumOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfSumOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMeanOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMeanOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMeanOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMeanOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMeanOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMinOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMinOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMinOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMaxOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMaxOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMaxOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMaxOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfVarOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfVarOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfVarOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfSumOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfSumOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfSumOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfSumOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfSumOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMeanOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMeanOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMeanOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMeanOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMeanOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMinOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMinOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMinOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMaxOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMaxOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMaxOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMaxOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfVarOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfVarOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfVarOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
)
                     ),"DBInstance_AggOfMachineAggOfOperationBasic")  
    })

setConstructorS3("DBInstance_AggOfMachineAggOfWorkDone",function()
    {  
      extend(DBModel(tableName = "Instance_AggOfMachineAggOfWorkDone",
                     columns = list("Instance_uniqueID"=Column(type ="varchar",
primaryKey =TRUE)
,"MeanOfSumOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfSumOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfSumOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfSumOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMeanOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMeanOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMeanOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMeanOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMinOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMinOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMaxOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMaxOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMaxOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfVarOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfVarOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfSumOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfSumOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfSumOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfSumOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMeanOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMeanOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMeanOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMeanOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMinOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMinOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMaxOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMaxOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMaxOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfVarOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfVarOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfSumOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfSumOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfSumOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfSumOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMeanOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMeanOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMeanOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMeanOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMinOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMinOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMaxOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMaxOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMaxOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfVarOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfVarOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfSumOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfSumOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfSumOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfSumOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMeanOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMeanOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMeanOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMeanOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMinOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMinOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMaxOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMaxOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMaxOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfVarOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfVarOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfSumOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfSumOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfSumOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfSumOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMeanOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMeanOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMeanOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMeanOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMinOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMinOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMaxOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMaxOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMaxOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfVarOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfVarOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
)
                     ),"DBInstance_AggOfMachineAggOfWorkDone")  
    })

setConstructorS3("DBInstance_AggOfMachineAggOfWorkRemaining",function()
    {  
      extend(DBModel(tableName = "Instance_AggOfMachineAggOfWorkRemaining",
                     columns = list("Instance_uniqueID"=Column(type ="varchar",
primaryKey =TRUE)
,"MeanOfSumOfSumWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfSumOfSumWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfSumOfSumWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfSumOfSumWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMeanOfSumWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMeanOfSumWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMeanOfSumWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMeanOfSumWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMinOfSumWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMinOfSumWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinOfSumWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinOfSumWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMaxOfSumWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMaxOfSumWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMaxOfSumWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxOfSumWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfVarOfSumWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarOfSumWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfVarOfSumWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarOfSumWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfSumOfMeanWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfSumOfMeanWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfSumOfMeanWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfSumOfMeanWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMeanOfMeanWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMeanOfMeanWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMeanOfMeanWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMeanOfMeanWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMinOfMeanWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMinOfMeanWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinOfMeanWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinOfMeanWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMaxOfMeanWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMaxOfMeanWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMaxOfMeanWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxOfMeanWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfVarOfMeanWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarOfMeanWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfVarOfMeanWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarOfMeanWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfSumOfMinWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfSumOfMinWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfSumOfMinWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfSumOfMinWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMeanOfMinWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMeanOfMinWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMeanOfMinWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMeanOfMinWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMinOfMinWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMinOfMinWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinOfMinWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinOfMinWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMaxOfMinWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMaxOfMinWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMaxOfMinWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxOfMinWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfVarOfMinWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarOfMinWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfVarOfMinWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarOfMinWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfSumOfMaxWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfSumOfMaxWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfSumOfMaxWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfSumOfMaxWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMeanOfMaxWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMeanOfMaxWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMeanOfMaxWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMeanOfMaxWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMinOfMaxWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMinOfMaxWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinOfMaxWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinOfMaxWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMaxOfMaxWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMaxOfMaxWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMaxOfMaxWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxOfMaxWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfVarOfMaxWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarOfMaxWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfVarOfMaxWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarOfMaxWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfSumOfVarWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfSumOfVarWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfSumOfVarWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfSumOfVarWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMeanOfVarWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMeanOfVarWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMeanOfVarWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMeanOfVarWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMinOfVarWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMinOfVarWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinOfVarWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinOfVarWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMaxOfVarWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMaxOfVarWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMaxOfVarWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxOfVarWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfVarOfVarWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarOfVarWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfVarOfVarWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarOfVarWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
)
                     ),"DBInstance_AggOfMachineAggOfWorkRemaining")  
    })

setConstructorS3("DBInstance_AggOfOperationBasic",function()
    {  
      extend(DBModel(tableName = "Instance_AggOfOperationBasic",
                     columns = list("Instance_uniqueID"=Column(type ="varchar",
primaryKey =TRUE)
,"SumOfDuration"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfDuration"=Column(type ="double",
primaryKey =FALSE)
,"MinOfDuration"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfDuration"=Column(type ="double",
primaryKey =FALSE)
,"VarOfDuration"=Column(type ="double",
primaryKey =FALSE)
)
                     ),"DBInstance_AggOfOperationBasic")  
    })

setConstructorS3("DBInstance_AggOfPrecedenceAggOfOperationBasic",function()
    {  
      extend(DBModel(tableName = "Instance_AggOfPrecedenceAggOfOperationBasic",
                     columns = list("Instance_uniqueID"=Column(type ="varchar",
primaryKey =TRUE)
,"SumOfSumOfDurationSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfSumOfDurationSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MinOfSumOfDurationSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfSumOfDurationSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"VarOfSumOfDurationSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMeanOfDurationSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMeanOfDurationSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMeanOfDurationSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMeanOfDurationSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMeanOfDurationSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMinOfDurationSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMinOfDurationSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMinOfDurationSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinOfDurationSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinOfDurationSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMaxOfDurationSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMaxOfDurationSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMaxOfDurationSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMaxOfDurationSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxOfDurationSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"SumOfVarOfDurationSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfVarOfDurationSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarOfDurationSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfVarOfDurationSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarOfDurationSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"SumOfCountDistinctOfMachineSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfCountDistinctOfMachineSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MinOfCountDistinctOfMachineSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfCountDistinctOfMachineSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"VarOfCountDistinctOfMachineSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"SumOfCountMaxOfMachineSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfCountMaxOfMachineSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MinOfCountMaxOfMachineSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfCountMaxOfMachineSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"VarOfCountMaxOfMachineSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"SumOfCountMinOfMachineSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfCountMinOfMachineSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MinOfCountMinOfMachineSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfCountMinOfMachineSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"VarOfCountMinOfMachineSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
)
                     ),"DBInstance_AggOfPrecedenceAggOfOperationBasic")  
    })

setConstructorS3("DBInstance_MinEndTimevsMWR_4x4_1",function()
    {  
      extend(DBModel(tableName = "Instance_MinEndTimevsMWR_4x4_1",
                     columns = list("Instance_uniqueID"=Column(type ="varchar",
primaryKey =TRUE)
,"MinEndTimeminusMWR"=Column(type ="double",
primaryKey =FALSE)
,"MinEndTimevsMWR"=Column(type ="varchar",
primaryKey =FALSE)
,"abs_MinEndTimeminusMWR"=Column(type ="double",
primaryKey =FALSE)
)
                     ),"DBInstance_MinEndTimevsMWR_4x4_1")  
    })

setConstructorS3("DBInstance_SPTvsLPT_4x4_1",function()
    {  
      extend(DBModel(tableName = "Instance_SPTvsLPT_4x4_1",
                     columns = list("Instance_uniqueID"=Column(type ="varchar",
primaryKey =TRUE)
,"SPTminusLPT"=Column(type ="double",
primaryKey =FALSE)
,"SPTvsLPT"=Column(type ="varchar",
primaryKey =FALSE)
,"abs_SPTminusLPT"=Column(type ="double",
primaryKey =FALSE)
)
                     ),"DBInstance_SPTvsLPT_4x4_1")  
    })

setConstructorS3("DBInstance_StandMomentsOfJobAggOfOperationBasic",function()
    {  
      extend(DBModel(tableName = "Instance_StandMomentsOfJobAggOfOperationBasic",
                     columns = list("Instance_uniqueID"=Column(type ="varchar",
primaryKey =TRUE)
,"SkewnessOfSumOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfSumOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"SkewnessOfMeanOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfMeanOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"SkewnessOfMinOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfMinOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"SkewnessOfMaxOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfMaxOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"SkewnessOfVarOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfVarOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
)
                     ),"DBInstance_StandMomentsOfJobAggOfOperationBasic")  
    })

setConstructorS3("DBInstance_StandMomentsOfMachineAggOfOperationBasic",function()
    {  
      extend(DBModel(tableName = "Instance_StandMomentsOfMachineAggOfOperationBasic",
                     columns = list("Instance_uniqueID"=Column(type ="varchar",
primaryKey =TRUE)
,"SkewnessOfSumOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfSumOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SkewnessOfMeanOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfMeanOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SkewnessOfMinOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfMinOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SkewnessOfMaxOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfMaxOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SkewnessOfVarOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfVarOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SkewnessOfSumOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfSumOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SkewnessOfMeanOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfMeanOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SkewnessOfMinOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfMinOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SkewnessOfMaxOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfMaxOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SkewnessOfVarOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfVarOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
)
                     ),"DBInstance_StandMomentsOfMachineAggOfOperationBasic")  
    })

setConstructorS3("DBInstance_StandMomentsOfMachineAggOfWorkDone",function()
    {  
      extend(DBModel(tableName = "Instance_StandMomentsOfMachineAggOfWorkDone",
                     columns = list("Instance_uniqueID"=Column(type ="varchar",
primaryKey =TRUE)
,"SkewnessOfSumOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfSumOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SkewnessOfMeanOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfMeanOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SkewnessOfMinOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfMinOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SkewnessOfMaxOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfMaxOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SkewnessOfVarOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfVarOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SkewnessOfSumOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfSumOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SkewnessOfMeanOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfMeanOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SkewnessOfMinOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfMinOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SkewnessOfMaxOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfMaxOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SkewnessOfVarOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfVarOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SkewnessOfSumOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfSumOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SkewnessOfMeanOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfMeanOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SkewnessOfMinOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfMinOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SkewnessOfMaxOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfMaxOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SkewnessOfVarOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfVarOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SkewnessOfSumOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfSumOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SkewnessOfMeanOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfMeanOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SkewnessOfMinOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfMinOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SkewnessOfMaxOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfMaxOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SkewnessOfVarOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfVarOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SkewnessOfSumOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfSumOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SkewnessOfMeanOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfMeanOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SkewnessOfMinOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfMinOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SkewnessOfMaxOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfMaxOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SkewnessOfVarOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfVarOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
)
                     ),"DBInstance_StandMomentsOfMachineAggOfWorkDone")  
    })

setConstructorS3("DBInstance_has_InstanceGenerationParameter",function()
    {  
      extend(DBModel(tableName = "Instance_has_InstanceGenerationParameter",
                     columns = list("Instance_uniqueID"=Column(type ="varchar",
primaryKey =TRUE)
,"InstanceGenerationParameter_name"=Column(type ="varchar",
primaryKey =TRUE)
)
                     ),"DBInstance_has_InstanceGenerationParameter")  
    })

setConstructorS3("DBIterationStatistics",function()
    {  
      extend(DBModel(tableName = "IterationStatistics",
                     columns = list("avgFitness"=Column(type ="double",
primaryKey =FALSE)
,"medianFitness"=Column(type ="double",
primaryKey =FALSE)
,"minFitness"=Column(type ="double",
primaryKey =FALSE)
,"maxFitness"=Column(type ="double",
primaryKey =FALSE)
,"iteration"=Column(type ="varchar",
primaryKey =FALSE)
,"nrSolutionPerIteration"=Column(type ="double",
primaryKey =FALSE)
,"firstQuartilFitness"=Column(type ="double",
primaryKey =FALSE)
,"thirdQuartilFitness"=Column(type ="double",
primaryKey =FALSE)
,"Run_uniqueID"=Column(type ="varchar",
primaryKey =FALSE)
)
                     ),"DBIterationStatistics")  
    })

setConstructorS3("DBJobFeatures_AggOfBasic",function()
    {  
      extend(DBModel(tableName = "JobFeatures_AggOfBasic",
                     columns = list("Instance_uniqueID"=Column(type ="varchar",
primaryKey =FALSE)
,"job"=Column(type ="varchar",
primaryKey =FALSE)
,"SumOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MinOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"VarOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
)
                     ),"DBJobFeatures_AggOfBasic")  
    })

setConstructorS3("DBJobFeatures_AggOfBasicAndRestOfBasic",function()
    {  
      extend(DBModel(tableName = "JobFeatures_AggOfBasicAndRestOfBasic",
                     columns = list("Instance_uniqueID"=Column(type ="varchar",
primaryKey =FALSE)
,"job"=Column(type ="varchar",
primaryKey =FALSE)
,"SumOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MinOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"VarOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"SumOfRestJobsSumOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MinOfRestJobsSumOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfRestJobsSumOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"VarOfRestJobsSumOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"SumOfRestJobsMinOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MinOfRestJobsMinOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfRestJobsMinOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"VarOfRestJobsMinOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"SumOfRestJobsMaxOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MinOfRestJobsMaxOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfRestJobsMaxOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"VarOfRestJobsMaxOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"SumOfRestJobsVarOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MinOfRestJobsVarOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfRestJobsVarOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"VarOfRestJobsVarOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
)
                     ),"DBJobFeatures_AggOfBasicAndRestOfBasic")  
    })

setConstructorS3("DBJob_AggOfOperationBasic",function()
    {  
      extend(DBModel(tableName = "Job_AggOfOperationBasic",
                     columns = list("Instance_uniqueID"=Column(type ="varchar",
primaryKey =TRUE)
,"job"=Column(type ="varchar",
primaryKey =TRUE)
,"SumOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MinOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"VarOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
)
                     ),"DBJob_AggOfOperationBasic")  
    })

setConstructorS3("DBJob_AggOfRestJobAggOfOperationBasic",function()
    {  
      extend(DBModel(tableName = "Job_AggOfRestJobAggOfOperationBasic",
                     columns = list("Instance_uniqueID"=Column(type ="varchar",
primaryKey =TRUE)
,"job"=Column(type ="varchar",
primaryKey =TRUE)
,"SumOfRestJobsSumOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfRestJobsSumOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MinOfRestJobsSumOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfRestJobsSumOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"VarOfRestJobsSumOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"SumOfRestJobsMeanOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfRestJobsMeanOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MinOfRestJobsMeanOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfRestJobsMeanOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"VarOfRestJobsMeanOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"SumOfRestJobsMinOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfRestJobsMinOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MinOfRestJobsMinOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfRestJobsMinOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"VarOfRestJobsMinOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"SumOfRestJobsMaxOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfRestJobsMaxOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MinOfRestJobsMaxOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfRestJobsMaxOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"VarOfRestJobsMaxOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"SumOfRestJobsVarOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfRestJobsVarOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MinOfRestJobsVarOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfRestJobsVarOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"VarOfRestJobsVarOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
)
                     ),"DBJob_AggOfRestJobAggOfOperationBasic")  
    })

setConstructorS3("DBJob_StandMomentsOfOperationBasic",function()
    {  
      extend(DBModel(tableName = "Job_StandMomentsOfOperationBasic",
                     columns = list("Instance_uniqueID"=Column(type ="varchar",
primaryKey =TRUE)
,"job"=Column(type ="varchar",
primaryKey =TRUE)
,"SkewnessOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfDurationSameJob"=Column(type ="double",
primaryKey =FALSE)
)
                     ),"DBJob_StandMomentsOfOperationBasic")  
    })

setConstructorS3("DBLists_PartialPriorityList",function()
    {  
      extend(DBModel(tableName = "Lists_PartialPriorityList",
                     columns = list("job"=Column(type ="varchar",
primaryKey =TRUE)
,"machine"=Column(type ="varchar",
primaryKey =TRUE)
,"priority"=Column(type ="varchar",
primaryKey =FALSE)
,"PartialPriorityList_id"=Column(type ="varchar",
primaryKey =TRUE)
)
                     ),"DBLists_PartialPriorityList")  
    })

setConstructorS3("DBMachine",function()
    {  
      extend(DBModel(tableName = "Machine",
                     columns = list("Instance_uniqueID"=Column(type ="varchar",
primaryKey =TRUE)
,"machine"=Column(type ="varchar",
primaryKey =TRUE)
)
                     ),"DBMachine")  
    })

setConstructorS3("DBMachineFeatures_AggOfBasicAndDone",function()
    {  
      extend(DBModel(tableName = "MachineFeatures_AggOfBasicAndDone",
                     columns = list("Instance_uniqueID"=Column(type ="varchar",
primaryKey =FALSE)
,"machine"=Column(type ="varchar",
primaryKey =FALSE)
,"SumOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
)
                     ),"DBMachineFeatures_AggOfBasicAndDone")  
    })

setConstructorS3("DBMachineFeatures_AggOfBasicAndDoneAndRestOfBasic",function()
    {  
      extend(DBModel(tableName = "MachineFeatures_AggOfBasicAndDoneAndRestOfBasic",
                     columns = list("Instance_uniqueID"=Column(type ="varchar",
primaryKey =FALSE)
,"machine"=Column(type ="varchar",
primaryKey =FALSE)
,"SumOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfRestMachinesSumOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfRestMachinesSumOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfRestMachinesSumOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfRestMachinesSumOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfRestMachinesMinOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfRestMachinesMinOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfRestMachinesMinOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfRestMachinesMinOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfRestMachinesMaxOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfRestMachinesMaxOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfRestMachinesMaxOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfRestMachinesMaxOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfRestMachinesVarOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfRestMachinesVarOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfRestMachinesVarOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfRestMachinesVarOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfRestMachinesSumOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfRestMachinesSumOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfRestMachinesSumOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfRestMachinesMinOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfRestMachinesMinOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfRestMachinesMinOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfRestMachinesMinOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfRestMachinesMaxOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfRestMachinesMaxOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfRestMachinesMaxOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfRestMachinesMaxOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfRestMachinesVarOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfRestMachinesVarOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfRestMachinesVarOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfRestMachinesVarOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
)
                     ),"DBMachineFeatures_AggOfBasicAndDoneAndRestOfBasic")  
    })

setConstructorS3("DBMachine_AggOfOperationBasic",function()
    {  
      extend(DBModel(tableName = "Machine_AggOfOperationBasic",
                     columns = list("Instance_uniqueID"=Column(type ="varchar",
primaryKey =TRUE)
,"machine"=Column(type ="varchar",
primaryKey =TRUE)
,"SumOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
)
                     ),"DBMachine_AggOfOperationBasic")  
    })

setConstructorS3("DBMachine_AggOfOperationWorkBeingDone",function()
    {  
      extend(DBModel(tableName = "Machine_AggOfOperationWorkBeingDone",
                     columns = list("Instance_uniqueID"=Column(type ="varchar",
primaryKey =TRUE)
,"machine"=Column(type ="varchar",
primaryKey =TRUE)
,"SumOfMinEndTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMinEndTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMinEndTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinEndTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinEndTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMeanWorkBeingDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMeanWorkBeingDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMeanWorkBeingDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMeanWorkBeingDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMeanWorkBeingDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMinWorkBeingDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMinWorkBeingDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMinWorkBeingDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinWorkBeingDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinWorkBeingDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMaxWorkBeingDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMaxWorkBeingDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMaxWorkBeingDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMaxWorkBeingDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxWorkBeingDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfVarWorkBeingDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfVarWorkBeingDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarWorkBeingDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfVarWorkBeingDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarWorkBeingDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
)
                     ),"DBMachine_AggOfOperationWorkBeingDone")  
    })

setConstructorS3("DBMachine_AggOfOperationWorkDone",function()
    {  
      extend(DBModel(tableName = "Machine_AggOfOperationWorkDone",
                     columns = list("Instance_uniqueID"=Column(type ="varchar",
primaryKey =TRUE)
,"machine"=Column(type ="varchar",
primaryKey =TRUE)
,"SumOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinStartTimeSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMeanWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarWorkDoneSameMachine"=Column(type ="double",
primaryKey =FALSE)
)
                     ),"DBMachine_AggOfOperationWorkDone")  
    })

setConstructorS3("DBMachine_AggOfOperationWorkRemaining",function()
    {  
      extend(DBModel(tableName = "Machine_AggOfOperationWorkRemaining",
                     columns = list("Instance_uniqueID"=Column(type ="varchar",
primaryKey =TRUE)
,"machine"=Column(type ="varchar",
primaryKey =TRUE)
,"SumOfSumWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfSumWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfSumWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfSumWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfSumWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMeanWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMeanWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMeanWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMeanWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMeanWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMinWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMinWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMinWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMaxWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMaxWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMaxWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMaxWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfVarWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfVarWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfVarWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarWorkRemainingSameMachine"=Column(type ="double",
primaryKey =FALSE)
)
                     ),"DBMachine_AggOfOperationWorkRemaining")  
    })

setConstructorS3("DBMachine_AggOfRestMachineAggOfOperationBasic",function()
    {  
      extend(DBModel(tableName = "Machine_AggOfRestMachineAggOfOperationBasic",
                     columns = list("Instance_uniqueID"=Column(type ="varchar",
primaryKey =TRUE)
,"machine"=Column(type ="varchar",
primaryKey =TRUE)
,"SumOfRestMachinesSumOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfRestMachinesSumOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfRestMachinesSumOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfRestMachinesSumOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfRestMachinesSumOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfRestMachinesMeanOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfRestMachinesMeanOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfRestMachinesMeanOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfRestMachinesMeanOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfRestMachinesMeanOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfRestMachinesMinOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfRestMachinesMinOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfRestMachinesMinOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfRestMachinesMinOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfRestMachinesMinOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfRestMachinesMaxOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfRestMachinesMaxOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfRestMachinesMaxOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfRestMachinesMaxOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfRestMachinesMaxOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfRestMachinesVarOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfRestMachinesVarOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfRestMachinesVarOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfRestMachinesVarOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfRestMachinesVarOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfRestMachinesSumOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfRestMachinesSumOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfRestMachinesSumOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfRestMachinesSumOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfRestMachinesSumOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfRestMachinesMeanOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfRestMachinesMeanOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfRestMachinesMeanOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfRestMachinesMeanOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfRestMachinesMeanOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfRestMachinesMinOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfRestMachinesMinOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfRestMachinesMinOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfRestMachinesMinOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfRestMachinesMinOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfRestMachinesMaxOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfRestMachinesMaxOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfRestMachinesMaxOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfRestMachinesMaxOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfRestMachinesMaxOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SumOfRestMachinesVarOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfRestMachinesVarOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MinOfRestMachinesVarOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfRestMachinesVarOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"VarOfRestMachinesVarOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
)
                     ),"DBMachine_AggOfRestMachineAggOfOperationBasic")  
    })

setConstructorS3("DBMachine_HistogramOfOperationBasic_Duration_4",function()
    {  
      extend(DBModel(tableName = "Machine_HistogramOfOperationBasic_Duration_4",
                     columns = list("Instance_uniqueID"=Column(type ="varchar",
primaryKey =TRUE)
,"machine"=Column(type ="varchar",
primaryKey =TRUE)
,"Duration__0_25_"=Column(type ="double",
primaryKey =FALSE)
,"Duration__25_50_"=Column(type ="double",
primaryKey =FALSE)
,"Duration__50_75_"=Column(type ="double",
primaryKey =FALSE)
,"Duration__75_99_"=Column(type ="double",
primaryKey =FALSE)
)
                     ),"DBMachine_HistogramOfOperationBasic_Duration_4")  
    })

setConstructorS3("DBMachine_HistogramOfOperationBasic_Duration_4_Precedence_2",function()
    {  
      extend(DBModel(tableName = "Machine_HistogramOfOperationBasic_Duration_4_Precedence_2",
                     columns = list("Instance_uniqueID"=Column(type ="varchar",
primaryKey =TRUE)
,"machine"=Column(type ="varchar",
primaryKey =TRUE)
,"Precedence_Duration__0_0_5___0_25_"=Column(type ="double",
primaryKey =FALSE)
,"Precedence_Duration__0_0_5___25_50_"=Column(type ="double",
primaryKey =FALSE)
,"Precedence_Duration__0_0_5___75_99_"=Column(type ="double",
primaryKey =FALSE)
,"Precedence_Duration__0_5_1___0_25_"=Column(type ="double",
primaryKey =FALSE)
,"Precedence_Duration__0_5_1___25_50_"=Column(type ="double",
primaryKey =FALSE)
,"Precedence_Duration__0_5_1___50_75_"=Column(type ="double",
primaryKey =FALSE)
,"Precedence_Duration__0_0_5___50_75_"=Column(type ="double",
primaryKey =FALSE)
,"Precedence_Duration__0_5_1___75_99_"=Column(type ="double",
primaryKey =FALSE)
)
                     ),"DBMachine_HistogramOfOperationBasic_Duration_4_Precedence_2")  
    })

setConstructorS3("DBMachine_HistogramOfOperationBasic_Precedence_2",function()
    {  
      extend(DBModel(tableName = "Machine_HistogramOfOperationBasic_Precedence_2",
                     columns = list("Instance_uniqueID"=Column(type ="varchar",
primaryKey =TRUE)
,"machine"=Column(type ="varchar",
primaryKey =TRUE)
,"Precedence__0_0_5_"=Column(type ="double",
primaryKey =FALSE)
,"Precedence__0_5_1_"=Column(type ="double",
primaryKey =FALSE)
)
                     ),"DBMachine_HistogramOfOperationBasic_Precedence_2")  
    })

setConstructorS3("DBMachine_StandMomentsOfOperationBasic",function()
    {  
      extend(DBModel(tableName = "Machine_StandMomentsOfOperationBasic",
                     columns = list("Instance_uniqueID"=Column(type ="varchar",
primaryKey =TRUE)
,"machine"=Column(type ="varchar",
primaryKey =TRUE)
,"SkewnessOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfDurationSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"SkewnessOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
,"KurtosisOfPrecedenceSameMachine"=Column(type ="double",
primaryKey =FALSE)
)
                     ),"DBMachine_StandMomentsOfOperationBasic")  
    })

setConstructorS3("DBMetaheuristicRun",function()
    {  
      extend(DBModel(tableName = "MetaheuristicRun",
                     columns = list("Run_uniqueID"=Column(type ="varchar",
primaryKey =FALSE)
,"Solution_uniqueID"=Column(type ="varchar",
primaryKey =FALSE)
,"nrIterations"=Column(type ="varchar",
primaryKey =FALSE)
,"resolution"=Column(type ="varchar",
primaryKey =FALSE)
)
                     ),"DBMetaheuristicRun")  
    })

setConstructorS3("DBNonLinearFeaturesDimensions",function()
    {  
      extend(DBModel(tableName = "NonLinearFeaturesDimensions",
                     columns = list("InstanceCodificationNonLinearFeatures_id"=Column(type ="varchar",
primaryKey =FALSE)
,"feature"=Column(type ="varchar",
primaryKey =FALSE)
,"nrPartitions"=Column(type ="varchar",
primaryKey =FALSE)
,"id"=Column(type ="varchar",
primaryKey =TRUE)
)
                     ),"DBNonLinearFeaturesDimensions")  
    })

setConstructorS3("DBOperation",function()
    {  
      extend(DBModel(tableName = "Operation",
                     columns = list("Instance_uniqueID"=Column(type ="varchar",
primaryKey =TRUE)
,"machine"=Column(type ="varchar",
primaryKey =TRUE)
,"job"=Column(type ="varchar",
primaryKey =TRUE)
,"duration"=Column(type ="varchar",
primaryKey =FALSE)
,"precedence"=Column(type ="varchar",
primaryKey =FALSE)
,"Instance_size"=Column(type ="varchar",
primaryKey =FALSE)
)
                     ),"DBOperation")  
    })

setConstructorS3("DBOperationDistributionLinearFeatures",function()
    {  
      extend(DBModel(tableName = "OperationDistributionLinearFeatures",
                     columns = list("Instance_uniqueID"=Column(type ="varchar",
primaryKey =TRUE)
,"nrJobsxnrMachines"=Column(type ="varchar",
primaryKey =FALSE)
,"OperationNrBins"=Column(type ="varchar",
primaryKey =TRUE)
,"AggregatorNrBins"=Column(type ="varchar",
primaryKey =TRUE)
,"value"=Column(type ="varchar",
primaryKey =FALSE)
,"aggregator"=Column(type ="varchar",
primaryKey =TRUE)
,"operationFeatureName"=Column(type ="varchar",
primaryKey =TRUE)
)
                     ),"DBOperationDistributionLinearFeatures")  
    })

setConstructorS3("DBOperationTest",function()
    {  
      extend(DBModel(tableName = "OperationTest",
                     columns = list("Instance_uniqueID"=Column(type ="varchar",
primaryKey =FALSE)
,"machine"=Column(type ="varchar",
primaryKey =FALSE)
,"job"=Column(type ="varchar",
primaryKey =FALSE)
,"duration"=Column(type ="varchar",
primaryKey =FALSE)
,"precedence"=Column(type ="varchar",
primaryKey =FALSE)
,"Instance_size"=Column(type ="varchar",
primaryKey =FALSE)
,"nrJobs"=Column(type ="varchar",
primaryKey =FALSE)
,"nrMachines"=Column(type ="varchar",
primaryKey =FALSE)
)
                     ),"DBOperationTest")  
    })

setConstructorS3("DBOperation_Basic",function()
    {  
      extend(DBModel(tableName = "Operation_Basic",
                     columns = list("Instance_uniqueID"=Column(type ="varchar",
primaryKey =TRUE)
,"machine"=Column(type ="varchar",
primaryKey =TRUE)
,"job"=Column(type ="varchar",
primaryKey =TRUE)
,"nrJobs"=Column(type ="varchar",
primaryKey =FALSE)
,"nrMachines"=Column(type ="varchar",
primaryKey =FALSE)
,"Duration"=Column(type ="varchar",
primaryKey =FALSE)
,"Precedence"=Column(type ="varchar",
primaryKey =FALSE)
)
                     ),"DBOperation_Basic")  
    })

setConstructorS3("DBOperation_ICS",function()
    {  
      extend(DBModel(tableName = "Operation_ICS",
                     columns = list("Instance_uniqueID"=Column(type ="varchar",
primaryKey =TRUE)
,"job"=Column(type ="varchar",
primaryKey =TRUE)
,"machine"=Column(type ="varchar",
primaryKey =TRUE)
,"MinStartTime"=Column(type ="double",
primaryKey =FALSE)
,"MinEndTime"=Column(type ="double",
primaryKey =FALSE)
,"Duration"=Column(type ="double",
primaryKey =FALSE)
,"Precedence"=Column(type ="double",
primaryKey =FALSE)
)
                     ),"DBOperation_ICS")  
    })

setConstructorS3("DBOperation_WorkBeingDone",function()
    {  
      extend(DBModel(tableName = "Operation_WorkBeingDone",
                     columns = list("Instance_uniqueID"=Column(type ="varchar",
primaryKey =TRUE)
,"job"=Column(type ="varchar",
primaryKey =TRUE)
,"machine"=Column(type ="varchar",
primaryKey =TRUE)
,"Duration"=Column(type ="varchar",
primaryKey =FALSE)
,"Precedence"=Column(type ="varchar",
primaryKey =FALSE)
,"MinEndTime"=Column(type ="double",
primaryKey =FALSE)
,"MeanWorkBeingDone"=Column(type ="double",
primaryKey =FALSE)
,"MinWorkBeingDone"=Column(type ="double",
primaryKey =FALSE)
,"MaxWorkBeingDone"=Column(type ="double",
primaryKey =FALSE)
,"VarWorkBeingDone"=Column(type ="double",
primaryKey =FALSE)
)
                     ),"DBOperation_WorkBeingDone")  
    })

setConstructorS3("DBOperation_WorkDone",function()
    {  
      extend(DBModel(tableName = "Operation_WorkDone",
                     columns = list("Instance_uniqueID"=Column(type ="varchar",
primaryKey =TRUE)
,"job"=Column(type ="varchar",
primaryKey =TRUE)
,"machine"=Column(type ="varchar",
primaryKey =TRUE)
,"Duration"=Column(type ="varchar",
primaryKey =FALSE)
,"Precedence"=Column(type ="varchar",
primaryKey =FALSE)
,"MinStartTime"=Column(type ="double",
primaryKey =FALSE)
,"MeanWorkDone"=Column(type ="double",
primaryKey =FALSE)
,"MinWorkDone"=Column(type ="double",
primaryKey =FALSE)
,"MaxWorkDone"=Column(type ="double",
primaryKey =FALSE)
,"VarWorkDone"=Column(type ="double",
primaryKey =FALSE)
)
                     ),"DBOperation_WorkDone")  
    })

setConstructorS3("DBOperation_WorkRemaining",function()
    {  
      extend(DBModel(tableName = "Operation_WorkRemaining",
                     columns = list("Instance_uniqueID"=Column(type ="varchar",
primaryKey =TRUE)
,"job"=Column(type ="varchar",
primaryKey =TRUE)
,"machine"=Column(type ="varchar",
primaryKey =TRUE)
,"Duration"=Column(type ="varchar",
primaryKey =FALSE)
,"Precedence"=Column(type ="varchar",
primaryKey =FALSE)
,"SumWorkRemaining"=Column(type ="double",
primaryKey =FALSE)
,"MeanWorkRemaining"=Column(type ="double",
primaryKey =FALSE)
,"MinWorkRemaining"=Column(type ="double",
primaryKey =FALSE)
,"MaxWorkRemaining"=Column(type ="double",
primaryKey =FALSE)
,"VarWorkRemaining"=Column(type ="double",
primaryKey =FALSE)
)
                     ),"DBOperation_WorkRemaining")  
    })

setConstructorS3("DBPartialPriorityList",function()
    {  
      extend(DBModel(tableName = "PartialPriorityList",
                     columns = list("id"=Column(type ="varchar",
primaryKey =TRUE)
,"defaultEvaluationFunction"=Column(type ="varchar",
primaryKey =FALSE)
,"defaultSelectionFunction"=Column(type ="varchar",
primaryKey =FALSE)
,"Solution_uniqueID"=Column(type ="varchar",
primaryKey =FALSE)
)
                     ),"DBPartialPriorityList")  
    })

setConstructorS3("DBPrecedence_AggOfOperationBasic",function()
    {  
      extend(DBModel(tableName = "Precedence_AggOfOperationBasic",
                     columns = list("Instance_uniqueID"=Column(type ="varchar",
primaryKey =TRUE)
,"Precedence"=Column(type ="varchar",
primaryKey =TRUE)
,"SumOfDurationSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfDurationSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MinOfDurationSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfDurationSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"VarOfDurationSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"CountDistinctOfMachineSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"CountMaxOfMachineSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"CountMinOfMachineSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"CountVarOfMachineSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
)
                     ),"DBPrecedence_AggOfOperationBasic")  
    })

setConstructorS3("DBPrecedence_AggOfOperationWorkDone",function()
    {  
      extend(DBModel(tableName = "Precedence_AggOfOperationWorkDone",
                     columns = list("Instance_uniqueID"=Column(type ="varchar",
primaryKey =TRUE)
,"Precedence"=Column(type ="varchar",
primaryKey =TRUE)
,"SumOfMinStartTimeSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMinStartTimeSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMinStartTimeSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinStartTimeSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinStartTimeSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMeanWorkDoneSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMeanWorkDoneSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMeanWorkDoneSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMeanWorkDoneSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMeanWorkDoneSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMinWorkDoneSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMinWorkDoneSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMinWorkDoneSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMinWorkDoneSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMinWorkDoneSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"SumOfMaxWorkDoneSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfMaxWorkDoneSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MinOfMaxWorkDoneSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfMaxWorkDoneSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"VarOfMaxWorkDoneSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"SumOfVarWorkDoneSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MeanOfVarWorkDoneSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MinOfVarWorkDoneSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"MaxOfVarWorkDoneSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
,"VarOfVarWorkDoneSamePrecedence"=Column(type ="double",
primaryKey =FALSE)
)
                     ),"DBPrecedence_AggOfOperationWorkDone")  
    })

setConstructorS3("DBPriorityList",function()
    {  
      extend(DBModel(tableName = "PriorityList",
                     columns = list("job"=Column(type ="varchar",
primaryKey =TRUE)
,"machine"=Column(type ="varchar",
primaryKey =TRUE)
,"priority"=Column(type ="varchar",
primaryKey =FALSE)
,"Solution_uniqueID"=Column(type ="varchar",
primaryKey =TRUE)
)
                     ),"DBPriorityList")  
    })

setConstructorS3("DBRun",function()
    {  
      extend(DBModel(tableName = "Run",
                     columns = list("uniqueID"=Column(type ="varchar",
primaryKey =TRUE)
,"start_time"=Column(type ="varchar",
primaryKey =FALSE)
,"seed"=Column(type ="varchar",
primaryKey =FALSE)
,"systemTime"=Column(type ="double",
primaryKey =FALSE)
,"userTime"=Column(type ="double",
primaryKey =FALSE)
,"elapsedTime"=Column(type ="double",
primaryKey =FALSE)
,"memory"=Column(type ="double",
primaryKey =FALSE)
,"AlgorithmParameterized_uniqueID"=Column(type ="varchar",
primaryKey =FALSE)
,"FeasibleSchedule_uniqueID"=Column(type ="varchar",
primaryKey =FALSE)
,"Instance_uniqueID"=Column(type ="varchar",
primaryKey =FALSE)
,"status"=Column(type ="varchar",
primaryKey =FALSE)
)
                     ),"DBRun")  
    })

setConstructorS3("DBSequence",function()
    {  
      extend(DBModel(tableName = "Sequence",
                     columns = list("Solution_uniqueID"=Column(type ="varchar",
primaryKey =FALSE)
,"uniqueID"=Column(type ="varchar",
primaryKey =FALSE)
,"sequence"=Column(type ="varchar",
primaryKey =FALSE)
)
                     ),"DBSequence")  
    })

setConstructorS3("DBSolution",function()
    {  
      extend(DBModel(tableName = "Solution",
                     columns = list("uniqueID"=Column(type ="varchar",
primaryKey =TRUE)
,"source"=Column(type ="varchar",
primaryKey =FALSE)
,"seed"=Column(type ="varchar",
primaryKey =FALSE)
,"SolutionType_name"=Column(type ="varchar",
primaryKey =FALSE)
,"nrJobs"=Column(type ="varchar",
primaryKey =FALSE)
,"nrMachines"=Column(type ="varchar",
primaryKey =FALSE)
)
                     ),"DBSolution")  
    })

setConstructorS3("DBSolutionType",function()
    {  
      extend(DBModel(tableName = "SolutionType",
                     columns = list("name"=Column(type ="varchar",
primaryKey =TRUE)
)
                     ),"DBSolutionType")  
    })

setConstructorS3("DBTarget_MinEndTimevsMWR_higher75",function()
    {  
      extend(DBModel(tableName = "Target_MinEndTimevsMWR_higher75",
                     columns = list("target"=Column(type ="varchar",
primaryKey =FALSE)
,"Instance_uniqueID"=Column(type ="varchar",
primaryKey =TRUE)
,"weight"=Column(type ="double",
primaryKey =FALSE)
)
                     ),"DBTarget_MinEndTimevsMWR_higher75")  
    })

setConstructorS3("DBTarget_SPTvsLPT_higher200",function()
    {  
      extend(DBModel(tableName = "Target_SPTvsLPT_higher200",
                     columns = list("target"=Column(type ="varchar",
primaryKey =FALSE)
,"Instance_uniqueID"=Column(type ="varchar",
primaryKey =TRUE)
,"weight"=Column(type ="double",
primaryKey =FALSE)
)
                     ),"DBTarget_SPTvsLPT_higher200")  
    })

setConstructorS3("DBTarget_SPTvsLPT_higher230",function()
    {  
      extend(DBModel(tableName = "Target_SPTvsLPT_higher230",
                     columns = list("target"=Column(type ="varchar",
primaryKey =FALSE)
,"Instance_uniqueID"=Column(type ="varchar",
primaryKey =TRUE)
,"weight"=Column(type ="double",
primaryKey =FALSE)
)
                     ),"DBTarget_SPTvsLPT_higher230")  
    })

