SELECT t0.vid,
t0.name,
t0.geotab_connected,
SUM(t0.TotalPreInspections) AS TotalPreInspections,
SUM(t0.TotalPostInspections) AS TotalPostInspections 


from
(SELECT vv.id AS vid,
vv.name,
vv.geotab_connected, 
vr.form_name, 
COUNT(vr.Form_name) AS TotalPreInspections,
0 AS TotalPostInspections

FROM LocalWAProd.dbo.v2_vehicles vv 
LEFT OUTER JOIN LocalWAProd.dbo.v2_reports AS vr ON vv.id = vr.vehicle_id
WHERE vr.business_id = 27035
AND vr.created_at >= DATEadd(DAY, -7, CAST(GETDATE() AS DATE))  
AND vr.form_name LIKE '%Pre%'
GROUP BY vv.id,
vv.name,
vv.geotab_connected, 
vr.form_name
UNION 
SELECT vv.id AS vid,
vv.name,
vv.geotab_connected, 
vr.form_name, 
0 AS TotalPreInspections,
COUNT(vr.Form_name) AS TotalPostInspections

FROM LocalWAProd.dbo.v2_vehicles vv 
LEFT OUTER JOIN LocalWAProd.dbo.v2_reports AS vr ON vv.id = vr.vehicle_id
WHERE vr.business_id = 27035
AND vr.created_at >= DATEadd(DAY, -7, CAST(GETDATE() AS DATE))  
AND vr.form_name LIKE '%Post%'
GROUP BY vv.id,
vv.name,
vv.geotab_connected, 
vr.form_name)
AS t0
GROUP BY t0.vid,
t0.name,
t0.geotab_connected