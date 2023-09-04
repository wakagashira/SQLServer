SELECT
	pvt.business_id
	,pvt.pISU__c AS initialsignupdate
   ,pvt.salesforce_account_id
   ,U.name AS OnboardingSp
   ,CASE WHEN pvt.[0] IS NULL AND pvt.[10] IS NOT NULL THEN pvt.[10]
WHEN pvt.[0] IS NULL AND pvt.[20] IS NOT NULL THEN pvt.[20]
WHEN pvt.[0] IS NULL AND pvt.[30] IS NOT NULL THEN pvt.[30]
WHEN pvt.[0] IS NULL AND pvt.[40] IS NOT NULL THEN pvt.[40]
WHEN pvt.[0] IS NULL AND pvt.[50] IS NOT NULL THEN pvt.[50]
WHEN pvt.[0] IS NULL AND pvt.[60] IS NOT NULL THEN pvt.[60]
WHEN pvt.[0] IS NULL AND pvt.[70] IS NOT NULL THEN pvt.[70]
WHEN pvt.[0] IS NULL AND pvt.[80] IS NOT NULL THEN pvt.[80]
WHEN pvt.[0] IS NULL AND pvt.[90] IS NOT NULL THEN pvt.[90]
WHEN pvt.[0] IS NULL AND pvt.[100] IS NOT NULL THEN pvt.[100]
ELSE pvt.[0] END AS DaysToFirstInspection,
CASE 
WHEN pvt.[10] IS NULL AND pvt.[20] IS NOT NULL THEN pvt.[20]
WHEN pvt.[10] IS NULL AND pvt.[30] IS NOT NULL THEN pvt.[30]
WHEN pvt.[10] IS NULL AND pvt.[40] IS NOT NULL THEN pvt.[40]
WHEN pvt.[10] IS NULL AND pvt.[50] IS NOT NULL THEN pvt.[50]
WHEN pvt.[10] IS NULL AND pvt.[60] IS NOT NULL THEN pvt.[60]
WHEN pvt.[10] IS NULL AND pvt.[70] IS NOT NULL THEN pvt.[70]
WHEN pvt.[10] IS NULL AND pvt.[80] IS NOT NULL THEN pvt.[80]
WHEN pvt.[10] IS NULL AND pvt.[90] IS NOT NULL THEN pvt.[90]
WHEN pvt.[10] IS NULL AND pvt.[100] IS NOT NULL THEN pvt.[100]
ELSE pvt.[10] END AS DaysTo10Percent,
CASE 
WHEN pvt.[20] IS NULL AND pvt.[30] IS NOT NULL THEN pvt.[30]
WHEN pvt.[20] IS NULL AND pvt.[40] IS NOT NULL THEN pvt.[40]
WHEN pvt.[20] IS NULL AND pvt.[50] IS NOT NULL THEN pvt.[50]
WHEN pvt.[20] IS NULL AND pvt.[60] IS NOT NULL THEN pvt.[60]
WHEN pvt.[20] IS NULL AND pvt.[70] IS NOT NULL THEN pvt.[70]
WHEN pvt.[20] IS NULL AND pvt.[80] IS NOT NULL THEN pvt.[80]
WHEN pvt.[20] IS NULL AND pvt.[90] IS NOT NULL THEN pvt.[90]
WHEN pvt.[20] IS NULL AND pvt.[100] IS NOT NULL THEN pvt.[100]
ELSE pvt.[20] END AS DaysTo20Percent,
CASE 
WHEN pvt.[30] IS NULL AND pvt.[40] IS NOT NULL THEN pvt.[40]
WHEN pvt.[30] IS NULL AND pvt.[50] IS NOT NULL THEN pvt.[50]
WHEN pvt.[30] IS NULL AND pvt.[60] IS NOT NULL THEN pvt.[60]
WHEN pvt.[30] IS NULL AND pvt.[70] IS NOT NULL THEN pvt.[70]
WHEN pvt.[30] IS NULL AND pvt.[80] IS NOT NULL THEN pvt.[80]
WHEN pvt.[30] IS NULL AND pvt.[90] IS NOT NULL THEN pvt.[90]
WHEN pvt.[30] IS NULL AND pvt.[100] IS NOT NULL THEN pvt.[100]
ELSE pvt.[30] END AS DaysTo30Percent,
CASE 
WHEN pvt.[40] IS NULL AND pvt.[50] IS NOT NULL THEN pvt.[50]
WHEN pvt.[40] IS NULL AND pvt.[60] IS NOT NULL THEN pvt.[60]
WHEN pvt.[40] IS NULL AND pvt.[70] IS NOT NULL THEN pvt.[70]
WHEN pvt.[40] IS NULL AND pvt.[80] IS NOT NULL THEN pvt.[80]
WHEN pvt.[40] IS NULL AND pvt.[90] IS NOT NULL THEN pvt.[90]
WHEN pvt.[40] IS NULL AND pvt.[100] IS NOT NULL THEN pvt.[100]
ELSE pvt.[40] END AS DaysTo40Percent,
CASE 
WHEN pvt.[50] IS NULL AND pvt.[60] IS NOT NULL THEN pvt.[60]
WHEN pvt.[50] IS NULL AND pvt.[70] IS NOT NULL THEN pvt.[70]
WHEN pvt.[50] IS NULL AND pvt.[80] IS NOT NULL THEN pvt.[80]
WHEN pvt.[50] IS NULL AND pvt.[90] IS NOT NULL THEN pvt.[90]
WHEN pvt.[50] IS NULL AND pvt.[100] IS NOT NULL THEN pvt.[100]
ELSE pvt.[50] END AS DaysTo50Percent,
CASE 
WHEN pvt.[60] IS NULL AND pvt.[70] IS NOT NULL THEN pvt.[70]
WHEN pvt.[60] IS NULL AND pvt.[80] IS NOT NULL THEN pvt.[80]
WHEN pvt.[60] IS NULL AND pvt.[90] IS NOT NULL THEN pvt.[90]
WHEN pvt.[60] IS NULL AND pvt.[100] IS NOT NULL THEN pvt.[100]
ELSE pvt.[60] END AS DaysTo60Percent,
CASE 
WHEN pvt.[70] IS NULL AND pvt.[80] IS NOT NULL THEN pvt.[80]
WHEN pvt.[70] IS NULL AND pvt.[90] IS NOT NULL THEN pvt.[90]
WHEN pvt.[70] IS NULL AND pvt.[100] IS NOT NULL THEN pvt.[100]
ELSE pvt.[70] END AS DaysTo70Percent,
CASE 
WHEN pvt.[80] IS NULL AND pvt.[90] IS NOT NULL THEN pvt.[90]
WHEN pvt.[80] IS NULL AND pvt.[100] IS NOT NULL THEN pvt.[100]
ELSE pvt.[80] END AS DaysTo80Percent,
CASE 
WHEN pvt.[90] IS NULL AND pvt.[100] IS NOT NULL THEN pvt.[100]
ELSE pvt.[90] END AS DaysTo90Percent,
pvt.[100] AS DaysTo100Percent
FROM (SELECT
		*
	FROM (SELECT
			x1.business_id
		   ,x1.salesforce_account_id
		   ,x1.Name
		   ,x1.vehicleInspectPercentageRound
		   ,x1.pISU__c
		   ,MIN(x1.DAYSToGetToPercent) AS DaysToGetPercent
		FROM (SELECT DISTINCT
				Z0.date
			   ,Z1.business_id
			   ,Z1.salesforce_account_id
			   ,Z1.Name
			   ,COUNT(Z1.vehicle_id) OVER (PARTITION BY Z1.business_id
				ORDER BY Z1.business_id, Z0.date) AS vehiclesInspecting
			   ,Z2.Assets AS Totalvehicles
			   ,(CAST(COUNT(Z1.vehicle_id) OVER (PARTITION BY Z1.business_id
				ORDER BY Z1.business_id, Z0.date) AS DECIMAL) / CAST(Z2.assets AS DECIMAL)) * 100 AS vehiclesInspectPercentage
			   ,ROUND(CAST(((CAST(COUNT(Z1.vehicle_id) OVER (PARTITION BY Z1.business_id
				ORDER BY Z1.business_id, Z0.date) AS DECIMAL) / CAST(Z2.assets AS DECIMAL)) * 100) AS INT), -1, 1) AS vehicleInspectPercentageRound
			   ,z3.pISU__c
			   ,CASE
					WHEN z3.pISU__c IS NULL THEN NULL
					ELSE DATEDIFF(DAY, z3.pISU__c, Z0.date)
				END AS DAYSToGetToPercent
			FROM LocalWAProd.dbo.calendar AS Z0
			INNER JOIN (SELECT
					T0.business_id
				   ,MIN(T0.CreatedAtDate) AS FirstInspection
				   ,T0.vehicle_id
				   ,T0.salesforce_account_id
				   ,T0.Name
				FROM (SELECT DISTINCT
						CAST(i.created_at AS DATE) AS CreatedAtDate
					   ,i.vehicle_id
					   ,i.business_id
					   ,a.salesforce_account_id
					   ,a.Name
					FROM LocalWAProd.dbo.v2_reports AS i
					LEFT OUTER JOIN LocalWAProd.dbo.v2_vehicles AS d
						ON i.vehicle_id = d.Id
					INNER JOIN LocalWAProd.dbo.v2_businesses AS a
						ON i.business_id = a.Id
						AND a.salesforce_account_id IS NOT NULL
					WHERE (d.deleted_at IS NULL)
					AND (i.deleted_at IS NULL)
					AND (a.sub_status IN ('active', 'trial'))) AS T0
				/*WHERE T0.business_id in (120)*/ GROUP BY T0.business_id
														  ,T0.vehicle_id
														  ,T0.salesforce_account_id
														  ,T0.Name) AS Z1
				ON Z0.date = Z1.FirstInspection
			INNER JOIN [dbo].[CDPGetVehicles] AS Z2
				ON Z1.business_id = Z2.Id
			INNER JOIN Salesforce.dbo.Account AS z3
				ON Z1.business_id = z3.AppID__c
				AND z3.AppID__c != 'TRUE'
			WHERE Z1.business_id IS NOT NULL) AS x1
			--WHERE x1.business_id = 1769
		GROUP BY x1.business_id
				,x1.salesforce_account_id
				,x1.Name
				,x1.vehicleInspectPercentageRound
				,x1.pISU__c) AS Y1) AS Y2 PIVOT (MIN(Y2.DaysToGetPercent) FOR Y2.vehicleInspectPercentageRound IN ([0], [10], [20], [30], [40], [50], [60], [70], [80], [90], [100])) AS pvt

			LEFT OUTER JOIN  Salesforce.dbo.account AS a ON pvt.salesforce_account_id = a.Id
			LEFT OUTER JOIN Salesforce.dbo.[USER] AS u ON a.Onboarding_Specialist_UserLook__c = u.id

			ORDER BY initialsignupdate desc