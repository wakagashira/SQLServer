SELECT
	vi.business_id
	,vb.name AS CompanyName
	,vi.TotalVehicleCNT
   ,ISNULL(vi.PercentOfVehiclesInspectingLast90days, 0) AS PercentOfVehiclesInspectingLast90days
   ,ISNULL(vi.PercentOfVehiclesInspectingLast30days, 0) AS PercentOfVehiclesInspectingLast30days
   ,CASE WHEN ISNULL(vi.PercentOfVehiclesInspectingLast90days, 0) = 0 THEN -100 WHEN ISNULL(vi.PercentOfVehiclesInspectingLast30days, 0) = 0 THEN 100 ELSE ISNULL(vi.PercentOfVehiclesInspectingLast30days, 0) - ISNULL(vi.PercentOfVehiclesInspectingLast90days, 0) END AS TrendVehiclesInspectingLast9030days   ,ISNULL(vd.PercentTotalCorrectedFaults, 0) AS PercentTotalCorrectedFaultAllTime
   ,ISNULL(vd.PercentCorrectedFaults90Day, 0) AS PercentCorrectedFaults90Day
   ,ISNULL(vdr.PercentDriversInspectingLast90days, 0) AS PercentOfDriversInspectingLast90days
   ,vsf.Contract_Status__c AS ContractStatus
   ,vsf.Churn_Risk__c 
   ,vsf.Type AS CustomerType
   ,vsf.TotalContacts
   ,vsf.Stratigic
   ,vsf.Tactical
   ,vsf.Operational
   ,vsf.vitally_segment__c AS Segment
   ,vsf.[RecurlyMRR]
   ,vsf.[OldVitallyScore]
   ,vsf.[NewSegment] AS SubscriptionSegment

FROM LocalWAProd.dbo.VitallyHealthScoreVehiclesInspecting AS vi
LEFT OUTER JOIN LocalWAProd.dbo.VitallyHealthScoreDefects AS vd
	ON vi.business_id = vd.business_id
INNER JOIN LocalWAProd.dbo.v2_businesses vb ON vi.business_id = vb.id
LEFT outer JOIN LocalWAProd.dbo.VitallyHealthScoreDriversInspecting AS vdr ON vi.business_id = vdr.business_id
LEFT OUTER JOIN LocalWAProd.dbo.VitallyHealthScoreSalesforceStats AS vsf ON vi.business_id = vsf.business_id AND vsf.business_id != 'true'
WHERE vsf.type = 'Customer'


--WHERE vi.business_id IN (19581, 10742, 13862, 26296, 19096, 5104, 19503, 19251, 18722, 18007, 8461, 7756, 6726, 31312,31064, 30770, 29689 )
--ORDER BY ISNULL(vd.PercentCorrectedFaults90Day, 0)  desc