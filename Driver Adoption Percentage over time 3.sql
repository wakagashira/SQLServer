SELECT c1.business_id
,c1.salesforce_account_id
, c1.name
, CASE WHEN  c1.[0]


FROM 
(SELECT pvt.business_id
, pvt.salesforce_account_id
, pvt.name
, pvt.[0], pvt.[10], pvt.[20], pvt.[30], pvt.[40], pvt.[50], pvt.[60], pvt.[70], pvt.[80], pvt.[90], pvt.[100] 

FROM (


SELECT * FROM
(SELECT x1.business_id
, x1.salesforce_account_id
, x1.name
, x1.DriverInspectPercentageRound
,   x1.pISU__c
, MIN(x1.DAYSToGetToPercent) AS DaysToGetPercent

FROM 


(SELECT DISTINCT 
	Z0.date
   ,Z1.business_id
   ,z1.salesforce_account_id
   ,z1.name
   ,COUNT(z1.driver_id) OVER (PARTITION BY Z1.business_id ORDER BY z1.business_id, Z0.date ) AS DriversInspecting
   ,z2.drivers AS TotalDrivers
   ,(CAST(COUNT(z1.driver_id) OVER (PARTITION BY Z1.business_id ORDER BY z1.business_id, Z0.date ) AS DECIMAL) / CAST(z2.Drivers AS DECIMAL)) * 100 AS DriversInspectPercentage 
   , round(CAST(((CAST(COUNT(z1.driver_id) OVER (PARTITION BY Z1.business_id ORDER BY z1.business_id, Z0.date ) AS DECIMAL) / CAST(z2.Drivers AS DECIMAL)) * 100) AS INT), -1, 1 ) AS DriverInspectPercentageRound
   , z3.pISU__c
   , CASE WHEN z3.pISU__c IS NULL THEN NULL ELSE  DATEDIFF(DAY, z3.pISU__c, Z0.date) end AS DAYSToGetToPercent 
FROM LocalWAProd.dbo.calendar AS Z0
INNER JOIN (SELECT
		T0.business_id
	   ,MIN(T0.CreatedAtDate) AS FirstInspection
	   ,T0.driver_id
	   ,t0.salesforce_account_id
	   ,t0.name

	FROM (SELECT DISTINCT
			CAST(i.created_at AS DATE) AS CreatedAtDate
		   ,i.driver_id
		   ,i.business_id
		   ,a.salesforce_account_id
		   ,a.name
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
--WHERE T0.business_id in (120)
	GROUP BY T0.business_id
			,T0.driver_id
			,t0.salesforce_account_id
	   ,t0.name) AS Z1 ON Z0.date = Z1.FirstInspection
INNER JOIN LocalWAProd.dbo.[CDPGetDrivers] AS Z2 ON Z1.business_id = z2.id
INNER JOIN Salesforce.dbo.account AS z3 ON z1.business_id = z3.AppID__c AND z3.AppID__c !='TRUE'
	WHERE z1.business_id IS NOT NULL ) AS x1
	GROUP BY x1.business_id
, x1.salesforce_account_id
, x1.name
, x1.DriverInspectPercentageRound
,   x1.pISU__c) AS Y1) AS Y2

	PIVOT
	(
	MIN(y2.DaysToGetPercent) 
	FOR y2.DriverInspectPercentageRound IN ([0], [10], [20], [30], [40], [50], [60], [70], [80], [90], [100])
	) AS pvt
--	WHERE pvt.business_id = 120
--	GROUP BY pvt.business_id, pvt.salesforce_account_id, pvt.name
	--ORDER BY pvt.business_id
	) AS c1