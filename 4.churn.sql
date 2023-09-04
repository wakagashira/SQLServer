select 
b.name,
c1.ownerid,
sum(activity_mrr) / 100 as Activity_mrr,
sum(activity_mrr_movement)  / 100 as Activity_mrr_movement
from (
-- Get Chart Mogul Churn items for the month 

SELECT a.*, 
datepart(month, a.date) Month, 
datepart(year, a.date) Year,
c.external_id,
c.company,
b.*,
sfa.ownerid
  FROM [Recurly].[dbo].[chartmogul_customer_activities] as a 
left outer join [dbo].[chartmogul_customers] as c on a.customerId = c.id
left outer join openquery(SFWA , 'select id as ActId, recurly_v2__Account__c as SFAccount, Name, recurly_v2__Created_At__c  from recurly_v2__Recurly_Account__c') as b on c.external_id = 	b.name
left outer join openquery(SFWA , 'select id  , ownerId from account') as sfa on b.SFAccount = sfa.id
  where 
  type = 'churn'
  and datepart(month, date) = 05
  and datepart(year, date) = 2022
  and Datediff(day, recurly_v2__Created_At__c, getdate()) <= 180
)  as c1
 left outer join openquery(SFWA , 'select id, name from user') as b on c1.ownerid = b.id

Group by c1.ownerid, b.name