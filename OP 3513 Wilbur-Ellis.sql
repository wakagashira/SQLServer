SELECT c.date
,v.id AS VehicleID
,v.name AS VehicleName
,vt.name AS TeamName
, CASE WHEN pre.vehicle_id IS NOT NULL THEN 'Yes' ELSE 'No' END AS PreInspected
, CASE WHEN post.vehicle_id IS NOT NULL THEN 'Yes' ELSE 'No' END AS PostInspected
, CASE WHEN CASE WHEN pre.vehicle_id IS NOT NULL THEN 'Yes' ELSE 'No' END = 'No' OR 
  CASE WHEN post.vehicle_id IS NOT NULL THEN 'Yes' ELSE 'No' END = 'No' THEN 'No' ELSE 'Yes' END AS BothPreAndPost

FROM 
(SELECT date FROM localwaprod.[dbo].[calendar] AS c 
WHERE c.date >= DATEADD(day, -7, getdate()) 
AND c.date <= GETDATE()) AS c
Inner JOIN 
(SELECT DISTINCT id, name, team_id, team_name FROM  LocalWAProd.dbo.v2_vehicles
WHERE business_id = 19581 AND deleted_at IS NULL AND is_test_vehicle = 0  ) AS v ON 1=1

LEFT OUTER JOIN 
(
SELECT DISTINCT CAST(vr.created_datetime AS DATE) AS TheDate, vr.vehicle_id 
FROM LocalWAProd.dbo.v2_reports vr
WHERE business_id = 19581
AND CAST(vr.created_datetime AS DATE) >= DATEADD(day, -7, getdate())
AND vr.form_name LIKE 'Pre%') AS pre ON c.Date = pre.TheDate AND v.id = pre.vehicle_id
LEFT OUTER JOIN 
(
SELECT DISTINCT CAST(vr.created_datetime AS DATE) AS TheDate, vr.vehicle_id 
FROM LocalWAProd.dbo.v2_reports vr
WHERE business_id = 19581
AND CAST(vr.created_datetime AS DATE) >= DATEADD(day, -7, getdate())
AND vr.form_name LIKE 'Post%') AS post ON c.Date = post.TheDate AND v.id = post.vehicle_id
LEFT OUTER JOIN LocalWAProd.dbo.v2_teams vt ON v.team_id = vt.id
