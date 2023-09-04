SELECT CASE WHEN a.id IS NULL THEN rc.recurly_v2__Account__c
	  WHEN rc.recurly_v2__Account__c IS NULL THEN a.id ELSE rc.recurly_v2__Account__c END AS Account
	  ,ca.[uuid] AS name
      ,ca.[description]
      ,CAST(ca.[activity_mrr_movement] AS DECIMAL(16 , 2)) / 100 AS activity_mrr_movement__c
      ,CAST(ca.[activity_mrr] AS DECIMAL(16 , 2)) / 100 AS New_mrr__c
      ,CAST(ca.[activity_arr] AS DECIMAL(16 , 2))/ 100 AS New_arr__c
      ,ca.[date] AS activity_change__c
      ,ca.[type] AS EventType
      ,ca.[currency]
      ,ca.[subscription_external_id]
      ,ca.[plan_external_id]
      ,ca.[customer_name] AS account_Name__c
      ,ca.[customer_uuid] AS customer_UUid__c
      ,ca.[customer_external_id] 
      ,ca.[billing_connector_uuid]
	  ,DATEPART(MONTH, date) AS Month
	  ,DATEPART(year, date) AS Year
	  ,DATEPART(Quarter, date) AS Quarter
	  ,a.Segment__c
	  ,CASE WHEN a.id IS NULL THEN rc.recurly_v2__Account__c
	  WHEN rc.recurly_v2__Account__c IS NULL THEN a.id ELSE NULL END AS Account
	  
  FROM [recurly].[dbo].[chartmogul_activities] AS ca
  LEFT OUTER JOIN salesforce.[dbo].[recurly_v2__Recurly_Account__c] AS rc ON ca.customer_external_id = rc.recurly_v2__Code__c
  LEFT OUTER JOIN Salesforce.dbo.account AS a ON ca.customer_external_id = a.RECURLYEXID__C
  LEFT OUTER JOIN salesforce.[dbo].[ChartMogul_Activities__c] AS b ON ca.uuid = b.name

  WHERE
  
  --a.id IS NOT NULL 
   b.id IS NULL 
  -- AND (ISNULL(b.Account__c, 'Null') != ISNULL(a.Id, 'NULL') 
  -- OR b.Activity_MRR_Movement__c != b.Activity_MRR_Movement__c)
   
   
   ORDER BY a.id, ca.date