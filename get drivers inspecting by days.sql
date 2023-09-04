
SELECT a.business_id, 
a.TotalDrivers,
ISNULL(f.InspDrivCt, 0) AS DriversInspectingLast90Days,
ISNULL(b.InspDrivCt, 0) AS DriversInspectingLast30Days,
ISNULL(c.InspDrivCt, 0) AS DriversInspectingLast7Days,
ISNULL(d.InspDrivCt, 0) AS DriversInspectingYesterday,
ISNULL(e.InspDrivCt, 0) AS DriversInspectingAllTime,
CASE WHEN ISNULL(f.InspDrivCt, 0) = 0 THEN CAST(0 AS DECIMAL) ELSE  (CAST(ISNULL(f.InspDrivCt, 0) AS DECIMAL) / cast(a.totaldrivers AS DECIMAL) ) * 100 END AS PercentDriversInspectingLast90days, 
CASE WHEN ISNULL(b.InspDrivCt, 0) = 0 THEN CAST(0 AS DECIMAL) ELSE  (CAST(ISNULL(b.InspDrivCt, 0) AS DECIMAL) / cast(a.totaldrivers AS DECIMAL) ) * 100 END AS PercentDriversInspectingLast30days, 
CASE WHEN ISNULL(c.InspDrivCt, 0) = 0 THEN CAST(0 AS DECIMAL) ELSE  (CAST(ISNULL(c.InspDrivCt, 0) AS DECIMAL) / cast(a.totaldrivers AS DECIMAL) ) * 100 END AS PercentDriversInspectingLast7days,
CASE WHEN ISNULL(d.InspDrivCt, 0) = 0 THEN CAST(0 AS DECIMAL) ELSE  (CAST(ISNULL(d.InspDrivCt, 0) AS DECIMAL) / cast(a.totaldrivers AS DECIMAL) ) * 100 END AS PercentDriversInspectingyesterday,
CASE WHEN ISNULL(e.InspDrivCt, 0) = 0 THEN CAST(0 AS DECIMAL) ELSE  (CAST(ISNULL(e.InspDrivCt, 0) AS DECIMAL) / cast(a.totaldrivers AS DECIMAL) ) * 100 END AS PercentDriversInspectingAllTime

from
--Get all businesses from WA
(SELECT
	COUNT(DISTINCT d.driver_id) AS TotalDrivers
   ,d.business_id
FROM dbo.v2_businesses AS a
LEFT OUTER JOIN dbo.v2_users AS d 	ON a.id = d.business_id
WHERE (d.deleted_at IS NULL)
AND (d.deleted_username IS NULL)
AND (a.deleted_at IS NULL)
AND d.driver_id IS NOT NULL 
--AND (a.sub_status IN ('active', 'trial'))
GROUP BY d.business_id
) AS a
LEFT OUTER JOIN --Get cnt of drivers last 30 days
(SELECT
	COUNT(DISTINCT i.driver_id) AS InspDrivCt
   ,d.business_id
FROM dbo.v2_reports AS i
LEFT OUTER JOIN dbo.v2_users AS d 	ON i.driver_id = d.driver_id
LEFT OUTER JOIN dbo.v2_businesses AS a
	ON d.business_id = a.id
WHERE (d.deleted_at IS NULL)
AND (d.deleted_username IS NULL)
AND (i.deleted_at IS NULL)
--AND (a.sub_status IN ('active', 'trial'))
AND CAST(i.created_at AS DATE) >= CAST(DATEADD(DAY, -30, Getdate()) AS DATE)
GROUP BY d.business_id) AS B ON a.business_id = b.business_id
LEFT OUTER JOIN --Get cnt of drivers last 7 days
(SELECT
	COUNT(DISTINCT i.driver_id) AS InspDrivCt
   ,d.business_id
FROM dbo.v2_reports AS i
LEFT OUTER JOIN dbo.v2_users AS d 	ON i.driver_id = d.driver_id
LEFT OUTER JOIN dbo.v2_businesses AS a
	ON d.business_id = a.id
WHERE (d.deleted_at IS NULL)
AND (d.deleted_username IS NULL)
AND (i.deleted_at IS NULL)
--AND (a.sub_status IN ('active', 'trial'))
AND CAST(i.created_at AS DATE) >= CAST(DATEADD(DAY, -7, Getdate()) AS DATE)
AND CAST(i.created_at AS DATE) < CAST(Getdate() AS date)
GROUP BY d.business_id) AS C ON a.business_id = c.business_id
LEFT OUTER JOIN --Get cnt of drivers all time 
(SELECT
	COUNT(DISTINCT i.driver_id) AS InspDrivCt
   ,d.business_id
FROM dbo.v2_reports AS i
LEFT OUTER JOIN dbo.v2_users AS d 	ON i.driver_id = d.driver_id
LEFT OUTER JOIN dbo.v2_businesses AS a
	ON d.business_id = a.id
WHERE (d.deleted_at IS NULL)
AND (d.deleted_username IS NULL)
AND (i.deleted_at IS NULL)
--AND (a.sub_status IN ('active', 'trial'))
AND CAST(i.created_at AS DATE) >= CAST(DATEADD(DAY, -1, Getdate()) AS DATE)
GROUP BY d.business_id) AS d ON a.business_id = d.business_id
LEFT OUTER JOIN (SELECT        COUNT(DISTINCT i.driver_id) AS InspDrivCt, d.business_id
FROM            dbo.v2_reports AS i LEFT OUTER JOIN
                         dbo.v2_users AS d ON i.driver_id = d.driver_id LEFT OUTER JOIN
                         dbo.v2_businesses AS a ON d.business_id = a.id
WHERE        (d.deleted_at IS NULL) AND (d.deleted_username IS NULL) AND (i.deleted_at IS NULL) 
GROUP BY d.business_id) AS e ON a.business_id = e.business_id
LEFT OUTER JOIN  --Get cnt of drivers last 90 days
(SELECT
	COUNT(DISTINCT i.driver_id) AS InspDrivCt
   ,d.business_id
FROM dbo.v2_reports AS i
LEFT OUTER JOIN dbo.v2_users AS d 	ON i.driver_id = d.driver_id
LEFT OUTER JOIN dbo.v2_businesses AS a
	ON d.business_id = a.id
WHERE (d.deleted_at IS NULL)
AND (d.deleted_username IS NULL)
AND (i.deleted_at IS NULL)
--AND (a.sub_status IN ('active', 'trial'))
AND CAST(i.created_at AS DATE) >= CAST(DATEADD(DAY, -90, Getdate()) AS DATE)
GROUP BY d.business_id) AS f ON a.business_id = f.business_id

