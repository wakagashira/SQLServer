select 
--1912 rows
Sum(t1.recurly_v2__Amount__c) as LastMonthMRR,
t0.*

from
(select 
b.name,
b.id as accountId,
max(a.recurly_v2__Start_Date__c) as startdate
from 
account  as b
--openquery(SFWA , 'select id, name, type from Account') as b
Left Outer Join 
recurly_v2__Recurly_Line_Item__c 
--openquery(SFWA , 'select recurly_v2__Account__c,recurly_v2__Start_Date__c, recurly_v2__Origin__c, recurly_v2__Line_Item_Description__c, Short_LI_Description__c, recurly_v2__Amount__c, recurly_v2__Quantity__c, recurly_v2__Unit_Amount__c  from recurly_v2__Recurly_Line_Item__c ') 
as a  on a.recurly_v2__Account__c = b.id and b.Type = 'customer'
where a.recurly_v2__Origin__c = 'Plan'
group by b.Name,
b.id)  as t0
Inner join 
recurly_v2__Recurly_Line_Item__c 
--openquery(SFWA , 'select recurly_v2__Account__c,recurly_v2__Start_Date__c, recurly_v2__Origin__c, t1.recurly_v2__Amount__c from recurly_v2__Recurly_Line_Item__c ') 
as t1 on t1.recurly_v2__Account__c = t0.accountid and t0.startdate = t1.recurly_v2__Start_Date__c and t1.recurly_v2__Origin__c = 'plan'
Group by t0.Name,
t0.accountId,
t0.startdate
