SELECT
	vb.id
   ,vb.salesforce_account_id
   ,ISNULL(SUM(cdpd.InspectionCnt), 0) AS InspectionCnt
   ,ISNULL(SUM(cdpd.vehiclecnt),0) AS VehicleCNT
FROM LocalWAProd.dbo.v2_businesses vb
LEFT OUTER JOIN LocalWAProd.dbo.CDPGetDriverInspectionsAndVehicleCntForToday CDPD ON vb.id = cdpd.business_id	
WHERE vb.salesforce_account_id IS NOT NULL 
GROUP BY vb.id
   ,vb.salesforce_account_id
