/****** Script for SelectTopNRows command from SSMS  ******/
SELECT 
datepart(month, date) as Month
,datepart(Year, date) as Year
		,u.name
		,cm.[customer_name]
     ,sum(cm.[MRR_Movement_In_dollars]) as MRR_Movement_in_Dollars
  FROM [Whiparound].[dbo].[CM_exp] as cm
  left outer join Salesforce.dbo.account as a on cm.customer_external_id = a.Recurly_External_ID__c
  left outer join Salesforce.dbo.[User] as u on a.ownerid = u.id
group by datepart(month, date)
,datepart(Year, date) 
		,u.name
		,cm.[customer_name]

  Order by datepart(month, date)
,datepart(Year, date)
,u.name
		,cm.[customer_name]
