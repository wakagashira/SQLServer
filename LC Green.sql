select a.id, 
a.name,
o.state__c,
case when o.State__c = 'Ready to close' then 'Green' else 'Incorrect Stage To Close' end as StageStatus 
from Salesforce.dbo.account as a
inner join Salesforce.dbo.Opportunity as o on a.id = o.AccountId