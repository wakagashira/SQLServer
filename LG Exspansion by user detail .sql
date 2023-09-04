/****** Script for SelectTopNRows command from SSMS  ******/
SELECT 
datepart(month, date) as Month
,datepart(Year, date) as Year
		,u.name
		,cm.[customer_name]
		,cm.[customer_uuid]
      ,cm.[customer_external_id]
      ,cm.[subscription_external_id]
      ,cm.[currency]
      ,cm.[MRR_Movement_In_dollars]
      ,cm.[description]
      ,cm.[date]
  FROM [Whiparound].[dbo].[CM_exp] as cm
  left outer join Salesforce.dbo.account as a on cm.customer_external_id = a.Recurly_External_ID__c
  left outer join Salesforce.dbo.[User] as u on a.ownerid = u.id
  Order by datepart(month, date)
,datepart(Year, date)
,u.name
		,cm.[customer_name]
