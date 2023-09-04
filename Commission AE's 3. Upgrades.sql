-- Duplicate tab 3. Upgrades on Sheet All Commison Scheme From Finance 
select 
a.CustomerName,
a.CustomerExternalID,
--a.product,
sum(a.change) as TotalChange,
QualifyForUpgradeOnCommission,
sum(ActivityAmount) as ActivityAmount,
Currency,
sum(AmountInUSD) as AmountInUSD,
SalesRep
from
(

Select 
a.name as CustomerName,
ra.code as CustomerExternalID,
cast(wa.product as nvarchar) as Product,
wa.QuantityChangeTotal as Change,
wa.TotalMRRChange as ActivityAmount,
s.currency as Currency,
wa.TotalMRRChange * e.Multiplier as AmountInUSD,
Null as ActivityDate,
s.activated_at as SignupDate,
datediff(day, s.activated_at, getdate()) as DaysSinceSignUp,
case when datediff(day, s.activated_at, getdate()) <= 180 then 'Yes' else 'No' end  as QualifyForUpgradeOnCommission,
u.name as SalesRep,
wa.TotalMRRChange * e.Multiplier as Commission
From 
openquery(WAPROD, '
select z1.Salesforce_account_id,
z1.Product, 
recurly_account_code,
currency_id,
(case when z1.addedremoved = ''Added'' then sum(cast(z1.adjusted_vehicles as int)) else 0 end) + (case when z1.addedremoved != ''Added'' then (sum(cast(z1.adjusted_vehicles as int)) * -1) else 0 end) as QuantityChangeTotal, 
sum(TotalMrrChange) as TotalMRRChange
 from 
(

select t0.Salesforce_account_id,
	t0.name,
t0.description,
Adjusted_vehicles,
Created_at,
AddedRemoved, 
Product,
MRRPerItem,
case when addedremoved = ''Added'' then cast(Adjusted_vehicles as int) * MrrPerItem else (cast(Adjusted_vehicles as int) * MrrPerItem) * -1 end as TotalMRRChange,
recurly_account_code,
currency_id	

from 
(
select a.*,
b.salesforce_account_id,

case when a.prorated_price_per_vehicle not like ''-%'' then ''Added'' else ''Removed'' end as AddedRemoved,

--get type of change 
case when a.description like ''%Maintain Lite%'' then ''Maintain Lite''
when a.description like ''%Maintain%'' then ''Maintain''
when a.description like ''%Inspect Lite%'' then ''inspect Lite''
else ''Inspect'' end as Product,

--Find Cost of Item  
case when (case when a.description like ''%Maintain Lite%'' then ''Maintain Lite''
when a.description like ''%Maintain%'' then ''Maintain''
when a.description like ''%Inspect Lite%'' then ''inspect Lite''
else ''Inspect'' end) = ''Inspect'' then b.unit_price_per_vehicle
else s.price_per_unit end as MRRPerItem,

b.Name,
b.id,
	b.recurly_account_code,
	b.currency_id
from v2_billing_audits as a 
inner join public.v2_businesses as b on a.business_id = b.id
left outer join (SELECT a.*, s.name
FROM public.business_sub_add_ons as a
left outer join public.subscription_add_ons as s on a.subscription_add_on_id = s.id
inner join public.v2_businesses as b on a.business_id = b.id
where a.deleted_at is null 
order by a.business_id) as s on a.business_id = s.business_id and case when a.description like ''%Maintain Lite%'' then ''Maintain Lite''
when a.description like ''%Maintain%'' then ''Maintain''
when a.description like ''%Inspect Lite%'' then ''inspect Lite''
else ''Inspect'' end = s.name
where a.created_at > ''2022-03-01 00:00:01''
and a.created_at < ''2022-04-01 00:00:01''
--	and salesforce_account_id = ''0014p00001m9EupAAE''
) as T0

) as Z1

Group by  Z1.Salesforce_account_id,
Product,
z1.addedremoved,
recurly_account_code,
currency_id')  as wa
left outer join  openquery(SFWA , 'select id, name, Sales_Rep__c  from Account') as a on wa.Salesforce_account_id = a.id
left outer join  openquery(SFWA , 'select id, 	recurly_v2__Account__c,  recurly_v2__SubscriptionID__c, WA_MRR__c from recurly_v2__Recurly_Subscription__c') as b on wa.Salesforce_account_id = b.recurly_v2__Account__c
left outer join [Recurly].[dbo].[recurly_subscriptions] as s on b.recurly_v2__SubscriptionID__c = s.id 
Left outer Join[Recurly].[dbo].[recurly_accounts] as ra on s.accountId = ra.id
left outer join [Recurly].[dbo].[Exchange Rate] as e on s.currency = e.[CountryCode]
left outer join [dbo].[SF_User] as u on a.sales_rep__c = u.id
) as A
where
QualifyForUpgradeOnCommission = 'Yes'

group by a.CustomerName,
a.CustomerExternalID,
--a.product,
a.QualifyForUpgradeOnCommission,
Currency,
SalesRep
Having sum(a.change) >0
Order by customerName