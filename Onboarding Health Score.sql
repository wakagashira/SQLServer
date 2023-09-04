--CREATE VIEW dbo.VitallyHealthScoreOnboarding
--AS
 

SELECT
	t0.business_id
   ,t0.NewSegment
   ,t0.Declined_Training__c
   ,t0.AccountSetupScore
   ,t0.acc_Training_Completed__c
   ,t0.TrainingScore
   ,t0.InitialSignupDate
   ,t0.InitialSignupDateScore
   ,CAST((t0.AccountSetupScore + t0.TrainingScore + t0.InitialSignupDateScore) AS DECIMAL)/3 AS OnboardingAccountScore
   ,t0.DriversInspectingAllTime
   ,t0.OnboardingPercentDriversInspScore
   ,t0.PercentOfVehiclesInspectingAllTime
   ,t0.PercentOfVehiclesInspectingAllTimeScore
   ,CAST((t0.OnboardingPercentDriversInspScore + t0.PercentOfVehiclesInspectingAllTimeScore) AS DECIMAL) /2 AS OnboardingInspectScore
   ,t0.of_Service_Programs__c
   ,t0.Numberof_Service_Programs_Score
   ,t0.app_Closed_Work_Orders__c
   ,t0.app_Closed_Work_Orders_Score
   ,CAST((t0.Numberof_Service_Programs_Score + t0.app_Closed_Work_Orders_Score) AS DECIMAL)/2 AS OnboardingMaintainScore
   ,CASE WHEN t0.NewSegment = 'Prime' THEN 
   CAST((t0.InitialSignupDateScore + t0.AccountSetupScore + t0.TrainingScore + T0.OnboardingPercentDriversInspScore + T0.PercentOfVehiclesInspectingAllTimeScore) AS DECIMAL) / 5
   WHEN t0.NewSegment = 'Plus'
 THEN CAST((t0.InitialSignupDateScore + t0.AccountSetupScore + t0.TrainingScore + T0.OnboardingPercentDriversInspScore + T0.PercentOfVehiclesInspectingAllTimeScore + T0.Numberof_Service_Programs_Score + t0.app_Closed_Work_Orders_Score) AS DECIMAL) / 7
ELSE CAST((t0.InitialSignupDateScore + t0.AccountSetupScore + t0.TrainingScore + T0.OnboardingPercentDriversInspScore + T0.PercentOfVehiclesInspectingAllTimeScore) AS DECIMAL)/5
END AS OnboardingScore
FROM (SELECT
		a.business_id
	   ,a.NewSegment
	   ,a.Declined_Training__c
	   ,CASE
			WHEN a.acc_setup__c = 1 THEN 10
			ELSE 0
		END AS AccountSetupScore
	   ,a.acc_Training_Completed__c
	   ,CASE
			WHEN a.acc_Training_Completed__c = 1 THEN 10
			WHEN a.Declined_Training__c = 1 THEN 10
			ELSE 0
		END AS TrainingScore
	   ,a.InitialSignupDate AS InitialSignupDate
	   ,CASE
			WHEN a.InitialSignupDate >= DATEADD(DAY, -20, GETDATE()) THEN 10
			WHEN a.InitialSignupDate >= DATEADD(DAY, -45, GETDATE()) THEN 5
			ELSE 0
		END AS InitialSignupDateScore
	   ,c.Percent_of_Drivers_Inspecting__c AS DriversInspectingAllTime
	   ,CASE
			WHEN c.Percent_of_Drivers_Inspecting__c >= h.OnboardingPercentDriversInspGood THEN 10
			WHEN c.Percent_of_Drivers_Inspecting__c >= h.OnboardingPercentDriversInspNeutral THEN 5
			ELSE 0
		END AS OnboardingPercentDriversInspScore
	   ,vi.PercentOfVehiclesInspectingAllTime
	   ,CASE
			WHEN vi.PercentOfVehiclesInspectingAllTime >= h.OnboardingVehiclesInspectGood THEN 10
			WHEN vi.PercentOfVehiclesInspectingAllTime >= h.OnboardingVehiclesInspNeutral THEN 5
			ELSE 0
		END AS PercentOfVehiclesInspectingAllTimeScore
	   ,c.of_Service_Programs__c
	   ,CASE
			WHEN c.of_Service_Programs__c >= 1 THEN 10
			ELSE 0
		END AS Numberof_Service_Programs_Score
	   ,c.app_Closed_Work_Orders__c
	   ,CASE
			WHEN c.app_Closed_Work_Orders__c >= 1 THEN 10
			ELSE 0
		END AS app_Closed_Work_Orders_Score
	FROM LocalWAProd.[dbo].[VitallyHealthScoreSalesforceStats] AS a
	INNER JOIN Salesforce.dbo.[User] AS U
		ON a.OwnerId = U.Id
	LEFT OUTER JOIN Salesforce.dbo.App_CDP__c c
		ON a.business_id = c.Id
	LEFT OUTER JOIN LocalWAProd.dbo.VitallyHealthScoreVehiclesInspecting vi
		ON a.business_id = vi.business_id
	LEFT OUTER JOIN Whiparound.dbo.TheNewHealthScore h
		ON 1 = 1
	WHERE U.Role_Name__c LIKE '%onboard%'
	AND a.Type = 'customer') AS T0
	WHERE T0.business_id= 33937
	ORDER BY T0.InitialSignupDate desc
