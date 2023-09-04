SELECT 
a.id AS salesforceId
,ta.business_id
--,ta.TotalAssets
--,td.TotalAssetsWithDefects
,CASE WHEN td.TotalAssetsWithDefects IS NULL THEN 0 ELSE CAST(td.TotalAssetsWithDefects AS DECIMAL) / CAST(ta.TotalAssets AS DECIMAL) END AS PercentOfVehiclesWithDefects
, s6m.VehicleCntWithService6Month
, s12m.VehicleCntWithService12Month
, ISNULL(o.NumberOfOverdue, 0) AS TotalOverDue
, ISNULL(wo.WorkOrders, 0) AS TotalWorkOrders
FROM 
Salesforce.dbo.Account a
LEFT OUTER JOIN 
(
SELECT business_id	
	   ,COUNT(DISTINCT id ) AS TotalAssets
	FROM LocalWAProd.dbo.v2_vehicles vv
	WHERE deleted_at IS NULL
	GROUP BY vv.business_id
	) AS TA ON a.AppID__c = ta.business_id

	LEFT OUTER JOIN (
	SELECT vv.business_id,
COUNT(DISTINCT vf.vehicle_id) AS TotalAssetsWithDefects
--COUNT(DISTINCT spa.asset_id) AS VehicleCntWithService
  FROM [LocalWAProd].[dbo].[v2_faults] AS vf
  INNER JOIN LocalWAProd.dbo.v2_vehicles vv ON vf.vehicle_id = vv.id
  WHERE vf.deleted_at IS NULL 
  AND (vf.created_at >= DATEADD(DAY, -183, GETDATE()))
  GROUP BY vv.business_id
) AS TD ON a.AppID__c = td.business_id
LEFT OUTER JOIN (SELECT s.business_id, 
COUNT(s.asset_id) AS VehicleCntWithService6Month
  FROM [LocalWAProd].[dbo].[services] AS s
  --INNER JOIN LocalWAProd.dbo.v2_vehicles vv ON spa.asset_id = vv.id
  WHERE s.deleted_at IS NULL 
  AND created_at >= DATEADD(month, -6, getdate())
GROUP BY s.business_id) AS s6m ON a.AppID__c = s6m.business_id
LEFT OUTER JOIN (SELECT s.business_id, 
COUNT(s.asset_id) AS VehicleCntWithService12Month
  FROM [LocalWAProd].[dbo].[services] AS s
  --INNER JOIN LocalWAProd.dbo.v2_vehicles vv ON spa.asset_id = vv.id
  WHERE s.deleted_at IS NULL 
  AND created_at >= DATEADD(month, -12, getdate())
GROUP BY s.business_id) AS s12m ON a.AppID__c = s12m.business_id
LEFT OUTER JOIN (SELECT [business_id]
      ,CASE WHEN [service_status] = 0 THEN 'New' 
	  WHEN [service_status] = 1 THEN 'Due Soon'
	  WHEN [service_status] = 2 THEN 'Over Due' 
	  ELSE 'Closed' END AS ServiceState
	  , COUNT(service_id) NumberOfOverdue
  FROM [LocalWAProd].[dbo].[service_status_view]
  where CASE WHEN [service_status] = 0 THEN 'New' 
	  WHEN [service_status] = 1 THEN 'Due Soon'
	  WHEN [service_status] = 2 THEN 'Over Due' 
	  ELSE 'Closed' END = 'Over Due'
  GROUP BY [business_id]
      ,CASE WHEN [service_status] = 0 THEN 'New' 
	  WHEN [service_status] = 1 THEN 'Due Soon'
	  WHEN [service_status] = 2 THEN 'Over Due' 
	  ELSE 'Closed' END) AS o ON a.AppID__c = o.business_id
	LEFT OUTER JOIN (SELECT
	business_id
   ,COUNT(id) AS WorkOrders
FROM LocalWAProd.dbo.[work_orders]
WHERE deleted_at IS NULL
AND created_at >= DATEADD(MONTH, -6, GETDATE())
GROUP BY business_id) AS wo ON a.AppID__c = wo.business_id
WHERE a.Type = 'Customer'
AND ta.business_id IS NOT NULL 