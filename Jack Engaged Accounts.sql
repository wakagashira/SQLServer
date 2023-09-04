select 
--distinct is added to reduce the number of changes,   it will differ from the report totals 
--https://whiparound.lightning.force.com/lightning/r/Report/00O6T000006MCDAUA4/view  But is still accurate 
distinct 
l.Id as LeadId,
case when l.Account__c is not null then l.account__c else l.ConvertedAccountId end as AccountId,
'Hot' as TempStage,
'Contacts Downloading Content' as Report 
from 
Salesforce.dbo.Campaign as c
inner join Salesforce.dbo.CampaignMember as cm on c.id = cm.CampaignId
inner join Salesforce.dbo.Lead_Account_Opportunity_Crosswalk__c as cw on cm.Lead_For_Reports__c = cw.Lead__c
left outer join  Salesforce.dbo.Lead as l on cw.Lead__c = l.id
left outer join Salesforce.dbo.[User] as U on l.OwnerId = u.id
left outer join Salesforce.dbo.Opportunity as O on cm.Opportunity_For_Reports__c = o.id
where c.Name like '%Download%'
and (u.name not like '%existing%' or u.name is null)
and (l.Closed_Reason__c not in ('Already a customer', 'Competitor Shopping Us', 'Country Not Supported', 'Country/Language Not Supported', 'Duplicate', 'Test Record') or l.Closed_Reason__c is null)
and (l.Status not in ('Engaging', 'Qualified', 'Existing Customer', 'Existing Prospect Account', 'Partner') or l.status is null   )
and (l.Total_Fleet_Size__c >= 20 or l.Total_Fleet_Size__c is null)  
and (o.StageName not in ('Sat - Negotiating', 'Docs Requested', 'Ready To Close', 'Closed Won') or o.StageName is null )
and l.Company not like '***%'
and l.Company not like '%test%'
and l.Company not like '%whip%around%' 
and l.Company not like '%disney%'
and l.Company not like '%lolo%'
and l.Company not like '%kahuna%'
--and cw.lead__c = '00Q4p00000Vp6W1EAJ' 
Union 
select 
--distinct is added to reduce the number of changes,   it will differ from the report totals 
--https://whiparound.lightning.force.com/lightning/r/Report/00O6T000006MClbUAG/edit Clicks - YTD  But is still accurate 
distinct 
l.Id as Leadid,
case when l.Account__c is not null then l.account__c else l.ConvertedAccountId end  as AccountId,
'Hot' as TempStage,
'Contacts Clicking Emails' as Report 
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
union 
select distinct  
l.Id,
a.id as AccountId,
'Hot' as TempStatus,
'Accounts Visiting Website' as Report
from Salesforce.dbo.account as a
left outer join Salesforce.dbo.lead as l on l.ConvertedAccountId = a.id
where 
a.RecordTypeId in ('0124p000000E4B0AAK' /* Sales Standard */ , '0124p000000NkuCAAS' /* standard */ , '0124p000000iICzAAM' /* Terminus */ )
and a.type not in ('Trial Customer', 'Customer')
and a.website is not null 
and (a.Account_Status__c not in ('Customer', 'New Customer', 'Needs Account Set Up', 'Needs Training', 'First Month', '30 to 90 Days', 'Low Risk', 'High Risk', 'Customer Unresponsive', 'Dont Touch') or a.Account_Status__c is null)
and (a.Sales_Status__c not in ('Engaging', 'Converted To Opp', 'Customer', 'Closed Account') or a.Sales_Status__c is null)
and a.ZoomInfo_Workflow_Name__c like '%websights%'
--and id = '0016T00002rQKoiQAG'

union 

select distinct  
-- https://whiparound.lightning.force.com/lightning/r/Report/00O6T000006M5ScUAK/view 
null as LeadId,
a.id as AccountId,
'Warm' as TempStatus,
'ZoomInfo Intent' as Report
from Salesforce.dbo.account as a
left outer join Salesforce.dbo.lead as l on l.ConvertedAccountId = a.id
where 
a.ZoomInfo_Workflow_Name__c not like '%websights%'
and a.ZoomInfo_Workflow_Name__c is not null 
--and id = '0016T00002rQKoiQAG'
union 
select 
--distinct is added to reduce the number of changes,   it will differ from the report totals 
--https://whiparound.lightning.force.com/lightning/r/Report/00O6T000006M9j8UAC/view  But is still accurate 
distinct 
l.Id as Leadid,
case when l.Account__c is not null then l.account__c else l.ConvertedAccountId end  as AccountId,
'Warm' as TempStage,
'Opens - YTD' as Report 
from 
Salesforce.dbo.Campaign as c
inner join Salesforce.dbo.CampaignMember as cm on c.id = cm.CampaignId
inner join Salesforce.dbo.Lead_Account_Opportunity_Crosswalk__c as cw on cm.Lead_For_Reports__c = cw.Lead__c
left outer join  Salesforce.dbo.Lead as l on cw.Lead__c = l.id
left outer join Salesforce.dbo.[User] as U on l.OwnerId = u.id
left outer join Salesforce.dbo.Opportunity as O on cm.Opportunity_For_Reports__c = o.id
where 
c.Name like '%22%'
and cm.Status = 'Opened Email'
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