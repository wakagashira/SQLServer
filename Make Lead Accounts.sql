select distinct
--78615 with no filtering
--78665 with email filtering
dbo.ProperWebsite(a.website) as website, -- Pulls just the Domain from the leads entered website fields
max(a.Total_Fleet_Size__c) as FleetSize, -- Gets the Max listed Fleet size of all the leads with the same domain
max(b.id) as accountid  , --Gets the largest Account id from all of the leads that match domains to tie the domain to the SF account
Min(a.company) as Company, --Gets the shortest Company name from all the Leads that match domains.  This is just a guess of the actual company name
Min(d.id) as OppID, --Gets the first sf Opp id 
case 
--Converted Active Customer
when max(b.id) is not null and Max(c.[Id]) is not null and max(c.recurly_v2__Canceled_At__c) is null  then 'Customer'
--Converted Active Former Customer
when max(b.id) is not null and Max(c.[Id]) is not null and max(c.recurly_v2__Canceled_At__c) is not null  then 'X-Customer'
--Converted Oppotunity (Assumed)  need to add more detail
when max(b.id) is not null and max(d.id) is not null and Max(d.StageName) not like '%Closed%'   then 'Converted Open Opp'
when max(b.id) is not null and max(d.id) is not null and Max(d.StageName) like '%Closed%Won%'   then 'Something Is Wrong'
when max(b.id) is not null and max(d.id) is not null and Max(d.StageName) like '%Closed%Lost%' then 'Converted Opp Closed Lost'
when max(b.id) is not null and max(d.id) is not null and Max(d.StageName) like '%Closed%Lost%' then 'Converted Opp Closed Lost'
when max(dbo.leadstatusrank(a.status)) = 110 then 'Matched To Account'
when max(dbo.leadstatusrank(a.status)) = 100 then 'Matched To Prospect Account'
when max(dbo.leadstatusrank(a.status)) = 50 then 'Matched To Partner'
when max(dbo.leadstatusrank(a.status)) = 25 then 'Closed Lead'
when max(dbo.leadstatusrank(a.status)) = 10 then 'Waiting To Book'
when max(dbo.leadstatusrank(a.status)) = 9 then 'Engaging'
when max(dbo.leadstatusrank(a.status)) = 8 then 'Qualified'
when max(dbo.leadstatusrank(a.status)) = 7 then 'Contacted'
when max(dbo.leadstatusrank(a.status)) = 6 then 'Call Completed'
when max(dbo.leadstatusrank(a.status)) = 5 then 'Call Scheduled'
when max(dbo.leadstatusrank(a.status)) = 4 then 'Call New'
when max(dbo.leadstatusrank(a.status)) = 3 then 'Attempting Contact'
when max(dbo.leadstatusrank(a.status)) = 2 then 'Open'
when max(dbo.leadstatusrank(a.status)) = 1 then 'Open Not Contacted'
else 'something else' end as LeadCompanyStatus --Goes though steps to decide LeadCompany Status to start,  i.e. If active customer, Past Customer, current Opp former Opp Lead, etc...
,Null as LeadSource--,e.LeadSource as FirstLeadSource  --Grabs the lead source from the first LeadSourceHistory for the Domain
,null as FirstLeadSourceDate --,e.LeadSourceDate as FirstLeadSource--Grabs the lead source date from the first LeadSourceHistory for the Domain
,f.Segment as Segment --gets the highest lead segment from the view GetLeadSegment
,g.Industry as Industry --Get the most common industry from the view Getleadindustry 
Into NewLeadCompany
from leads as a
Left Outer Join Accounts as b on a.ConvertedAccountId = b.id
Left Outer Join [dbo].[recurly_v2__Recurly_Subscription__c] as c on  a.ConvertedAccountId = c.recurly_v2__Account__c  --Pulling active and former account subscriptions
Left Outer Join [dbo].Opportunity as d on  a.ConvertedAccountId = d.AccountId
--left outer join GetFirstLeadSource as e on dbo.properwebsite(a.website) = e.website --A View that finds and lists the first Lead source and date 
Left outer join GetLeadSegment as f on dbo.properwebsite(a.website) = f.website
Left outer join GetLeadIndustry as g on dbo.properwebsite(a.website) = g.website

where a.website is not null
--and company != '<Sent from Intercom>'
and dbo.ProperWebsite(a.website) not in (
'gmail.com',
'yahoo.com',
'hotmail.com',
'whiparound.com',
'icloud.com',
'aol.com',
'outlook.com',
'facebook.com',
'na.com',
'comcast.com',
'mail.com',
'live.com',
'comcast.net',
'msn.com',
'me.com',
'sbcglobal.net',
'ymail.com',
'verizon.net',
'test.com',
'att.net',
'mail.ru',
'att.com',
'example.com'
) --Removing Junk domains 
Group by dbo.ProperWebsite(a.website)
--,e.LeadSource
--,e.LeadSourceDate
, f.Segment
, g.Industry
--Order by max(a.Total_Fleet_Size__c) desc, dbo.ProperWebsite(a.website)