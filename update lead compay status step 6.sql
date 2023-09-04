update
NewLeadCompany
set newleadcompany.LeadCompanyStatus = c.LeadCompanyStatus



from newleadcompany as a 
inner join (

select c.Domain,
case 
--Converted Active Customer
when max(b.id) is not null and Max(c.[Id]) is not null and max(e.recurly_v2__Canceled_At__c) is null  then 'Customer'
--Converted Active Former Customer
when max(b.id) is not null and Max(c.[Id]) is not null and max(e.recurly_v2__Canceled_At__c) is not null  then 'X-Customer'
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
from leads as a 
inner join [dbo].[GetDomainFromLead] as c on a.id = c.id
Left Outer Join Accounts as b on a.ConvertedAccountId = b.id
Left Outer Join [dbo].[recurly_v2__Recurly_Subscription__c] as e on  a.ConvertedAccountId = e.recurly_v2__Account__c  --Pulling active and former account subscriptions
Left Outer Join [dbo].Opportunity as d on  a.ConvertedAccountId = d.AccountId

group by c.domain


) as c on a.domain = c.domain 