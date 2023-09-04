select a.id, 
a.name,
a.type, 
a.RecurlyExID__c, 
a.RecurlyID__c, 
a.Terminus_Account_Stage__c ,
r.recurly_v2__Account__c,
r.recurly_v2__Active_Subscribers__c,
a.up
from account as a
left outer join recurly_v2__Recurly_Account__c as r on a.id = r.recurly_v2__Account__c
where 
r.recurly_v2__Active_Subscribers__c = 1
and a.type != 'Customer'
--and (a.RecurlyExID__c is null or a.RecurlyID__c is null) 
--and a.Terminus_Account_Stage__c like 't%'
order by r.recurly_v2__Active_Subscribers__c