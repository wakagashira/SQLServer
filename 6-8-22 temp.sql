
-- From https://whiparound.lightning.force.com/lightning/r/Report/00O4p000004WcDGEA0/view
select 
Cast(CAST( GETDATE() AS Date ) as nvarchar) + '-' + 'Opens - Digital Adoption' + '-' + isnull(a.status, '-') as TheKey ,
CAST( GETDATE() AS Date )  as TheDate,
'Opens - Digital Adoption' as Report,
isnull(status, '-') as status,
count(id) as Cnt
from (
select distinct 
a.Sales_Status__c as status,
m.id as Id
--a.id as accountId,
--a.Account_Status__c,
--co.Opportunity_Owner_Name__c
from [dbo].[CampaignMember] as m 
Inner join    Campaign as c on m.CampaignId = c.ID
--Left Outer Join lead as l on m.LeadId = l.id
--Left outer join  [user] as u on l.ownerid = u.id
left outer join contact as co on m.[Contact_For_Reporting__c] = co.Id
Left outer join account as a on m.Accounts_For_Reporting__c = a.id
where 
c.Name like '%22 -%'
--and m.id like   '00v4p00000mm8k1%' 
and m.Status in  ('Opened Email', 'Clicked Email')
and (a.Terminus_Account_Stage__c in ('T-Prospect', 'T-Nurturing', 'T-Engaging', 'Attempting Contact', 'Engaging', 'Waiting to Book') )
and (a.Account_Status__c not in ('Customer', 'New Customer', 'Needs Account Set Up', 'Needs Training', 'First Month', '30 to 90 Days', 'Low Risk', 'High Risk', 'Customer Unresponsive', 'Dont Touch') or a.Account_Status__c is null)
and (a.Sales_Status__c  not in ('Engaging', 'Converted To Opp', 'Customer', 'Closed Account') or a.Sales_Status__c is null)
and co.Opportunity_Owner_Name__c is null 
and a.IsDeleted = 0
) as a 
group by status