Select t0.recurlyAccountid,
t1.recurly_v2__Account__c,
'https://whip-around.recurly.com/accounts/' + t0.code,
--T0.recsubId,
case when sum(t0.isactive) > 0 then 'Active' else 'Inactive' end  as TotalActiveSub,

t1.recurly_v2__Status__c as SFstatus,
t2.state
From (
--Get a list of all the subscriptions by account id 1 if the account is active 0 if inactive
select a0.accountid as recurlyAccountid,
a0.id as recsubId,
a1.code,
case when a0.expiration_reason is null then 1 else 0 end as isactive
from Recurly.dbo.recurly_subscriptions as a0
Left outer join Recurly.dbo.recurly_accounts as a1 on a0.accountId = a1.id ) as T0
left outer join Salesforce.dbo.recurly_v2__Recurly_Account__c as T1 on t0.recurlyAccountid = t1.recurly_v2__Account_ID__c
Left outer join Recurly.dbo.recurly_accounts as t2 on t0.recurlyAccountid = t2.id
Group by t0.recurlyAccountid,  t1.recurly_v2__Status__c, t0.code, t2.state, t1.recurly_v2__Account__c
having case when sum(t0.isactive) > 0 then 'Active' else 'Inactive' end  != t1.recurly_v2__Status__c

 