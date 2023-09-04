
update
NewLeadPerson
set newleadperson.Status = c.Leadstatus
from newleadperson as a 
inner join (



SELECT 
--99,260
a.domain,
b.email,
	case when	max(dbo.LeadStatusRank(b.Status)) = 3 then 'Attempting Contact' 
when max(dbo.LeadStatusRank(b.Status)) = 6 then 'Call completed' 
when max(dbo.LeadStatusRank(b.Status)) = 4 then 'Call new'
when max(dbo.LeadStatusRank(b.Status)) = 5 then 'Call scheduled'
when max(dbo.LeadStatusRank(b.Status)) = 25 then 'Closed Lead'
when max(dbo.LeadStatusRank(b.Status)) = 7 then 'Contacted'
when max(dbo.LeadStatusRank(b.Status)) = 9 then 'Engaging'
when max(dbo.LeadStatusRank(b.Status)) = 110 then 'Existing Customer'
when max(dbo.LeadStatusRank(b.Status)) = 100 then 'Existing Prospect Account' 
when max(dbo.LeadStatusRank(b.Status)) = 2 then 'Open' 
when max(dbo.LeadStatusRank(b.Status)) = 1 then 'Open - Not Contacted' 
when max(dbo.LeadStatusRank(b.Status)) = 50 then 'Partner' 
when max(dbo.LeadStatusRank(b.Status)) = 8 then 'Qualified' 
when max(dbo.LeadStatusRank(b.Status)) = 10 then 'Waiting to book' 
else 'Unknown' end  as Leadstatus
FROM GetDomainFromLead AS a
     INNER JOIN leads AS b ON a.id = b.id
	 where b.email is not null 
	 and a.domain != 'Company Only'
Group by a.domain,
b.email






) as c on a.email = c.email and a.domain = c.domain
