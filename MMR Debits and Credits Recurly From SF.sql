CREATE VIEW dbo.GetLocalMRRChangeTotal
AS
 
Select 
isnull(x2.id, 'MRR-Total') as AccountId,
--isnull(x2.id, 'Total') as ID,
sum(isnull(x1.Added, 0)) as Added,
Sum(isnull(x1.Removed, 0)) as Removed,
Sum(isnull([Refund], 0)) as Refund, 
Sum(isnull([Discount], 0)) as Discount, 
Sum(isnull([Credit], 0)) as Credit,  
Sum(isnull([Upgrade], 0)) as Upgrade, 
Sum(isnull([Other], 0)) as Other,
Sum(isnull(x1.Added, 0) + isnull(x1.Removed, 0)) as MRRChangeTotal

from 
account as x2
--openquery(SFWA , 'select id, name from Account') as x2
Left outer Join
(
select Id as ID,

[Added], [Removed], [Refund], [Discount], [Credit],  [Upgrade], [Other]
from


(Select t0.id,
t0.TheType,
Sum(t0.recurly_v2__Amount__c) as TotalTypeAmount


from 
(
select 
b.name, 
b.Id,
a.recurly_v2__Start_Date__c,
a.recurly_v2__Origin__c,
a.recurly_v2__Line_Item_Description__c,
a.Short_LI_Description__c,
case when a.Short_LI_Description__c like '%Refund%' then 'Refund'
when a.Short_LI_Description__c like '%discount%' then 'Discount'
when a.Short_LI_Description__c like '%Credit%' then 'Credit'
when a.Short_LI_Description__c like '%Free%' then 'Discount'
when a.Short_LI_Description__c like '%Upgrade%' then 'Upgrade'
when a.Short_LI_Description__c like '%Added%' Then 'Added'
when a.Short_LI_Description__c like '%Removed%' Then 'Removed'
Else 'Other' end as TheType,
a.recurly_v2__Amount__c,
a.recurly_v2__Quantity__c,
a.recurly_v2__Unit_Amount__c,
c.startdate as BillingStartDate
from  
account as b
--openquery(SFWA , 'select id, name, type from Account') as b 
Left outer join 
recurly_v2__Recurly_Line_Item__c
--openquery(SFWA , 'select recurly_v2__Account__c,recurly_v2__Start_Date__c, recurly_v2__Origin__c, recurly_v2__Line_Item_Description__c, Short_LI_Description__c, recurly_v2__Amount__c, recurly_v2__Quantity__c, recurly_v2__Unit_Amount__c  from recurly_v2__Recurly_Line_Item__c ')  
as a  on a.recurly_v2__Account__c = b.id and b.Type = 'customer'
left outer join (select 
b.name,
b.id as accountId,
max(a.recurly_v2__Start_Date__c) as startdate
from  
account as b
--openquery(SFWA , 'select id, name, type from Account') as b
Left Outer Join 
--recurly_v2__Recurly_Line_Item__c
openquery(SFWA , 'select recurly_v2__Account__c,recurly_v2__Start_Date__c, recurly_v2__Origin__c, recurly_v2__Line_Item_Description__c, Short_LI_Description__c, recurly_v2__Amount__c, recurly_v2__Quantity__c, recurly_v2__Unit_Amount__c  from recurly_v2__Recurly_Line_Item__c ')  
as a  on a.recurly_v2__Account__c = b.id and b.Type = 'customer'
where a.recurly_v2__Origin__c = 'Plan'
group by b.Name,
b.id
) as C on b.id = c.accountId
where a.recurly_v2__Origin__c in ('debit','credit')
--and b.name = 'Sharp''s Landscaping Inc'
and c.startdate < a.recurly_v2__Start_Date__c
--Order by b.name
) as T0
Group by t0.name,
t0.ID,
t0.TheType
) as SourceTable 
PIVOT  
(  
  AVG(Totaltypeamount)  
  FOR TheType IN ([Added], [Removed], [Refund], [Discount], [Credit],  [Upgrade], [Other])  
) AS PivotTable  


) as X1 on x2.id = x1.ID
Group by 
ROLLUP(x2.ID)
--ROLLUP(x2.Name)

--Take this out when in production 
--having Sum(isnull(x1.Added, 0) + isnull(x1.Removed, 0)) <> 0
