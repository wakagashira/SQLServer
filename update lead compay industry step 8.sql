update
NewLeadCompany
set newleadcompany.Industry = c.Industry



from newleadcompany as a 
inner join (

select 
t0.domain,
max(t0.Indcount) as Indcount,
case 
when t2.accountid is not null then max(t3.Segment__c) 
else max(t1.Industry) end as Industry
from(
select b.domain ,
a.Industry,
count(a.industry) as IndCount
from leads as a 
Inner join GetDomainFromLead as b on a.id = b.id
--where a.Industry is not null 
Group by b.domain, a.Industry
--order by domain, count(a.industry)desc
) as t0
Inner Join (
select b.domain ,
a.Industry,
count(a.industry) as IndCount
from leads as a 
Inner join GetDomainFromLead as b on a.id = b.id
--where a.Industry is not null 
Group by b.domain, a.Industry
--order by domain, count(a.industry)desc
) as t1 on t0.domain = t1.domain and t0.IndCount = t1.IndCount
left outer join NewLeadCompany as t2 on t0.domain = t2.Domain
left outer join account as t3 on t2.accountid = t3.Id

Group by t0.domain, t2.accountid



) as c on a.domain = c.domain 