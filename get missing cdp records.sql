select b.id waid, b.salesforce_account_id, a.id as sfaid, c.id as cdpid, a.Type 
from LocalWAProd.dbo.v2_businesses as b
Left outer join Salesforce.dbo.Account as a on b.salesforce_account_id = a.id
left outer join Salesforce.dbo.App_CDP__c as c on b.salesforce_account_id = c.Account__c

where b.salesforce_account_id is not null 
and a.id is not null 
and c.id is null 
and a.id in ('0016T00002stsRVQAY', '0016T00002yB2gLQAS')
