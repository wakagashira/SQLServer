--CREATE VIEW dbo.VitallyHealthScoreOverMasterScores
--AS
 

SELECT a.business_id
,a.sfid
,a.Name
,a.Type
,CASE WHEN o.business_id IS NOT NULL THEN 'Onboarding'+ '-' + a.NewSegment ELSE a.NewSegment END NewSegment
,a.Contract_Status__c
,a.ContractStatusScoreWeighted
,a.Churn_Risk__c
,a.ChurnRiskScoreWeighted
,a.Stratigic
,a.StratigicScoreWeighted
,a.Tactical
,a.TacticalScoreWeighted
, a.ContractStatusScoreWeighted + a.ChurnRiskScoreWeighted + a.StratigicScoreWeighted + a.TacticalScoreWeighted AS CSAccountScore
,a.PercentOfVehiclesInspectingLast90days
,a.PercentOfVehiclesInspectingLast90daysScoreWeighted
,a.TrendVehiclesInspectingLast9030days
,a.TrendVehiclesInspectingLast9030daysScoreWeighted
,a.PercentTotalCorrectedFaultAllTime
,a.PercentTotalCorrectedFaultAllTimeScoreWeighted
,a.PercentCorrectedFaults90Day
,a.PercentCorrectedFaults90DayScoreWeighted
,a.PercentOfDriversInspectingLast90days
,a.PercentOfDriversInspectingLast90daysScoreWeighted
,a.PercentOfVehiclesInspectingLast90daysScoreWeighted + a.TrendVehiclesInspectingLast9030daysScoreWeighted + a.PercentTotalCorrectedFaultAllTimeScoreWeighted + a.PercentCorrectedFaults90DayScoreWeighted + a.PercentOfDriversInspectingLast90daysScoreWeighted AS CSInspectScore

,a.OpenedVsClosedWO90Days
,a.OpenedVsClosedWO90DaysScoreWeighted
,a.PercentVehiclesWithWorkOrder90Days
,a.PercentVehiclesWithWorkOrder90DaysscoreWeighted
,a.PercentOfVehiclesWithService90Days
,a.PercentOfVehiclesWithService90DaysScoreWeighted
,a.PercentOfServicesOpenedvsClosed90Days
,a.PercentOfServicesOpenedvsClosed90DaysScoreWeighted

,a.OpenedVsClosedWO90DaysScoreWeighted + a.PercentVehiclesWithWorkOrder90DaysscoreWeighted + a.PercentOfVehiclesWithService90DaysScoreWeighted + a.PercentOfServicesOpenedvsClosed90DaysScoreWeighted AS CSMaintainScore
,o.Declined_Training__c
,CAST(o.AccountSetupScore AS DECIMAL) / 3 AS AccountSetupScoreWeighted
,o.acc_Training_Completed__c
,CAST(o.TrainingScore AS DECIMAL) / 3 AS TrainingScoreWeighted
,o.InitialSignupDate
,CAST(o.InitialSignupDateScore AS decimal) / 3 AS InitialSignupDateScoreWeighted
,o.OnboardingAccountScore
,o.DriversInspectingAllTime
,CAST(o.OnboardingPercentDriversInspScore AS DECIMAL) /2 AS OnboardingPercentDriversInspScoreWeighted
,o.PercentOfVehiclesInspectingAllTime
,CAST(o.PercentOfVehiclesInspectingAllTimeScore AS DECIMAL) /2 AS PercentOfVehiclesInspectingAllTimeScoreWeighted
,o.OnboardingInspectScore
,o.of_Service_Programs__c AS NumberOfServicePrograms
,CAST(o.Numberof_Service_Programs_Score AS DECIMAL) /2 AS Numberof_Service_Programs_ScoreWeighted
,o.app_Closed_Work_Orders__c
,CAST(o.app_Closed_Work_Orders_Score AS DECIMAL) /2 AS app_Closed_Work_Orders_ScoreWeighted
,o.OnboardingMaintainScore
,o.OnboardingScore
,CASE WHEN CASE WHEN o.business_id IS NOT NULL THEN 'Onboarding'+ '-' + a.NewSegment ELSE a.NewSegment END LIKE 'Onboarding%' THEN o.AccountSetupScore
ELSE a.ContractStatusScoreWeighted + a.ChurnRiskScoreWeighted + a.StratigicScoreWeighted + a.TacticalScoreWeighted END AS AccountScore
,CASE WHEN CASE WHEN o.business_id IS NOT NULL THEN 'Onboarding'+ '-' + a.NewSegment ELSE a.NewSegment END LIKE 'Onboarding%' THEN o.OnboardingInspectScore
ELSE a.PercentOfVehiclesInspectingLast90daysScoreWeighted + a.TrendVehiclesInspectingLast9030daysScoreWeighted + a.PercentTotalCorrectedFaultAllTimeScoreWeighted + a.PercentCorrectedFaults90DayScoreWeighted + a.PercentOfDriversInspectingLast90daysScoreWeighted END AS InspectScore

,CASE WHEN CASE WHEN o.business_id IS NOT NULL THEN 'Onboarding'+ '-' + a.NewSegment ELSE a.NewSegment END LIKE 'Onboarding%' THEN o.OnboardingMaintainScore
ELSE a.OpenedVsClosedWO90DaysScoreWeighted + a.PercentVehiclesWithWorkOrder90DaysscoreWeighted + a.PercentOfVehiclesWithService90DaysScoreWeighted + a.PercentOfServicesOpenedvsClosed90DaysScoreWeighted END AS MaintainScore
,
CASE WHEN CASE WHEN o.business_id IS NOT NULL THEN 'Onboarding'+ '-' + a.NewSegment ELSE a.NewSegment END = 'Plus' THEN ((a.ContractStatusScoreWeighted + a.ChurnRiskScoreWeighted + a.StratigicScoreWeighted + a.TacticalScoreWeighted) +
(a.PercentOfVehiclesInspectingLast90daysScoreWeighted + a.TrendVehiclesInspectingLast9030daysScoreWeighted + a.PercentTotalCorrectedFaultAllTimeScoreWeighted + a.PercentCorrectedFaults90DayScoreWeighted + a.PercentOfDriversInspectingLast90daysScoreWeighted) ) / 2
WHEN CASE WHEN o.business_id IS NOT NULL THEN 'Onboarding'+ '-' + a.NewSegment ELSE a.NewSegment END = 'Prime' THEN 
((a.ContractStatusScoreWeighted + a.ChurnRiskScoreWeighted + a.StratigicScoreWeighted + a.TacticalScoreWeighted) +
(a.PercentOfVehiclesInspectingLast90daysScoreWeighted + a.TrendVehiclesInspectingLast9030daysScoreWeighted + a.PercentTotalCorrectedFaultAllTimeScoreWeighted + a.PercentCorrectedFaults90DayScoreWeighted + a.PercentOfDriversInspectingLast90daysScoreWeighted) +
(a.OpenedVsClosedWO90DaysScoreWeighted + a.PercentVehiclesWithWorkOrder90DaysscoreWeighted + a.PercentOfVehiclesWithService90DaysScoreWeighted + a.PercentOfServicesOpenedvsClosed90DaysScoreWeighted)) / 3 
WHEN CASE WHEN o.business_id IS NOT NULL THEN 'Onboarding'+ '-' + a.NewSegment ELSE a.NewSegment END LIKE 'Onboarding%' THEN o.OnboardingScore
ELSE ((a.ContractStatusScoreWeighted + a.ChurnRiskScoreWeighted + a.StratigicScoreWeighted + a.TacticalScoreWeighted) +
(a.PercentOfVehiclesInspectingLast90daysScoreWeighted + a.TrendVehiclesInspectingLast9030daysScoreWeighted + a.PercentTotalCorrectedFaultAllTimeScoreWeighted + a.PercentCorrectedFaults90DayScoreWeighted + a.PercentOfDriversInspectingLast90daysScoreWeighted) ) / 2
END 
AS TotalScore


FROM 
(SELECT
	sf.[business_id]
   ,sf.[sfid]
   ,sf.[Name]
   ,sf.[Type]
   ,sf.[NewSegment]
   ,sf.[Contract_Status__c]
   ,CASE WHEN sf.Contract_Status__c = h1.Incontractgood THEN (10)  ELSE 0 END AS ContractStatusScoreRaw
   ,CASE WHEN sf.Contract_Status__c = h1.Incontractgood THEN (10 * (CAST(h1.Incontractweight AS DECIMAL) * .01))  ELSE 0 END AS ContractStatusScoreWeighted
   ,sf.[Churn_Risk__c]
   ,CASE WHEN sf.Churn_Risk__c = h1.churnriskgood THEN (10)  ELSE 0 END AS ChurnRiskScoreRaw
   ,CASE WHEN sf.Churn_Risk__c = h1.churnriskgood THEN (10 * (CAST(h1.churnriskweight AS DECIMAL) * .01))  ELSE 0 END AS ChurnRiskScoreWeighted
   ,sf.[Stratigic]
   ,CASE WHEN sf.Stratigic > 1 THEN (10) WHEN sf.Stratigic = 1 THEN (5 * (CAST(h1.stratigicWeight AS DECIMAL) * .01))  ELSE 0 END AS StratigicScoreRaw
   ,CASE WHEN sf.Stratigic > 1 THEN (10 * (CAST(h1.stratigicWeight AS DECIMAL) * .01)) WHEN sf.Stratigic = 1 THEN (5 * (CAST(h1.stratigicWeight AS DECIMAL) * .01))  ELSE 0 END AS StratigicScoreWeighted
   ,sf.[Tactical]
   ,CASE WHEN sf.Tactical > 1 THEN (10)  ELSE 0 END AS TacticalScoreRaw
   ,CASE WHEN sf.Tactical > 1 THEN (10 * (CAST(h1.TacticalWeight AS DECIMAL) * .01)) WHEN sf.Tactical = 1 THEN (5 * (CAST(h1.TacticalWeight AS DECIMAL) * .01))  ELSE 0 END AS TacticalScoreWeighted
   ,sf.[Operational]
   ,I.PercentOfVehiclesInspectingLast90days
   ,CASE WHEN I.PercentOfVehiclesInspectingLast90days >= CAST(h1.PercentOfVehiclesInspectingLast90daysGood AS DECIMAL)  THEN (10) 
   WHEN I.PercentOfVehiclesInspectingLast90days >= CAST(h1.PercentOfVehiclesInspectingLast90daysNeutral AS DECIMAL)  THEN (5)
   ELSE 0 END AS PercentOfVehiclesInspectingLast90daysScoreWeightedRaw
   ,CASE WHEN I.PercentOfVehiclesInspectingLast90days >= CAST(h1.PercentOfVehiclesInspectingLast90daysGood AS DECIMAL)  THEN (10 * (CAST(h1.PercentOfVehiclesInspectingLast90daysWeight AS DECIMAL) * .01)) 
   WHEN I.PercentOfVehiclesInspectingLast90days >= CAST(h1.PercentOfVehiclesInspectingLast90daysNeutral AS DECIMAL)  THEN (5 * (CAST(h1.PercentOfVehiclesInspectingLast90daysWeight AS DECIMAL) * .01)) 
   ELSE 0 END AS PercentOfVehiclesInspectingLast90daysScoreWeighted
   ,I.TrendVehiclesInspectingLast9030days
   ,CASE WHEN I.TrendVehiclesInspectingLast9030days >= CAST(h1.TrendVehiclesInspectingLast9030daysGood AS DECIMAL)  THEN (10) 
   WHEN I.TrendVehiclesInspectingLast9030days >= CAST(h1.TrendVehiclesInspectingLast9030daysNeutral AS DECIMAL)  THEN (5) 
   ELSE 0 END AS TrendVehiclesInspectingLast9030daysScoreRaw
   ,CASE WHEN I.TrendVehiclesInspectingLast9030days >= CAST(h1.TrendVehiclesInspectingLast9030daysGood AS DECIMAL)  THEN (10 * (CAST(h1.TrendVehiclesInspectingLast9030daysWeight AS DECIMAL) * .01)) 
   WHEN I.TrendVehiclesInspectingLast9030days >= CAST(h1.TrendVehiclesInspectingLast9030daysNeutral AS DECIMAL)  THEN (5 * (CAST(h1.TrendVehiclesInspectingLast9030daysWeight AS DECIMAL) * .01)) 
   ELSE 0 END AS TrendVehiclesInspectingLast9030daysScoreWeighted
   ,I.PercentTotalCorrectedFaultAllTime
   ,CASE WHEN I.PercentTotalCorrectedFaultAllTime >= CAST(h1.PercentTotalCorrectedFaultAllTimeGood AS DECIMAL)  THEN (10) 
   WHEN I.PercentTotalCorrectedFaultAllTime >= CAST(h1.PercentTotalCorrectedFaultAllTimeNeutral AS DECIMAL)  THEN (5) 
   ELSE 0 END AS PercentTotalCorrectedFaultAllTimeScoreRaw   
   ,CASE WHEN I.PercentTotalCorrectedFaultAllTime >= CAST(h1.PercentTotalCorrectedFaultAllTimeGood AS DECIMAL)  THEN (10 * (CAST(h1.PercentTotalCorrectedFaultAllTimeWeight AS DECIMAL) * .01)) 
   WHEN I.PercentTotalCorrectedFaultAllTime >= CAST(h1.PercentTotalCorrectedFaultAllTimeNeutral AS DECIMAL)  THEN (5 * (CAST(h1.PercentTotalCorrectedFaultAllTimeWeight AS DECIMAL) * .01)) 
   ELSE 0 END AS PercentTotalCorrectedFaultAllTimeScoreWeighted
   ,I.PercentCorrectedFaults90Day
   ,CASE WHEN I.PercentCorrectedFaults90Day >= CAST(h1.PercentCorrectedFaults90DayGood AS DECIMAL)  THEN (10) 
   WHEN I.PercentCorrectedFaults90Day >= CAST(h1.PercentCorrectedFaults90DayNeutral AS DECIMAL)  THEN (5) 
   ELSE 0 END AS PercentCorrectedFaults90DayScoreRaw
   ,CASE WHEN I.PercentCorrectedFaults90Day >= CAST(h1.PercentCorrectedFaults90DayGood AS DECIMAL)  THEN (10 * (CAST(h1.PercentCorrectedFaults90DayWeight AS DECIMAL) * .01)) 
   WHEN I.PercentCorrectedFaults90Day >= CAST(h1.PercentCorrectedFaults90DayNeutral AS DECIMAL)  THEN (5 * (CAST(h1.PercentCorrectedFaults90DayWeight AS DECIMAL) * .01)) 
   ELSE 0 END AS PercentCorrectedFaults90DayScoreWeighted
   ,I.PercentOfDriversInspectingLast90days
   ,CASE WHEN I.PercentOfDriversInspectingLast90days >= CAST(h1.PercentOfDriversInspectingLast90daysGood AS DECIMAL)  THEN (10) 
   WHEN I.PercentOfDriversInspectingLast90days >= CAST(h1.PercentOfDriversInspectingLast90daysNeutral AS DECIMAL)  THEN (5) 
   ELSE 0 END AS PercentOfDriversInspectingLast90daysScoreRaw
   ,CASE WHEN I.PercentOfDriversInspectingLast90days >= CAST(h1.PercentOfDriversInspectingLast90daysGood AS DECIMAL)  THEN (10 * (CAST(h1.PercentOfDriversInspectingLast90daysWeight AS DECIMAL) * .01)) 
   WHEN I.PercentOfDriversInspectingLast90days >= CAST(h1.PercentOfDriversInspectingLast90daysNeutral AS DECIMAL)  THEN (5 * (CAST(h1.PercentOfDriversInspectingLast90daysWeight AS DECIMAL) * .01)) 
   ELSE 0 END AS PercentOfDriversInspectingLast90daysScoreWeighted
   
   ,M.OpenedVsClosedWO90Days
   ,CASE WHEN m.OpenedVsClosedWO90Days >= CAST(h1.OpenedVsClosedWO90DaysGood AS DECIMAL)  THEN (10) 
   WHEN m.OpenedVsClosedWO90Days >= CAST(h1.OpenedVsClosedWO90DaysNeutral AS DECIMAL)  THEN (5) 
   ELSE 0 END AS OpenedVsClosedWO90DaysScoreRaw
   ,CASE WHEN m.OpenedVsClosedWO90Days >= CAST(h1.OpenedVsClosedWO90DaysGood AS DECIMAL)  THEN (10 * (CAST(h1.OpenedVsClosedWO90DaysWeight AS DECIMAL) * .01)) 
   WHEN m.OpenedVsClosedWO90Days >= CAST(h1.OpenedVsClosedWO90DaysNeutral AS DECIMAL)  THEN (5 * (CAST(h1.OpenedVsClosedWO90DaysWeight AS DECIMAL) * .01)) 
   ELSE 0 END AS OpenedVsClosedWO90DaysScoreWeighted
   ,M.PercentVehiclesWithWorkOrder90Days
   ,CASE WHEN m.PercentVehiclesWithWorkOrder90Days >= CAST(h1.PercentVehiclesWithWorkOrder90DaysGood AS DECIMAL)  THEN (10) 
   WHEN m.PercentVehiclesWithWorkOrder90Days >= CAST(h1.PercentVehiclesWithWorkOrder90DaysNeutral AS DECIMAL)  THEN (5) 
   ELSE 0 END AS PercentVehiclesWithWorkOrder90DaysscoreRaw
   
   ,CASE WHEN m.PercentVehiclesWithWorkOrder90Days >= CAST(h1.PercentVehiclesWithWorkOrder90DaysGood AS DECIMAL)  THEN (10 * (CAST(h1.PercentVehiclesWithWorkOrder90DaysWeight AS DECIMAL) * .01)) 
   WHEN m.PercentVehiclesWithWorkOrder90Days >= CAST(h1.PercentVehiclesWithWorkOrder90DaysNeutral AS DECIMAL)  THEN (5 * (CAST(h1.PercentVehiclesWithWorkOrder90DaysWeight AS DECIMAL) * .01)) 
   ELSE 0 END AS PercentVehiclesWithWorkOrder90DaysscoreWeighted
   ,M.PercentOfVehiclesWithService90Days
   ,CASE WHEN m.PercentOfVehiclesWithService90Days >= CAST(h1.PercentOfVehiclesWithService90DaysGood AS DECIMAL)  THEN (10) 
   WHEN m.PercentOfVehiclesWithService90Days >= CAST(h1.PercentOfVehiclesWithService90DaysNeutral AS DECIMAL)  THEN (5) 
   ELSE 0 END AS PercentOfVehiclesWithService90DaysScoreRaw
   ,CASE WHEN m.PercentOfVehiclesWithService90Days >= CAST(h1.PercentOfVehiclesWithService90DaysGood AS DECIMAL)  THEN (10 * (CAST(h1.PercentOfVehiclesWithService90DaysWeight AS DECIMAL) * .01)) 
   WHEN m.PercentOfVehiclesWithService90Days >= CAST(h1.PercentOfVehiclesWithService90DaysNeutral AS DECIMAL)  THEN (5 * (CAST(h1.PercentOfVehiclesWithService90DaysWeight AS DECIMAL) * .01)) 
   ELSE 0 END AS PercentOfVehiclesWithService90DaysScoreWeighted
   ,M.PercentOfServicesOpenedvsClosed90Days
   ,CASE WHEN m.PercentOfServicesOpenedvsClosed90Days >= CAST(h1.PercentOfServicesOpenedvsClosed90DaysGood AS DECIMAL)  THEN (10) 
   WHEN m.PercentOfServicesOpenedvsClosed90Days >= CAST(h1.PercentOfServicesOpenedvsClosed90DaysNeutral AS DECIMAL)  THEN (5) 
   ELSE 0 END AS PercentOfServicesOpenedvsClosed90DaysScoreRaw
   ,CASE WHEN m.PercentOfServicesOpenedvsClosed90Days >= CAST(h1.PercentOfServicesOpenedvsClosed90DaysGood AS DECIMAL)  THEN (10 * (CAST(h1.PercentOfServicesOpenedvsClosed90DaysWeight AS DECIMAL) * .01)) 
   WHEN m.PercentOfServicesOpenedvsClosed90Days >= CAST(h1.PercentOfServicesOpenedvsClosed90DaysNeutral AS DECIMAL)  THEN (5 * (CAST(h1.PercentOfServicesOpenedvsClosed90DaysWeight AS DECIMAL) * .01)) 
   ELSE 0 END AS PercentOfServicesOpenedvsClosed90DaysScoreWeighted
FROM LocalWAProd.[dbo].[VitallyHealthScoreSalesforceStats] AS sf
LEFT OUTER JOIN LocalWAProd.[dbo].[VitallyHealthScoreInspection] AS I
	ON sf.business_id = I.business_id
LEFT OUTER JOIN LocalWAProd.dbo.VittallyHealthScoreMaintain AS M
	ON sf.business_id = M.business_id
LEFT OUTER JOIN Whiparound.dbo.TheNewHealthScore h1 ON 1=1
WHERE sf.business_id != 'true'
AND sf.type = 'Customer'
) AS A
LEFT OUTER JOIN LocalWAProd.dbo.VitallyHealthScoreOnboarding AS o ON a.business_id = o.business_id
--WHERE a.business_id = 6515
--WHERE A.PercentOfVehiclesInspectingLast90days = 0