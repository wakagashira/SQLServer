SELECT
	A1.TotalAccounts
   ,COUNT(A2.DaysToFirstInspection) AS InspcntFirst
   , (CAST(COUNT(A2.DaysToFirstInspection) AS DECIMAL) / CAST(A1.TotalAccounts AS DECIMAL)) * 100 AS PERCENTThatGet1OrMoreInspections
   , (CAST(COUNT(A2.DaysTo10Percent) AS DECIMAL) / CAST(A1.TotalAccounts AS DECIMAL)) * 100 AS PERCENTThatGet10PercentMoreInspections
   , (CAST(COUNT(A2.DaysTo20Percent) AS DECIMAL) / CAST(A1.TotalAccounts AS DECIMAL)) * 100 AS PERCENTThatGet20PercentMoreInspections
   , (CAST(COUNT(A2.DaysTo30Percent) AS DECIMAL) / CAST(A1.TotalAccounts AS DECIMAL)) * 100 AS PERCENTThatGet30PercentMoreInspections
   , (CAST(COUNT(A2.DaysTo40Percent) AS DECIMAL) / CAST(A1.TotalAccounts AS DECIMAL)) * 100 AS PERCENTThatGet40PercentMoreInspections
   , (CAST(COUNT(A2.DaysTo50Percent) AS DECIMAL) / CAST(A1.TotalAccounts AS DECIMAL)) * 100 AS PERCENTThatGet50PercentMoreInspections
   , (CAST(COUNT(A2.DaysTo60Percent) AS DECIMAL) / CAST(A1.TotalAccounts AS DECIMAL)) * 100 AS PERCENTThatGet60PercentMoreInspections
   , (CAST(COUNT(A2.DaysTo70Percent) AS DECIMAL) / CAST(A1.TotalAccounts AS DECIMAL)) * 100 AS PERCENTThatGet70PercentMoreInspections
   , (CAST(COUNT(A2.DaysTo80Percent) AS DECIMAL) / CAST(A1.TotalAccounts AS DECIMAL)) * 100 AS PERCENTThatGet80PercentMoreInspections
   , (CAST(COUNT(A2.DaysTo90Percent) AS DECIMAL) / CAST(A1.TotalAccounts AS DECIMAL)) * 100 AS PERCENTThatGet90PercentMoreInspections
   , (CAST(COUNT(A2.DaysTo100Percent) AS DECIMAL) / CAST(A1.TotalAccounts AS DECIMAL)) * 100 AS PERCENTThatGet100PercentMoreInspections
FROM (SELECT
		COUNT(id) TotalAccounts
	FROM Salesforce.dbo.Account
	WHERE pISU__c >= DATEADD(MONTH, -12, GETDATE())
	AND Type = 'customer') AS A1
LEFT OUTER JOIN LocalWAProd.dbo.CDPGetBusinessAdoptionDriversInspectingPercentagePivoted AS A2
	ON 1 = 1
	--	AND A2.WABusinessId = 32221
GROUP BY A1.TotalAccounts;


