SELECT
	vt.name AS Team_Name
   ,vd.first_name
   ,vd.last_name
   , ISNULL(insp.CntOfInspections, 0) CntOfInspections
   , ISNULL(insp.InspectionDurationInSec, 0) InspectionDurationInSec
   , ISNULL(defect.FaultCount, 0) AS DefectCount
 
FROM LocalWAProd.dbo.v2_drivers vd
INNER JOIN LocalWAProd.dbo.v2_teams vt
	ON vd.team_id = vt.Id
LEFT OUTER JOIN (SELECT
		driver_id
	   ,COUNT(Id) CntOfInspections
	   , SUM(report_duration_sec) InspectionDurationInSec
	FROM LocalWAProd.dbo.v2_reports vr
	WHERE vr.business_id = 11537
	AND vr.created_at >= DATEADD(DAY, -7, GETDATE())
	GROUP BY driver_id) AS insp
	ON vd.Id = insp.driver_id

	LEFT OUTER JOIN (SELECT  COUNT(vrf.report_id) AS FaultCount, vrf.driver_id
	FROM LocalWAProd.[dbo].[v2_faults] vrf
	WHERE vrf.business_id = 11537
	AND vrf.created_at >= DATEADD(DAY, -7, GETDATE())
	GROUP BY driver_id) defect ON vd.id = defect.driver_id

WHERE vt.business_id = 11537
AND vd.deleted_at IS NULL
ORDER BY vt.name