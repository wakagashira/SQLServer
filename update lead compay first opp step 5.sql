update
NewLeadCompany
set newleadcompany.OppID = c.OppID



from newleadcompany as a 
inner join (

select b.Domain,
max(a.ConvertedOpportunityId) as OppID
from leads as a 
inner join [dbo].[GetDomainFromLead] as b on a.id = b.id
where a.ConvertedOpportunityId is not null
group by b.domain


) as c on a.domain = c.domain 