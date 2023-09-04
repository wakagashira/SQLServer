SELECT
vt.name AS teamname
	,vrf.fault_name
   ,vrf.form_name
   ,vrf.driver_id
   ,vrf.driver_name 
   ,DATEDIFF(DAY, vrf.created_at, vrf.completed_at) DaysToComplete
FROM LocalWAProd.[dbo].[v2_faults] vrf
INNER JOIN LocalWAProd.dbo.v2_drivers vd ON vrf.driver_id = vd.id
INNER JOIN LocalWAProd.dbo.v2_teams vt ON vd.team_id = vt.id
WHERE vrf.business_id = 11537
AND vrf.completed_at >= DATEADD(DAY, -7, GETDATE())
	--GROUP BY driver_id, datediff(DAY, vrf.created_at , vrf.completed_at)