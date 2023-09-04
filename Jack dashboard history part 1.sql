select 
'Clicks - Digital Adoption' as Report ,
Leadstatus,
count(Leadid) as CntOfLeads
from (
select 
l.Status as leadstatus,
l.id as LeadId

from lead as l 
inner join [dbo].[CampaignMember] as m on l.id = m.LeadId
Inner Join Campaign as c on c.Name like '22 - Digital Adoption%' and m.CampaignId = c.ID
Left outer join  [user] as u on l.ownerid = u.id
left outer join contact as co on m.ContactId = co.Id
--Left outer join Opportunity as O on c.id = o.CampaignId and m.AccountId = o.AccountId 
where (m.Status = 'Clicked Email' or m.status is null)
and isnull(U.name, '') not like '%existing%' 
and (l.Closed_Reason__c not in  ('Already a customer', 'Competitor Shopping Us', 'Country/Language Not Supported', 'Duplicate', 'Test Record') or l.Closed_Reason__c is null)
and l.Status not in ('Qualified', 'Closed Lead', 'Existing Customer', 'Partner')
--and (o.StageName not In ('Sat - Negotiating', 'Docs Requested', 'Ready To Close', 'Closed Won') or o.StageName is null)
and (l.Total_Fleet_Size__c >= 10 or l.Total_Fleet_Size__c is null)
) as a 

group by Leadstatus