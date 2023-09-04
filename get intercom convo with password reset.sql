SELECT  DATEPART(MONTH, ic.created_at) AS Month,
DATEPART(Year, ic.created_at) AS Year,
CAST(DATEPART(Year, ic.created_at) AS NVARCHAR) + '-' + CAST(DATEPART(MONTH, ic.created_at)AS NVARCHAR) AS dates,
COUNT(ics.id) AS TotalPasswordRequests


FROM recurly.[dbo].[intercom_conversations] AS ic
INNER JOIN (SELECT  [id]
      ,[type]
      ,[delivered_as]
      ,[subject]
      ,[body]
      ,[url]
      ,[redacted]
      ,[author_id]
      ,[author_type]
  FROM [recurly].[dbo].[intercom_conversation_sources]
  WHERE body LIKE '%password%') ics ON ic.sourceId = ics.id
  GROUP BY DATEPART(MONTH, ic.created_at),
DATEPART(Year, ic.created_at) ,
CAST(DATEPART(Year, ic.created_at) AS NVARCHAR) + '-' + CAST(DATEPART(MONTH, ic.created_at)AS NVARCHAR) 
  
  