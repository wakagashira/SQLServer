SELECT DISTINCT 
	Z0.created_at
   ,Z1.business_id
   ,COUNT(z1.driver_id) OVER (PARTITION BY Z1.business_id ORDER BY z1.business_id, Z0.created_at ) AS DriversInspecting
   ,z2.drivers AS TotalDrivers
   ,(CAST(COUNT(z1.driver_id) OVER (PARTITION BY Z1.business_id ORDER BY z1.business_id, Z0.created_at ) AS DECIMAL) / CAST(z2.Drivers AS DECIMAL)) * 100 AS DriversInspectPercentage 
   , z3.pISU__c
   , CASE WHEN z3.pISU__c IS NULL THEN NULL ELSE  DATEDIFF(DAY, Z0.created_at, z3.pISU__c) end AS DAYSToGetToPercent 
FROM (SELECT DISTINCT
		CAST(vr.created_at AS DATE) AS created_at
	FROM LocalWAProd.dbo.v2_reports vr) AS Z0
INNER JOIN (SELECT
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
		INNER Join LocalWAProd.dbo.v2_businesses AS a
			ON d.business_id = a.id AND a.salesforce_account_id IS NOT NULL 
		WHERE (d.deleted_at IS NULL)
		AND (d.deleted_username IS NULL)
		AND (i.deleted_at IS NULL)
		AND (a.sub_status IN ('active', 'trial'))
		) AS T0
--WHERE T0.business_id in (112, 6554)
	GROUP BY T0.business_id
			,T0.driver_id) AS Z1 ON Z0.created_at = Z1.FirstInspection
INNER JOIN LocalWAProd.dbo.[CDPGetDrivers] AS Z2 ON Z1.business_id = z2.id
INNER JOIN Salesforce.dbo.account AS z3 ON z1.business_id = z3.AppID__c AND z3.AppID__c !='TRUE'
	WHERE z1.business_id IS NOT NULL 