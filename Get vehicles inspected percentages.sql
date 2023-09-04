SELECT a.business_id, 
a.VehicleCnt AS TotalVehicleCNT,
ISNULL(b.InspectedVehicles, 0) AS UNIQUEVehiclesInspectingLast90Days,
ISNULL(c.InspectedVehicles, 0) AS UNIQUEVehiclesInspectingLast30Days,
ISNULL(d.InspectedVehicles, 0) AS UNIQUEVehiclesInspectingLast7Days,
ISNULL(e.InspectedVehicles, 0) AS UNIQUEVehiclesInspectingYesterday,
ISNULL(f.InspectedVehicles, 0) AS UNIQUEVehiclesInspectingAlltime,
CASE WHEN ISNULL(b.InspectedVehicles, 0) = 0 THEN CAST(0 AS DECIMAL) ELSE  (CAST(ISNULL(b.InspectedVehicles, 0) AS DECIMAL) / cast(a.VehicleCnt AS DECIMAL) ) * 100 END AS PercentOfVehiclesInspectingLast90days,
CASE WHEN ISNULL(c.InspectedVehicles, 0) = 0 THEN CAST(0 AS DECIMAL) ELSE  (CAST(ISNULL(c.InspectedVehicles, 0) AS DECIMAL) / cast(a.VehicleCnt AS DECIMAL) ) * 100 END AS PercentOfVehiclesInspectingLast30days,
CASE WHEN ISNULL(d.InspectedVehicles, 0) = 0 THEN CAST(0 AS DECIMAL) ELSE  (CAST(ISNULL(d.InspectedVehicles, 0) AS DECIMAL) / cast(a.VehicleCnt AS DECIMAL) ) * 100 END AS PercentOfVehiclesInspectingLast7days,
CASE WHEN ISNULL(e.InspectedVehicles, 0) = 0 THEN CAST(0 AS DECIMAL) ELSE  (CAST(ISNULL(e.InspectedVehicles, 0) AS DECIMAL) / cast(a.VehicleCnt AS DECIMAL) ) * 100 END AS PercentOfVehiclesInspectingYesterday,
CASE WHEN ISNULL(f.InspectedVehicles, 0) = 0 THEN CAST(0 AS DECIMAL) ELSE  (CAST(ISNULL(f.InspectedVehicles, 0) AS DECIMAL) / cast(a.VehicleCnt AS DECIMAL) ) * 100 END AS PercentOfVehiclesInspectingAllTime,
CASE WHEN ISNULL(c.InspectedVehicles, 0) = 0 THEN CAST(0 AS DECIMAL) ELSE  (CAST(ISNULL(c.InspectedVehicles, 0) AS DECIMAL) / cast(a.VehicleCnt AS DECIMAL) ) * 100 END - CASE WHEN ISNULL(b.InspectedVehicles, 0) = 0 THEN CAST(0 AS DECIMAL) ELSE  (CAST(ISNULL(b.InspectedVehicles, 0) AS DECIMAL) / cast(a.VehicleCnt AS DECIMAL) ) * 100 END  AS upordown

from
--Get all businesses from WA
(SELECT
	a.id AS business_id
	, COUNT(DISTINCT vv.id) AS VehicleCnt
FROM dbo.v2_businesses AS a
LEFT OUTER JOIN dbo.v2_vehicles vv ON a.id = vv.business_id
WHERE (vv.deleted_at IS NULL)
AND (a.deleted_at IS NULL)
--AND (a.sub_status IN ('active', 'trial'))
GROUP BY a.id
HAVING COUNT(DISTINCT vv.id) > 0
) AS a
LEFT OUTER JOIN --Get cnt of drivers last 90 days
(SELECT
	COUNT(DISTINCT v.id) AS InspectedVehicles
   ,d.business_id
FROM dbo.v2_reports AS i
LEFT OUTER JOIN dbo.v2_users AS d 	ON i.driver_id = d.driver_id
LEFT OUTER JOIN dbo.v2_vehicles AS v ON i.vehicle_id = v.id
LEFT OUTER JOIN dbo.v2_businesses AS a
	ON d.business_id = a.id
WHERE (d.deleted_at IS NULL)
AND (d.deleted_username IS NULL)
AND (i.deleted_at IS NULL)
AND v.deleted_at IS NULL 
--AND (a.sub_status IN ('active', 'trial'))
AND CAST(i.created_at AS DATE) >= CAST(DATEADD(DAY, -90, Getdate()) AS DATE)


GROUP BY D.business_id) AS B ON a.business_id = b.business_id

LEFT OUTER JOIN --Get cnt of drivers last 30 days
(SELECT
	COUNT(DISTINCT v.id) AS InspectedVehicles
   ,d.business_id
FROM dbo.v2_reports AS i
LEFT OUTER JOIN dbo.v2_users AS d 	ON i.driver_id = d.driver_id
LEFT OUTER JOIN dbo.v2_vehicles AS v ON i.vehicle_id = v.id
LEFT OUTER JOIN dbo.v2_businesses AS a
	ON d.business_id = a.id
WHERE (d.deleted_at IS NULL)
AND (d.deleted_username IS NULL)
AND (i.deleted_at IS NULL)
AND v.deleted_at IS NULL 
--AND (a.sub_status IN ('active', 'trial'))
AND CAST(i.created_at AS DATE) >= CAST(DATEADD(DAY, -30, Getdate()) AS DATE)
GROUP BY d.business_id) AS c ON a.business_id = c.business_id


LEFT OUTER JOIN --Get cnt of drivers last 7 days
(SELECT
	COUNT(DISTINCT v.id) AS InspectedVehicles
   ,d.business_id
FROM dbo.v2_reports AS i
LEFT OUTER JOIN dbo.v2_users AS d 	ON i.driver_id = d.driver_id
LEFT OUTER JOIN dbo.v2_vehicles AS v ON i.vehicle_id = v.id
LEFT OUTER JOIN dbo.v2_businesses AS a
	ON d.business_id = a.id
WHERE (d.deleted_at IS NULL)
AND (d.deleted_username IS NULL)
AND (i.deleted_at IS NULL)
AND v.deleted_at IS NULL 
--AND (a.sub_status IN ('active', 'trial'))
AND CAST(i.created_at AS DATE) >= CAST(DATEADD(DAY, -7, Getdate()) AS DATE)
GROUP BY d.business_id) AS d ON a.business_id = d.business_id


LEFT OUTER JOIN --Get cnt of drivers yesterday
(SELECT
	COUNT(DISTINCT v.id) AS InspectedVehicles
   ,d.business_id
FROM dbo.v2_reports AS i
LEFT OUTER JOIN dbo.v2_users AS d 	ON i.driver_id = d.driver_id
LEFT OUTER JOIN dbo.v2_vehicles AS v ON i.vehicle_id = v.id
LEFT OUTER JOIN dbo.v2_businesses AS a
	ON d.business_id = a.id
WHERE (d.deleted_at IS NULL)
AND (d.deleted_username IS NULL)
AND (i.deleted_at IS NULL)
AND v.deleted_at IS NULL 
--AND (a.sub_status IN ('active', 'trial'))
AND CAST(i.created_at AS DATE) >= CAST(DATEADD(DAY, -1, Getdate()) AS DATE)
AND CAST(i.created_at AS DATE) < CAST(Getdate() AS DATE)
GROUP BY d.business_id) AS e ON a.business_id = e.business_id

LEFT OUTER JOIN --Get cnt of drivers yesterday
(SELECT
	COUNT(DISTINCT v.id) AS InspectedVehicles
   ,d.business_id
FROM dbo.v2_reports AS i
LEFT OUTER JOIN dbo.v2_users AS d 	ON i.driver_id = d.driver_id
LEFT OUTER JOIN dbo.v2_vehicles AS v ON i.vehicle_id = v.id
LEFT OUTER JOIN dbo.v2_businesses AS a
	ON d.business_id = a.id
WHERE (d.deleted_at IS NULL)
AND (d.deleted_username IS NULL)
AND (i.deleted_at IS NULL)
AND v.deleted_at IS NULL 
--AND (a.sub_status IN ('active', 'trial'))
GROUP BY d.business_id) AS f ON a.business_id = f.business_id


WHERE a.business_id in (19581,
10742,
13862,
26296,
19096,
5104,
19503,
19251,
18722,
18007,
8461,
7756,
6726,
31312,
31064,
30770,
29689
)
ORDER BY CASE WHEN ISNULL(c.InspectedVehicles, 0) = 0 THEN CAST(0 AS DECIMAL) ELSE  (CAST(ISNULL(c.InspectedVehicles, 0) AS DECIMAL) / cast(a.VehicleCnt AS DECIMAL) ) * 100 END - CASE WHEN ISNULL(b.InspectedVehicles, 0) = 0 THEN CAST(0 AS DECIMAL) ELSE  (CAST(ISNULL(b.InspectedVehicles, 0) AS DECIMAL) / cast(a.VehicleCnt AS DECIMAL) ) * 100 END