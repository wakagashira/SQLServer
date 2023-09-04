CREATE VIEW dbo.CDPGetDriverInspectionsAndVehicleCntForToday
AS
 
 SELECT
	CAST(created_at AS DATE) AS CreateDate
   ,business_id
   ,r.driver_id
   ,COUNT(r.id) InspectionCnt
   ,COUNT(DISTINCT r.vehicle_id) AS vehiclecnt
FROM LocalWAProd.dbo.v2_reports AS r
WHERE  CAST(created_at AS DATE) = CAST(GETDATE() AS date)
GROUP BY CAST(r.created_at AS DATE)
		,r.business_id
		,r.driver_id