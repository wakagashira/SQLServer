CREATE VIEW dbo.VitallyHealthScoreTCMaster
AS
 
SELECT 
b.id
	  ,a.[business_id]
      ,a.[sfid]
      ,a.[Name]
      ,a.[Type]
      ,a.[NewSegment] as TC_Vitally_Segment_Type__c
      ,a.[ContractStatusScoreWeighted] as TC_Contract_Status_score__c
      ,a.[ChurnRiskScoreWeighted] as TC_Churn_Risk_score__c 
      ,a.[Stratigic] as TC_Stratigic_Contacts__c 
      ,a.[StratigicScoreWeighted] as TC_Stratigic_Contacts_Score__c
      ,a.[Tactical] as TC_Tactical_Contacts__c
      ,a.[TacticalScoreWeighted] as TC_Tactical_Contacts_Score__c
      ,isnull(a.[PercentOfVehiclesInspectingLast90days], 0) as TC_Per_Vehicles_Inspecting_90_Days__c 
      ,a.[PercentOfVehiclesInspectingLast90daysScoreWeighted] as TC_Per_Vehicles_Inspecting_90_Days_Score__c
      ,isnull(a.[TrendVehiclesInspectingLast9030days], 0) as TC_Vehicle_Inspection_Trend__c
      ,a.[TrendVehiclesInspectingLast9030daysScoreWeighted] as TC_Vehicle_Inspection_Trend_Score__c
      ,isnull(a.[PercentTotalCorrectedFaultAllTime], 0) as TC_Per_Correct_Faults_All_Time__c
      ,a.[PercentTotalCorrectedFaultAllTimeScoreWeighted] as TC_Per_Correct_Faults_All_Time_Score__c
      ,isnull(a.[PercentCorrectedFaults90Day], 0) as TC_Per_Correct_Faults_90_Days__c
      ,a.[PercentCorrectedFaults90DayScoreWeighted] as TC_Per_Correct_Faults_90_Days_Score__c
      ,isnull(a.[PercentOfDriversInspectingLast90days], 0) as TC_Per_Drivers_Inspecting_90_Days__c
      ,a.[PercentOfDriversInspectingLast90daysScoreWeighted] as TC_Per_Drivers_Inspecting_90_Days_Score__c
      ,a.[OpenedVsClosedWO90Days] as TC_Per_Closed_Work_Orders_90_Days__c
      ,a.[OpenedVsClosedWO90DaysScoreWeighted] as TC_Per_Closed_Work_Orders_90_Days_Score__c
      ,a.[PercentVehiclesWithWorkOrder90Days] as TC_Per_Vehicles_W_WO_90_Days__c
      ,a.[PercentVehiclesWithWorkOrder90DaysscoreWeighted] as TC_Per_Vehicles_W_WO_90_Days_Score__c
      ,a.[PercentOfVehiclesWithService90Days] as TC_Per_Vehicles_W_Service_90_Days__c
      ,a.[PercentOfVehiclesWithService90DaysScoreWeighted] as TC_Per_Vehicles_W_Service_90_Days_Score__c
      ,a.[PercentOfServicesOpenedvsClosed90Days] as TC_Per_Closed_Services_90_Days__c
      ,a.[PercentOfServicesOpenedvsClosed90DaysScoreWeighted] as TC_Per_Closed_Services_90_Days_Score__c
      ,a.[acc_Training_Completed__c] as Training_Completed__c
      ,isnull(a.[TrainingScoreWeighted], 0) as TC_Training_Score__c 
      ,case when a.[InitialSignupDate] is null then '' else cast(a.[InitialSignupDate] as nvarchar) end as [InitialSignupDate]  
      ,isnull(a.[InitialSignupDateScoreWeighted], 0) as TC_Initial_Sign_Up_Date_Score__c 
      ,isnull(a.[DriversInspectingAllTime], 0) as TC_Per_Drivers_Inspect_All_Time__c
      ,isnull(a.[OnboardingPercentDriversInspScoreWeighted], 0) as TC_Per_Drivers_Inspect_All_Time_Score__c
      ,Isnull(a.[PercentOfVehiclesInspectingAllTime], 0) as TC_Per_Vehicles_Inspecting_All_Time__c
      ,isnull(a.[PercentOfVehiclesInspectingAllTimeScoreWeighted], 0) as TC_Per_Vehicles_Inspecting_All_Time_Score__c
      ,isnull(a.[Numberof_Service_Programs_ScoreWeighted], 0) as TC_Number_of_Service_Programs_Score__c
      ,isnull(a.[app_Closed_Work_Orders_ScoreWeighted], 0) as TC_Closed_Work_Order_Score__c
      ,a.[AccountScore] as TC_Account_Score__c
      ,a.[InspectScore] as TC_Inspect_Score__c
      ,a.[MaintainScore] as TC_Maintain_Score__c
      ,a.[TotalScore] as TC_Total_Health_Score__c
  FROM [LocalWAProd].[dbo].[VitallyHealthScoreOverMasterScores] as a
  left outer join Salesforce.dbo.App_CDP__c as b on a.business_id = b.WA_group_Id__c
where 
a.[TotalScore] != b.TC_Total_Health_Score__c
 or a.[AccountScore] != b.TC_Account_Score__c
  or a.[InspectScore] != b.TC_Inspect_Score__c
  or a.[MaintainScore] != b.TC_Maintain_Score__c
  or a.[NewSegment] != TC_Vitally_Segment_Type__c
  or cast(a.[ContractStatusScoreWeighted] as int) != TC_Contract_Status_score__c
      or a.[ChurnRiskScoreWeighted] != TC_Churn_Risk_score__c 
      or a.[Stratigic] != b.TC_Strategic_Contacts__c
      or a.[StratigicScoreWeighted] != b.TC_Strategic_Contacts_Score__c
      or a.[Tactical] != TC_Tactical_Contacts__c
      or a.[TacticalScoreWeighted] != TC_Tactical_Contacts_Score__c
      or cast(isnull(a.[PercentOfVehiclesInspectingLast90days], 0) as decimal(16,2)) != cast(TC_Per_Vehicles_Inspecting_90_Days__c as decimal(16,2)) 
      or a.[PercentOfVehiclesInspectingLast90daysScoreWeighted] != TC_Per_Vehicles_Inspecting_90_Days_Score__c
      or CAST(isnull(a.[TrendVehiclesInspectingLast9030days], 0) AS DECIMAL(16,2)) != CAST(TC_Vehicle_Inspection_Trend__c  AS DECIMAL(16,2))
      or a.[TrendVehiclesInspectingLast9030daysScoreWeighted] != TC_Vehicle_Inspection_Trend_Score__c
      or CAST(isnull(a.[PercentTotalCorrectedFaultAllTime], 0) AS DECIMAL(16,2)) != CAST(TC_Per_Correct_Faults_All_Time__c AS DECIMAL(16,2))
      or a.[PercentTotalCorrectedFaultAllTimeScoreWeighted] != TC_Per_Correct_Faults_All_Time_Score__c
      or CAST(isnull(a.[PercentCorrectedFaults90Day], 0) AS DECIMAL(16,2)) != CAST(TC_Per_Correct_Faults_90_Days__c AS DECIMAL(16,2))
      or a.[PercentCorrectedFaults90DayScoreWeighted] != TC_Per_Correct_Faults_90_Days_Score__c
      or cast(isnull(a.[PercentOfDriversInspectingLast90days], 0) AS DECIMAL(16,2)) != cast(TC_Per_Drivers_Inspecting_90_Days__c AS DECIMAL(16,2))
      or cast(a.[PercentOfDriversInspectingLast90daysScoreWeighted] AS DECIMAL(16,2)) != CAST(TC_Per_Drivers_Inspecting_90_Days_Score__c AS DECIMAL(16,2))
      or cast(a.[OpenedVsClosedWO90Days] AS DECIMAL(16,2)) != cast(TC_Per_Closed_Work_Orders_90_Days__c AS DECIMAL(16,2))
      or a.[OpenedVsClosedWO90DaysScoreWeighted] != TC_Per_Closed_Work_Orders_90_Days_Score__c
      or cast(a.[PercentVehiclesWithWorkOrder90Days] AS DECIMAL(16,2)) != cast(TC_Per_Vehicles_W_WO_90_Days__c AS DECIMAL(16,2))
      or cast(a.[PercentVehiclesWithWorkOrder90DaysscoreWeighted] AS DECIMAL(16,2)) != cast(TC_Per_Vehicles_W_WO_90_Days_Score__c AS DECIMAL(16,2))
      or cast(a.[PercentOfVehiclesWithService90Days] AS DECIMAL(16,2)) != cast(TC_Per_Vehicles_W_Service_90_Days__c AS DECIMAL(16,2))
      or cast(a.[PercentOfVehiclesWithService90DaysScoreWeighted] AS DECIMAL(16,2)) != cast(TC_Per_Vehicles_W_Service_90_Days_Score__c AS DECIMAL(16,2))
      or cast(a.[PercentOfServicesOpenedvsClosed90Days] AS DECIMAL(16,2)) != cast(TC_Per_Closed_Services_90_Days__c AS DECIMAL(16,2))
      or cast(a.[PercentOfServicesOpenedvsClosed90DaysScoreWeighted]  AS DECIMAL(16,2)) != cast(TC_Per_Closed_Services_90_Days_Score__c AS DECIMAL(16,2))
    --  or a.[acc_Training_Completed__c] != Training_Completed__c
      or isnull(a.[TrainingScoreWeighted], 0) != TC_Training_Score__c 
      --or case when a.[InitialSignupDate] is null then '' else cast(a.[InitialSignupDate] as nvarchar) end != cast[InitialSignupDate]  
      or isnull(a.[InitialSignupDateScoreWeighted], 0) != TC_Initial_Sign_Up_Date_Score__c 
     -- or isnull(a.[DriversInspectingAllTime], 0) != b.drover
      or cast(isnull(a.[OnboardingPercentDriversInspScoreWeighted], 0) AS DECIMAL(16,2)) != cast(TC_Per_Drivers_Inspect_All_Time_Score__c AS DECIMAL(16,2))
      or cast(Isnull(a.[PercentOfVehiclesInspectingAllTime], 0) AS DECIMAL(16,2)) != cast(TC_Per_Vehicles_Inspecting_All_Time__c AS DECIMAL(16,2))
      or isnull(a.[PercentOfVehiclesInspectingAllTimeScoreWeighted], 0) != TC_Per_Vehicles_Inspecting_All_Time_Scor__c
      or isnull(a.[Numberof_Service_Programs_ScoreWeighted], 0) != TC_Number_of_Service_Programs_Score__c
      or isnull(a.[app_Closed_Work_Orders_ScoreWeighted], 0) != TC_Closed_Work_Order_Score__c
	  