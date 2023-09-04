SELECT a.id,
a.type,
a.date,	
a.description,	
a.subscription_external_id,	
a.activity_arr / 100 as activity_arr,	
a.activity_mrr / 100 as activity_mrr,	
a.activity_mrr_movement / 100 as activity_mrr_movement,	
a.customerId,
datepart(month, a.date) Month, 
datepart(year, a.date) Year,
c.external_id,
c.company,
b.*,
sfa.ownerid,
recurly_v2__Created_At__c
FROM [Recurly].[dbo].[chartmogul_customer_activities] as a 
left outer join [dbo].[chartmogul_customers] as c on a.customerId = c.id
left outer join openquery(SFWA , 'select id as ActId, recurly_v2__Account__c as SFAccount, Name, recurly_v2__Created_At__c  from recurly_v2__Recurly_Account__c') as b on c.external_id = 	b.name
left outer join openquery(SFWA , 'select id  , ownerId from account') as sfa on b.SFAccount = sfa.id
