--CREATE VIEW dbo.VitallyHealthScoreServices
--AS
 

SELECT 
a.id, 
a.TotalVehiclesInServicePrograms AS TotalVehiclesInServicePrograms,
ISNULL(h.UniqueAssetsWithCompletedService, 0) AS TotalVehiclesWithCompletedService,
ISNULL(b.ServiceCnt, 0) AS totalservicescreated,
ISNULL(h.CompletedServiceCnt, 0) AS TotalCompletedServes,
ISNULL(b.UniqueAssets, 0) AS TotalUniqueAssetsWServes,
ISNULL(i.[Over Due], 0) AS TotalOverDue,
ISNULL(c.ServiceCnt, 0) AS ServicesCreatedLast90Days,
ISNULL(d.ServiceCnt, 0) AS ServicesCreatedLast30Days,
ISNULL(e.ServiceCnt, 0) AS ServicesCreatedLast7Days,
ISNULL(f.ServiceCnt, 0) AS ServicesCreatedYesterday,
ISNULL(j.ServiceCnt, 0) AS ServicesClosedLast90Days,
CASE WHEN ISNULL(b.ServiceCnt, 0) = 0 THEN CAST(0 AS DECIMAL) WHEN ISNULL(c.ServiceCnt, 0) = 0 THEN CAST(0 AS DECIMAL) ELSE  (CAST(ISNULL(c.ServiceCnt, 0) AS DECIMAL) / cast(b.ServiceCnt AS DECIMAL) ) * 100 END AS PercentOfVechiclesWithServiceLast90days,
CASE WHEN ISNULL(b.ServiceCnt, 0) = 0 THEN CAST(0 AS DECIMAL) WHEN ISNULL(d.ServiceCnt, 0) = 0 THEN CAST(0 AS DECIMAL) ELSE  (CAST(ISNULL(d.ServiceCnt, 0) AS DECIMAL) / cast(b.ServiceCnt AS DECIMAL) ) * 100 END AS PercentOfVechiclesWithServiceLast30days,
CASE WHEN ISNULL(b.ServiceCnt, 0) = 0 THEN CAST(0 AS DECIMAL) WHEN ISNULL(e.ServiceCnt, 0) = 0 THEN CAST(0 AS DECIMAL) ELSE  (CAST(ISNULL(e.ServiceCnt, 0) AS DECIMAL) / cast(b.ServiceCnt AS DECIMAL) ) * 100 END AS PercentOfVechiclesWithServiceLast7days,
CASE WHEN ISNULL(b.ServiceCnt, 0) = 0 THEN CAST(0 AS DECIMAL) WHEN ISNULL(f.ServiceCnt, 0) = 0 THEN CAST(0 AS DECIMAL) ELSE  (CAST(ISNULL(f.ServiceCnt, 0) AS DECIMAL) / cast(b.ServiceCnt AS DECIMAL) ) * 100 END AS PercentOfVechiclesWithServiceyeserday,
CASE WHEN ISNULL(b.ServiceCnt, 0) = 0 THEN CAST(0 AS DECIMAL) WHEN ISNULL(g.ServiceCnt, 0) = 0 THEN CAST(0 AS DECIMAL) ELSE  (CAST(ISNULL(g.ServiceCnt, 0) AS DECIMAL) / cast(b.ServiceCnt AS DECIMAL) ) * 100 END AS PercentOfVechiclesWithServiceAllTime,
CASE WHEN ISNULL(c.ServiceCnt, 0) = 0 THEN CAST(0 AS DECIMAL) WHEN ISNULL(i.[Over Due], 0) = 0 THEN CAST(100 AS DECIMAL) ELSE  (CAST(ISNULL(i.[Over Due], 0) AS DECIMAL) / cast(c.ServiceCnt AS DECIMAL) ) * 100 END AS PercentOverdueServicesBy90DayTotalInspections,
CASE WHEN ISNULL(c.serviceCnt, 0) = 0 THEN CAST(0 AS DECIMAL) WHEN ISNULL(j.servicecnt, 0) = 0 THEN CAST(0 AS decimal) ELSE (CAST(ISNULL(j.ServiceCnt, 0) AS DECIMAL) / cast(c.ServiceCnt AS DECIMAL) ) * 100 END PercentOfServicesOpenedvsClosed
FROM 
--get all business id's and the total number of unique assets in the service programs
(SELECT a.id
, COUNT(DISTINCT c.asset_id) AS TotalVehiclesInServicePrograms

FROM v2_businesses AS a 
LEFT OUTER JOIN v2_vehicles b ON a.id = b.business_id AND b.deleted_at IS NULL 
LEFT OUTER JOIN [dbo].[service_program_assets] AS c ON b.id = c.asset_id AND c.deleted_at IS NULL 
WHERE 
a.deleted_at IS NULL 

GROUP BY a.id) AS a

-- Get total services all time 
LEFT OUTER JOIN (SELECT DISTINCT 
	s.business_id,
   COUNT(s.id) AS ServiceCnt,
   COUNT(DISTINCT a.asset_id) AS UniqueAssets
FROM services s
LEFT OUTER JOIN v2_vehicles vv ON s.asset_id = vv.id AND vv.deleted_at IS NULL 
LEFT OUTER JOIN service_program_assets AS a ON s.asset_id = a.asset_id AND s.service_program_id = a.service_program_id AND a.deleted_at IS NULL 
WHERE s.deleted_at IS NULL
GROUP BY s.business_id)  AS b ON a.id = b.business_id


-- Get total services last 90 days 
LEFT OUTER JOIN (SELECT s.business_id, COUNT(id) AS ServiceCnt FROM services s
WHERE s.deleted_at IS NULL
AND CAST(s.created_at AS date) >= CAST(DATEADD(DAY, -90, getdate()) AS date)
GROUP BY s.business_id)  AS c ON a.id = c.business_id


-- Get total services last 30 days 
LEFT OUTER JOIN (SELECT s.business_id, COUNT(id) AS ServiceCnt FROM services s
WHERE s.deleted_at IS NULL
AND CAST(s.created_at AS date) >= CAST(DATEADD(DAY, -30, getdate()) AS date)
GROUP BY s.business_id)  AS d ON a.id = d.business_id

-- Get total services last 7 days 
LEFT OUTER JOIN (SELECT s.business_id, COUNT(id) AS ServiceCnt FROM services s
WHERE s.deleted_at IS NULL
AND CAST(s.created_at AS date) >= CAST(DATEADD(DAY, -7, getdate()) AS date)
GROUP BY s.business_id)  AS e ON a.id = e.business_id


-- Get total services Yesterday 
LEFT OUTER JOIN (SELECT s.business_id, COUNT(id) AS ServiceCnt FROM services s
WHERE s.deleted_at IS NULL
AND CAST(s.created_at AS date) >= CAST(DATEADD(DAY, -1, getdate()) AS date)
AND CAST(s.created_at AS date) < CAST(getdate() AS date)
GROUP BY s.business_id)  AS f ON a.id = f.business_id

-- Get total services all time 
LEFT OUTER JOIN (SELECT s.business_id, COUNT(id) AS ServiceCnt FROM services s
WHERE s.deleted_at IS NULL
GROUP BY s.business_id)  AS g ON a.id = g.business_id

-- Get total Completed services all time 
LEFT OUTER JOIN (SELECT DISTINCT 
	s.business_id,
   COUNT(s.id) AS CompletedServiceCnt,
   COUNT(DISTINCT a.asset_id) AS UniqueAssetsWithCompletedService
FROM services s
LEFT OUTER JOIN v2_vehicles vv ON s.asset_id = vv.id AND vv.deleted_at IS NULL 
LEFT OUTER JOIN service_program_assets AS a ON s.asset_id = a.asset_id AND s.service_program_id = a.service_program_id AND a.deleted_at IS NULL 
WHERE s.completion_date IS NOT NULL 

AND s.deleted_at IS NULL
--AND s.business_id = 6016
AND vv.deleted_at IS NULL
AND a.asset_id IS NOT NULL 
GROUP BY s.business_id)  AS h ON a.id = h.business_id

--Get overdue to and due soon services
LEFT OUTER JOIN VitallyGetServiceStatusClosedOverDuePivot AS i ON a.id = i.business_id

-- Get total closed services last 90 days 
LEFT OUTER JOIN (SELECT s.business_id, COUNT(id) AS ServiceCnt FROM services s
WHERE s.deleted_at IS NULL
AND s.completion_date >= CAST(DATEADD(DAY, -90, getdate()) AS date)
GROUP BY s.business_id)  AS j ON a.id = j.business_id