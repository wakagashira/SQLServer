SELECT ca.[uuid] AS name
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
	  ,a.id AS account
	  
  FROM [recurly].[dbo].[chartmogul_activities] AS ca
  LEFT OUTER JOIN Salesforce.dbo.account AS a ON ca.customer_external_id = a.RECURLYEXID__C
  LEFT OUTER JOIN salesforce.[dbo].[Chart_Mogul_Customer_Activities__c] AS b ON a.id = b.account__c AND ca.uuid = b.name

  where 
  a.id IS NOT NULL 
  AND b.id IS NULL 
  /*ca.customer_name = 'Ace Relocation Systems, Inc.'
   AND ca.date LIKE '2023-05-10%'*/

   ORDER BY a.id, ca.date