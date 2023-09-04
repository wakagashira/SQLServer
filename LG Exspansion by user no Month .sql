/****** Script for SelectTopNRows command from SSMS  ******/
SELECT u.name
     ,sum(cm.[MRR_Movement_In_dollars]) as MRR_Movement_in_Dollars
  FROM [Whiparound].[dbo].[CM_exp] as cm
  left outer join Salesforce.dbo.account as a on cm.customer_external_id = a.Recurly_External_ID__c
  left outer join Salesforce.dbo.[User] as u on a.ownerid = u.id
group by  
		u.name

  Order by 
u.name
		--,cm.[customer_name]
