SELECT [business_id]
      ,CASE WHEN [service_status] = 0 THEN 'New' 
	  WHEN [service_status] = 1 THEN 'Due Soon'
	  WHEN [service_status] = 2 THEN 'Over Due' 
	  ELSE 'Closed' END AS ServiceState
	  , COUNT(service_id) NumberOfOverdue
  FROM [LocalWAProd].[dbo].[service_status_view]
  where CASE WHEN [service_status] = 0 THEN 'New' 
	  WHEN [service_status] = 1 THEN 'Due Soon'
	  WHEN [service_status] = 2 THEN 'Over Due' 
	  ELSE 'Closed' END = 'Over Due'
  GROUP BY [business_id]
      ,CASE WHEN [service_status] = 0 THEN 'New' 
	  WHEN [service_status] = 1 THEN 'Due Soon'
	  WHEN [service_status] = 2 THEN 'Over Due' 
	  ELSE 'Closed' END
  --1 is due soon 