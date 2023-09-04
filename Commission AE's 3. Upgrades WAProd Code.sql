select z1.Salesforce_account_id,
z1.Product, 
recurly_account_code,
currency_id,
--(case when z1.addedremoved = 'Added' then sum(cast(z1.adjusted_vehicles as int)) else 0 end)  as positive,
--(case when z1.addedremoved != 'Added' then (sum(cast(z1.adjusted_vehicles as int)) * -1) else 0 end) as negitive,
(case when z1.addedremoved = 'Added' then sum(cast(z1.adjusted_vehicles as int)) else 0 end) + (case when z1.addedremoved != 'Added' then (sum(cast(z1.adjusted_vehicles as int)) * -1) else 0 end) as QuantityChangeTotal, 
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
case when addedremoved = 'Added' then cast(Adjusted_vehicles as int) * MrrPerItem else (cast(Adjusted_vehicles as int) * MrrPerItem) * -1 end as TotalMRRChange,
recurly_account_code,
currency_id	

from 
(
select a.*,
b.salesforce_account_id,

case when a.prorated_price_per_vehicle not like '-%' then 'Added' else 'Removed' end as AddedRemoved,

--get type of change 
case when a.description like '%Maintain Lite%' then 'Maintain Lite'
when a.description like '%Maintain%' then 'Maintain'
when a.description like '%Inspect Lite%' then 'inspect Lite'
else 'Inspect' end as Product,

--Find Cost of Item  
case when (case when a.description like '%Maintain Lite%' then 'Maintain Lite'
when a.description like '%Maintain%' then 'Maintain'
when a.description like '%Inspect Lite%' then 'inspect Lite'
else 'Inspect' end) = 'Inspect' then b.unit_price_per_vehicle
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
order by a.business_id) as s on a.business_id = s.business_id and case when a.description like '%Maintain Lite%' then 'Maintain Lite'
when a.description like '%Maintain%' then 'Maintain'
when a.description like '%Inspect Lite%' then 'inspect Lite'
else 'Inspect' end = s.name
where a.created_at > '2022-04-01 00:00:01'
	and salesforce_account_id = '0014p00001m9EupAAE'
) as T0

) as Z1

Group by  Z1.Salesforce_account_id,
Product,
z1.addedremoved,
recurly_account_code,
currency_id