SELECT
	Z0.created_at
   ,Z1.business_id
   ,COUNT(*) OVER (ORDER BY Z0.created_at ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS DriversInspecting
   ,z2.CntDriver AS TotalDrivers
   , (CAST(COUNT(*) OVER (ORDER BY Z0.created_at ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS DECIMAL)  / CAST(z2.CntDriver AS DECIMAL)) *100 AS DriversinspectPercent
FROM (SELECT DISTINCT
		CAST(vr.created_at AS DATE) AS created_at
	FROM LocalWAProd.dbo.v2_reports vr) AS Z0
LEFT OUTER JOIN (SELECT
		T0.business_id
	   ,MIN(T0.CreatedAtDate) AS FirstInspection
	   ,T0.driver_id

	FROM (SELECT DISTINCT
			CAST(i.created_at AS DATE) AS CreatedAtDate
		   ,i.driver_id
		   ,i.business_id
		FROM LocalWAProd.dbo.v2_reports AS i
		LEFT OUTER JOIN LocalWAProd.dbo.v2_users AS d
			ON i.driver_id = d.driver_id
		LEFT OUTER JOIN LocalWAProd.dbo.v2_businesses AS a
			ON d.business_id = a.id
		WHERE (d.deleted_at IS NULL)
		AND (d.deleted_username IS NULL)
		AND (i.deleted_at IS NULL)
		AND (a.sub_status IN ('active', 'trial'))) AS T0
	--INNER JOIN Salesforce.dbo.account AS a ON t0.business_id = a.AppID__c
	--INNER JOIN (SELECT a.id AS business_id, Drivers AS CntDriver FROM LocalWAProd.[dbo].[CDPGetDrivers] AS a ) AS t1 ON t0.business_id = t1.business_id
	WHERE T0.business_id = 81
	GROUP BY T0.business_id
			,T0.driver_id) AS Z1
	ON Z0.created_at = Z1.FirstInspection
LEFT OUTER JOIN (SELECT
		a.id AS business_id
	   ,Drivers AS CntDriver
	FROM LocalWAProd.[dbo].[CDPGetDrivers] AS a) AS z2
	ON Z1.business_id = z2.business_id

WHERE Z1.driver_id IS NOT NULL 
