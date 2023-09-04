SELECT a.id AS business_id
, a.TotalVehiclesInServicePrograms
, c.UniqueVehicles
, CASE WHEN ISNULL(c.UniqueVehicles, 0) = 0 THEN 0 
WHEN ISNULL(a.TotalVehiclesInServicePrograms, 0) = 0 THEN 0 ELSE  CAST(c.UniqueVehicles AS DECIMAL(14,4)) / CAST(a.TotalVehiclesInServicePrograms AS DECIMAL(14,4)) END AS q2
, acc.id AS SFID
FROM 
(
	SELECT
		a.id
	   ,COUNT(DISTINCT c.asset_id) AS TotalVehiclesInServicePrograms
	FROM dbo.v2_businesses AS a
	LEFT OUTER JOIN dbo.v2_vehicles AS b
		ON a.id = b.business_id
		AND b.deleted_at IS NULL
	LEFT OUTER JOIN dbo.service_program_assets AS c
		ON b.id = c.asset_id
		AND c.deleted_at IS NULL
	WHERE (a.deleted_at IS NULL)
	AND b.created_at <= '07-06-2023'
	GROUP BY a.id) AS a 
	
	LEFT OUTER JOIN (SELECT
		business_id
	   ,COUNT(id) AS ServiceCnt
	   ,COUNT(DISTINCT asset_id) AS UniqueVehicles
	FROM dbo.services AS s
	WHERE (deleted_at IS NULL)
	AND (CAST(created_at AS DATE)) >= '04-07-2023' 
	AND (CAST(created_at AS DATE)) <= '07-06-2023' 
	GROUP BY business_id) AS C
ON a.id = c.business_id
LEFT OUTER JOIN salesforce.dbo.App_CDP__c acc ON a.id = acc.WA_group_Id__c
--WHERE a.id = 20241
WHERE acc.id IS NOT NULL 