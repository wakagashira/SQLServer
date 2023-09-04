--CREATE VIEW dbo.VittallyHealthScoreMaintain
--AS
 

SELECT a.id AS business_id
, b.OpenedVsClosedWO90Days
, b.PercentVehiclesWithWorkOrder90Days
, ISNULL(c.PercentOfVechiclesWithServiceLast90days, 0) AS PercentOfVehiclesWithService90Days
, ISNULL(c.PercentOfServicesOpenedvsClosed90Days, 0) AS PercentOfServicesOpenedvsClosed90Days
FROM 
LocalWAProd.dbo.v2_businesses AS a 
LEFT OUTER JOIN LocalWAProd.[dbo].[VitallyHealthScoreWorkOrders] AS b ON a.id = b.business_Id
LEFT OUTER JOIN LocalWAProd.dbo.VitallyHealthScoreServices AS c ON a.id = c.id

