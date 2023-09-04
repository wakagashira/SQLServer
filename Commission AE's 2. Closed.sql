-- Duplicate tab 2. Closed on Sheet All Commison Scheme From Finance 
Select 
o.Sales_Rep__c as SalesRepId,
u1.Name as SalesRepName,
o.id as OpportuniutyId,
o.amount as AmountSF,
o.createddate as CreatedDate,
o.CloseDate as CloseDate,
o.[Type] as Type,
--What is this field 
null as CustomerSuccessTrack,
o.StageName as Stage,
o.OwnerId as OpportunityOwnerID,
u.name as OpportunityOwnerName,
u.Role_Name__c as OwnerRole,
o.AccountName as AccountName,
o.AccountId as AccountId,
U2.name as SDRName,
o.Biz_Dev_del__c as SDRID,
--Do we want this or just the plan name
replace( rp.name, 'Inspect - ', '') as Frequency,
b.WA_MRR__c as MRRInRecurly,
b.recurly_v2__SubscriptionID__c
From openquery(SFWA , 'select o.id, 
o.Sales_Rep__c,
	o.Amount,
	o.CloseDate,
	o.Type,
	o.StageName,
	o.ownerId,
	o.AccountId,
	o.Biz_Dev_del__c,
	a.Name as AccountName,
	o.createddate
from Opportunity as o 
inner join account as a on o.accountId = a.id 
where o.CloseDate >= 
''2022-04-01''
and o.stageName in (''Closed Won'', ''Docs Requested'') and o.Type = ''New Business''
') as o 
 left outer join  openquery(SFWA , 'select id, 	recurly_v2__Account__c,  recurly_v2__SubscriptionID__c, WA_MRR__c from recurly_v2__Recurly_Subscription__c') as b on o.accountid = b.recurly_v2__Account__c
left outer join [Recurly].[dbo].[recurly_subscriptions] as s on b.recurly_v2__SubscriptionID__c = s.id
left outer join [Recurly].[dbo].[recurly_plans] as rp on s.planId = rp.id
Left outer Join sf_user as u on o.ownerid = u.Id
Left outer join  sf_user as u1 on o.Sales_Rep__c = u1.Id
left outer Join sf_user as u2 on o.Biz_Dev_del__c  = u2.Id
