/****** Script for SelectTopNRows command from SSMS  ******/
SELECT 
datepart(month, date) as Month
,datepart(Year, date) as Year
		,Case when ah.OldValue is null then u.name else ah.OldValue end as Name
     ,sum(cm.[MRR_Movement_In_dollars]) as MRR_Movement_in_Dollars
  FROM [Whiparound].[dbo].[CM_exp] as cm
  left outer join Salesforce.dbo.account as a on cm.customer_external_id = a.Recurly_External_ID__c
  left outer join Salesforce.dbo.[User] as u on a.ownerid = u.id
  Left outer join (select a.* from (SELECT id,[AccountId]  ,[OldValue] FROM [Salesforce].[dbo].[AccountHistory]  where field like 'Owner%'  and CreatedDate >= '2022-08-15'   and DataType != 'EntityId'  ) as a   Inner Join (SELECT Min(id) as MinId,[AccountId]  FROM [Salesforce].[dbo].[AccountHistory]   where field like 'Owner%'    and CreatedDate >= '2022-08-15'   and DataType != 'EntityId'   Group by [AccountId]) as b on a.id = b.minid ) as AH on A.id = ah.AccountId
group by datepart(month, date)
,datepart(Year, date) 
		,Case when ah.OldValue is null then u.name else ah.OldValue end

  Order by datepart(month, date)
,datepart(Year, date)
,Case when ah.OldValue is null then u.name else ah.OldValue end
		--,cm.[customer_name]
