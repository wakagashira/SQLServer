SELECT vv.id AS vid,
vv.name,
vr.created_at,
vv.geotab_connected, 
vr.form_name, 
vr.id AS Inspectionid,
CASE WHEN vr.form_name LIKE '%Pre%' THEN 'Pre Trip' ELSE 'Post Trip' END AS PreOrPost,
COUNT(vf.fault_name) AS NumberOfFaults
FROM LocalWAProd.dbo.v2_vehicles vv 
LEFT OUTER JOIN LocalWAProd.dbo.v2_reports AS vr ON vv.id = vr.vehicle_id
LEFT OUTER JOIN LocalWAProd.dbo.v2_faults vf ON vr.id = vf.report_id
WHERE vr.business_id = 27035
AND vr.created_at >= DATEadd(DAY, -7, CAST(GETDATE() AS DATE))  
AND vr.form_name LIKE '%Pre%'
GROUP BY vv.id ,
vv.name,
vr.created_at,
vv.geotab_connected, 
vr.form_name, 
vr.id ,
CASE WHEN vr.form_name LIKE '%Pre%' THEN 'Pre Trip' ELSE 'Post Trip' END
UNION 
SELECT vv.id AS vid,
vv.name,
vr.created_at,
vv.geotab_connected, 
vr.form_name, 
vr.id AS Inspectionid,
CASE WHEN vr.form_name LIKE '%Pre%' THEN 'Pre Trip' ELSE 'Post Trip' END AS PreOrPost,
COUNT(vf.fault_name) AS NumberOfFaults
FROM LocalWAProd.dbo.v2_vehicles vv 
LEFT OUTER JOIN LocalWAProd.dbo.v2_reports AS vr ON vv.id = vr.vehicle_id
LEFT OUTER JOIN LocalWAProd.dbo.v2_faults vf ON vr.id = vf.report_id
WHERE vr.business_id = 27035
AND vr.created_at >= DATEadd(DAY, -7, CAST(GETDATE() AS DATE))  
AND vr.form_name LIKE '%Post%'
GROUP BY vv.id ,
vv.name,
vr.created_at,
vv.geotab_connected, 
vr.form_name, 
vr.id ,
CASE WHEN vr.form_name LIKE '%Pre%' THEN 'Pre Trip' ELSE 'Post Trip' END

