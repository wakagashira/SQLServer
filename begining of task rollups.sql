select WhatId, TaskSubtype, [Account], [Contact], [Opportunity]

From
(

select t0.whatid,
case when a.id is not null then a.id
when c.Id is not null then c.AccountId
when o.Id is not null then o.AccountId else Null end as masteraccount,
t0.TaskSubtype,
T0.objectname,
sum(t0.TaskCount) as TaskCount
from 
(select 
t.WhatId,
t.TaskSubtype, 
case when left(t.whatid, 3) = '001' then 'Account'
when left(t.whatid, 3) = '003' then 'Contact'
when left(t.whatid, 3) = '006' then 'Opportunity' end as objectname,
count(t.id) TaskCount
from Salesforce.dbo.task as t
where left(t.whatid, 3) in ('001', '003', '006')

Group by case when left(t.whatid, 3) = '001' then 'Account'
when left(t.whatid, 3) = '003' then 'Contact'
when left(t.whatid, 3) = '006' then 'Opportunity' end,
t.WhatId,
t.TaskSubtype
union 
select 
t.WhoId,
t.TaskSubtype, 
case when left(t.whoid, 3) = '003' then 'Contact' end as objectname,
count(t.id) TaskCount
from Salesforce.dbo.task as t
where left(t.whoid, 3) = '003'

Group by case when left(t.whoid, 3) = '003' then 'Contact'
 end,
t.WhoId,
t.TaskSubtype) as T0 
left outer join Salesforce.dbo.account as a on  t0.whatid = a.id
left outer join Salesforce.dbo.contact as c on t0.WhatId = c.id
left outer join Salesforce.dbo.Opportunity as o on t0.WhatId = o.id
Group by t0.whatid,
t0.TaskSubtype,
T0.objectname,
case when a.id is not null then a.id
when c.Id is not null then c.AccountId
when o.Id is not null then o.AccountId else Null end




) as A 
Pivot (sum(TaskCount)
for objectname in ([Account], [Contact], [Opportunity])
) as pivotTable
