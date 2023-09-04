/****** Script for SelectTopNRows command from SSMS  ******/
SELECT q.[customer_name]
      ,q.[customer_external_id]
      ,q.[movement_type]
      ,q.[date]
      ,q.[account_currency]
      ,q.[MRR]
      ,q.[column7]
      ,q.[Account_Owner]
      ,q.[MRR2]
	  , a.id
	  , ah.Field
	  , ah.OldValue
	  , ah.NewValue
	  , ah.CreatedDate
  FROM [Whiparound].[dbo].[Churn Q Jan-Mar] AS Q
  LEFT OUTER JOIN Salesforce.dbo.Account a ON q.customer_external_id = a.Recurly_External_ID__c
  LEFT OUTER JOIN Salesforce.dbo.AccountHistory ah ON a.id = ah.AccountId

  WHERE ah.field = 'Owner'
  AND ah.OldValue NOT LIKE '005%'
  AND ah.NewValue like '%Lauren%'
--AND q.customer_name LIKE '%turner%'
  ORDER BY q.customer_name, ah.Createddate desc