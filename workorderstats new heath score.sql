--CREATE VIEW dbo.VitallyHealthScoreWorkOrders
--AS
 

SELECT a.id AS business_Id
,ISNULL(h.Cnt, 0) AS UNIQUEVehiclesWithServices
,ISNULL(b.cnt ,0) AS WorkOrdersAllTime
,ISNULL(c.cnt ,0) AS ClosedWorkOrdersAllTime
,ISNULL(d.Cnt ,0) AS WorkOrdersCreatedLast90Days
,ISNULL(e.Cnt ,0) AS WorkOrdersCreatedLast30Days
,ISNULL(f.Cnt ,0) AS WorkOrdersCreatedLast7Days
,ISNULL(g.cnt,0) AS WorkOrdersCreatedYesterday
,ISNULL(i.cnt, 0) AS WorkOrdersClosedLast90Days
,ISNULL(j.cnt, 0) AS WorkOrdersClosedLast30Days
,ISNULL(k.VehicleCnt, 0) AS UNIQUEVehicleCntLast90Days
,CASE WHEN ISNULL(d.Cnt, 0) = 0 THEN CAST(0 AS DECIMAL) WHEN ISNULL(i.cnt, 0) = 0 THEN CAST(0 AS DECIMAL) ELSE (CAST(ISNULL(i.cnt, 0) AS DECIMAL) / CAST(ISNULL(d.Cnt ,0) AS DECIMAL)) *100 END AS OpenedVsClosedWO90Days
,CASE WHEN ISNULL(e.Cnt, 0) = 0 THEN CAST(0 AS DECIMAL) WHEN ISNULL(j.cnt, 0) = 0 THEN CAST(0 AS DECIMAL) ELSE (CAST(ISNULL(j.cnt, 0) AS DECIMAL) / CAST(ISNULL(e.Cnt ,0) AS DECIMAL)) *100 END AS OpenedVsClosedWO90Days
,CASE WHEN ISNULL(h.Cnt, 0) = 0 THEN CAST(0 AS DECIMAL) WHEN ISNULL(k.VehicleCnt, 0) = 0 THEN CAST(0 AS DECIMAL) ELSE (CAST(ISNULL(k.VehicleCnt, 0) AS DECIMAL) / CAST(ISNULL(h.Cnt ,0) AS DECIMAL)) *100 END AS PercentVehiclesWithWorkOrder90Days
FROM LocalWAProd.dbo.v2_businesses a

--Get All Work Orders All Time
LEFT OUTER JOIN (
SELECT  
wo.business_id
,COUNT(id) AS Cnt

FROM LocalWAProd.dbo.work_orders wo
WHERE wo.deleted_at IS NULL 

GROUP BY wo.business_id) AS b ON a.id = b.business_id

--Get All Closed Work Orders All Time
LEFT OUTER JOIN (
SELECT  
wo.business_id
,COUNT(id) AS Cnt

FROM LocalWAProd.dbo.work_orders wo
WHERE wo.deleted_at IS NULL 
AND wo.completion_date IS NOT NULL 
GROUP BY wo.business_id) AS c ON a.id = c.business_id

--Get All Work Orders Last 90 Days
LEFT OUTER JOIN (
SELECT  
wo.business_id
,COUNT(id) AS Cnt

FROM LocalWAProd.dbo.work_orders wo
WHERE wo.deleted_at IS NULL 
AND wo.created_at >= DATEADD(DAY, -90, GETDATE())
GROUP BY wo.business_id) AS d ON a.id = d.business_id

--Get All Work Orders Last 30 Days
LEFT OUTER JOIN (
SELECT  
wo.business_id
,COUNT(id) AS Cnt

FROM LocalWAProd.dbo.work_orders wo
WHERE wo.deleted_at IS NULL 
AND wo.created_at >= DATEADD(DAY, -30, GETDATE())
GROUP BY wo.business_id) AS e ON a.id = e.business_id

--Get All Work Orders Last 7 Days
LEFT OUTER JOIN (
SELECT  
wo.business_id
,COUNT(id) AS Cnt

FROM LocalWAProd.dbo.work_orders wo
WHERE wo.deleted_at IS NULL 
AND wo.created_at >= DATEADD(DAY, -7, GETDATE())
GROUP BY wo.business_id) AS f ON a.id = f.business_id

--Get All Work Orders Last Yesterday
LEFT OUTER JOIN (
SELECT  
wo.business_id
,COUNT(id) AS Cnt

FROM LocalWAProd.dbo.work_orders wo
WHERE wo.deleted_at IS NULL 
AND CAST(wo.created_at AS DATE) =CAST(DATEADD(DAY, -1, GETDATE()) AS DATE)
GROUP BY wo.business_id) AS g ON a.id = g.business_id

--Get Unique Vehicles All Time
LEFT OUTER JOIN (
SELECT  
wo.business_id
,COUNT(DISTINCT wo.asset_id) AS Cnt

FROM LocalWAProd.dbo.work_orders wo
INNER JOIN LocalWAProd.dbo.v2_vehicles vv ON wo.asset_id = vv.id AND vv.deleted_at IS NULL 
WHERE wo.deleted_at IS NULL 
--AND CAST(wo.created_at AS DATE) =CAST(DATEADD(DAY, -1, GETDATE()) AS DATE)
GROUP BY wo.business_id) AS h ON a.id = h.business_id


--Get All Closed Work Orders Last 90 Days
LEFT OUTER JOIN (
SELECT  
wo.business_id
,COUNT(id) AS Cnt

FROM LocalWAProd.dbo.work_orders wo
WHERE wo.deleted_at IS NULL 
AND wo.completion_date >= DATEADD(DAY, -90, GETDATE())
GROUP BY wo.business_id) AS i ON a.id = i.business_id

--Get All Closed Work Orders Last 30 Days
LEFT OUTER JOIN (
SELECT  
wo.business_id
,COUNT(id) AS Cnt

FROM LocalWAProd.dbo.work_orders wo
WHERE wo.deleted_at IS NULL 
AND wo.completion_date >= DATEADD(DAY, -30, GETDATE())
GROUP BY wo.business_id) AS j ON a.id = j.business_id

--Get All Unique Vihicles With Work Orders Last 90 Days
LEFT OUTER JOIN (
SELECT  
wo.business_id
,COUNT(DISTINCT wo.asset_id) AS VehicleCnt

FROM LocalWAProd.dbo.work_orders wo
WHERE wo.deleted_at IS NULL 
AND wo.completion_date >= DATEADD(DAY, -90, GETDATE())
GROUP BY wo.business_id) AS k ON a.id = k.business_id
