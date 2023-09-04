select
t0.domain,
Sum(t0.people) as People,
sum(t0.LeadHistoryLines) as LeadLines
from 
(
select a.Domain
,count(b.email) as People
,0 as LeadHistoryLines
--,Count(c.id) as LeadHistoryLines

From NewLeadCompany as a 
left Outer Join NewLeadPerson as b on a.domain = b.domain
--Left outer Join NewLead_Source_History as c on a.domain = c.NewDomain 
Group by a.domain

union 
select a.Domain
,0 as  People
--,count(b.email) as People
--,0 as LeadHistoryLines
,Count(c.id) as LeadHistoryLines

From NewLeadCompany as a 
--left Outer Join NewLeadPerson as b on a.domain = b.domain
Left outer Join NewLead_Source_History as c on a.domain = c.NewDomain 
Group by a.domain
) as T0
Group by t0.Domain
Order by LeadLines desc