select * from 


(select t0.id, 
t0.type, 
case 
when s.recurly_v2__In_Trial__c = 1 and cast(s.recurly_v2__Trial_Ends_At__c as date) > getdate()  then 'In trial'
when s.recurly_v2__In_Trial__c = 1 and cast(s.recurly_v2__Trial_Ends_At__c as date) <= getdate() and s.recurly_v2__Subscription_Status__c is null then 'Was in Trial'
when s.recurly_v2__Subscription_Status__c is null then 'Not a customer'
else s.recurly_v2__Subscription_Status__c end as recStatus,
case 
when s.recurly_v2__In_Trial__c = 1 and cast(s.recurly_v2__Trial_Ends_At__c as date) > getdate()  then 'Prospect' --In trial 
when s.recurly_v2__In_Trial__c = 1 and cast(s.recurly_v2__Trial_Ends_At__c as date) <= getdate() and s.recurly_v2__Subscription_Status__c is null then 'Prospect' --Was in Trial
when s.recurly_v2__Subscription_Status__c is null then 'Prospect' --Not a customer
else case when s.recurly_v2__Subscription_Status__c = 'Failed' then 'Prospect'
when s.recurly_v2__Subscription_Status__c = 'Canceled' then 'Ex-Customer'
when s.recurly_v2__Subscription_Status__c = 'Expired' then 'Prospect'
when s.recurly_v2__Subscription_Status__c = 'Active' then 'Customer'
end end as RecomendedStatus,
s.recurly_v2__In_Trial__c, 
s.recurly_v2__Trial_Ends_At__c,
s.recurly_v2__Subscription_Status__c

from
account as t0
left outer join recurly_v2__Recurly_Account__c as r on t0.id = r.recurly_v2__Account__c and t0.RecurlyExID__c = r.name
left outer join recurly_v2__Recurly_Subscription__c as s on r.recurly_v2__Account_ID__c = s.recurly_v2__Subscription_Account_ID__c 

/*left outer join 
(
--get active accounts 
Select a.id 
from account as a
left outer join recurly_v2__Recurly_Account__c as r on a.id = r.recurly_v2__Account__c and a.RecurlyExID__c = r.name
left outer join recurly_v2__Recurly_Subscription__c as s on r.recurly_v2__Account_ID__c = s.recurly_v2__Subscription_Account_ID__c 

where (s.recurly_v2__In_Trial__c = 0 or (s.recurly_v2__In_Trial__c = 1 and cast(s.recurly_v2__Trial_Ends_At__c as date) 
and s.recurly_v2__Subscription_Status__c = 'Active') as act on t0.id = act.id
*/
) as Z0
where z0.Type = 'Customer' and recStatus != 'Active'