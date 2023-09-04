select 
--distinct is added to reduce the number of changes,   it will differ from the report totals 
--https://whiparound.lightning.force.com/lightning/r/Report/00O6T000006MCDAUA4/view  But is still accurate 
distinct 
l.Id,
'Hot'
from 
Salesforce.dbo.Campaign as c
inner join Salesforce.dbo.CampaignMember as cm on c.id = cm.CampaignId
inner join Salesforce.dbo.Lead_Account_Opportunity_Crosswalk__c as cw on cm.Lead_For_Reports__c = cw.Lead__c
left outer join  Salesforce.dbo.Lead as l on cw.Lead__c = l.id
left outer join Salesforce.dbo.[User] as U on l.OwnerId = u.id
left outer join Salesforce.dbo.Opportunity as O on cm.Opportunity_For_Reports__c = o.id
where 
c.Name like '%22%'
and cm.Status = 'Clicked Email'
and (u.name not like '%existing%' or u.name is null)
and (l.Closed_Reason__c not in ('Already a customer', 'Competitor Shopping Us', 'Country Not Supported', 'Country/Language Not Supported', 'Duplicate', 'Test Record') or l.Closed_Reason__c is null)
and (l.Status not in ('Engaging', 'Existing Customer', 'Existing Prospect Account', 'Partner') or l.status is null   )
and (l.Total_Fleet_Size__c >= 20 or l.Total_Fleet_Size__c is null)  
and (o.StageName not in ('Sat - Negotiating', 'Docs Requested', 'Ready To Close', 'Closed Won') or o.StageName is null )
and l.Company not like '***%'
and l.Company not like '%test%'
and l.Company not like '%whip%around%' 
and l.Company not like '%disney%'
and l.Company not like '%lolo%'
and l.Company not like '%kahuna%'
--and cw.lead__c = '00Q4600000QeT1qEAF' 
