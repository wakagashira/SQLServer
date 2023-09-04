select 
a.Id as AcctId,
l.Account__c,
cm.Id as CMID,
'Hot' as TempStatus
from salesforce.dbo.Campaign as C
inner join Salesforce.dbo.CampaignMember as CM on c.id = cm.CampaignId
Left Outer Join Salesforce.dbo.lead as l on cm.LeadId = l.id
left outer join  Salesforce.dbo.[User] as u on l.OwnerId = u.id
left outer join Salesforce.dbo.Opportunity as o on cm.Opportunity_For_Reports__c = o.id
left outer join Salesforce.dbo.account as a on l.Account__c = a.id 
Where c.name like '%Download%'
and (u.name not like '%existing%' or u.name is null)
and (l.Closed_Reason__c not in ('Already a customer', 'Competitor Shopping Us', 'Country Not Supported', 'Country/Language Not Supported', 'Duplicate', 'Test Record') or l.Closed_Reason__c is null)
and (l.Status not in ('Engaging', 'Qualified', 'Existing Customer', 'Existing Prospect Account', 'Partner') or l.status is null)
and (o.StageName not in ('Sat - Negotiating', 'Docs Requested', 'Ready To Close', 'Closed Won') or o.StageName is null)
and (l.Total_Fleet_Size__c >=20 or l.Total_Fleet_Size__c is null)
and l.Company not like '***%'
and l.Company not like '%test%'
and l.Company not like '%Whip around%'
and l.Company not like '%Disney%'
and l.Company not like '%lolo%'
and l.Company not like '%kahuna%'
and (a.Sales_Status__c not in ('Customer', 'Closed Account') or a.Sales_Status__c is null )
and a.id is not null 
